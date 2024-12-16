resource "aws_apigatewayv2_integration" "eks" {
  api_id = aws_apigatewayv2_api.tech_challenger_gtw.id

  integration_uri    = "http://abc79719170774120a0c443b0600597c-07fc987cb4ea0bbe.elb.us-east-1.amazonaws.com/{path}"
  integration_type   = "HTTP_PROXY"
  integration_method = "ANY"
}

resource "aws_apigatewayv2_route" "gestaopedidos" {
  api_id = aws_apigatewayv2_api.tech_challenger_gtw.id

  route_key = "ANY /gestaopedidos/{path+}"
  target    = "integrations/${aws_apigatewayv2_integration.eks.id}"
}
