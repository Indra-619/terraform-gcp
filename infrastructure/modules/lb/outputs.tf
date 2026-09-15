output "load_balancer_ip" {
  description = "The external IPv4 address of the Global Load Balancer"
  value       = google_compute_global_address.default.address
}

output "load_balancer_https_url" {
  description = "HTTPS URL for DNS domain verification (GCP-managed SSL cert)"
  value       = "https://${google_compute_managed_ssl_certificate.default.managed[0].domains[0]}/"
}
