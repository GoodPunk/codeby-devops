resource "yandex_vpc_network" "net" {
  name = "network"
}

resource "yandex_vpc_subnet" "public" {
  name           = "public"
  zone           = var.default_zone
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.128.100.0/24"]

  depends_on = [
    yandex_vpc_network.net
  ]
}
