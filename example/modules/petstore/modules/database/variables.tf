variable "namespace" {
  type = string
}

variable "rds_azs" {
  type = list(string)
}

variable "rds_subnet_group_name" {
  type = string
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
