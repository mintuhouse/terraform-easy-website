#!/bin/bash 

prepare_path="$(dirname "$0")/../source/prepare"
cd $prepare_path
terraform init
terraform plan -out prepare.tfout 
terraform apply prepare.tfout 
terraform output | sed 's/\(.*\)=\s*\(.*\)/\1= "\2"/g' > ../main/backend-config
cd -