# create vpc 
resource "aws_vpc" "example" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "lilos-vpc"
    Create = "Terraform"
  }
}

# create the subnet and connect to vpc
resource "aws_subnet" "Public-Subnet" {
  count      = var.subnet_count
  vpc_id     = aws_vpc.example.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
  map_public_ip_on_launch = var.map_public_ip

  tags = {
    Name = "lilos-public-subnet"
    Create = "Terraform"
  }
}
resource "aws_subnet" "Private-Subnet" {
  count      = var.subnet_count
  vpc_id     = aws_vpc.example.id
  cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index + 100)
  map_public_ip_on_launch = false

  tags = {
    Name = "lilos-private-subnet"
    Create = "Terraform"
  }
}

# create igw and connect to vpc
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.example.id
  tags = {
    Name = "lilos-igw"
    Create = "Terraform"
  }
}
# create a route table -Public
resource "aws_route_table" "rt_Public" {
  vpc_id = aws_vpc.example.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "lilos-public-rt"
    Create = "Terraform"
  }
}
# create a route table -Private
resource "aws_route_table" "rt_Private" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "lilos-private-rt"
    Create = "Terraform"
  }
}

resource "aws_route_table_association" "public_assoc" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.Public-Subnet[count.index].id
  route_table_id = aws_route_table.rt_Public.id
}

# connect the route table to the subnet
resource "aws_route_table_association" "con-Private-rt" {
  count          = var.subnet_count
  subnet_id      = aws_subnet.Private-Subnet[count.index].id 
  route_table_id = aws_route_table.rt_Private.id
}

#  create a security group
resource "aws_security_group" "sg" {
  name   = "sg"
  vpc_id = aws_vpc.example.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lilos-sg"
    Create = "Terraform"
  }
}
