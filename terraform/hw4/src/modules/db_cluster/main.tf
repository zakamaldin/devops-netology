terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}

resource "yandex_mdb_mysql_cluster" "netology_db_cluster" {
  name                = var.cluster_name
  environment         = "PRODUCTION"
  network_id          = var.net_id
  version             = "8.0"
  deletion_protection = false

  resources {
    resource_preset_id = "b1.medium"
    disk_type_id       = "network-hdd"
    disk_size          = 10
  }

  dynamic "host" {
    for_each = var.HA ? toset(["1","2","3"]) : toset(["1"])
    content {
      zone             = "ru-central1-a"
      subnet_id        = var.subnet_id
    }
    
  }
}
