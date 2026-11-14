
# EC2 Instance ID

output "ec2_instance_id" {
  description = "ID of the created EC2 instance"
  value       = aws_instance.web_server.id
}

# EC2 Public IP

output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

# EC2 Public DNS

output "ec2_public_dns" {
  description = "Public DNS name of the EC2 instance"
  value       = aws_instance.web_server.public_dns
}

# Nginx Website URL

output "website_url" {
  description = "URL to access the Nginx web server"
  value       = "http://${aws_instance.web_server.public_dns}"
}
