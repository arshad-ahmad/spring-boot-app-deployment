provider "aws" {
  region = "us-east-1" # Change as needed
}

# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

# Internet Gateway to enable internet access
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Route Table for public subnet to route traffic through the internet gateway
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

# Associate route table with the public subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group allowing HTTP (port 80) traffic from anywhere
resource "aws_security_group" "allow_http" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance for Spring Boot App
resource "aws_instance" "app" {
  ami           = "ami-12345678" # Replace with your AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id
  security_groups = [aws_security_group.allow_http.name]

  tags = {
    Name = "SpringBootApp"
  }

  # Attach an Elastic IP
  associate_public_ip_address = true
}

# Elastic IP for the EC2 instance
resource "aws_eip" "app" {
  instance = aws_instance.app.id
}
