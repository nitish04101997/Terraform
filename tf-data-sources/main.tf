terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.7.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "name" {
  most_recent = true
  owners      = ["amazon"]
}

data "aws_security_group" "name" {
  tags = {
    sg_1 = "sg_1"
  }
}

data "aws_availability_zones" "name" {
    state = "available"
}

data "aws_caller_identity" "name" {
}

data "aws_region" "name" {
}

output "aws_region" {
  value = data.aws_region.name.id
}


output "aws_caller_identity" {
  value = data.aws_caller_identity.name.id
}

output "aws_availability_zones" {
  value = data.aws_availability_zones.name.id
}

output "ami_id" {
  value = data.aws_ami.name.id      
}

output "security_group_id" {
  value = data.aws_security_group.name.id
}

#vpc_id variable
data "aws_vpc" "name" {
  tags = {
    ENV = "PROD"
  }
}

#vpc_id variable
output "vpc_id" {
  value = data.aws_vpc.name.id
}

#subnet_id variable
data "aws_subnet" "name" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.name.id]
  }
  tags = {
    NAME = "NITISH"
  }
}

output "subnet_id" {
  value = data.aws_subnet.name.id
}

resource "aws_instance" "myserver" {
  ami           = "ami-020cba7c55df1f615"
  instance_type = "t2.nano"
  subnet_id = data.aws_subnet.name.id
  security_groups = [data.aws_security_group.name.id] 

  tags = {
    Name = "MyServer"   
    }
}





