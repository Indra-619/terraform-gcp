# ============================================================
# terraform-gcp — Makefile
# Usage: make <target>
# Terraform commands run inside infrastructure/ directory.
# ============================================================

.PHONY: help init fmt validate plan apply destroy clean setup

TF_DIR   := infrastructure
TF_FILES := $(TF_DIR)/

help:
	@echo "terraform-gcp targets:"
	@echo "  make init      — terraform init (in $(TF_DIR)/)"
	@echo "  make fmt       — terraform fmt -recursive"
	@echo "  make validate  — terraform validate"
	@echo "  make plan      — terraform plan"
	@echo "  make apply     — terraform apply"
	@echo "  make destroy   — terraform destroy"
	@echo "  make clean     — remove .terraform dirs and local state"
	@echo "  make setup     — first-time setup (init + validate)"

init:
	cd $(TF_DIR) && terraform init

fmt:
	terraform fmt -recursive -check

validate: init
	cd $(TF_DIR) && terraform validate

plan: init
	cd $(TF_DIR) && terraform plan

apply: init
	cd $(TF_DIR) && terraform apply

destroy: init
	cd $(TF_DIR) && terraform destroy

clean:
	find . -name ".terraform" -type d -exec rm -rf {} + 2>/dev/null || true
	find . -name ".terraform.lock.hcl" -delete 2>/dev/null || true
	rm -f infrastructure/terraform.tfstate infrastructure/terraform.tfstate.*

setup: fmt validate
	@echo ""
	@echo "Setup complete. Copy terraform.tfvars.example to terraform.tfvars:"
	@echo "  cp infrastructure/terraform.tfvars.example infrastructure/terraform.tfvars"
	@echo "Then edit terraform.tfvars with your values and run: make plan"
