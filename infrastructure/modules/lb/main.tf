locals {
  name_prefix = "${var.company_name}-${var.environment}-${var.service_name}"
}

resource "google_compute_global_forwarding_rule" "default" {
  name       = "${local.name_prefix}-lb-forwarding-rule"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${local.name_prefix}-lb-target-proxy"
  url_map = google_compute_url_map.default.id
}

resource "google_compute_url_map" "default" {
  name            = "${local.name_prefix}-lb-url-map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_backend_service" "default" {
  name        = "${local.name_prefix}-lb-backend-service"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 10

  backend {
    group = var.instance_group
  }

  health_checks = [google_compute_health_check.default.id]
}

resource "google_compute_health_check" "default" {
  name               = "${local.name_prefix}-lb-hc"
  check_interval_sec = 5
  timeout_sec        = 5

  http_health_check {
    port = 80
  }
}
