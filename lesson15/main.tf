terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {  
  zone = "ru-central1-a"
  service_account_key_file = "./key.json" # auth key JSON
  cloud_id  = "b1g36ffc0ookossrhfk4"           # Cloud ID
  folder_id = "b1g50aj68447h8te2uoi"           # Folder ID
}
#network
resource "yandex_vpc_network" "default" {  
  name = "devops-vpc-network"
}

#public ip
resource "yandex_vpc_subnet" "public" {  
  name           = "public-subnet"
  zone           = "ru-central1-a" 
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.0.0/24"]
}

#private ip
resource "yandex_vpc_subnet" "private" {  
  name           = "private-subnet"
  zone           = "ru-central1-a" 
  network_id     = yandex_vpc_network.default.id
  v4_cidr_blocks = ["192.168.1.0/24"]
}

# module data_subnet
module "data_subnets" {  
  
  source  = "./modules/data_subnets"
  vpc_network_id  = yandex_vpc_network.default.id
}


#outputs
output "subnets_list" {
  value = module.data_subnets.subnets_info
}

# module create vm
module "create_vm" {  
  source  = "./modules/create_vm"
  vpc_subnet_list  = module.data_subnets.subnets_info
  #let's initialize zone
  target_zone = "ru-central1-a"
}