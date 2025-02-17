terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

data "yandex_vpc_subnet" "subnets" {
  count     = length(var.vpc_subnet_list)
  subnet_id = var.vpc_subnet_list[count.index]
}

locals {
  matched_subnet_id = [
    for subnet in data.yandex_vpc_subnet.subnets :
    subnet.subnet_id if subnet.zone == var.target_zone
  ][0]
}

#Create VM
resource "yandex_compute_instance" "vm-1" {
  name        = "vm-1"
  platform_id = "standard-v2"
  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd89sohb28dqsoq35u7j" # ID Ubuntu
    }
  }
  network_interface {
    subnet_id = local.matched_subnet_id
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  } 

}