output "route53_name_servers" {
  # value = "${var.enable == "true" ? aws_route53_zone.website.name_servers : ""}"
  # Hack to get lists working with conditionals (https://github.com/hashicorp/terraform/issues/12453)
  value = "${split(",", var.enable == "true" ? join(",", aws_route53_zone.website.name_servers) : "")}"
  description = "Set the NS records of ${var.domain} in your registrar zone file to `ns-servers`"
}

output "route53_zone_id" {
  value = "${var.enable == "true" ? aws_route53_zone.website.zone_id : ""}"
  description = "ID of the Route53 zone just created"
}