#lambda role
data "aws_iam_policy_document" "lambda_assume_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_iam_policy_document" {
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
      "logs:*",
      "rds:*",
      "ec2:*",
    ]
    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "lambda_iam_policy" {
  name   = "lambda-policy-${var.namespace}"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_iam_policy_document.json
}

resource "aws_iam_role" "lambda_role" {
  name               = "lambda-role-${var.namespace}"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy_document.json
}

resource "aws_iam_policy_attachment" "lambda_iam_policy_role_attachment" {
  name       = "lambda-policy-attachment-${var.namespace}"
  roles      = [aws_iam_role.lambda_role.name]
  policy_arn = aws_iam_policy.lambda_iam_policy.arn
}

#lambda function
resource "aws_lambda_function" "lambda_function" {
  filename                       = "${path.module}/../../dist/function.zip"
  function_name                  = "${var.namespace}-lambda"
  handler                        = "deployment"
  role                           = aws_iam_role.lambda_role.arn
  memory_size                    = 256
  runtime                        = "go1.x"
  timeout                        = 60
  reserved_concurrent_executions = 1

  environment {
    variables = {
      rds_user     = var.rds_user
      rds_password = var.rds_password
      rds_host     = var.rds_host
      rds_port     = var.rds_port
      rds_database = var.rds_database
    }
  }

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [var.sg.lambda]
  }
}
