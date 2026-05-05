variable "company_name" {
  description = "The name of the company"
  type        = string
}

variable "environment" {
  description = "The environment (dev, staging, production)"
  type        = string
}

variable "service_name" {
  description = "The name of the service"
  type        = string
}

variable "instance_group" {
  description = "The instance group for the load balancer"
  type        = string
}
