output "region" {
  value = "${var.region}"
}

output "module-output-value" {
  value = "${module.users.module-output-value}"
}

output "module-output-value" {
  value = "${module.roles.module-output-value}"
}

output "module-output-value" {
  value = "${module.groups.module-output-value}"
}

output "module-output-value" {
  value = "${module.backend.module-output-value}"
}
