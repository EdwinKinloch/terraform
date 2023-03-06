provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket         = "edwin-terraform-state"
    key            = "LockID"
    region         = "us-east-1"
    dynamodb_table = "terraform-state"
  }
}


module "ec2" {
  source          = "./ec2-module"
  security_groups = ["sg-03891b8d8e3f589ef", "sg-0b5428e0f651a5edf", "sg-02047a5a2e403129c"]
  key_name        = "terraform-us-east-2"
}