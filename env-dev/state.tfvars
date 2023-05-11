terraform {
  backend "s3" {
    bucket = "terraform-roboshop-dev"
    key    = "Project-1/dev/terraform.tfstate"
    region = "us-east-1"
  }
}

