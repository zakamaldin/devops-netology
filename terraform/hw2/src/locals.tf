locals {
  web_vm_name = "${var.cloud_name}-${var.dev_environment}-${var.platform}-web"
  db_vm_name = "${var.cloud_name}-${var.dev_environment}-${var.platform}-db"
}