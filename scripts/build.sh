#!/bin/bash 

# Check if required packages are installed
command -v aws >/dev/null 2>&1 || { echo >&2 "awscli is required, but not found.  Aborting."; exit 1; }
command -v jq >/dev/null 2>&1 || { echo >&2 "jq is required, but not found.  Aborting."; exit 1; }

# Check if required ENV variables are passed
: ${SUBDOMAIN?"Need to set ENV variable SUBDOMAIN"} # Exit if SUBDOMAIN is not defined
default_config_file="../../examples/${SUBDOMAIN}.tfvars"
CONFIG_FILE="${CONFIG_FILE:-$default_config_file}"

main_path="$(dirname "$0")/../source/main"
cd $main_path

terraform init -backend-config=backend-config -backend-config="key=${SUBDOMAIN}"

DOMAIN=$(sed -n 's/^domain=//p' $CONFIG_FILE | tr -d '"')
# Import the zone file if it already exists
zone_id=$(aws route53 list-hosted-zones-by-name  --dns-name "${DOMAIN}" --max-items 1 | jq ".HostedZones[0].Id" | tr -d '"' | rev | cut -d'/' -f1 | rev)
if ! [[ "$zone_id" -eq "null" ]]; then
  terraform import aws_route53_zone.website $zone_id
fi

terraform plan -out main.tfout -var="subdomain=${SUBDOMAIN}" -var-file="${CONFIG_FILE}"

terraform apply main.tfout 

cd -
