# Has to be unique across configurations as we use to store the terraform state
variable "subdomain" {
  description = "Subdomain of the website being configured"
} 

variable "domain" {
  description = "Domain for Route53 Zonefile."
}

variable "create_a_new_route53_zone" {
  description = "Whether ('true'/ 'false') to create a new Route53 Zonefile if it already exists"
  default = "true"
}

variable "route53_zone_id" {
  description = "Route53 Zone ID of the domain. If not provided, will create a Route53 zone"
  default = ""
}

variable "acm_certificate_arn" {
  description = "ARN of ACM SSL certificate for the subdomain"
}

variable "error_document" {
  description = "S3 bucket error page"
  default = "error.html"
}

variable "index_document" {
  description = "S3 bucket default page"
  default = "index.html"
}

variable "target" {
  description = "Target subdomain (https by default) to which current subdomain has to be redirected"
  default = ""
}

variable "redirect" {
  #Note: Terraform doesn't support booleans today. Use string "true" & "false"
  description = "Set to 'true' if subdomain is to be redirected to target"
  default = "false"
}