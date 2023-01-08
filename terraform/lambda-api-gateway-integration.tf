# Create the integration between the API Gateway and the lambda function
resource "aws_apigatewayv2_integration" "update-counter-tf" {
  api_id = aws_apigatewayv2_api.awsresumeapi-tf.id

  integration_uri    = aws_lambda_function.update-counter-tf.invoke_arn
  integration_type   = "AWS_PROXY"
  integration_method = "POST"
}
# Create a route within the API Gateway
resource "aws_apigatewayv2_route" "update-counter-tf-route" {
  api_id = aws_apigatewayv2_api.awsresumeapi-tf.id

  route_key = "GET /faigh"
  target    = "integrations/${aws_apigatewayv2_integration.update-counter-tf.id}"
}
# Allow API Gateway to invoke lambda function
resource "aws_lambda_permission" "api_gw" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.update-counter-tf.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.awsresumeapi-tf.execution_arn}/*/*"
}
# Base URL for the faigh route
output "faigh_base_url" {
  value = "${aws_apigatewayv2_stage.prod.invoke_url}/faigh"
}
