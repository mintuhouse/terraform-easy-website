#!/bin/bash 
prepare_path="$(dirname "$0")/../source/prepare"
cd $prepare_path
terraform init
terraform plan -out prepare.tfout 
terraform apply prepare.tfout 
cd -