provider "aws" {
    region = "ap-south-1"
    access_key = "AKIA3BG3HZEUY3U3LJRH"
    secret_key = "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"
}

module "new_vpc" {
    source = "../demo_vpc_task"
    cidr_block_vpc = "12.0.0.0/24"
    cidr_block_sub1 = "12.0.0.16/28"
    cidr_block_sub2 = "12.0.0.32/28"
    cidr_block_sub3 = "12.0.0.48/28"
    cidr_block_sub4 = "12.0.0.64/28"
}