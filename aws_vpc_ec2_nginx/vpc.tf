# Resource to create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "100.0.0.0/16"
    tags = {
        Name = "my_vpc"
    }
}

#private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "100.0.1.0/24"
  availability_zone = "us-east-1b" # Replace with your desired AZ
    tags = {
        Name = "private_subnet"
    }
}


#public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "100.0.0.0/24"    
  availability_zone = "us-east-1a" # Replace with your desired AZ
    tags = {
      Name = "public_subnet"
    }
} 

# Resource to create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "my_igw"
  }
}

# Resource to create a route table 
# This route table will allow traffic to the Internet Gateway
# public_route_table name could be anything and is used to create a route table for the public
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
    }   
    tags = {
        Name = "public_route_table"
    }
}

# Associate the public subnet with the route table
# public_route_table_association name could be anything and is used to associate the public subnet with the route table
resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}