resource "null_resource" "groups" {
    provisioner "local-exec" {
        command = "echo You are deploying to the ${var.environment} environment!"
    }
}
