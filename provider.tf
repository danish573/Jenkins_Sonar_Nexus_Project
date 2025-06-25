terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "latest"  #Choose version instead of latest, latest not a valid specifier in terraform ot remove version
    }
  }
}

provider "aws" {
  region = "ap-south-1"

}
