# 🤝 Contributing Guide

![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=for-the-badge)

Terima kasih atas minat Anda untuk berkontribusi! Proyek ini menggunakan standar **Code Unified** untuk menjaga kualitas dan keamanan infrastruktur.

## 📐 Code Standards (Principal Level)

### 1. Naming Convention
Semua nama resource **WAJIB** mengikuti format:
`{company}-{environment}-{service}-{resource_type}`

Contoh:
- `indra-prod-web-server-vpc`
- `indra-dev-api-gateway-gce-template`

### 2. Mandatory Labels
Setiap resource yang mendukung labels **WAJIB** menyertakan:
- `company`: Nama organisasi.
- `environment`: `dev`, `staging`, atau `production`.
- `service`: Nama layanan terkait.
- `managed_by`: Selalu `terraform`.

### 3. Security Principles
- **DILARANG** menambahkan `access_config` (Public IP) pada instance tanpa persetujuan arsitek.
- **SSH Access**: Harus melalui IAP. Jangan membuka port 22 ke `0.0.0.0/0`.
- **Secrets**: DILARANG melakukan hardcode secret. Gunakan GCP Secret Manager atau variabel sensitif.

### 4. Code Quality
- Gunakan `terraform fmt` secara rekursif sebelum commit.
- Setiap variabel **WAJIB** memiliki `description` dan `validation` block jika memungkinkan.
- Sertakan output yang berguna (ID, URL, IP Internal) untuk setiap modul.

## 🔄 Workflow

1.  **Fork** repository ini.
2.  **Clone** hasil fork Anda.
3.  **Branch** dengan format `feat/` atau `fix/`:
    ```bash
    git checkout -b feat/add-cloud-sql-module
    ```
4.  **Validate** perubahan Anda:
    ```bash
    terraform validate
    ```
5.  **Push** dan buat **Pull Request** dengan deskripsi yang jelas tentang apa yang diubah dan alasannya.

## 🛠️ Recommended Tools

| Tool | Kegunaan |
| :--- | :--- |
| **TFLint** | Linter untuk mendeteksi error dan praktik buruk. |
| **tfsec / Checkov** | Security scanner untuk mendeteksi celah keamanan. |
| **VS Code** | Dengan extension resmi HashiCorp Terraform. |

---

<p align="center">Happy Infrastructure Coding! 🚀</p>
