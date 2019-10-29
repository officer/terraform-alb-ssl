
module "logging_bucket" {
  source    = "github.com/officer/terraform-logging-bucket.git"
  region    = "${var.region}"
  namespace = "${var.prefix}"
  tags      = "${var.tags}"
}

module "certificate" {
  source      = "github.com/officer/terraform-acm-certificate.git"
  region      = "${var.region}"
  zone_id     = "${var.zone_id}"
  domain_name = "${var.domain_name}"
  tags        = "${var.tags}"
}


resource "aws_lb" "alb" {
  name_prefix           = "${var.prefix}"
  internal              = false
  load_balancer_type    = "application"

  subnets               = "${var.subnets}"
  security_groups       = "${var.security_groups}"

  access_logs {
    bucket = "${module.logging_bucket.bucket.bucket}"
    enabled = "true"
  }
}

resource "aws_lb_listener" "ssl" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  certificate_arn   = "${module.certificate.certificate_arn}"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Fixed response content"
      status_code  = "200"
    }
  }
}
