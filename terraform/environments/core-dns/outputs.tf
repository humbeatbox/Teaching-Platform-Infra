output "zone_id" {
  description = "The Hosted Zone ID"
  value       = aws_route53_zone.primary.zone_id
}

output "nameservers" {
  description = "The Nameservers of the hosted zone"
  value       = aws_route53_zone.primary.name_servers
}
