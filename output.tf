output "alb" {
  value = "${aws_lb.alb}"
}

output "listener" {
  value = "${aws_lb_listener.ssl}"
}

