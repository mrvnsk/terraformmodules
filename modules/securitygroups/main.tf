# Create security group for the application load balancer
resource "aws_security_group" "alb_sg" {
    name                = "alb security group"
    description         = "enable http/https on port 80"
    vpc_id              = var.vpc-id

    ingress {
        description     = "http access"
        from_port       = 80
        to_port         = 80
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    ingress {
        description     = "https access"
        from_port       = 443
        to_port         = 443
        protocol        = "tcp"
        cidr_blocks     = ["0.0.0.0/0"]
    }

    egress {
        from_port       = 0
        to_port         = 0
        protocol        = -1
        cidr_blocks     = ["0.0.0.0/0"]
    }

    tags = {
      Name = "alb security group"
    }
}

# Create Security groups for the Container
resource "aws_security_group" "ecs_sg" {
    name               = "ecs security group"
    description        = "enable http/https ports on 80/443 via alb sg"
    vpc_id             = var.vpc-id

    ingress {
        description = "http access"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }

    ingress {
        description = "https access"
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = [aws_security_group.alb_sg.id]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "ecs security group"
    }
}