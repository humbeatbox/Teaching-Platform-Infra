terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

# --- Route53 Zone ---
resource "aws_route53_zone" "primary" {
  name = var.domain_name
}

# --- Cloudflare DNS Automation ---
# Automatically updates Cloudflare with the random NS records AWS assigned to us
resource "cloudflare_record" "ns" {
  for_each = toset(aws_route53_zone.primary.name_servers)

  zone_id         = var.cloudflare_zone_id
  name            = "mern" # Subdomain name
  type            = "NS"
  value           = each.value
  ttl             = 3600 # 1 hour
  allow_overwrite = true
}
