data "google_project" "project" {}

resource "google_storage_bucket" "valohai-data" {
  name          = "valohai-data-${data.google_project.project.number}"
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