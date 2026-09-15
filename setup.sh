#!/usr/bin/env bash
# ============================================================
# setup.sh — First-time setup for terraform-gcp
# Run once after cloning: ./setup.sh
# ============================================================

set -e

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; NC='\033[0m'

echo -e "${GREEN}==> terraform-gcp setup${NC}"

# Check prerequisites
echo -e "\n${GREEN}==> Checking prerequisites...${NC}"
command -v terraform >/dev/null 2>&1 || { echo -e "${RED}terraform not found — install from https://terraform.io${NC}"; exit 1; }
command -v gcloud >/dev/null 2>&1 || { echo -e "${RED}gcloud not found — install Google Cloud SDK${NC}"; exit 1; }

# Auth check
echo -e "\n${GREEN}==> Checking GCP authentication...${NC}"
gcloud auth list --filter=status:ACTIVE --format="value(account)" 2>/dev/null | head -1 || \
  { echo -e "${YELLOW}No active gcloud account — run: gcloud auth login${NC}"; }

# Terraform fmt
echo -e "\n${GREEN}==> Running terraform fmt...${NC}"
terraform fmt -recursive

# Terraform init
echo -e "\n${GREEN}==> Running terraform init...${NC}"
cd infrastructure
terraform init -upgrade

# Terraform validate
echo -e "\n${GREEN}==> Running terraform validate...${NC}"
terraform validate

# Copy tfvars hint
if [ ! -f terraform.tfvars ]; then
  echo -e "\n${YELLOW}terraform.tfvars not found — copying from example...${NC}"
  cp terraform.tfvars.example terraform.tfvars
  echo -e "${YELLOW}Edit infrastructure/terraform.tfvars with your values, then run: make plan${NC}"
else
  echo -e "\n${GREEN}terraform.tfvars found — ready to plan.${NC}"
fi

echo -e "\n${GREEN}==> Setup complete!${NC}"
echo "Next steps:"
echo "  1. Edit infrastructure/terraform.tfvars"
echo "  2. make plan"
echo "  3. make apply"
