output "alb-sg-id" {
    value = aws_security_group.alb_sg.id  
}

output "ecs-sg-id" {
    value = aws_security_group.ecs_sg.id
}

