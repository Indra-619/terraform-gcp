locals {
  name_prefix = "${var.company_name}-${var.environment}-${var.service_name}"
}

resource "google_compute_network" "vpc_network" {
  name                    = "${local.name_prefix}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name                     = "${local.name_prefix}-subnet"
  ip_cidr_range            = "10.0.0.0/24"
  region                   = var.region
  network                  = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow_internal" {
  name    = "${local.name_prefix}-fw-allow-internal"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080"] # Standard internal ports instead of all
  }

  source_ranges = ["10.0.0.0/24"]
}

# Principal Architect Standard: Access SSH via IAP only
resource "google_compute_firewall" "allow_ssh_iap" {
  name    = "${local.name_prefix}-fw-allow-ssh-iap"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Google IAP range
  source_ranges = ["35.235.240.0/20"]
  target_tags   = ["allow-ssh"]
}

resource "google_compute_firewall" "allow_http" {
  name    = "${local.name_prefix}-fw-allow-http"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}
