terraform {
  backend "s3" {
    bucket         = "terraform-state-adambaker"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-locks"
    profile        = "terraform-deployer"
  }
}
