# The attribute `${data.aws_caller_identity.current.account_id}` will be current account number. 
data "aws_caller_identity" "current" {}

# The attribue `${data.aws_iam_account_alias.current.account_alias}` will be current account alias
data "aws_iam_account_alias" "current" {}

# Set as [local values](https://www.terraform.io/docs/configuration/locals.html)
locals {
  account_id    = data.aws_caller_identity.current.account_id
  account_alias = data.aws_iam_account_alias.current.account_alias
}


provider "aws" {
  # provider parameters here. Override any secrets at run time and avoid storing them in source control
  version = "~> 3.4"
  region  = "${ var.region }"

  assume_role {
    role_arn = "arn:aws:iam::ENTER_AN_ACCOUNT_NUMBER:role/ENTER_A_ROLE_NAME"
  }
}

terraform {
    backend "s3" {
        bucket   = "infra"
        key      = "terraform-remote-state/staging/us-west-2/vars.tfstate"
        region   = "us-west-2"
        role_arn = "arn:aws:iam::ENTER_AN_ACCOUNT_NUMBER:role/ENTER_A_ROLE_NAME"
        dynamodb_table = "my-table" 
        encrypt = "true" 
    }
}


