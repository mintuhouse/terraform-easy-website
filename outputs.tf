output "ns_servers" {
  value = "${module.aws-dns.route53_name_servers}"
  description = "Set the NS records of ${var.domain} in your registrar zone file to `ns_servers`"
}