variable "namespace" {
  type    = string
  default = "petstore"
}

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "lambda_subnet_ids" {
  description = "List of subnet IDs of the Lambda"
}

variable "rds_azs" {
  description = "List of availability zones of the Relational Database Service (RDS)"
}

variable "rds_subnet_group_name" {
  description = "Name of database subnet group"
}

variable "rds_user" {
  type    = string
  default = "root"
}

variable "rds_password" {
  type    = string
  default = "password"
}
