#!/bin/sh
# Create the S3 bucket in which to store the Terraform TFState
aws s3api create-bucket --bucket scottohallorancv.com-tfstate
# Enable S3 versioning on the TF State bucket
aws s3api put-bucket-versioning --bucket scottohallorancv.com-tfstate --versioning-configuration Status=Enabled