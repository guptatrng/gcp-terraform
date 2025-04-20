resource "google_compute_region_instance_group_manager" "nginx_instance_group" {
  name = var.region_instance_group_manager_name
  base_instance_name = var.base_instance_name
  region = var.region
  target_size = 2
  version {
    name = "nginx-instance-template-v1"
    instance_template = google_compute_instance_template.nginx-instance-template.id
  }
  named_port {
    name = "http-port"
    port = 80
  }
}

resource "google_compute_instance_template" "nginx-instance-template" {
  name = var.instance_template_name
  machine_type = "n1-standard"
  disk {
    source_image = "debian-cloud/debian-12"
    auto_delete  = true
    boot         = true
  }
  tags = [ "allow-health-checks" ]
  network_interface {
    network = var.network
    subnetwork = var.subnetwork
  }


# install nginx and serve a simple web page
  metadata = {
    startup-script = <<-EOF1
      #! /bin/bash
      set -euo pipefail

      export DEBIAN_FRONTEND=noninteractive
      apt-get update
      apt-get install -y nginx-light jq

      NAME=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/hostname")
      IP=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip")
      METADATA=$(curl -f -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/attributes/?recursive=True" | jq 'del(.["startup-script"])')

      cat <<EOF > /var/www/html/index.html
      <pre>
      Name: $NAME
      IP: $IP
      Metadata: $METADATA
      </pre>
      EOF
    EOF1
  }
}

resource "google_compute_firewall" "nginx_firewall" {
    name = var.firewall_name
    network = var.network
    direction = "INGRESS"
    source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
    allow {
      protocol = "tcp"
      ports = [ "80" ]
    }
    target_tags = [ "allow-health-checks" ]  
}

resource "google_compute_region_autoscaler" "nginx_instance_group_autoscaler" {
  name = var.instance_group_autoscaler_name
  target = google_compute_region_instance_group_manager.nginx_instance_group.id
  region = var.region
  autoscaling_policy {
    max_replicas = 3
    min_replicas = 1
  }
  
}
