resource "aws_apigatewayv2_api" "tech_challenger_gtw" {
  name          = "tech_challenger_gtw"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "default" {
  api_id = aws_apigatewayv2_api.tech_challenger_gtw.id

  name        = "$default"
  auto_deploy = true
}