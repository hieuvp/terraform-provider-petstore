variable "namespace" {
  type = string
}

variable "azs" {
  description = "A list of availability zones names or ids in the region"
  type        = list(string)
}

variable "subnet_group_name" {
  description = "Name of subnet group"
}

variable "rds_user" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "sg" {
  type = any
}
