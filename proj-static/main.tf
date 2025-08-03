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

resource "aws_s3_bucket" "web-bucket" {
  bucket = "nitish-dfb7962807ca49d6"
  # force_destroy = true
  # terraform import aws_s3_bucket.web-bucket nitish-dfb7962807ca49d6   
  # add this line if bucket already exists
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.web-bucket.id
  # This block is used to block public access to the bucket  
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
} 


resource "aws_s3_bucket_policy" "mywebapp" {
    bucket = aws_s3_bucket.web-bucket.id
    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Effect = "Allow"
            Principal = "*"
            Action = "s3:GetObject"
            Resource = "${aws_s3_bucket.web-bucket.arn}/*"
        }
        ]
    })
}

resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.web-bucket.id
  index_document {
    suffix = "index.html"
  }
}


resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.web-bucket.bucket
  source = "./index.html" # Path to your HTML file
  # Alternatively, you can use content instead of source
  key    = "static-website/index.html"
  # key will change the name of the source file in S3
  content_type = "text/html" # This is the content type for HTML files
  
}

resource "aws_s3_object" "styles_css" {
  bucket = aws_s3_bucket.web-bucket.bucket
  source = "./styles.css" # Path to your HTML file
  # Alternatively, you can use content instead of source
  key    = "static-website/styles.css"
  # key will change the name of the source file in S3
  # content = "This is a sample file stored in S3 bucket."
}

output "name" {
  value = "${aws_s3_bucket_website_configuration.mywebapp.website_endpoint}/static-website/index.html"
}

