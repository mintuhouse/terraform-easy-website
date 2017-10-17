terraform {
  backend "local" {
    # Set path via -backend-config="path=<path>.tfstate"
  } 
}

provider "aws" {
  version = "~> 1.0"
  # Configured via ENV variables
}

locals {
  create_a_new_route53_zone = "${((var.create_a_new_route53_zone == "true") && (var.route53_zone_id == "")) ? "true" : "false"}"
}

# Create a new Route53 Zone if var.route53_zone_id is not passed
module "aws-dns" {
  source = "./aws-dns"
  domain = "${var.domain}"
  enable = "${local.create_a_new_route53_zone}"
}

locals { 
  route53_zone_id = "${local.create_a_new_route53_zone == "true" ? module.aws-dns.route53_zone_id : var.route53_zone_id}"
}

# module "aws-website" {
#   source = "./aws-website"
# }