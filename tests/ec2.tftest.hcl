
mock_provider "aws" {
  mock_data "aws_ami" {
    defaults = {
      id = "ami-0123456789abcdef0"
    }
  }
}

run "ec2_infrastructure_test" {
  command = plan

  assert {
    condition     = aws_instance.web_server.instance_type == "t3.micro"
    error_message = "EC2 instance type should be t3.micro"
  }

  assert {
  condition = one([
    for rule in aws_security_group.web_sg.ingress :
    rule.from_port == 80 && rule.to_port == 80 && rule.protocol == "tcp"
  ])

  error_message = "Security group must allow HTTP traffic on port 80"
}

  assert {
    condition     = aws_instance.web_server.root_block_device[0].encrypted == true
    error_message = "Root EBS volume must be encrypted"
  }

  assert {
    condition     = aws_instance.web_server.metadata_options[0].http_tokens == "required"
    error_message = "IMDSv2 must be enforced"
  }

  assert {
    condition     = strcontains(aws_instance.web_server.user_data, "apt-get install -y nginx")
    error_message = "EC2 user data must install Nginx"
  }

  assert {
    condition     = data.aws_ami.ubuntu.id == "ami-0123456789abcdef0"
    error_message = "Ubuntu AMI must be selected"
  }
}

