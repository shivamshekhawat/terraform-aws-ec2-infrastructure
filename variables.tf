
# AWS Region
variable "aws_region" {
  description = "AWS region where infrastructure will be created"
  type        = string
  default     = "ap-south-1"
}

# EC2 Instance Type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

# Project Name
variable "project_name" {
  description = "Name of the Terraform project"
  type        = string
  default     = "terraform-ec2-project"
}

# Environment
variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
