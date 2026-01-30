resource "google_compute_instance_template" "default" {
  name_prefix  = "web-server-template-"
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
    access_config {
      // Ephemeral public IP
    }
  }

  // Preemptible VMs for best price
  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  tags = ["web-server"]

  metadata_startup_script = <<-EOT
    #!/bin/bash
    apt-get update
    apt-get install -y nginx
    echo "Hello from Terraform Managed Instance Group! Hostname: $(hostname)" > /var/www/html/index.html
  EOT

  lifecycle {
    create_before_destroy = true
  }
}

resource "google_compute_instance_group_manager" "default" {
  name = "web-server-mig"

  base_instance_name = "web-server"
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
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}
