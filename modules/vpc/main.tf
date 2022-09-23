# Create VPC
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc-cidr
    instance_tenancy = "default"
    enable_dns_hostnames = true

    tags = {
        Name = "${var.project-name}-vpc"
    }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
    vpc_id =  aws_vpc.vpc.id 

    tags = {
      Name = "${var.project-name}-vpc-igw"
    }
}

# use data source to get all avaliability zone in region
data "aws_availability_zones" "availability_zones" {}

# Create public subnet az1
resource "aws_subnet" "pub-sub-az1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub-sub-az1-cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch = true

    tags = {
       Name = "${var.project-name}-pub-sub-az1"
    }
}

# Create public subnet az2
resource "aws_subnet" "pub-sub-az2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pub-sub-az2-cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch = true

    tags = {
       Name = "${var.project-name}-pub-sub-az2"
    }
}

# Create Route Table and add public route
resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "${var.project-name}-pub-rt"
    }
}

# Associate public subnet az1 to public route table
resource "aws_route_table_association" "pub-sub-az1-pub-rt-assoc" {
    subnet_id = aws_subnet.pub-sub-az1.id
    route_table_id = aws_route_table.public_rt.id
}

# Associate public subnet az2 to public route table
resource "aws_route_table_association" "pub-sub-az2-pub-rt-assoc" {
    subnet_id = aws_subnet.pub-sub-az2.id
    route_table_id = aws_route_table.public_rt.id
}

# Create private app subnet az1
resource "aws_subnet" "pvt-app-sub-az1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pvt-sub-az1-cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.project-name}-pvt-app-sub-az1"
    }
}

# Create private subnet az2
resource "aws_subnet" "pvt-app-sub-az2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pvt-sub-az2-cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.project-name}-pvt-app-sub-az2"
    }
}

# Create private data subnet az1
resource "aws_subnet" "pvt-data-sub-az1" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pvt-data-sub-az1-cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[0]
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.project-name}-pvt-data-sub-az1"
    }
}

# Create private data subnet az2
resource "aws_subnet" "pvt-data-sub-az2" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.pvt-data-sub-az2-cidr
    availability_zone = data.aws_availability_zones.availability_zones.names[1]
    map_public_ip_on_launch = false

    tags = {
        Name = "${var.project-name}-pvt-data-sub-az2"
    }
}