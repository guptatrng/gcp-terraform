resource "google_compute_global_address" "nginx_external_ip" {
    name = var.global_address_name
}

resource "google_compute_global_forwarding_rule" "nginx_global_forwarding_rule" {
  name = var.global_forwarding_rule_name
  ip_address = google_compute_global_address.nginx_external_ip.id
  target = google_compute_target_http_proxy.nginx_target_http_proxy.id
  load_balancing_scheme = "EXTERNAL"
  ip_protocol = "TCP"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "nginx_target_http_proxy" {
  name = var.global_target_http_proxy_name
  url_map = google_compute_url_map.nginx_url_map.id
}

resource "google_compute_url_map" "nginx_url_map" {
  name = var.url_map_name
  default_service = google_compute_region_backend_service.nginx_backend_service.id
}

resource "google_compute_region_backend_service" "nginx_backend_service" {
  name = var.backend_service_name
  region = var.region
  protocol = "HTTP"
  load_balancing_scheme = "EXTERNAL"
  port_name = "http-port"
  health_checks = [ google_compute_health_check.nginx_health_check.id ]
  backend {
    group = google_compute_region_instance_group_manager.nginx_instance_group.instance_group
  }
}

resource "google_compute_health_check" "nginx_health_check" {
  name = var.health_check_name
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}
