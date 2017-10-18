variable "enable" {
  description = "Whether to enable this module (Emulate conditional logic in modules)"
  # Tracking https://github.com/hashicorp/terraform/issues/953
  default = "true"
}

variable "subdomain" {
  description = "Subdomain of the website being configured"
} 

variable "route53_zone_id" {
  description = "Route53 Zone ID of the domain. If not provided, will create a Route53 zone"
}

variable "acm_certificate_arn" {
  description = "ARN of ACM SSL certificate for the subdomain"
}

variable "target" {
  description = "Target subdomain to which current subdomain has to be redirected (https by default)"
}

