# Week 11 Homework with Terraform

![Terraform](https://img.shields.io/badge/Terraform-1.5+-623CE4?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Deployed-orange?logo=amazon-aws)
![CI/CD](https://img.shields.io/badge/Jenkins-Automated-blue?logo=jenkins)

This repository contains Terraform code for deploying a simple AWS infrastructure as part of the Week 11 assignment.

## 📦 Project Structure

| File / Directory | Description                                      |
|------------------|--------------------------------------------------|
| `main.tf`        | Primary Terraform configuration                  |
| `variables.tf`   | Input variables                                  |
| `outputs.tf`     | Output definitions                               |
| `13-SNS.tf`      | SNS (Simple Notification Service) configuration  |
| `Jenkinsfile`    | Jenkins pipeline for Terraform automation        |
| `.gitignore`     | Git ignored files                                |
| `README.md`      | You're here!                                     |

## 🚀 What It Does

This Terraform configuration:

- Provisions AWS infrastructure in `us-east-1`
- Includes resources like:
  - EC2 instances
  - SNS topics
  - IAM roles/policies
  - Security groups
- Automates deployment using Jenkins pipeline (`Jenkinsfile`)

## 🔧 Prerequisites

- Terraform CLI installed (`>= 1.0.0`)
- AWS CLI configured with valid credentials
- Jenkins (optional, if using CI/CD)

## 🛠️ Usage

1. **Clone the repo:**

   ```bash
   git clone https://github.com/tiqsclass6/Week-11-Homework.git
   cd Week-11-Homework
   code .
   ```

2. **Initialize Terraform:**

   ```bash
   terraform init
   ```

3. **Format the configuration:**

   ```bash
   terraform fmt
   ```

4. **Validate the configuration:**

   ```bash
   terraform validate
   ```

5. **Review the plan:**

   ```bash
   terraform plan
   ```

6. **Apply the configuration:**

   ```bash
   terraform apply
   ```

## 🧼 Clean Up

To destroy the infrastructure:

```bash
terraform destroy
```

## 🧰 Troubleshooting

If you run into issues, here are some tips:

### 🛠️ Terraform

- 🧩 **terraform init fails**: Make sure your AWS credentials and region are properly configured. Try `aws configure` and verify network access.
- 🧪 **terraform plan/validate returns errors**: Check for missing variables, typos, or duplicate resource names.
- ⏳ **terraform apply is stuck**: Look for resource creation dependencies (e.g., subnet, security group, or IAM roles). Run with `-auto-approve` to skip prompts.
- ⚠️ **Duplicate resources**: Ensure resource names within the same type (e.g., `aws_instance.my_vm`) are unique.
- 🔐 **Permission denied errors**: Make sure your IAM user or role has permissions for EC2, VPC, IAM, SNS, and Load Balancer services.
- 🗂️ **State issues**: If your Terraform state is corrupted or out of sync, consider running:

  ```bash
  terraform refresh
  terraform taint <resource>
  terraform apply
  ```

### 🧱 Jenkins Pipeline Failures

- 🔑 **Missing credentials**: Ensure your Jenkins pipeline is configured with the correct AWS IAM credentials using Jenkins Credentials Plugin.
- 🧹 **Pipeline fails on terraform commands**: Add `terraform fmt` and `terraform validate` stages to detect and catch formatting or syntax issues early.
- ⚙️ **Agent environment issues**: Verify that the Jenkins agent has Terraform and AWS CLI installed and in `$PATH`.

### ☁️ AWS-Specific Issues

- 🚫 **AccessDenied errors**: Double-check IAM permissions (especially for EC2, VPC, SNS, and Auto Scaling).

- ⏱️ **Instance stuck in pending state**: Check for:
  - 📦 Subnet availability
  - 🖼️ Correct AMI ID
  - 🔐 Key pair existence

- ❤️ **ALB/Target Group shows unhealthy instances**:
  - Ensure health check path and ports are configured correctly.
  - Validate security groups allow traffic on necessary ports (e.g., 80, 443).
