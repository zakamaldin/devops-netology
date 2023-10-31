output "cluster_id" {
    description = "Database cluster id"
    value       = yandex_mdb_mysql_cluster.netology_db_cluster.id
}