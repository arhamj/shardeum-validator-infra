resource "aws_vpc" "shardeum_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  instance_tenancy     = "default"

  tags = {
    Name = "shardeum_vpc"
  }
}

resource "aws_subnet" "shardeum_subnet_public_1" {
  vpc_id                  = aws_vpc.shardeum_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = "ap-south-1a"

  tags = {
    Name = "shardeum_subnet_public_1"
  }
}