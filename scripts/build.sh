#!/bin/bash 
main_path="$(dirname "$0")/../source/main"
cd $main_path
: ${SUBDOMAIN?"Need to set ENV variable SUBDOMAIN"}
terraform init -backend-config=backend-config -backend-config="key=${SUBDOMAIN}"
terraform plan -out prepare.tfout -var="subdomain=${SUBDOMAIN}"
cd -
