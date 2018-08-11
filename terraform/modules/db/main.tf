resource "google_compute_instance" "db" {
  name         = "reddit-db-${count.index}"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-db"]
  count        = "${var.number_of_instances}"

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = "false"
    private_key = "${file(var.secret_key_path)}"
  }

  #  provisioner "file" {
  #    source      = "files/puma.service"
  #    destination = "/tmp/puma.service"
  #  }

  #  provisioner "remote-exec" {
  #    script = "files/deploy.sh"
  #  }
}

resource "google_compute_firewall" "firewall_mongo" {
  name = "allow-mongo-default"

  # Название сети, в которой действует правило
  network = "default"

  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  # Правило применимо для инстансов с тегом
  target_tags = ["reddit-db"]
  source_tags = ["reddit-app"]
}
