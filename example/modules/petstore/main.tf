resource "random_string" "rand" {
  length  = 24
  special = false
  upper   = false
}

locals {
  namespace = substr(join("-", [var.namespace, random_string.rand.result]), 0, 24)
}

module "networking" {
  source    = "./modules/networking"
  namespace = local.namespace
  vpc_id    = var.vpc_id
}

module "database" {
  source                = "./modules/database"
  namespace             = local.namespace
  rds_azs               = var.rds_azs
  rds_subnet_group_name = var.rds_subnet_group_name
  rds_user              = var.rds_user
  rds_password          = var.rds_password
  sg                    = module.networking.sg
}

module "lambda" {
  source       = "./modules/lambda"
  namespace    = local.namespace
  subnet_ids   = var.lambda_subnet_ids
  rds_user     = var.rds_user
  rds_password = var.rds_password
  rds_host     = module.database.rds_host
  rds_port     = module.database.rds_port
  rds_database = module.database.rds_database
  sg           = module.networking.sg
}

module "apigw" {
  source     = "./modules/apigw"
  namespace  = local.namespace
  lambda_arn = module.lambda.lambda_arn
}
