provider "aws" {
    region = "ap-south-1"
    access_key = "AKIA3BG3HZEUY3U3LJRH"
    secret_key = "HzKvl07pR6u0otZmLtQh3y74vbgkizWRp3guPBFE"
}

resource "aws_vpc" "vpc-example" {
    cidr_block = var.cidr_block
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "subnet-public" {
    vpc_id = aws_vpc.vpc-example.id
    cidr_block= var.cidr_block_pub
    tags = {
        Name = var.subnet_public
    }
}

resource "aws_subnet" "subnet-private" {
    vpc_id = aws_vpc.vpc-example.id
    cidr_block = var.cidr_block_private
    tags = {
        Name = var.subnet_private
    }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-example.id
  tags = {
    Name = var.Internet_gateway_name
  }  
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.vpc-example.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}

resource "aws_route_table_association" "rtb_associate" {
    subnet_id = aws_subnet.subnet-public.id
    route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "sg_public" {
    vpc_id = aws_vpc.vpc-example.id
    ingress {
        description = "ssh connection"
        from_port = "22"
        to_port = "22"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = "0"
        to_port =  "0"
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name  = "SG"
    }
 }


resource "aws_instance" "ec2-example" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name


tags = {
    Name = var.instance_name
}
}


