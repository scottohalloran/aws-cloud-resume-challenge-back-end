# Create resume counter table in Dynamo DB 
resource "aws_dynamodb_table" "cloud-resume-challenge-tf" {
  name         = "cloud-resume-challenge-tf"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "id"
    type = "S"
  }
  hash_key = "id"
}
# Create Key ID 1 and set its initial value to "0"
resource "aws_dynamodb_table_item" "cloud-resume-challenge-tf" {
  table_name = "cloud-resume-challenge-tf"
  hash_key   = aws_dynamodb_table.cloud-resume-challenge-tf.hash_key
  item = jsonencode(
    {
      "id"         = { S = "1" }
      "item_count" = { S = "0" }
  })
}
