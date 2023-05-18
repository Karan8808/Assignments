variable "region" {
  type    = string
  default = "ap-south-1"
}

variable "cidr_block_vpc" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = "new_vpc"
}

variable "cidr_block_sub1" {
  type    = string
  default = "10.0.1.0/24"
}

variable "sub_1" {
  type    = string
  default = "subnet-1"
}

variable "cidr_block_sub2" {
  type    = string
  default = "10.0.2.0/24"
}

variable "sub_2" {
  type    = string
  default = "subnet-2"
}

variable "gw" {
  type        = string
  default     = "Internet_gateway"
  description = "create internet gateway"
}

variable "eip" {
  type        = string
  default     = "elasticip_1"
  description = "elastic_ip"
}

variable "nat_name_1" {
  type        = string
  default     = "nat_1"
  description = "1st nat gateway"
}

variable "eip2" {
  type        = string
  default     = "elasticip_2"
  description = "elastic_ip"
}

variable "nat_name_2" {
  type        = string
  default     = "nat_2"
  description = "2nd nat gateway"
}

variable "ami" {
  type    = string
  default = "ami-0376ec8eacdf70aae"
}