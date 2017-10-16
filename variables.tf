# Has to be unique across configurations as we use to store the terraform state
variable "subdomain" {
  type = "string"
  description = "Subdomain of the website being configured"
} 

variable "domain" {
  type = "string"
  description = "Domain for Route53 Zonefile. Prepopulate via import command if already exists"
}

variable "route53_zone_id" {
  type = "string"
  description = "Route53 Zone ID of the domain"
  default = ""
}