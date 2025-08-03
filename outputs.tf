output  "Instance_Id" {
  description = "ID of AWS instance"
  value       = aws_instance.my_server.id
}

output "aws_instance_public_ip" {
  description = "Public IP of AWS instance"
  value       = aws_instance.my_server.public_ip
}