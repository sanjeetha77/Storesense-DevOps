resource "aws_vpc" "Storesense-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.project_name}-VPC"
  }
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.Storesense-vpc.id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.project_name}-Public Subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Storesense-vpc.id
  tags = {
    Name = "${var.project_name}-IGW"
  }
}
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.Storesense-vpc.id
  tags = {
    Name = "${var.project_name}-rt"
  }
}
resource "aws_route" "internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}