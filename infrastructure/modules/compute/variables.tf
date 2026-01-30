variable "machine_type" {
  description = "The machine type for the instances"
  type        = string
}

variable "region" {
  description = "The GCP Region"
  type        = string
}

variable "zone" {
  description = "The GCP Zone"
  type        = string
}

variable "network_id" {
  description = "The ID of the VPC network"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnetwork"
  type        = string
}

variable "instance_count" {
  description = "Number of instances in the MIG"
  type        = number
}
