data "aws_route53_zone" "root_domain" {
  name         = var.root_domain
  private_zone = var.private
}

/*

// Creation
resource "aws_route53_zone" "root_domain" {
  name         = var.root_domain
  comment       = "Hosted Zone for ${var.root_domain)}"
}
*/

# Sub domain Hosted Zone ( Ex. dev.example.com)
resource "aws_route53_zone" "sub_domain_zone" {
  for_each = toset(var.sub_domains)
  name          = format("%s.%s", each.value, var.root_domain)
  comment       = "Hosted Zone for ${format("%s.%s", each.value, var.root_domain)}"
}

# Record in the example.com hosted zone that contains the name servers of the dev.example.com hosted zone.
resource "aws_route53_record" "ns_record" {
  for_each = aws_route53_zone.sub_domain_zone
  type    = "NS"
  zone_id = data.aws_route53_zone.root_domain.id
  name    = each.value.name
  ttl     = "86400"
  records = each.value.name_servers
}

# See : https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/dns-routing-traffic-for-subdomains.html