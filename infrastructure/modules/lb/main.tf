locals {
  name_prefix = "${var.company_name}-${var.environment}-${var.service_name}"
}

# ─── Global External IP ───────────────────────────────────────────────────────
resource "google_compute_global_address" "default" {
  name         = "${local.name_prefix}-lb-ip"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

# ─── HTTP → HTTPS Redirect ────────────────────────────────────────────────────
resource "google_compute_global_forwarding_rule" "http_redirect" {
  name       = "${local.name_prefix}-lb-http-redirect"
  target     = google_compute_target_http_proxy.default.id
  port_range = "80"
}

resource "google_compute_target_http_proxy" "default" {
  name    = "${local.name_prefix}-lb-target-proxy"
  url_map = google_compute_url_map.default.id

  # Redirect HTTP → HTTPS
  redirect_id = google_compute_url_map.http_redirect[0].id
}

# ─── HTTPS Frontend ────────────────────────────────────────────────────────────
resource "google_compute_global_forwarding_rule" "https" {
  name       = "${local.name_prefix}-lb-https"
  target     = google_compute_target_https_proxy.default.id
  port_range = "443"
  address    = google_compute_global_address.default.id
}

resource "google_compute_target_https_proxy" "default" {
  name         = "${local.name_prefix}-lb-https-proxy"
  url_map      = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

resource "google_compute_managed_ssl_certificate" "default" {
  name = "${local.name_prefix}-lb-ssl"

  managed {
    domains = ["${local.name_prefix}-lb.endpoints.${var.project_id}.cloud.goog"]
  }
}

# ─── URL Map with HTTP → HTTPS redirect ───────────────────────────────────────
resource "google_compute_url_map" "http_redirect" {
  count = 1
  name  = "${local.name_prefix}-lb-http-redirect"

  default_url_redirect {
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    https_redirect         = true
  }
}

resource "google_compute_url_map" "default" {
  name            = "${local.name_prefix}-lb-url-map"
  default_service = google_compute_backend_service.default.id
}

# ─── Cloud Armor Security Policy ──────────────────────────────────────────────
resource "google_compute_security_policy" "default" {
  name    = "${local.name_prefix}-security-policy"
  description = "OWASP-based WAF rules + rate limiting"

  # ── Preconfigured WAF ruleset (OWASP Top 10) ─────────────────────────────
  rule {
    action   = "deny(403)"
    priority = 1000
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('xss-stable')"
      }
    }
    description = "Block XSS attacks"
  }

  rule {
    action   = "deny(403)"
    priority = 1001
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('sqli-stable')"
      }
    }
    description = "Block SQL injection"
  }

  rule {
    action   = "deny(403)"
    priority = 1002
    match {
      expr {
        expression = "evaluatePreconfiguredExpr('rce-stable')"
      }
    }
    description = "Block RCE attacks"
  }

  # ── Rate limiting (DDoS protection) ──────────────────────────────────────
  rule {
    action   = "throttle"
    priority = 2000
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
      ban_duration_sec        = 120
      enforce_on_key          = "IP"
    }
    description = "Rate limit: 100 req/min per IP"
  }

  # ── Adaptive Protection (Cloud Armor ML-based) ─────────────────────────────
  adaptive_protection_config {
    layer_7_ddos_defense_config {
      enable = true
    }
  }
}

# ─── Backend Service with Security Policy ────────────────────────────────────
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

resource "google_compute_health_check" "default" {
  name               = "${local.name_prefix}-lb-hc"
  check_interval_sec = 5
  timeout_sec        = 5

  http_health_check {
    port = 80
  }
}
