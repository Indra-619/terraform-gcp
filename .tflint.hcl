# ============================================================
# .tflint.hcl — TFLint configuration for GCP Terraform
# https://github.com/terraform-linters/tflint
#
# NOTE: tflint-ruleset-google plugin incompatible with runner's TFLint (API v11).
# GCP-specific security checks covered by Trivy IaC scan in CI security job.
# This config uses only built-in core rules.
# ============================================================

config {
  force = false
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
