# Create Elastic IP address for NAT gateway-az1
resource "aws_eip" "eip-ngw-az1" {
    vpc = true

    tags ={
        Name = "${var.project-name}-EIP-1"
    }
}

# Create Elastic IP address for NAT gateway-az2
resource "aws_eip" "eip-ngw-az2" {
    vpc = true

    tags ={
        Name = "${var.project-name}-EIP-2"
    }
}

# Create NAT Gateway in Public Subnet az1
resource "aws_nat_gateway" "ngw-az1" {
    allocation_id = aws_eip.eip-ngw-az1.id
    subnet_id     = var.pub-sub-az1-id

    tags = {
      Name = "${var.project-name}-ngw-az1"
    }
    # To ensure proper ordering, it is r
    depends_on = [var.internet_gateway]
}

# Create NAT Gateway in Public Subnet az2
resource "aws_nat_gateway" "ngw-az2" {
    allocation_id = aws_eip.eip-ngw-az2.id
    subnet_id     = var.pub-sub-az2-id
 
    tags = {
      Name = "${var.project-name}-ngw-az2"
    }

    # To ensure proper ordering, it is r
    depends_on = [var.internet_gateway]
}

# Create a Private Route table-az1 and add the route table through nat gateway az1
resource "aws_route_table" "pvt-rt-az1" {
    vpc_id = var.vpc-id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.ngw-az1.id
    }

    tags = {
      Name = "pvt-rt-az1"
    }
}

# Associate private app subnet-1 with pvt route table-az1
resource "aws_route_table_association" "pvt-app-sub-az1-pvt-rt-az1-assoc" {
    subnet_id = var.pvt-app-sub-az1-id
    route_table_id = aws_route_table.pvt-rt-az1.id
}

# Associate private data subnet-1 with pvt route table-az1
resource "aws_route_table_association" "pvt-data-sub-az1-pvt-rt-az1-assoc" {
    subnet_id = var.pvt-data-sub-az1-id
    route_table_id = aws_route_table.pvt-rt-az1.id
}

# Create a Private Route table-az2 and add the route table through nat gateway az2
resource "aws_route_table" "pvt-rt-az2" {
    vpc_id = var.vpc-id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.ngw-az2.id
    }

    tags = {
      Name = "pvt-rt-az2"
    }
}

# Associate private app subnet-az2 with pvt rt az2
resource "aws_route_table_association" "pvt-app-sub-az2-pvt-rt-az2-assoc" {
    subnet_id = var.pvt-app-sub-az2-id
    route_table_id = aws_route_table.pvt-rt-az2.id
}

# Associate private data subnet-az2 with pvt rt az2
resource "aws_route_table_association" "pvt-data-sub-az2-pvt-rt-az2-assoc" {
    subnet_id = var.pvt-data-sub-az2-id
    route_table_id = aws_route_table.pvt-rt-az2.id
}