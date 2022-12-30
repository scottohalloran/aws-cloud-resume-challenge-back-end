#Bucket to store the Terraform TFState
terraform {
  backend "s3" {
    bucket = "scottohallorancv.com-tfstate"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}


