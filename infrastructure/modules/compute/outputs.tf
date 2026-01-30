output "instance_group" {
  value = google_compute_instance_group_manager.default.instance_group
}

output "instance_group_link" {
  value = google_compute_instance_group_manager.default.self_link
}
