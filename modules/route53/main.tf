resource "aws_route53_zone" "example" {
  name = var.domain_name
  vpc {
    vpc_id = var.vpc_id
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.example.zone_id
  name    = "backend"
  type    = "A"
  ttl     = "300"
  records = [var.private_ip_address]
}
