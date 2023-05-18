provider "aws" {
    region = var.region
    access_key = "AKIA3BG3HZEUY3U3LJRH"
    secret_key = "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"
}

resource "aws_vpc" "VPC_1" {
    cidr_block = var.cidr_block_vpc
    tags = {
        Name = var.vpc_name
    }
}

resource "aws_subnet" "subnet_1_public" {
    vpc_id = aws_vpc.VPC_1.id
    cidr_block = var.cidr_block_sub1
    tags = {
        Name = var.sub_1
    }

}

resource "aws_subnet" "subnet_2_public" {
    vpc_id = aws_vpc.VPC_1.id
    cidr_block = var.cidr_block_sub2
    tags = {
        Name = var.sub_2
    }

}

resource "aws_subnet" "subnet_3_private" {
    vpc_id = aws_vpc.VPC_1.id
    cidr_block = var.cidr_block_sub3
    tags = {
        Name = var.sub_3
    }

}

resource "aws_subnet" "subnet_4_private" {
    vpc_id = aws_vpc.VPC_1.id
    cidr_block = var.cidr_block_sub4
    tags = {
        Name = var.sub_4
    }

}

output "vpc_id" {
    value = "${aws_vpc.VPC_1.id}"
}