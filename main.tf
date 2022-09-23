# Configure AWS Provider
provider "aws" {
    region = var.region
    profile = "tf-user"
}

# Create VPC
module "vpc" {
  source                = "./modules/vpc"
  region                = var.region
  project-name          = var.project-name
  vpc-cidr              = var.vpc-cidr
  pub-sub-az1-cidr      = var.pub-sub-az1-cidr
  pub-sub-az2-cidr      = var.pub-sub-az2-cidr
  pvt-sub-az1-cidr      = var.pvt-sub-az1-cidr
  pvt-sub-az2-cidr      = var.pvt-sub-az2-cidr
  pvt-data-sub-az1-cidr = var.pvt-data-sub-az1-cidr
  pvt-data-sub-az2-cidr = var.pvt-data-sub-az2-cidr
}

# Create security group
module "security-group" {
  source                = "./modules/securitygroups"
  vpc-id                = module.vpc.vpc-id
}

# Create IAM Role
module "ecs-task-execution-role" {
  source                = "./modules/ecs-task-exec-role"
  project-name          = var.project-name
}