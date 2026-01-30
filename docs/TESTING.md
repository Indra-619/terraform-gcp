# 🧪 Testing & Verification Plan

Ensure your infrastructure works exactly as expected.

## 🤖 1. Automated Validation

Before applying, run these standard Terraform checks:

```bash
cd infrastructure

# 1. Check syntax and internal consistency
terraform validate

# 2. Preview changes
terraform plan
```

## 🔍 2. Manual Verification

After running `terraform apply`, verify the resources in the GCP Console:

### 🌐 Networking
- [ ] **VPC**: `main-vpc` exists.
- [ ] **Subnet**: `main-subnet` is created.
- [ ] **Firewall**: Rules `allow-ssh`, `allow-http`, `allow-internal` are active.

### 💻 Compute
- [ ] **MIG**: `web-server-mig` is running `instance_count` VMs.
- [ ] **Health**: All instances report as **Healthy**.

### ⚖️ Load Balancing
1.  Go to **Network services > Load balancing**.
2.  Find the LB created by `global-rule`.
3.  Copy the **Frontend IP**.
4.  Visit `http://<load_balancer_ip>` in your browser.
    > You should see: *"Hello from Terraform Managed Instance Group!"*

## 🔌 3. Connectivity Tests

```bash
# Test LB Response
curl -I http://<load_balancer_ip>
```
