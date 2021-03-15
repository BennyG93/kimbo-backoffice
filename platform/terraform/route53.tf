resource "aws_route53_record" "backoffice_public_dns" {
  zone_id = var.dns.public.id
  name    = "backoffice.kimboapp.com"
  type    = "A"

  alias {
    name                   = module.alb.this_lb_dns_name
    zone_id                = module.alb.this_lb_zone_id
    evaluate_target_health = true
  }
}