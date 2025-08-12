terraform{
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "6.5.0"
        }
    }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  project_name = "tf-multi-resource"
}

resource "aws_vpc" "myvpc" {
  cidr_block = "100.0.0.0/16"
    tags = {
        Name = "${local.project_name}-vpc"
    }
}

resource "aws_subnet" "aws_subnet1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "100.0.${count.index}.0/24"
  availability_zone = "us-east-1a"
  count = 2
    tags = {
        Name = "${local.project_name}-subnet-${count.index}"
    }
}

# output the subnet IDs
output "aws_subnet_ids" {
  value = aws_subnet.aws_subnet1[*].id  
}

# output the CIDR blocks of the subnets
output "aws_cidr_blocks" {
  value = aws_subnet.aws_subnet1[*].cidr_block
}

/*
#creating 4EC2 instances in each subnet
resource "aws_instance" "main" {
    count = 2

    ami = "ami-020cba7c55df1f615"

    instance_type = "t2.nano"
     
    subnet_id = element(aws_subnet.aws_subnet1[*].id, count.index % length(aws_subnet.aws_subnet1))
    
    tags = {
        Name = "${local.project_name}-instance-${count.index}"
    }
}




resource "aws_subnet" "aws_subnet2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "100.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
        Name = "aws_subnet2"
    }
}
*/

#creating EC2 instances using variable configuration

resource "aws_instance" "main" {
    count = length(var.ec2_config)

    ami = var.ec2_config[count.index].ami

    instance_type = var.ec2_config[count.index].instance_type
     
    subnet_id = element(aws_subnet.aws_subnet1[*].id, count.index % length(aws_subnet.aws_subnet1))
    
    tags = {
        Name = "${local.project_name}-instance-${count.index}"
    }
}

