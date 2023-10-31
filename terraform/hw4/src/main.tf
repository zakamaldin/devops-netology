module "test-vm-dev" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab828b1fcae16556a4d167134efca2fccf2"
  env_name        = "develop"
  network_id      = module.net_dev.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = module.net_dev.subnet_ids
  instance_name   = "web"
  image_family    = var.image_family
  public_ip       = false
  security_group_ids = [ module.net_dev.network_id ]
  
  metadata = {
      user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
      serial-port-enable = 1
  }

}

module "test-vm-prod" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=4d05fab828b1fcae16556a4d167134efca2fccf2"
  env_name        = "production"
  network_id      = module.net_prod.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = module.net_prod.subnet_ids
  instance_name   = "web"
  image_family    = var.image_family
  public_ip       = false
  security_group_ids = [ module.net_dev.network_id ]
  
  metadata = {
      user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
      serial-port-enable = 1
  }

}

module "net_prod" {
  source       = "./modules/net"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "net_dev" {
  source       = "./modules/net"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}

module "netology_db_cluster" {
  source       = "./modules/db_cluster"
  cluster_name = "example"
  net_id       = module.net_dev.network_id
  subnet_id    = module.net_dev.subnet_ids[0]
  HA           = false
  security_group_ids = [ module.net_dev.network_id ]

}

module "netology_db_with_user" {
  source          = "./modules/db_user"
  db_cluster_id   = module.netology_db_cluster.cluster_id
  db_name         = "test"
  db_username     = "app"
  db_password     = var.db_password
}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
  vars = {
    ssh_public_key = file(var.vms_ssh_root_key)
  }
}

