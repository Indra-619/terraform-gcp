locals {
  name_prefix = "${var.company_name}-${var.environment}-${var.service_name}"
}

resource "google_compute_instance_template" "default" {
  name_prefix  = "${local.name_prefix}-template-"
  machine_type = var.machine_type
  region       = var.region

  disk {
    source_image = "ubuntu-os-cloud/ubuntu-2204-lts"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    network    = var.network_id
    subnetwork = var.subnet_id
    # Principal Architect Standard: No public IP in production
    # access_config {} 
  }

  # Preemptible VMs for best price (Dev environment standard)
  scheduling {
    preemptible       = var.environment == "production" ? false : true
    automatic_restart = var.environment == "production" ? true : false
  }

  tags = ["web-server", "allow-ssh"]

  metadata_startup_script = file("${path.module}/startup.sh")

  labels = var.labels

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "default" {
  name = "${local.name_prefix}-mig"

  base_instance_name = var.service_name
  zone               = var.zone

  version {
    instance_template = google_compute_instance_template.default.id
  }

  target_size = var.instance_count

  named_port {
    name = "http"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
}

resource "google_compute_health_check" "autohealing" {
  name                = "${local.name_prefix}-hc-autohealing"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}
