provider "aws" {
  region     = var.region
}

resource "aws_vpc" "VPC_1" {
  cidr_block = var.cidr_block_vpc
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet_1_public" {
  vpc_id            = aws_vpc.VPC_1.id
  cidr_block        = var.cidr_block_sub1
  availability_zone = "ap-south-1a"
  tags = {
    Name = var.sub_1
  }

}

resource "aws_subnet" "subnet_2_public" {
  vpc_id            = aws_vpc.VPC_1.id
  cidr_block        = var.cidr_block_sub2
  availability_zone = "ap-south-1b"
  tags = {
    Name = var.sub_2
  }

}

output "vpc_id" {
  value = aws_vpc.VPC_1.id
}

output "s1_pub_id" {
  value = aws_subnet.subnet_1_public.id
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.VPC_1.id
  tags = {
    Name = var.gw
  }
}

resource "aws_route_table" "route_table_1" {
  vpc_id = aws_vpc.VPC_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "route_1_public"
  }
}

resource "aws_route_table_association" "route_association_public1" {
  subnet_id      = aws_subnet.subnet_1_public.id
  route_table_id = aws_route_table.route_table_1.id
}

resource "aws_route_table_association" "route_association_public2" {
  subnet_id      = aws_subnet.subnet_1_public.id
  route_table_id = aws_route_table.route_table_1.id
}

resource "aws_security_group" "new_sec_gup" {
  name   = "new_sg"
  vpc_id = aws_vpc.VPC_1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "new_tf" {
  ami                         = var.ami
  subnet_id                   = aws_subnet.subnet_1_public.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.new_sec_gup.id]
  key_name                    = "new-key"

  tags = {
    Name = "terraform"
  }


   provisioner "remote-exec" {
    inline = ["echo 'SSH in progress'"]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = "/home/ec2-user/Ansible-terraform/new_key.pem"
      host        = aws_instance.new_tf.public_ip
    }
  }

  provisioner "local-exec" {
    command = "ansible-playbook  -i ${aws_instance.new_tf.public_ip}, --private-key ${"/home/ec2-user/Ansible-terraform/new_key.pem"} master.yaml"
  }
}

output "terraform_ip" {
  value = aws_instance.new_tf.public_ip
}




