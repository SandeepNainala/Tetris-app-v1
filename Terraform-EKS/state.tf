terraform {
  backend "s3" {
    bucket = "terraform-nainala"
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}
