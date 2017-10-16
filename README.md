# Terraform Easy Website

* Websites are configured with HTTPS by default
* Works with latest terraform

# Prerequisites
* Install 
  * [Terraform(>= 0.8.0)](https://www.terraform.io/intro/getting-started/install.html)
  * [awscli](https://aws.amazon.com/cli/)
  * [jq](https://stedolan.github.io/jq/)

* [Configure](#aws-provider-authentication) AWS credentials
* Delete example [terraform.tfstate](terraform.tfstate) ( `rm terraform.tfstate` )
* [Create ACM certificates](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-request.html) for the domains you want to use in us-east-1 region and note their IDs 
  *  e.g., `aws acm request-certificate --region us-east-1 --domain-name "*.astarcrm.com" --subject-alternative-names "*.astarcrm.in" --idempotency-token random`
  
      Note: 
      * Type the above command only once
      * To use an ACM certificate with Amazon CloudFront, you must request or import the certificate in the US East (N. Virginia) region
  * You will receive an email with [instructions](https://docs.aws.amazon.com/acm/latest/userguide/gs-acm-validate.html) for each domain. Follow the steps in it to validate the ownership of domain.
  * Once all the domain names in the certificate request are approved, confirm that the certificate status is `Issued` on [AWS Console](https://console.aws.amazon.com/acm/home?region=us-east-1)
  * Note the ARN in Details section of the certificate 
  
      e.g., `arn:aws:acm:us-east-1:352457905336:certificate/bb324c8f-6652-4610-aebc-6baa0b6817c4`

# Usage
*

# AWS provider authentication
[Configure](https://www.terraform.io/docs/providers/aws/#authentication) via environment variables
* `AWS_SECRET_ACCESS_KEY`
* `AWS_ACCESS_KEY_ID`
* `AWS_DEFAULT_REGION`

OR
* `AWS_PROFILE`
* `AWS_SHARED_CREDENTIALS_FILE `

# HTTPS 



