# Create a new Route53 Zone if var.route53_zone_id is not passed
resource "aws_route53_zone" "website" {
  count = "${var.route53_zone_id == "" ? 1 : 0}"
  name = "${var.domain}"
  comment = "IMPORTANT: Don't Delete"
  lifecycle {
    prevent_destroy = true # We use this zone file for other records (MX, TXT etc) also
  }
}

output "ns-servers" {
  value = "${aws_route53_zone.website.name_servers}"
  description = "Set the NS records of ${var.domain} in your registrar zone file to `ns-servers`"
  depends_on = ["aws_route53_zone.website"]
}

locals { 
  route53_zone_id = "${var.route53_zone_id == "" ? aws_route53_zone.website.zone_id : var.route53_zone_id}"
  depends_on = ["aws_route53_zone.website"]
}

# https://dcc.godaddy.com/manage/${var.domain}/dns
# TODO: Automate using https://developer.godaddy.com/doc
# TODO: Add a DNSSEC record

