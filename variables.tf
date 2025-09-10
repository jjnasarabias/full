variable "aws" {
  type = object({
    region = string
    access_key = string
    secret_key = string
    skip_credentials_validation = bool
    skip_metadata_api_check = bool
    skip_requesting_account_id = bool
    s3_force_path_style = bool
    endpoint = string
  })
}