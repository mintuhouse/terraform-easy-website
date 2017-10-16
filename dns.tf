resource "aws_route53_zone" "website" {
  name = "${var.domain}"
}

output "ns-servers" {
  value = "${aws_route53_zone.website.name_servers}"
  description = "Set the NS records of ${var.domain} in your registrar zone file to `ns-servers`"
}
# https://dcc.godaddy.com/manage/${var.domain}/dns
# TODO: Automate using https://developer.godaddy.com/doc
# TODO: Add a DNSSEC record

