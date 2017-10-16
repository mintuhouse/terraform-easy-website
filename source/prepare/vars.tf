variable "s3_terraform_log_bucket_name" {
  type = "string"
  description = "Bucket name for storing terraform logs"
  default = "terraform-log-bucket"
}

variable "s3_remote_state_bucket_prefix" {
  type = "string"
  description = "Bucket name prefix for storing remote state"
  default = "terraform-state-"
}