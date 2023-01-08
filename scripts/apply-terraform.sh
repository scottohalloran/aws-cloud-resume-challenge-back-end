#!/bin/bash

# fail on any error
set -eu

# change to terraform directory
cd ../terraform

# initialize terraform
terraform init

#apply terraform
terraform apply -auto-approve

# destroy terraform
#  terraform destroy -auto-approve