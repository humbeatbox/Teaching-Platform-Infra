variable "aws_region" {
  description = "AWS Region to deploy resources"
  type        = string
  default     = "ca-central-1"
}

variable "domain_name" {
  description = "Domain name for the hosted zone"
  type        = string
  default     = "mern.garychang1214.com"
}

variable "cloudflare_api_token" {
  description = "API Token for Cloudflare DNS updates"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Zone ID for Cloudflare domain"
  type        = string
}
