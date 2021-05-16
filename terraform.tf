terraform {
  required_version = ">=0.12.0"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">=3.35.0"
    }
  }
}
