variable "project_id" {
  description = "The GCP Project ID"
  type        = string
}

variable "region" {
  description = "The GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP Zone"
  type        = string
  default     = "us-central1-a"
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
}
