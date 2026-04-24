variable "aws_region" {
  default     = "us-east-1"
  description = "Region de AWS"
}

variable "project_name" {
  default     = "lab-terraform-aws"
  description = "Localstack AWS Terraform"
}

variable "bucket_name" {
  default     = "bucket-local-eventos"
  description = "Primer S3"
}
