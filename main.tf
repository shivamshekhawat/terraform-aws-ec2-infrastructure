
# ------------------------------------------
# 1. Find Latest Ubuntu 24.04 AMI
# ------------------------------------------

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# ------------------------------------------
# 2. Create Security Group
# ------------------------------------------

resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-sg"
  description = "Allow HTTP traffic to EC2 web server"

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# ------------------------------------------
# 3. Create EC2 Instance
# ------------------------------------------

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # Install and configure Nginx automatically

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx

              systemctl enable nginx
              systemctl start nginx

              echo "<h1>Welcome to My Terraform EC2 Project</h1>" > /var/www/html/index.html
              echo "<p>Infrastructure provisioned using Terraform.</p>" >> /var/www/html/index.html
              EOF

  user_data_replace_on_change = true

  # Configure encrypted EBS storage

  root_block_device {
    volume_size           = 10
    volume_type           = "gp3"
    encrypted             = true
    delete_on_termination = true
  }

  # Enforce IMDSv2

  metadata_options {
    http_tokens = "required"
  }

  # Resource tags

  tags = {
    Name        = "${var.project_name}-server"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
