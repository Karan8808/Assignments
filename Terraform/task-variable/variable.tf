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