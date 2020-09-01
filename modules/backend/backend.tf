resource "null_resource" "backend" {
    provisioner "local-exec" {
        command = "echo You are deploying to the ${var.environment} environment!"
    }
}
