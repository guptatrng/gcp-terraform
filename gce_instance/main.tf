resource "google_compute_instance" "terraform_instance" {
    name = "nginx-box"
    machine_type = "n1-standard-1"
    boot_disk {
        initialize_params {
            image = "debian-cloud/debian-11"
        }
    }
    network_interface {
        network = "guptaji-tech-network"
        subnetwork = "guptaji-tech-subnet"
    }
}