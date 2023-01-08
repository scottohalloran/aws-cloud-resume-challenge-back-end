#!/bin/sh
# Create an S3 bucket to store the Terraform state
# Empty bucket if it already exists
aws s3 rm s3://scottohallorancv.com-tfstate --recursive
# Delete bucket if it already exists
aws s3api delete-bucket --bucket scottohallorancv.com-tfstate
aws s3api create-bucket --bucket scottohallorancv.com-tfstate

