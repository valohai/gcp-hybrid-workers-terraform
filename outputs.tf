data "google_project" "project" {}
output "project" {
    value = data.google_project.project.project_id
}

output "external-ip" {
    value = "${module.worker_queue.external-ip}"
}

output "valohai_master_sa" {
    value = "${module.iam.valohai_master_sa}"
}

