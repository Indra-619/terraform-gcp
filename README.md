# ☁️ Modular Terraform GCP Setup (Code Unified Standard)

![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)
![Code Unified](https://img.shields.io/badge/Standards-Code--Unified-blue?style=for-the-badge)

> **Deploy scalable, cost-effective, and hardened web infrastructure with ease.**  
> Repository ini mengikuti **Code Unified Standards (Principal Architect Edition)** untuk keamanan tingkat enterprise dan skalabilitas cloud.

---

## 🛡️ Key Features & Standards

1.  **Security Hardened**:
    - **No Public IP**: Semua instance berada di subnet privat tanpa akses publik langsung.
    - **IAP Access**: Akses SSH hanya diperbolehkan melalui **Identity-Aware Proxy (IAP)**.
    - **Standardized Firewalls**: Whitelist ketat untuk port internal dan eksternal.
2.  **Cost Optimized**:
    - **Preemptible VMs**: Otomatis menggunakan Preemptible/Spot VMs di lingkungan non-production.
    - **Scale-to-Zero Ready**: Desain modular untuk integrasi serverless.
3.  **Enterprise Readiness**:
    - **Remote Backend**: Menggunakan GCS untuk state management yang aman dan kolaboratif.
    - **Naming Convention**: `{company}-{env}-{service}-{type}` untuk semua resource.
    - **Mandatory Labels**: Tracking biaya dan kepemilikan via labels otomatis.

---

## 📂 Project Structure

```bash
terraform-gcp/
├── 📄 README.md              # Anda di sini!
├── 📂 docs/                  # Dokumentasi detail
│   ├── 🤝 CONTRIBUTING.md    # Panduan kontribusi & standar koding
│   └── 🧪 TESTING.md         # Prosedur verifikasi infrastruktur
└── 📂 infrastructure/        # Kode Terraform Utama
    ├── 🧱 main.tf            # Root orchestrator & common labels
    ├── ⚙️ provider.tf         # Strict provider pinning (~> 5.40)
    ├── 📦 backend.tf         # GCS Remote State configuration
    ├── 📝 variables.tf        # Input variables dengan validasi ketat
    └── 📦 modules/           # Reusable components
        ├── 🌐 network/       # VPC, Subnets (Private Google Access), Firewall
        ├── 💻 compute/       # MIG, Instance Template, startup.sh
        └── ⚖️ lb/            # Global HTTP Load Balancer
```

---

## 🚀 Quick Start

### Prerequisites
- [x] **Terraform** (v1.7+)
- [x] **Google Cloud SDK** (`gcloud`)
- [x] **GCP Project** dengan billing aktif

### 1️⃣ Konfigurasi Backend
Edit `infrastructure/backend.tf` dan masukkan nama bucket GCS Anda:
```hcl
bucket = "nama-bucket-state-anda"
```

### 2️⃣ Inisialisasi & Authenticate
```bash
gcloud auth application-default login
cd infrastructure
terraform init
```

### 3️⃣ Plan & Apply
```bash
terraform plan -var="project_id=your-project-id"
terraform apply -var="project_id=your-project-id"
```

---

## 📚 Dokumentasi Lanjutan

- **[🤝 Panduan Kontribusi](docs/CONTRIBUTING.md)**: Aturan penamaan dan standar penulisan `.tf`.
- **[🧪 Verifikasi & Testing](docs/TESTING.md)**: Cara melakukan tes konektivitas dan audit keamanan pasca-deploy.

---

<p align="center">
  Maintained with ❤️ by <a href="https://github.com/Indra-619">Indra-619</a><br>
  Powered by <b>Code Unified Standards</b>
</p>
