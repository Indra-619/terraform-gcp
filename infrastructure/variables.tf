variable "company_name" {
  description = "The name of the company"
  type        = string
  default     = "indra"
}

variable "environment" {
  description = "The environment (dev, staging, production)"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "production"], var.environment)
    error_message = "Environment harus salah satu dari: dev, staging, production."
  }
}

variable "service_name" {
  description = "The name of the service"
  type        = string
  default     = "web-server"
}

variable "project_id" {
  description = "The GCP Project ID"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "Project ID harus lowercase alphanumeric, 6-30 chars."
  }
}

variable "region" {
  description = "The GCP Region"
  type        = string
  default     = "asia-southeast2" # Default to Jakarta per standards

  validation {
    condition     = can(regex("^[a-z]{2,}-[a-z]+[0-9]$", var.region))
    error_message = "Format region tidak valid (contoh: asia-southeast2)."
  }
}

variable "zone" {
  description = "The GCP Zone"
  type        = string
  default     = "asia-southeast2-a"
}

variable "machine_type" {
  description = "The machine type for the instances"
  type        = string
  default     = "e2-medium"
}

variable "instance_count" {
  description = "Number of instances in the MIG"
  type        = number
  default     = 2

  validation {
    condition     = var.instance_count > 0 && var.instance_count <= 10
    error_message = "Jumlah instance harus antara 1 sampai 10."
  }
}
