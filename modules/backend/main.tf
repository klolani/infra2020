resource "aws_s3_bucket" "this" {
bucket = var.bucket_name
acl    = "private"

versioning {
  enabled = true
}

lifecycle {
  prevent_destroy = true
}
}
