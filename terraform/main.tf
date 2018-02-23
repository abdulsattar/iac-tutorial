resource "google_compute_instance" "raddit" {
  name          = "raddit-instance"
  machine_type  = "n1-standard-1"
  zone          = "asia-south1-a"
  
  boot_disk {
    initialize_params {
      image = "raddit-base"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_compute_project_metadata" "raddit" {
  metadata {
    ssh-keys = "raddit-user:${file("~/.ssh/raddit-user.pub")}" // path to ssh key file
  }
}

resource "google_compute_firewall" "raddit" {
  name    = "allow-raddit-tcp-9292"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  source_ranges = ["0.0.0.0/0"]
}
