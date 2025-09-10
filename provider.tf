provider "aws" {
  region                      = var.aws.region
  access_key                  = var.aws.access_key
  secret_key                  = var.aws.secret_key
  skip_credentials_validation = var.aws.skip_credentials_validation
  skip_metadata_api_check     = var.aws.skip_metadata_api_check
  skip_requesting_account_id  = var.aws.skip_requesting_account_id
  s3_force_path_style         = var.aws.s3_force_path_style

  endpoints {
    s3 = var.aws.endpoint

    # s3 = "http://127.0.0.1:4566" # or your LocalStack endpoint
  }
}

