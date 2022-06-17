# Configure vpc 
resource "aws_vpc" "my-vpc-pj" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true
  
  tags = {
    Name = "test vpc"
  }
}

# Create Internet Gateway and Attach it to VPC
resource "aws_internet_gateway" "my-igw-1" {
  vpc_id    = aws_vpc.my-vpc-pj.id

  tags      = {
    Name    = "test igw"
  }
}




# Create Route in Route Table for Internet Access
resource "aws_route" "public-route" {
  route_table_id = aws_route_table.public-route-table.id 
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.my-igw-1.id 
}


# Create Public Subnet 1
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.my-vpc-pj.id
  cidr_block              = var.public-subnet-1-cidr
  availability_zone       = "eu-west-2a"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public subnet 1 | web"
  }
}


# Create Public Subnet 2
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.my-vpc-pj.id
  cidr_block              = var.public-subnet-2-cidr
  availability_zone       = "eu-west-2b"
  map_public_ip_on_launch = true

  tags      = {
    Name    = "public subnet 2 | web"
  }
}


# Create Route Table and Add Public Route
resource "aws_route_table" "public-route-table" {
  vpc_id       = aws_vpc.my-vpc-pj.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw-1.id
  }

  tags       = {
    Name     = "public route table"
  }
}

# Associate Public Subnet 1 to "Public Route Table"
resource "aws_route_table_association" "public-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-1.id
  route_table_id      = aws_route_table.public-route-table.id
}


# Associate Public Subnet 2 to "Public Route Table"
resource "aws_route_table_association" "public-subnet-2-route-table-association" {
  subnet_id           = aws_subnet.public-subnet-2.id
  route_table_id      = aws_route_table.public-route-table.id
}


# Create Private Subnet 1
resource "aws_subnet" "private-subnet-1" {
  vpc_id                   = aws_vpc.my-vpc-pj.id
  cidr_block               = var.private-subnet-1-cidr
  availability_zone        = "eu-west-2a"
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private subnet 1 | app"
  }
}


# Create Private Subnet 2
resource "aws_subnet" "private-subnet-2" {
  vpc_id                   = aws_vpc.my-vpc-pj.id
  cidr_block               = var.private-subnet-2-cidr
  availability_zone        = "eu-west-2b"
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private subnet 2 | app"
  }
}

# Create Private Subnet 3
resource "aws_subnet" "private-subnet-3" {
  vpc_id                   = aws_vpc.my-vpc-pj.id
  cidr_block               = var.private-subnet-3-cidr
  availability_zone        = "eu-west-2a"
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private subnet 4 | database"
  }
}


# Create Private Subnet 4
resource "aws_subnet" "private-subnet-4" {
  vpc_id                   = aws_vpc.my-vpc-pj.id
  cidr_block               = var.private-subnet-4-cidr
  availability_zone        = "eu-west-2b"
  map_public_ip_on_launch  = false

  tags      = {
    Name    = "private subnet 4 | database"
  }
}



#Create Security Group
resource "aws_security_group" "my-security-group" {
  name        = "my security group"
  description = "VPC Default Security Group"
  vpc_id      = aws_vpc.my-vpc-pj.id

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    description = "Allow all IP and Ports Outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# Create Application load Balancer
resource "aws_lb" "alb-tritek" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my-security-group.id]
  subnets            = [aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id ]


  tags = {
    Environment = "production"
  }
}