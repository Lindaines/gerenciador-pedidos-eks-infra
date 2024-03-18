variable "aws_region" {
  type    = string
  default = "us-east-1"
}

variable "aws_access_id" {
  description = "AWS access ID"
  sensitive = true
}

variable "aws_secret" {
  description = "AWS Secret"
  sensitive = true
}

