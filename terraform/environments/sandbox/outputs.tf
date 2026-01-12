output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.server.public_ip
}



output "ssh_command" {
  description = "Command to SSH into the instance"
  value       = "ssh -i devops-sandbox.pem ubuntu@${aws_instance.server.public_ip}"
}
