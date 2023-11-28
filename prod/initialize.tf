terraform {
  backend s3 {
    bucket  = "aws-docker-demo"
    key     = "azure-aks/terraform.tfstate"
    region  = "eu-west-2"
  }
}
