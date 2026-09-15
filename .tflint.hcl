# ============================================================
# .tflint.hcl — TFLint configuration for GCP Terraform
# https://github.com/terraform-linters/tflint
#
# NOTE: tflint-ruleset-google plugin is incompatible with the runner's
# pre-installed TFLint version (API v11 mismatch). Using only built-in
# core rules — GCP-specific checks should be done via Trivy in the CI.
# ============================================================

config {
  force = false
}

# Disable plugin auto-update (no google plugin loaded)
plugin "google" {
  enabled = false
}

# -----------------------------------------
# Built-in rules enabled
# -----------------------------------------

rule "terraform_deprecated_interpolation" { enabled = true }
rule "terraform_documented_outputs"     { enabled = true }
rule "terraform_documented_variables"    { enabled = true }
rule "terraform_naming_convention"       { enabled = true }
rule "terraform_required_version"       { enabled = true }
rule "terraform_required_providers"      { enabled = true }
rule "terraform_unused_declarations"    { enabled = true }
