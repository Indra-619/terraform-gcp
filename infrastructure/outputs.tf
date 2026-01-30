output "load_balancer_ip" {
  description = "The external IP address of the Global Load Balancer"
  value       = module.lb.load_balancer_ip
}

output "instance_group_link" {
  description = "Self link for the managed instance group"
  value       = module.compute.instance_group_link
}
