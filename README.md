# ☁️ Modular Terraform GCP Setup

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)
[![Built By](https://img.shields.io/badge/Built%20by-Indra--619-orange?style=for-the-badge&logo=github)](https://github.com/Indra-619)

> **Deploy scalable, cost-effective web infrastructure with ease.**  
> A modular Terraform configuration for Google Cloud Platform, featuring specific network security, auto-healing, and load balancing.

---

## 📂 Project Structure

```bash
terraform-gcp/
├── 📄 README.md              # You are here!
├── 📂 docs/                  # Detailed documentation
│   ├── 🤝 CONTRIBUTING.md    # Guide for contributors
│   └── 🧪 TESTING.md         # Verification procedures
└── 📂 infrastructure/        # Terraform code
    ├── 🧱 main.tf            # Root configuration
    └── 📦 modules/           # Reusable components
        ├── 🌐 network/       # VPC, Subnets, Firewall
        ├── 💻 compute/       # MIG, Templates, Auto-healing
        └── ⚖️ lb/            # Global HTTP Load Balancer
```

---

## 🚀 Quick Start

### Prerequisites
- [x] **Terraform** (v1.0+)
- [x] **Google Cloud SDK** (`gcloud`)
- [x] **GCP Project** with billing enabled

### 1️⃣ Authenticate
```bash
gcloud auth application-default login
```

### 2️⃣ Navigate & Initialize
```bash
cd infrastructure
terraform init
```

### 3️⃣ Plan & Apply
```bash
terraform plan
terraform apply
```

---

## 📚 Documentation links

- **[🤝 Contributing Guide](docs/CONTRIBUTING.md)**: Learn how to contribute to this project.
- **[🧪 Testing & Verification](docs/TESTING.md)**: How to verify your deployment.

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/Indra-619">Indra-619</a>
</p>
