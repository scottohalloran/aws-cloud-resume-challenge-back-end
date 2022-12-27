resource "aws_apigatewayv2_api_mapping" "awsresumeapi-tf" {
  api_id      = aws_apigatewayv2_api.awsresumeapi-tf.id
  domain_name = aws_apigatewayv2_domain_name.awsresumeapi-tf.id
  stage       = aws_apigatewayv2_stage.prod.id
}



output "custom_domain_api" {
  value = "https://${aws_apigatewayv2_api_mapping.awsresumeapi-tf.domain_name}"
}

