resource "yandex_vpc_subnet" "vpc_subnet_private_b" {
  name           = var.vpc_subnet_private_name_zone_b
  zone           = var.zone_b
  network_id     = yandex_vpc_network.vpc.id
  v4_cidr_blocks = var.vpc_subnet_private_cidr_zone_b
}

resource "yandex_mdb_mysql_cluster" "mysql_cluster" {
  name        = var.mysql_cluster_metadata.name
  environment = var.mysql_cluster_metadata.environment
  network_id  = yandex_vpc_network.vpc.id
  version     = var.mysql_cluster_metadata.version

  resources {
    resource_preset_id = var.mysql_cluster_metadata.resource_preset_id
    disk_type_id       = var.mysql_cluster_metadata.disk_type_id
    disk_size          = var.mysql_cluster_metadata.disk_size
  }

  maintenance_window {
    type = var.mysql_cluster_metadata.maintenance_window_type
  }

  backup_window_start {
    hours = var.mysql_cluster_metadata.backup_hours
    minutes = var.mysql_cluster_metadata.backup_minutes
  }

  deletion_protection = var.mysql_cluster_metadata.deletion_protection

  host {
    zone      = var.zone
    name      = var.mysql_cluster_metadata.host1_name
    subnet_id = yandex_vpc_subnet.vpc_subnet_private.id
  }

  host {
    zone      = var.zone_b
    name      = var.mysql_cluster_metadata.host2_name
    subnet_id = yandex_vpc_subnet.vpc_subnet_private_b.id
    replication_source_name = var.mysql_cluster_metadata.host1_name
  }
}

resource "yandex_mdb_mysql_database" "mysql_cluster_database" {
  cluster_id = yandex_mdb_mysql_cluster.mysql_cluster.id
  name       = var.mysql_cluster_metadata.database_name
}

resource "yandex_mdb_mysql_user" "john" {
	cluster_id = yandex_mdb_mysql_cluster.mysql_cluster.id
  name       = var.db_username
  password   = var.db_password

  permission {
    database_name = yandex_mdb_mysql_database.mysql_cluster_database.name
    roles         = ["ALL"]
  }

	authentication_plugin = "SHA256_PASSWORD"
}