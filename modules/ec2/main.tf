# Create Terraform ec2 instance
resource "aws_instance" "terraform-instance" {
    region              = var.region
    ami                 = var.ami-id
    instance_type       = var.instance-type
    key_name            = var.key-name
    vpc_id              = var.vpc-id
    subnet_id           = var.subnet-id
    security_groups     = var.security-group

    tags = {
        Name = "terraform"
    }    
}