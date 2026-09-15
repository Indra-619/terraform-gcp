output "load_balancer_ip" {
  description = "The external IPv4 address of the Global Load Balancer (use this for DNS A record)"
  value       = module.lb.load_balancer_ip
}

output "load_balancer_https_url" {
  description = "HTTPS URL for the Load Balancer (for SSL certificate domain verification)"
  value       = module.lb.load_balancer_https_url
}

output "instance_group_link" {
  description = "Self link for the managed instance group"
  value       = module.compute.instance_group_link
}
