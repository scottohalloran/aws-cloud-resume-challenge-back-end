#!/bin/sh
# Delete all versioned objects within bucket and then delete bucket if it already exists
aws s3api delete-objects --bucket scottohallorancv.com-tfstate \
--delete "$(aws s3api list-object-versions --bucket scottohallorancv.com-tfstate --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')"
aws s3api delete-bucket --bucket scottohallorancv.com-tfstate
# Create the S3 bucket in which to store the Terraform TFState
aws s3api create-bucket --bucket scottohallorancv.com-tfstate
# Enable S3 versioning on the TF State bucket
aws s3api put-bucket-versioning --bucket scottohallorancv.com-tfstate --versioning-configuration Status=Enabled