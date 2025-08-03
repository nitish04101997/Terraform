terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.5.0"
    }
  }
backend "s3" {
  bucket         = "nitish-dfb7962807ca49d6"
  key            = "static-website/terraform.tfstate"
  region         = "us-east-1"
    }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "my_server"{
  ami           = "ami-020cba7c55df1f615" # Example AMI ID, replace with a valid one
  instance_type = "t2.nano"

  tags = {
    Name = "MyInstance-1"
  }
}
