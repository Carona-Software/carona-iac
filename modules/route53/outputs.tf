output "zone_id" {
  value = aws_route53_zone.example.zone_id
}

output "record_fqdn" {
  value = aws_route53_record.www.fqdn
}
