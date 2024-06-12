terraform {
  backend "s3" {
    bucket         = "terraform-telus"
    key            = "terraform/state"
    region         = "ca-central-1"
    dynamodb_table = "telus-terraform-state-locking"
  }
}
