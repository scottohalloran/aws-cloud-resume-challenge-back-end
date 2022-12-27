#Create HTTP Gateway for resume counter
resource "aws_apigatewayv2_api" "awsresumeapi-tf" {
  name          = "awsresumeapi-tf"
  protocol_type = "HTTP"
}
#Create prod stage
resource "aws_apigatewayv2_stage" "prod" {
  name        = "prod"
  api_id      = aws_apigatewayv2_api.awsresumeapi-tf.id
  auto_deploy = true
}
