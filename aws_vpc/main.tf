terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "6.5.0"
        }
    }
}

provider "aws" {
  region = var.region
}

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

# Resource to create an EC2 instance in the public subnet
# This instance will be accessible from the Internet through the public subnet
resource "aws_instance" "my_server"{
  ami           = "ami-020cba7c55df1f615" # Example AMI ID, replace with a valid one
  instance_type = "t2.nano"
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "MyInstance-1"
  }
}

/*
# Resource to manage the state of the EC2 instance
# This resource is used to control the state of the instance (running, stopped, terminated)
resource "aws_ec2_instance_state" "my_server_state" {
  instance_id = aws_instance.my_server.id
  state       = "terminated"
# Change to "stopped" if you want the instance to be stopped initially
# Change to "running" if you want the instance to be running initially
# Change to "terminated" if you want the instance to be terminated initially
}





# Resource to create a security group that allows SSH and HTTP traffic
resource "aws_security_group" "my_sg" {
  name        = "my_security_group"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.my_vpc.id

# Ingress rules to allow SSH and HTTP traffic
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["100.0.0.0/16"] # Allow SSH from within the VPC
  } 

# Egress rules to allow all outbound traffic
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["100.0.0.0/16"] # Allow HTTP from within the VPC
    }
# Egress rule to allow all outbound traffic
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1" # Allow all outbound traffic
        cidr_blocks = ["0.0.0.0/0"]
    }   

    tags = {
        Name = "my_security_group"
    }
}   

# Resource to create an EC2 instance in the public subnet
resource "aws_instance" "my_server" {
  ami           = "ami-020cba7c55df1f615" # Example AMI ID, replace with a valid one
  instance_type = "t2.nano"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.my_sg.name]

  tags = {
    Name = "MyInstance-1"
  }
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "instance_id" {
  value = aws_instance.my_server.id
}
   
output "instance_public_ip" {
  value = aws_instance.my_server.public_ip
}
output "instance_private_ip" {
  value = aws_instance.my_server.private_ip
}

*/


