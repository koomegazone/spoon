# variable.tf
variable "bucket_name" {
  description = "bucket name"
  type        = string
  sensitive   = true
  default = "akbun-t101-week4-local-example"
}

