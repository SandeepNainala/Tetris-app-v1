terraform {
  backend "s3" {
    bucket = "EKS-bucket"
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}
