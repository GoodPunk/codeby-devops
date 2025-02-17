output "subnets_info" {
  value = data.yandex_vpc_network.net.subnet_ids
}