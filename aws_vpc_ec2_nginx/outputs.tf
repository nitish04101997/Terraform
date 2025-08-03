
output "nginx_public_ip" {
  description = "value of the public IP address of the EC2 instance"
  value = aws_instance.nginx_server.public_ip
}

output "instance_url" {
  description = "value of the public URL of the EC2 instance"
  value = "http://${aws_instance.nginx_server.public_ip}"
}