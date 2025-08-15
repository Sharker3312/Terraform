terraform {
  required_version = ">= 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # Recommended: remote backend in S3 (+ DynamoDB for state locks)
  # backend "s3" {
  #   bucket         = "my-terraform-state-bucket"
  #   key            = "aws-org/${terraform.workspace}/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-locks"
  #   encrypt        = true
  # }
}

# Default provider
provider "aws" {
  region = var.primary_region

  default_tags {
    tags = {
      Project     = "AWS-Organization"
      ManagedBy   = "Terraform"
      Environment = "global"
    }
  }
}

