resource "aws_vpc" "emby-project" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "emby-VPC"
  }
}

resource "aws_subnet" "emby-pub-1" {
  vpc_id                  = aws_vpc.emby-project.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.ZONE1

  tags = {
    Name = "emby-pub-1"
  }
}

resource "aws_internet_gateway" "emby-IGW" {
  vpc_id = aws_vpc.emby-project.id

  tags = {
    Name = "emby-IGW"
  }
}

resource "aws_route_table" "emby-pub-RT" {
  vpc_id = aws_vpc.emby-project.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.emby-IGW.id
  }

  tags = {
    Name = "emby-pub-RT"
  }
}

resource "aws_route_table_association" "emby-pub-1-a" {
  subnet_id      = aws_subnet.emby-pub-1.id
  route_table_id = aws_route_table.emby-pub-RT.id
}