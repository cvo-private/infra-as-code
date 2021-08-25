resource "google_compute_instance" "service_vm" {
  name         = "${var.name_prefix}-${random_integer.rand.result}-service"
  machine_type = "e2-micro"
  zone         = data.google_compute_zones.zones.names[1]
  allow_stopping_for_update = true

  boot_disk {
    auto_delete = true

    initialize_params {
      image = data.google_compute_image.image.self_link
    }
  }

  metadata_startup_script = file("setup.sh")

  network_interface {
    network = "default"

    access_config {
    }
  }

  tags = [ "http-server", "https-server" ]

  labels = merge(local.common_labels, { name = "${var.name_prefix}-service-a" })
}

output "internal_service_vm_ip" {
  value = google_compute_instance.service_vm.network_interface.0.access_config.0.nat_ip
}

