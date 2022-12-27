#!/bin/sh
# Create the S3 bucket in which to store the Terraform TFState
aws s3api create-bucket --bucket scottohallorancv.com-tfstate