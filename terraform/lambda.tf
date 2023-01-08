# Create IAM role theat allows gateway to execute update-counter-tf Lambda
resource "aws_iam_role" "update-counter-tf_lambda_exec" {
  name = "_update-counter-tf_lambda"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}
# Assign policy to the IAM role
resource "aws_iam_role_policy_attachment" "update-counter-tf_lambda_exec_policy" {
  role       = aws_iam_role.update-counter-tf_lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


# Create logging group for awsresume-tf
resource "aws_cloudwatch_log_group" "update-counter-tf" {
  name = "/aws/lambda/${aws_lambda_function.update-counter-tf.function_name}"

  retention_in_days = 14
}

# Upload the Python code for the Lambda function 
# that reads from and writes to the DynamoDB table
data "archive_file" "update-counter-tf" {
  type        = "zip"
  source_file = "update-counter-tf.py"
  output_path = "update-counter-tf.zip"
}
# Create the lambda function
resource "aws_lambda_function" "update-counter-tf" {
  function_name = "update-counter-tf"

  filename         = data.archive_file.update-counter-tf.output_path
  source_code_hash = data.archive_file.update-counter-tf.output_base64sha256
  role             = "arn:aws:iam::990969128752:role/_aws-lambda-role"

  handler = "update-counter-tf.lambda_handler"
  runtime = "python3.9"

}