output "load_balancer_ip" {
  description = "The external IPv4 address of the Global Load Balancer (use this for DNS A record)"
  value       = google_compute_global_address.default.address
}

output "load_balancer_https_url" {
  description = "HTTPS URL for the Load Balancer (for SSL certificate domain verification)"
  value       = "https://${google_compute_managed_ssl_certificate.default.managed[0].domains[0]}/"
}

output "instance_group_link" {
  description = "Self link for the managed instance group"
  value       = module.compute.instance_group_link
}
