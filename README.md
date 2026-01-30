# GCP Terraform Setup

This repository contains a Terraform configuration for deploying a scalable and cost-effective web server infrastructure on Google Cloud Platform (GCP).

## Infrastructure Overview

- **Compute**: Managed Instance Group (MIG) using preemptible Linux (Ubuntu) VMs.
- **Networking**: Custom VPC with private subnets and specific firewall rules.
- **Load Balancing**: External Global HTTP Load Balancer.
- **Structure**: Modular architecture (`infrastructure/modules/`).

## Documentation

- [Contributing Guide](docs/CONTRIBUTING.md)
- [Testing & Verification](docs/TESTING.md)

## Prerequisites

1.  **Terraform**: Install Terraform (v1.0+).
2.  **Google Cloud SDK**: Install and authenticate `gcloud`.
3.  **GCP Project**: A valid GCP project.

## Quick Start

1.  **Authenticate**:
    ```bash
    gcloud auth application-default login
    ```

2.  **Navigate to Infrastructure**:
    ```bash
    cd infrastructure
    ```

3.  **Initialize**:
    ```bash
    terraform init
    ```

4.  **Plan & Apply**:
    ```bash
    terraform plan
    terraform apply
    ```
