terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}
provider "aws" {
    region = "us-east-1"    
}
resource "random_id" "my_random_id" {
  byte_length = 8
}
resource "aws_s3_bucket" "my_bucket" {
  bucket = "nitish-${random_id.my_random_id.hex}"
  force_destroy = true
}
resource "aws_s3_object" "bucket_data" {
  bucket = aws_s3_bucket.my_bucket.bucket
  source = "../aws_ec2/main.tf"
  # Alternatively, you can use content instead of source
  key    = "aws_ec2/main.tf"
  # key will change the name of the source file in S3
  # content = "This is a sample file stored in S3 bucket."
}
output "name" {
  value = random_id.my_random_id.hex
}

