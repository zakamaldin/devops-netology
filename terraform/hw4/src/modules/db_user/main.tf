terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">=0.13"
}


resource "yandex_mdb_mysql_database" "db_name" {
  cluster_id = var.db_cluster_id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "db_username" {
  cluster_id = var.db_cluster_id
  name       = var.db_username
  password   = var.db_password
  permission {
    database_name = var.db_name
    roles         = ["ALL"]
  }
}

