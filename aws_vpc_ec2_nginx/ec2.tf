# Resource to create an EC2 instance in the public subnet
# This instance will be accessible from the Internet through the public subnet
resource "aws_instance" "nginx_server"{
  ami           = "ami-020cba7c55df1f615" # Example AMI ID, replace with a valid one
  instance_type = "t2.nano"
  subnet_id     = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.nginx_sg.id] 
  associate_public_ip_address = true

  user_data = <<EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install nginx -y
                sudo systemctl start nginx                 
                EOF
  
  tags = {
    Name = "nginxserver"
  }
}

/*
# Resource to manage the state of the EC2 instance
# This resource is used to control the state of the instance (running, stopped, terminated)
resource "aws_ec2_instance_state" "my_server_state" {
  instance_id = aws_instance.my_server.id
  state       = "running"
# Change to "stopped" if you want the instance to be stopped initially
# Change to "running" if you want the instance to be running initially
# Change to "terminated" if you want the instance to be terminated initially
}

*/