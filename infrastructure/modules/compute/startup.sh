#!/bin/bash
# Idempotent startup script — safe to re-run on reboot
set -e

# Install nginx only if not already installed
if ! command -v nginx &> /dev/null; then
    apt-get update
    apt-get install -y nginx
fi

# Write homepage (idempotent — always overwrite)
echo "Hello from Terraform Managed Instance Group! Hostname: $(hostname)" > /var/www/html/index.html
