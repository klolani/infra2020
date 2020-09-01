provider "aws" {
  region     = "us-west-2"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.users.id}:role/User"
  }

  alias      = "users"
  region     = "us-west-2"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.staging.id}:role/Dev"
  }

  alias      = "dev"
  region     = "us-west-2"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.staging.id}:role/Staging"
  }

  alias      = "staging"
  region     = "us-west-2"
}

provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::${aws_organizations_account.production.id}:role/Production"
  }

  alias      = "production"
  region     = "us-west-2"
}

resource "aws_organizations_organization" "organization" {
}

resource "aws_organizations_account" "users" {
  name       = local.account_name["users"]
  email      = local.account_owner_email["users"]
  role_name  = "User"
}

resource "aws_organizations_account" "dev" {
  name       = local.account_name["dev"]
  email      = local.account_owner_email["dev"]
  role_name  = "Dev"
}

resource "aws_organizations_account" "staging" {
  name       = local.account_name["staging"]
  email      = local.account_owner_email["staging"]
  role_name  = "Staging"
}

resource "aws_organizations_account" "production" {
  name       = local.account_name["production"]
  email      = local.account_owner_email["production"]
  role_name  = "Production"
}
