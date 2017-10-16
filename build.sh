#!/bin/bash 

# Check if required packages are installed
command -v aws >/dev/null 2>&1 || { echo >&2 "awscli is required, but not found.  Aborting."; exit 1; }
command -v jq >/dev/null 2>&1 || { echo >&2 "jq is required, but not found.  Aborting."; exit 1; }

# Check if required ENV variables are passed
: ${CONFIG_FILE?"Need to set ENV variable CONFIG_FILE"}

main_path="$(dirname "$0")"
cd $main_path

DOMAIN=$(jq '.domain' $CONFIG_FILE | tr -d '"')
SUBDOMAIN=$(jq '.subdomain' $CONFIG_FILE | tr -d '"')
STATE_PATH="tfstate/${SUBDOMAIN}.tfstate"

terraform init -backend-config="path=$STATE_PATH"

# Import the zone file if it already exists
zone_id=$(aws route53 list-hosted-zones-by-name  --dns-name "${DOMAIN}" --max-items 1 | jq ".HostedZones[0].Id" | tr -d '"' | rev | cut -d'/' -f1 | rev)
if [[ "$zone_id" -eq "null" ]]; then
  unset zone_id
else
  terraform import aws_route53_zone.website $zone_id
fi

terraform plan -out main.tfout -var-file="${CONFIG_FILE}" -var="route53_zone_id=${zone_id}"

terraform apply main.tfout 

cd -
