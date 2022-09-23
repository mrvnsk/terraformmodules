# Store the terraform state file in s3
terraform {
  backend "s3" {
    bucket      = "terraformbackupfile-s3"
    key         = "lih-website-ecs.tfstate.dev"
    region      = "ap-south-1"
    profile     = "tf-user"
  }
}