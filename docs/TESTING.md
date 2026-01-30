# Testing & Verification Plan

Follow these steps to verify the infrastructure deployment.

## 1. Automated Validation

Run the following commands to ensure configuration validity:

```bash
cd infrastructure

# Check syntax and internal consistency
terraform validate

# Verify the execution plan matches expectations
terraform plan
```

## 2. Manual Verification (Post-Deployment)

After running `terraform apply`, verify the resources in the GCP Console:

### Networking
1.  Go to **VPC network** > **VPC networks**.
2.  Verify `main-vpc` exists with subnet `main-subnet`.
3.  Check **Firewall** rules: ensure `allow-ssh`, `allow-http`, and `allow-internal` are present and targeting `web-server` tags where appropriate.

### Compute Engine
1.  Go to **Compute Engine** > **Instance groups**.
2.  Click on `web-server-mig`.
3.  Verify the number of instances matches `instance_count`.
4.  Check that instances are **Healthy**.

### Load Balancing
1.  Go to **Network services** > **Load balancing**.
2.  Find the Load Balancer (created by the forwarding rule).
3.  Copy the **Frontend IP**.
4.  Open the IP in a browser: `http://<load_balancer_ip>`.
    - You should see the "Hello from Terraform Managed Instance Group!" page.

## 3. Connectivity Tests

Test access from your local machine:

```bash
# Test Load Balancer response
curl http://<load_balancer_ip>

# (Optional) Test SSH to a specific instance via public IP (if key added)
ssh user@<instance_public_ip>
```
