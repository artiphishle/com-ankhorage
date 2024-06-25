provider "aws" {
  region = "us-east-1"
}

# IAM role for Lambda
resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "lambda_exec_policy" {
  name   = "lambda_exec_policy"
  role   = aws_iam_role.lambda_exec_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}

# Lambda function
resource "aws_lambda_function" "fen_by_san" {
  filename         = "lambda/fenBySan.zip"
  function_name    = "fenBySan"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "handler.lambda_handler"
  source_code_hash = filebase64sha256("lambda/fenBySan.zip")
  runtime          = "python3.9"
}

# API Gateway
module "api_gateway" {
  source = "./modules/api_gateway"

  lambda_function_arn = aws_lambda_function.fen_by_san.arn
}

# Outputs
output "api_gateway_url" {
  value = module.api_gateway.invoke_url
}
