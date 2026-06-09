#######################################
# PROVIDER (IMPORTANT - ENSURES CLEAN RUN)
#######################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

#######################################
# AMI (Amazon Linux 2023)
#######################################
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#######################################
# AUTO DETECT PUBLIC IP (NO VARIABLES)
#######################################
data "http" "my_ip" {
  url = "https://ipv4.icanhazip.com"
}

locals {
  my_ip_cidr = "${chomp(data.http.my_ip.response_body)}/32"
}

#######################################
# VPC
#######################################
resource "aws_vpc" "mern_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "mern-vpc"
  }
}

#######################################
# PUBLIC SUBNET
#######################################
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.mern_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "public-subnet"
  }
}

#######################################
# PRIVATE SUBNET
#######################################
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.mern_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "private-subnet"
  }
}

#######################################
# INTERNET GATEWAY
#######################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.mern_vpc.id
}

#######################################
# NAT GATEWAY
#######################################
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  depends_on = [aws_internet_gateway.igw]
}

#######################################
# ROUTE TABLES
#######################################
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.mern_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.mern_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

#######################################
# ROUTE TABLE ASSOCIATIONS
#######################################
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

#######################################
# SECURITY GROUP - WEB
#######################################
resource "aws_security_group" "web_sg" {
  name   = "web-sg"
  vpc_id = aws_vpc.mern_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_ip_cidr]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
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

#######################################
# SECURITY GROUP - MONGO
#######################################
resource "aws_security_group" "mongo_sg" {
  name   = "mongo-sg"
  vpc_id = aws_vpc.mern_vpc.id

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#######################################
# IAM ROLE
#######################################
resource "aws_iam_role" "ec2_role" {
  name = "mern-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_instance_profile" "profile" {
  role = aws_iam_role.ec2_role.name
}

#######################################
# EC2 WEB
#######################################
resource "aws_instance" "web" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  key_name = "mern-key"

  iam_instance_profile = aws_iam_instance_profile.profile.name

    root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name = "web-server"
  }
}

#######################################
# EC2 MONGO
#######################################
resource "aws_instance" "mongo" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.mongo_sg.id]

  key_name = "mern-key"

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }
  
  tags = {
    Name = "mongo-server"
  }
}