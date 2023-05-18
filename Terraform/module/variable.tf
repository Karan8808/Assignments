variable "region" {
    type = string
    default = "ap-south-1"
}

variable "cidr_block_vpc" {
    type = string
    default = "10.0.0.0/16"
}

variable "vpc_name" {
    type = string
    default = "new_vpc"
}

variable "cidr_block_sub1" {
    type = string
    default = "10.0.1.0/24"
}

variable "sub_1" {
    type = string
    default = "subnet-1"
}

variable "cidr_block_sub2" {
    type = string
    default = "10.0.2.0/24"
}

variable "sub_2" {
    type = string
    default = "subnet-2"
}

variable "cidr_block_sub3" {
    type = string
    default = "10.0.3.0/24"
}

variable "sub_3" {
    type = string
    default = "subnet-3"
}

variable "cidr_block_sub4" {
    type = string
    default = "10.0.4.0/24"
}

variable "sub_4" {
    type = string
    default = "subnet-4"
}