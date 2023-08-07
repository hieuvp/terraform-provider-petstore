provider "aws" {
  allowed_account_ids = [var.account_id]
  region              = var.region
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "petstore-vpc"
  azs  = var.availability_zones

  cidr             = "10.0.0.0/16"
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets  = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  database_subnets = ["10.0.7.0/24", "10.0.8.0/24", "10.0.9.0/24"]
}

module "petstore" {
  source = "../modules/petstore"
  vpc_id = module.vpc.vpc_id

  lambda_subnet_ids = module.vpc.private_subnets

  rds_azs               = module.vpc.azs
  rds_subnet_group_name = module.vpc.database_subnet_group_name
}
