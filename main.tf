provider "aws" {
  region = "us-east-1"
}

# Create a VPC (no hourly charge)
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "demo-vpc"
    Environment = "Dev"
    Service = "doot"
  }
}

# Create an Internet Gateway (free)
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "demo-igw"
    Environment = "Dev"
    Service = "doot"
  }
}

# Create a subnet explicitly linked to the VPC
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "demo-subnet"
    Environment = "Dev"
    Service = "doot"
  }
}

# Create a route table associated with the subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "demo-rt"
    Environment = "Dev"
    Service = "doot"
  }
}

# Associate the subnet with the route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}
