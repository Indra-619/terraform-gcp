#!/bin/bash
apt-get update
apt-get install -y nginx
echo "Hello from Terraform Managed Instance Group! Hostname: $(hostname)" > /var/www/html/index.html
