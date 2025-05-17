resource "yandex_compute_instance" "django" {
  name = "django"
  zone = var.default_zone
  resources {
    core_fraction = var.core_fraction
    cores         = 4
    memory        = 8
  }
  scheduling_policy {
    preemptible = var.preemptible
  }
  boot_disk {
    initialize_params {
      image_id = var.image_id
      name     = "root-django"
      type     = "network-nvme"
      size     = "10"
    }
  }
  network_interface {
    subnet_id      = yandex_vpc_subnet.public.id
    nat            = true
    nat_ip_address = var.nat_ip_address
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      #Docker
      "sudo apt-get update",
      "curl --fail --silent --show-error --location https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-keyring.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce docker-cecontainerd.io",
      "sudo apt-get install -y docker-compose",
      "sudo usermod -aG docker $USER",
      "sudo chmod 666 /var/run/docker.sock",
      #Github runner
      "mkdir actions-runner && cd actions-runner",
      "curl -o actions-runner-linux-x64-2.320.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.320.0/actions-runner-linux-x64-2.320.0.tar.gz",
      "echo \"93ac1b7ce743ee85b5d386f5c1787385ef07b3d7c728ff66ce0d3813d5f46900  actions-runner-linux-x64-2.320.0.tar.gz\" | shasum -a 256 -c",
      "tar xzf ./actions-runner-linux-x64-2.320.0.tar.gz",
    ]
    connection {
      type        = "ssh"
      host        = self.network_interface[0].nat_ip_address
      user        = "ubuntu"
      private_key = file(var.ssh_private_key_path)
    }
  }

  depends_on = [
    yandex_vpc_subnet.public
  ]
}
