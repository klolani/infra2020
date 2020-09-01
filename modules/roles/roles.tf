resource "null_resource" "roles" {
    provisioner "local-exec" {
        command = "echo You are deploying to the ${var.environment} environment!"
    }
}
