locals {
  account_name = {
    users      = "infra2020-users"
    dev        = "infra2020-staging"
    staging    = "infra2020-staging"
    production = "infra2020-production"
  }

  account_owner_email = {
    users      = "usersaccount@infra2020.com"
    staging    = "stageaccount@infra2020.com"
    production = "prodaccount@infra2020.com"
  }

  terraform_state_bucket_name = {
    staging    = "infra2020-terraform-state-dev"
    staging    = "infra2020-terraform-state-staging"
    production = "infra2020-terraform-state-production"
  }
}
