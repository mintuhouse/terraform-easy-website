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

state_output=$(terraform state show module.aws-dns.aws_route53_zone.website)
state_domain=$(echo "$state_output" | grep "name\s*=" | sed 's/name.*=\s*\(.*\)/\1/')
state_zone_id=$(echo "$state_output" | grep "zone_id\s*=" | sed 's/zone_id.*=\s*\(.*\)/\1/')

# Import the zone file if it already exists
zone_id=$(aws route53 list-hosted-zones-by-name  --dns-name "${DOMAIN}" --max-items 1 | jq ".HostedZones[0].Id" | tr -d '"' | rev | cut -d'/' -f1 | rev)
if [[ "$zone_id" == "null" ]]; then
  unset zone_id
elif [[ "$state_domain" == "" ]]; then # No state file found
  echo "Nothing to worry! We'll now create a new state file."
  terraform import module.aws-dns.aws_route53_zone.website $zone_id
elif [[ "$state_domain" != "$DOMAIN" ]] || [[ "$state_zone_id" != "$zone_id" ]]; then
  echo "Domain and Current Zone ID in state file doesn't match with remote"
  exit
#else 
  # Nothing to do
fi

terraform plan -out main.tfout -var-file="${CONFIG_FILE}" -var="route53_zone_id=${zone_id}" -detailed-exitcode
return_code=$?

if [[ $return_code != 0 ]]
then
  read -r -p "Are you sure you want to make above changes? [y/N] " response
  response=${response,,}    # tolower
  if [[ "$response" =~ ^(yes|y)$ ]]
  then
    terraform apply main.tfout 
  else
    echo "Exiting...!"
  fi 
fi

# Cleanup
rm -f main.tfout
cd $OLDPWD
