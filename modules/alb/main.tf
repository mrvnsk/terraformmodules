# Create Application load balancer
resource "aws_lb" "application-lb" {
    name                = "${var.project-name}-alb"
    internal            = false
    load_balancer_type  = "application"
    security_groups     = [var.alb-sg-id]
    subnets             = [var.pub-sub-az1-id, var.pub-sub-az2-id]
    enable_deletion_protection = false

    tags = {
      Name = "${var.project-name}-alb"
    }
}

# Create target group
resource "aws_lb_target_group" "alb-tg" {
    name                = "${var.project-name}-tg"
    target_type         = "ip"
    port                = 80
    protocol            = "HTTP"
    vpc_id              = var.vpc-id

    health_check {
      enabled           = true
      interval          = 300
      path              = "/"
      timeout           = 60
      matcher           = 200
      healthy_threshold = 5
      unhealthy_threshold = 5
    }

    lifecycle {
      create_before_destroy = true
    }
}

# Create listener on port 80 with redirect action
resource "aws_lb_listener" "alb-http-listener" {
    load_balancer_arn =  aws_lb.application_lb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
      type = "redirect"

      redirect {
        port          = 443
        protocol      = "HTTPS"
        status_code   = "HTTP_301"        
      }
    }
}

# Create a listener on port 443 with forward action
resource "aws_lb_listener" "alb-https-listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
}