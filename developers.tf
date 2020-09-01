module "developer_role_dev" {
  source         = "./modules/roles/developer"
  trusted_entity = "arn:aws:iam::${aws_organizations_account.users.id}:root"

  providers = {
    aws = aws.dev
  }
}

module "developer_role_staging" {
  source         = "./modules/roles/developer"
  trusted_entity = "arn:aws:iam::${aws_organizations_account.users.id}:root"

  providers = {
    aws = aws.staging
  }
}

module "developer_role_production" {
  source         = "./modules/roles/developer"
  trusted_entity = "arn:aws:iam::${aws_organizations_account.users.id}:root"

  providers = {
    aws = aws.production
  }
}

module "developer_group_dev" {
  source     = "./modules/groups"
  group_name = "developers-dev"

  assume_role_arns = [
    module.developer_role_dev.role_arn,
  ]

  providers = {
    aws = aws.users
  }
}

module "developer_group_staging" {
  source     = "./modules/groups"
  group_name = "developers-staging"

  assume_role_arns = [
    module.developer_role_staging.role_arn,
  ]

  providers = {
    aws = aws.users
  }
}

module "developer_group_production" {
  source     = "./modules/groups"
  group_name = "developers-production"

  assume_role_arns = [
    module.developer_role_production.role_arn
  ]

  providers = {
    aws = aws.users
  }
}

resource "aws_iam_group" "developer_self_managing" {
  name = "DevSelfManaging"

  provider = aws.users
}

resource "aws_iam_group_policy_attachment" "developer_iam_read_only_access" {
  group      = aws_iam_group.developer_self_managing.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"

  provider = aws.users
}

resource "aws_iam_group_policy_attachment" "developer_iam_self_manage_service_specific_credentials" {
  group      = aws_iam_group.developer_self_managing.name
  policy_arn = "arn:aws:iam::aws:policy/IAMSelfManageServiceSpecificCredentials"

  provider = aws.users
}

resource "aws_iam_group_policy_attachment" "developer_iam_user_change_password" {
  group      = aws_iam_group.developer_self_managing.name
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"

  provider = aws.users
}

resource "aws_iam_policy" "developer_self_manage_vmfa" {
  name   = "SelfManageVMFA"
  policy = file("${path.module}/data/self_manage_vmfa.json")

  provider = aws.users
}

resource "aws_iam_group_policy_attachment" "self_manage_vmfa" {
  group      = aws_iam_group.developer_self_managing.name
  policy_arn = aws_iam_policy.developer_self_manage_vmfa.arn

  provider = aws.users
}
