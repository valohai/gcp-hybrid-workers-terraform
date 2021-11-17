resource "google_compute_network" "valohai_vpc" {
  project                 = var.project
  name                    = "valohai-vpc"
  auto_create_subnetworks = true
}

resource "google_compute_firewall" "valohai_fr_queue_redis" {
  project     = var.project
  name        = "valohai-fr-queue-redis"
  network     = google_compute_network.valohai_vpc.name
  description = "Allows connection to the queue from Valohai services and valohai workers from this project"

  allow {
    protocol  = "tcp"
    ports     = ["63790"]
  }

  source_ranges = ["34.248.245.191/32", "63.34.156.112/32"]
  source_tags = ["valohai-worker"]
  target_tags = ["valohai-queue"]
}

resource "google_compute_firewall" "valohai_fr_queue_http" {
  project     = var.project
  name        = "valohai-fr-queue-http"
  network     = google_compute_network.valohai_vpc.name
  description = "Allows connections on port 80 for the letsencrypt HTTP challenge"

  allow {
    protocol  = "tcp"
    ports     = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["valohai-queue"]
}
