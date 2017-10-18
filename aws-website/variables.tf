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

variable "error_document" {
  description = "S3 bucket error page"
  default = "error.html"
}

variable "index_document" {
  description = "S3 bucket default page"
  default = "index.html"
}
