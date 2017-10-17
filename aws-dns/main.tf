resource "aws_route53_zone" "website" {
  count = "${var.enable == "true" ? 1 : 0}"
  name = "${var.domain}"
  comment = "IMPORTANT: Don't Delete"
  lifecycle {
    prevent_destroy = true # We use this zone file for other records (MX, TXT etc) also
  }
}
