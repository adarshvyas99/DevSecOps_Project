resource "aws_lb" "main" {
  name               = "${var.project_name}-alb"
  # tfsec:ignore:aws-elb-alb-not-public
  # This ALB is intentionally public to serve internet-facing traffic.
  internal           = false
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids
  security_groups    = [var.alb_sg_id]

  enable_deletion_protection = false
  drop_invalid_header_fields = true # Secure: Drops malformed/invalid headers before reaching target

  tags = {
    Name = "${var.project_name}-alb"
  }
}

resource "aws_lb_target_group" "app" {
  name     = "${var.project_name}-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/health"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  target_type = "ip"
}

# Ignore HTTP-only ALB listener (demo environment)
# tfsec:ignore:aws-elb-http-not-used
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}
