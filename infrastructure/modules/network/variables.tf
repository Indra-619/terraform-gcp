variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "The GCP Region"
  type        = string
}

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
