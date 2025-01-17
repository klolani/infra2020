module "ops_role_dev" {
  source           = "./modules/roles/ops"
  trusted_entity   = "arn:aws:iam::${aws_organizations_account.users.id}:root"

  providers        = {
    aws            = aws.dev
  }
}

module "ops_role_staging" {
  source           = "./modules/roles/ops"
  trusted_entity   = "arn:aws:iam::${aws_organizations_account.users.id}:root"

  providers        = {
    aws            = aws.staging
  }
}

module "ops_role_production" {
  source           = "./modules/roles/ops"
  trusted_entity   = "arn:aws:iam::${aws_organizations_account.users.id}:root"

  providers        = {
    aws            = aws.production
  }
}

module "ops_group_dev" {
  source           = "./modules/groups"
  group_name       = "ops-dev"

  assume_role_arns = [
    module.ops_role_dev.role_arn,
  ]

  providers        = {
    aws            = aws.users
  }
}

module "ops_group_staging" {
  source           = "./modules/groups"
  group_name       = "ops-staging"

  assume_role_arns = [
    module.ops_role_staging.role_arn,
  ]

  providers        = {
    aws            = aws.users
  }
}

module "ops_group_production" {
  source           = "./modules/groups"
  group_name       = "ops-production"

  assume_role_arns = [
    module.ops_role_production.role_arn
  ]

  providers        = {
    aws            = aws.users
  }
}

resource "aws_iam_group" "ops_self_managing" {
  name             = "OpsSelfManaging"

  provider         = aws.users
}

resource "aws_iam_group_policy_attachment" "ops_iam_read_only_access" {
  group            = aws_iam_group.ops_self_managing.name
  policy_arn       = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"

  provider         = aws.users
}

resource "aws_iam_group_policy_attachment" "ops_iam_self_manage_service_specific_credentials" {
  group            = aws_iam_group.ops_self_managing.name
  policy_arn       = "arn:aws:iam::aws:policy/IAMSelfManageServiceSpecificCredentials"

  provider         = aws.users
}

resource "aws_iam_group_policy_attachment" "ops_iam_user_change_password" {
  group            = aws_iam_group.ops_self_managing.name
  policy_arn       = "arn:aws:iam::aws:policy/IAMUserChangePassword"

  provider         = aws.users
}

resource "aws_iam_policy" "ops_self_manage_vmfa" {
  name             = "OpsSelfManageVMFA"
  policy           = file("${path.module}/data/self_manage_vmfa.json")

  provider         = aws.users
}

resource "aws_iam_group_policy_attachment" "ops_self_manage_vmfa" {
  group            = aws_iam_group.ops_self_managing.name
  policy_arn       = aws_iam_policy.ops_self_manage_vmfa.arn

  provider         = aws.users
}
