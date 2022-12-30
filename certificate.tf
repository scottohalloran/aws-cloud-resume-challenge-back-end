# The certificate being requested from ACM
resource "aws_acm_certificate" "awsresumeapi-tf" {
  domain_name       = "awsresumeapi-tf.scottohallorancv.com"
  validation_method = "DNS"
}
# The publically hosted zone in AWS Route 53
data "aws_route53_zone" "public" {
  name         = "scottohallorancv.com"
  private_zone = false
}
# Use for_each in case there are multiple alternative names on certificate
resource "aws_route53_record" "api_validation" {
  for_each = {
    for dvo in aws_acm_certificate.awsresumeapi-tf.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.public.zone_id
}
# Query DNS to get new CNAME records required by ACM
resource "aws_acm_certificate_validation" "awsresumeapi-tf" {
  certificate_arn         = aws_acm_certificate.awsresumeapi-tf.arn
  validation_record_fqdns = [for record in aws_route53_record.api_validation : record.fqdn]
}
