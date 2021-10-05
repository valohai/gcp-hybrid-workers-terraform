data "google_project" "project" {}

resource "google_storage_bucket" "static-site" {
  name          = "valohai-data-${project.number}"
  location      = var.region
  storage_class = "STANDARD"

  uniform_bucket_level_access = true

  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "OPTIONS"]
    response_header = ["Content-Type", "x-ms-*"]
    max_age_seconds = 3600
  }
    cors {
    origin          = ["https://app.valohai.com"]
    method          = ["POST", "PUT"]
    response_header = ["Content-Type", "x-ms-*"]
    max_age_seconds = 3600
  }
}