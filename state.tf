terraform {
  backend "s3" {
    bucket = "terraform-s3-sk"
    key    = "roboshop/terraform.tfstate"
    region = "us-east-1"
  }
}
