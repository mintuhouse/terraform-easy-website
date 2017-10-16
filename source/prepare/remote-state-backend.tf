provider "aws" {
  version = "~> 1.0"
} # Configured via ENV variables

# Bucket for sending logs
resource "aws_s3_bucket" "log_bucket" {
  bucket = "${var.s3_terraform_log_bucket_name}"
  acl = "log-delivery-write"
}

# Bucket for storing remote terraform state
resource "aws_s3_bucket" "remote-state" {
  bucket_prefix = "${var.s3_remote_state_bucket_prefix}"
  acl = "private"
  # Enable versioning to allow for state recovery
  versioning {
    enabled = true
  }
  logging {
    target_bucket = "${aws_s3_bucket.log_bucket.id}"
    target_prefix = "log/"
  }
  tags {
    Name = "Terraform State"
  }
}

# DynamoDB table for state lock 
resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = "terraform-state-lock"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

output "bucket-name" {
  value = "${aws_s3_bucket.remote-state.id}"
}

output "dynamodb-name" {
  value = "${aws_dynamodb_table.terraform-state-lock.name}"
}