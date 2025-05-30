provider "yandex" {
  service_account_key_file = var.key_file
  cloud_id                 = var.yandex_cloud_id
  folder_id                = var.yandex_folder_id
}
