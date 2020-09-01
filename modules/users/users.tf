resource "null_resource" "users" {
    provisioner "local-exec" {
        command = "echo You are deploying to the ${var.environment} environment!"
    }
}
