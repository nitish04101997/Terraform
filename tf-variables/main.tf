terraform {
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

resource "aws_instance" "myserver" {
    ami           = "ami-020cba7c55df1f615" # Example AMI ID, replace with a valid one
    instance_type = var.aws_instance_type

    root_block_device {
        delete_on_termination = true
        volume_size = var.ec2_config.v_size
        volume_type = var.ec2_config.v_type
    }

    tags = merge(var.additional_tags, {
            Name = "myserver"
        })
}


