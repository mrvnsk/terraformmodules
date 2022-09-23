output "region" {
    value = var.region
}

output "project-name" {
    value = var.project-name
}

output "vpc-id" {
    value = aws_vpc.vpc.id
}

output "pub-sub-az1-id" {
    value = aws_subnet.pub-sub-az1.id
}

output "pub-sub-az2-id" {
    value = aws_subnet.pub-sub-az2.id
}

output "pvt-app-sub-az1-id" {
    value = aws_subnet.pvt-app-sub-az1.id
}

output "pvt-app-sub-az2-id" {
    value = aws_subnet.pvt-app-sub-az2.id
}

output "pvt-data-sub-az1-id" {
  value = aws_subnet.pvt-data-sub-az1.id
}

output "pvt-data-sub-az2-id" {
  value = aws_subnet.pvt-data-sub-az2.id
}

output "internet_gateway" {
  value = aws_internet_gateway.igw
}