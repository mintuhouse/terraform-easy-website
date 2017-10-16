#!/bin/bash 

prepare_path="$(dirname "$0")/../source/prepare"
cd $prepare_path
terraform init
terraform plan -out prepare.tfout 
terraform apply prepare.tfout 
terraform output | sed 's/\(.*\)=\s*\(.*\)/\1= "\2"/g' > ../main/backend-config
cd -

# TODO: Create a branch with with prepare script and clean it up as having a remote backend for something as simple as static website is an overkill
