variable "lambda_function_arn" {}

resource "aws_api_gateway_rest_api" "chess_api" {
  name = "chess_api"
}

resource "aws_api_gateway_resource" "notation" {
  rest_api_id = aws_api_gateway_rest_api.chess_api.id
  parent_id   = aws_api_gateway_rest_api.chess_api.root_resource_id
  path_part   = "notation"
}

resource "aws_api_gateway_method" "get_fenBySan" {
  rest_api_id   = aws_api_gateway_rest_api.chess_api.id
  resource_id   = aws_api_gateway_resource.notation.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id             = aws_api_gateway_rest_api.chess_api.id
  resource_id             = aws_api_gateway_resource.notation.id
  http_method             = aws_api_gateway_method.get_fenBySan.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_function_arn}/invocations"
}

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${data.aws_caller_identity.current.account_id}:${aws_api_gateway_rest_api.chess_api.id}/*/POST/notation"
}

output "invoke_url" {
  value = aws_api_gateway_rest_api.chess_api.execution_arn
}
