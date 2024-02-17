# Create private hoted zone
resource "aws_route53_zone" "private" {
  name = var.name

  vpc {
    vpc_id = var.vpc_id
  }
}

# Create record set in route53
resource "aws_route53_record" "alb_record" {
  zone_id = aws_route53_zone.private.zone_id
  name    = "test.example.com"
  type    = "A"

  alias {
    name                   = var.alias_name
    zone_id                = var.alias_zone_id
    evaluate_target_health = true
  }
}