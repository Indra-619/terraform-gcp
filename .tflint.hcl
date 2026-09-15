# ============================================================
# .tflint.hcl — TFLint configuration for GCP
# https://github.com/terraform-linters/tflint
# Install: brew install tflint
# Run:     tflint
# CI:      tflint --init && tflint
# ============================================================

config {
  force = false
}

plugin "google" {
  enabled = true
  version = "0.16.0"
  source  = "github.com/terraform-linters/tflint-ruleset-google"
}

# ------------------------------------------
# Core rules (proven stable with tflint 0.54.0 + google plugin 0.16.0)
# ------------------------------------------

rule "google_instance_invalid_type"        { enabled = true }
rule "terraform_documented_outputs"         { enabled = true }
rule "terraform_documented_variables"     { enabled = true }
rule "terraform_naming_convention"        { enabled = true }
