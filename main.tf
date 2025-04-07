provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
}

resource "aws_instance" "web" {
  ami           = "ami-01e3c4a339a264cc9" # Amazon Linux 2
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
}
