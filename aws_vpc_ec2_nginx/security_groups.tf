# This file defines the security group for the Nginx server in AWS VPC
# Resource to create a security group that allows SSH and HTTP traffic
# This security group will be used by the EC2 instance running Nginx

resource "aws_security_group" "nginx_sg" {
    # nginx_sg is the block name and can be anything
  vpc_id    = aws_vpc.my_vpc.id
  name        = "nginx_sg"
  description = "sg for Nginx server"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["100.0.0.0/16"]  # Replace with your public IP or a safe range
  }




  #inbound rules to allow SSH and HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow HTTP from anywhere
    # cidr_blocks = ["-1"] # Allow HTTP from anywhere
}  

#outbound rules to allow all outbound traffic
    egress {
        from_port = 0
        to_port   = 0
        protocol  = "-1" # Allow all outbound traffic
        #cidr_blocks = [-1] # Allow all outbound traffic
        cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
    }

    tags = {   
        Name = "nginx_sg"
    }
}


