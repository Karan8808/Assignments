provider "aws" {
    region = "ap-south-1"
    access_key = "AKIA3BG3HZEUY3U3LJRH"
    secret_key = "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"
}

module "vpc-module" {
  source = ".//vpc/"
}


resource "aws_internet_gateway" "gw" {
    vpc_id = "${module.vpc.vpc_id}"
    tags = {
        Name = var.gw
    }
}

resource "aws_internet_gateway_attachment" "gw_attach" {
  internet_gateway_id = aws_internet_gateway.gw.id
  vpc_id              = "${vpc.vpc_id}"
}

resource "aws_eip" "elastic_ip" {
  vpc = true
  tags = {
    Name = var.eip
  }
}

resource "aws_nat_gateway" "nat_1" {
    allocation_id = aws_eip.elastic_ip.id
    subnet_id = "${module.vpc.s1_pub_id}"
    connectivity_type = "public"
    tags = {
        Name = var.nat_name_1
    }
}

resource "aws_eip" "elastic_ip1" {
  vpc = true
  tags = {
    Name = var.eip2
  }
}

resource "aws_nat_gateway" "nat_2" {
    allocation_id = aws_eip.elastic_ip1.id
    subnet_id = aws_subnet.subnet_2_public.id
    connectivity_type = "public"
    tags = {
        Name = var.nat_name_2
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

resource "aws_route_table" "route_table_2" {
    vpc_id = aws_vpc.VPC_1.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw.id
        tags = {
            Name = "route_2_private"
        }
    }
} 

resource "aws_route_table_association" "route_association_private1" {
    subnet_id = aws_subnet.subnet_3_private.id
    route_table_id = aws_route_table.route_table_2.id
}

resource "aws_route_table_association" "route_association_private2" {
    subnet_id = aws_subnet.subnet_4_private.id
    route_table_id = aws_route_table.route_table_2.id
}

resource "null_resource" "null_resource_simple" { 
    provisioner "local-exec" {
         command = "echo Hello World" 
         } 
}

