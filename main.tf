# provider "aws" {
#   region = "ap-southeast-2" # e.g., us-west-2
# }

# terraform {
#   backend "s3" {
#     bucket  = "backstage-tf-state" # S3 bucket name
#     key     = "terraform.tfstate"  # Path to the state file
#     region  = "ap-southeast-2"     # AWS region
#     encrypt = true                 # Enable encryption
#   }
# }


provider "local" {}

variable "file_count" {
  description = "The number of files to create (1 to 3)"
  type        = number
  default     = 1
  validation {
    condition     = var.file_count >= 1 && var.file_count <= 3
    error_message = "file_count must be between 1 and 3."
  }
}

variable "file_content" {
  description = "The content to add to the files"
  type        = string
  default     = "Hello"
}

resource "local_file" "example" {
  count    = var.file_count
  filename = "${path.module}/example_${count.index + 1}.txt"
  content  = var.file_content
}
