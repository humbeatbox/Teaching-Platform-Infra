variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "ca-central-1"
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t3.medium"
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "mern.garychang1214.com"
}


