resource "aws_route53_zone" "main" {
  name = var.domain_name

  tags = {
    Name = "${var.app_name}-zone"
  }
}

resource "aws_route53_record" "app" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = 60
  records = [var.instance_ip]
}
