locals {
  name_prefix = "${var.company_name}-${var.environment}-${var.service_name}"
}

# ─── Global External IP ───────────────────────────────────────────────────────
resource "google_compute_global_address" "default" {
  name         = "${local.name_prefix}-lb-ip"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

# ─── SSL Managed Certificate ──────────────────────────────────────────────────
resource "google_compute_managed_ssl_certificate" "default" {
  name = "${local.name_prefix}-lb-ssl"

  managed {
    domains = ["${local.name_prefix}.endpoints.${var.project_id}.cloud.goog"]
  }
}

# ─── HTTPS URL Map (primary routing) ────────────────────────────────────────
resource "google_compute_url_map" "https" {
  name            = "${local.name_prefix}-lb-url-map"
  default_service = google_compute_backend_service.default.id
}

# ─── HTTP → HTTPS Redirect URL Map ───────────────────────────────────────────
resource "google_compute_url_map" "http_redirect" {
  name = "${local.name_prefix}-lb-http-redirect-url-map"

  default_url_redirect {
    https_redirect         = true
    strip_query            = false
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
  }
}

# ─── Target Proxies ───────────────────────────────────────────────────────────
resource "google_compute_target_https_proxy" "https" {
  name             = "${local.name_prefix}-lb-https-proxy"
  url_map          = google_compute_url_map.https.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

resource "google_compute_target_http_proxy" "http" {
  name    = "${local.name_prefix}-lb-http-proxy"
  url_map = google_compute_url_map.http_redirect.id
}

# ─── Forwarding Rules (port 80 → redirect, port 443 → HTTPS) ────────────────
resource "google_compute_global_forwarding_rule" "https" {
  name       = "${local.name_prefix}-lb-https-fwd"
  target     = google_compute_target_https_proxy.https.id
  port_range = "443"
}

resource "google_compute_global_forwarding_rule" "http" {
  name       = "${local.name_prefix}-lb-http-fwd"
  target     = google_compute_target_http_proxy.http.id
  port_range = "80"
}

# ─── Cloud Armor Security Policy ──────────────────────────────────────────────
resource "google_compute_security_policy" "default" {
  name        = "${local.name_prefix}-security-policy"
  description = "OWASP-based WAF + rate limiting + Adaptive Protection"

  # ── OWASP Top 10 WAF Rules ─────────────────────────────────────────────
  rule {
    action      = "deny(403)"
    priority    = 1000
    description = "Block XSS attacks"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('xss-stable')"
      }
    }
  }

  rule {
    action      = "deny(403)"
    priority    = 1001
    description = "Block SQL injection"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('sqli-stable')"
      }
    }
  }

  rule {
    action      = "deny(403)"
    priority    = 1002
    description = "Block RCE attacks"
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('rce-stable')"
      }
    }
  }

  # ── Rate Limiting (DDoS protection) ────────────────────────────────────
  rule {
    action      = "throttle"
    priority    = 2000
    description = "Rate limit: 100 req/min per IP"
    match {
      expr {
        expression = "request.path.matches('/.*')"
      }
    }
    rate_limit_options {
      conform_action = "allow"
      exceed_action  = "deny(429)"
      rate_limit_threshold {
        count        = 100
        interval_sec = 60
      }
      ban_duration_sec = 120
      enforce_on_key   = "IP"
    }
  }

  # ── Adaptive Protection (ML-based DDoS) ───────────────────────────────────
  adaptive_protection_config {
    layer_7_ddos_defense_config {
      enable = true
    }
  }
}

# ─── Backend Service ───────────────────────────────────────────────────────────
resource "google_compute_backend_service" "default" {
  name        = "${local.name_prefix}-lb-backend-service"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 30

  backend {
    group           = var.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }

  security_policy = google_compute_security_policy.default.id
  health_checks   = [google_compute_health_check.default.id]
}

# ─── Health Check ─────────────────────────────────────────────────────────────
resource "google_compute_health_check" "default" {
  name                = "${local.name_prefix}-lb-hc"
  check_interval_sec  = 10
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 5

  http_health_check {
    port = 80
  }
}
