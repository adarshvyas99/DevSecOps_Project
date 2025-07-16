terraform {
  backend "s3" {
    bucket         = "voiceowl-dev-terraform-state"
    key            = "backend.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "voiceowl-dev-terraform-locks"
    encrypt        = true
  }
}