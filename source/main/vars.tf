# Has to be unique across configurations as we use to store the terraform state
variable "subdomain" {
  type = "string"
  description = "Subdomain of the website being configured"
}