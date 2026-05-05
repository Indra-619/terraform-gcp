# 🧪 Testing & Verification Plan

Pastikan infrastruktur Anda berjalan sesuai standar keamanan dan fungsionalitas **Code Unified**.

## 🤖 1. Validasi Pra-Deploy

Sebelum menjalankan `apply`, lakukan pemeriksaan standar:

```bash
cd infrastructure

# 1. Cek sintaks dan konsistensi internal
terraform validate

# 2. Preview perubahan dan simpan plan
terraform plan -out=tfplan
```

## 🔍 2. Verifikasi Pasca-Deploy (Audit Manual)

Setelah menjalankan `terraform apply`, verifikasi resource di GCP Console menggunakan naming convention yang baru:

### 🌐 Networking
- [ ] **VPC**: Nama mengikuti format `indra-{env}-web-server-vpc`.
- [ ] **Subnet**: Memiliki fitur **Private Google Access** diaktifkan.
- [ ] **Firewall**: 
    - Aturan `allow-ssh-iap` hanya mengizinkan range `35.235.240.0/20`.
    - Aturan `allow-http` aktif untuk port 80.
    - Tidak ada port 22 yang terbuka ke `0.0.0.0/0`.

### 💻 Compute (MIG)
- [ ] **MIG**: Berjalan dengan nama `{company}-{env}-{service}-mig`.
- [ ] **Health**: Semua instance dalam grup berstatus **Healthy**.
- [ ] **No Public IP**: Cek di console, instance TIDAK boleh memiliki External IP.

### ⚖️ Load Balancing
1.  Buka **Network services > Load balancing**.
2.  Cek frontend IP pada Load Balancer `{company}-{env}-{service}-lb-url-map`.
3.  Akses `http://<load_balancer_ip>` di browser.
    > Output: *"Hello from Terraform Managed Instance Group!"*

## 🔌 3. Tes Konektivitas SSH (via IAP)

Karena port 22 ditutup dari publik, gunakan `gcloud` untuk masuk ke instance melalui tunnel IAP:

```bash
# Ganti <instance_name> dengan nama VM dari MIG
gcloud compute ssh <instance_name> --tunnel-through-iap --project=<your_project_id> --zone=<your_zone>
```

## 📦 4. Verifikasi State
- [ ] Cek bucket GCS Anda. Pastikan file `default.tfstate` (atau sesuai prefix) sudah terbuat dan terupdate.

---
<p align="center">Verifikasi Selesai — Infrastruktur Aman & Standar 🛡️</p>
