output "links" {
  value = {
    aws_console_sign_in    = "https://${aws_organizations_account.users.id}.signin.aws.amazon.com/console/"
    switch_role_dev    = "https://signin.aws.amazon.com/switchrole?account=${aws_organizations_account.dev.id}&roleName=${urlencode(module.developer_role_dev.role_name)}&displayName=${urlencode("dev")}"
    switch_role_staging    = "https://signin.aws.amazon.com/switchrole?account=${aws_organizations_account.staging.id}&roleName=${urlencode(module.developer_role_staging.role_name)}&displayName=${urlencode("staging")}"
    switch_role_production = "https://signin.aws.amazon.com/switchrole?account=${aws_organizations_account.production.id}&roleName=${urlencode(module.developer_role_staging.role_name)}&displayName=${urlencode("production")}"
  }
}
