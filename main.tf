provider "aws" {
  region = "ap-southeast-2" # e.g., us-west-2
}

terraform {
  backend "s3" {
    bucket  = "backstage-tf-state" # S3 bucket name
    key     = "terraform.tfstate"  # Path to the state file
    region  = "ap-southeast-2"     # AWS region
    encrypt = true                 # Enable encryption
  }
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the instance"
  type        = string
  default     = "ami-0cc51e967b1cbe471" # Replace with your desired AMI
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "ExampleInstance"
  }
}
