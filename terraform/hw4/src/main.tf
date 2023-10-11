module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.net.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [ module.net.subnet_id ]
  instance_name   = "web"
  image_family    = "ubuntu-2004-lts"
  public_ip       = true
  
  metadata = {
      user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
      serial-port-enable = 1
  }

}

module "net" {
  source          = "./modules/net"
  zone            = var.default_zone
  cidr            = var.default_cidr
  network_name    = var.vpc_name
  subnet_name     = var.vpc_name
}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
  vars = {
    ssh_public_key = file(var.vms_ssh_root_key)
  }
}

