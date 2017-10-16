provider "terraform" {
  version = "~> 1.0"
}

terraform {
  backend "s3" {
    #bucket = "" # From backend-config
    #dynamodb_table = "" # For lock during plan execution - From backend-config
    #key = "${subdomain}" # Path for .tfstate inside the bucket
    encrypt = true # Enable Server Side Encryption
  }
}

# data "terraform_remote_state" "website" {
#   backend = "s3"
# }
