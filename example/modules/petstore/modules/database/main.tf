data "aws_region" "current" {}

resource "aws_rds_cluster" "rds_cluster" {
  cluster_identifier      = "${var.namespace}-aurora-cluster"
  engine                  = "aurora-mysql"
  availability_zones      = var.rds_azs
  db_subnet_group_name    = var.rds_subnet_group_name
  database_name           = "petstore"
  master_username         = var.rds_user
  master_password         = var.rds_password
  backup_retention_period = 1
  skip_final_snapshot     = true
  preferred_backup_window = "04:00-07:00"
  engine_mode             = "serverless"
  scaling_configuration {
    max_capacity = 2
    min_capacity = 2
  }
  vpc_security_group_ids = [var.sg.db]
}
