resource "google_compute_instance_group" "reddit-srv" {
  name        = "reddit-srv"
  description = "load balancer instance group"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  named_port {
    name = "tcp9292"
    port = "9292"
  }

  zone = "${var.zone}"
}

resource "google_compute_http_health_check" "reddit-srv" {
  name = "reddit-srv-health-check"

  timeout_sec         = 3
  check_interval_sec  = 5
  unhealthy_threshold = 2
  healthy_threshold   = 1
  port                = "9292"
  request_path        = "/"
}

resource "google_compute_global_forwarding_rule" "reddit-srv" {
  name       = "reddit-srv-lb-front"
  target     = "${google_compute_target_http_proxy.reddit-srv.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "reddit-srv" {
  name        = "reddit-srv-lb-target-proxy"
  description = "target proxy for reddit-srv front"
  url_map     = "${google_compute_url_map.reddit-srv.self_link}"
}

resource "google_compute_url_map" "reddit-srv" {
  name            = "reddit-srv-lb"
  description     = "reddit-srv load balancer"
  default_service = "${google_compute_backend_service.reddit-srv.self_link}"
}

resource "google_compute_backend_service" "reddit-srv" {
  name        = "reddit-srv-lb-back"
  port_name   = "tcp9292"
  protocol    = "HTTP"
  timeout_sec = 30

  backend {
    group = "${google_compute_instance_group.reddit-srv.self_link}"
  }

  health_checks = ["${google_compute_http_health_check.reddit-srv.self_link}"]
}
