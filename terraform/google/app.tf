data "google_compute_image" "srv" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "default" {
  name         = "srv"
  machine_type = "n1-standard-2"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.srv.self_link
      size  = "20"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnet-a.self_link
    access_config {
      // assign a public IP to the instance
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
