
variable "yandex_cloud_id" {
  type      = string
  sensitive = true
}

variable "yandex_folder_id" {
  type      = string
  sensitive = true
}

variable "default_zone" {
  type    = string
  default = "ru-central1-a"
}

variable "key_file" {
  type    = string
  default = "files/key.json"
}

variable "ssh_public_key_path" {
  type    = string
  default = "files/id_rsa.pub"
}

variable "ssh_private_key_path" {
  type    = string
  default = "files/id_rsa"
}

variable "image_id" {
  default = "fd81u2vhv3mc49l1ccbb"
}

variable "core_fraction" {
  type    = number
  default = 20
}

variable "preemptible" {
  type    = bool
  default = true
}

variable "nat_ip_address" {
  type    = string
  default = "89.169.145.94"
}

