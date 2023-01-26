# create an IGW (Internet Gateway)
# It enables vpc to connect to the internet
resource "aws_internet_gateway" "shardeum_igw" {
  vpc_id = aws_vpc.shardeum_vpc.id

  tags = {
    Name = "shardeum_igw"
  }
}

# create a custom route table for public subnets
# public subnets can reach to the internet buy using this
resource "aws_route_table" "shardeum_public_crt" {
  vpc_id = aws_vpc.shardeum_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.shardeum_igw.id
  }

  tags = {
    Name = "shardeum_public_crt"
  }
}

# route table association for the public subnets
resource "aws_route_table_association" "shardeum_crta_public_subnet_1" {
  subnet_id      = aws_subnet.shardeum_subnet_public_1.id
  route_table_id = aws_route_table.shardeum_public_crt.id
}

# security group
resource "aws_security_group" "shardeum_validator_sg" {

  vpc_id = aws_vpc.shardeum_vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # expose port 8080 for the validator GUI
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # expose port 9001 & 10001
  ingress {
    from_port   = 9001
    to_port     = 9001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 10001
    to_port     = 10001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "shardeum_validator_sg"
  }
}