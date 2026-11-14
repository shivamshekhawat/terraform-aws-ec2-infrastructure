# terraform-aws-ec2-infrastructure
Provision AWS EC2 infrastructure using Terraform (IaC)

# AWS EC2 Infrastructure Provisioning Using Terraform

## Project Overview

This project demonstrates Infrastructure as Code (IaC) using Terraform to provision and manage AWS EC2 infrastructure.

The configuration automates the creation of an Ubuntu 24.04 EC2 instance, AWS Security Group, encrypted EBS storage, and Nginx web server.

The objective is to make infrastructure provisioning repeatable, configurable, and easier to manage through Terraform.

## Project Objectives

- Automate AWS EC2 provisioning using Terraform.
- Implement Infrastructure as Code (IaC).
- Configure AWS Security Groups for network access.
- Automatically install and configure Nginx using EC2 User Data.
- Use Terraform variables and outputs for reusable configurations.
- Manage infrastructure through Terraform lifecycle commands.

## Technologies Used

| Technology | Purpose |
|---|---|
| Terraform | Infrastructure as Code |
| AWS EC2 | Virtual server provisioning |
| AWS Security Groups | Network traffic control |
| Ubuntu 24.04 | Operating system |
| Nginx | Web server |
| Amazon EBS | Persistent block storage |
| Git & GitHub | Version control |

## Architecture

The Terraform configuration provisions the following resources:

1. AWS Provider – Connects Terraform to AWS.
2. Ubuntu AMI – Identifies the latest matching Ubuntu 24.04 image.
3. Security Group – Allows HTTP traffic on port 80.
4. EC2 Instance – Provisions the virtual machine.
5. User Data – Installs and starts Nginx automatically.
6. EBS Volume – Provides encrypted root storage.
7. Terraform Outputs – Displays instance details and website URL.

## Project Structure

```text
terraform-aws-ec2-infrastructure/
│
├── versions.tf
├── provider.tf
├── variables.tf
├── main.tf
├── outputs.tf
├── terraform.tfvars.example
├── .gitignore
└── README.md
```

## Configuration Details

### 1. versions.tf

Defines the required Terraform version and AWS provider dependency.

### 2. provider.tf

Configures the AWS provider and deployment region.

Default region: ap-south-1 (Mumbai).

### 3. variables.tf

Defines reusable input variables:

- AWS region
- EC2 instance type
- Project name
- Deployment environment

### 4. main.tf

Contains the main infrastructure configuration:

- Ubuntu 24.04 AMI lookup
- AWS Security Group creation
- EC2 instance provisioning
- Nginx installation using User Data
- Encrypted EBS root volume
- IMDSv2 enforcement

### 5. outputs.tf

Displays:

- EC2 Instance ID
- EC2 Public IP
- EC2 Public DNS
- Nginx Website URL

### 6. terraform.tfvars.example

Provides example values for customizing infrastructure configuration.

### 7. .gitignore

Prevents local Terraform state, working directories, private keys, and local variable files from being added to Git.

## Prerequisites

Before deployment, install:

- Terraform
- AWS CLI
- Git
- An AWS account with appropriate IAM permissions

Configure AWS credentials using:

```bash
aws configure
```

## Deployment Instructions

### Step 1: Clone the repository

```bash
git clone https://github.com/shivamshekhawat/terraform-aws-ec2-infrastructure.git
cd terraform-aws-ec2-infrastructure
```

### Step 2: Initialize Terraform

```bash
terraform init
```

Downloads the required AWS provider and initializes the working directory.

### Step 3: Format Terraform files

```bash
terraform fmt -recursive
```

### Step 4: Validate configuration

```bash
terraform validate
```

Checks the Terraform configuration for syntax and structural errors.

### Step 5: Configure variables

```bash
cp terraform.tfvars.example terraform.tfvars
```

### Step 6: Preview infrastructure changes

```bash
terraform plan
```

Displays the infrastructure changes Terraform intends to make.

### Step 7: Provision AWS infrastructure

```bash
terraform apply
```

Review the execution plan and approve the deployment when ready.

### Step 8: View Terraform outputs

```bash
terraform output
```

Displays the EC2 instance details and website URL.

## Infrastructure Cleanup

To remove the resources managed by this Terraform configuration:

```bash
terraform destroy
```

Review the destruction plan before confirming.

## Security Considerations

- AWS credentials are managed outside the repository.
- Terraform state files are excluded using `.gitignore`.
- IMDSv2 is enforced on the EC2 instance.
- EBS root storage encryption is enabled.
- SSH access is not exposed in the demonstration configuration.
- HTTP access is enabled for demonstrating the Nginx web server.

For production environments, restrict HTTP access, use HTTPS, and apply least-privilege IAM policies.

## Author

**Shivam Shekhawat**

GitHub: https://github.com/shivamshekhawat

---

*This repository contains Terraform infrastructure configuration and deployment instructions. Update the deployment status and add verified screenshots after successfully testing it in AWS.*
