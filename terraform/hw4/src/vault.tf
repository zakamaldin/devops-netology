data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

resource "vault_generic_secret" "vault_database_creds" {

  path = "secret/creds"
  data_json = jsonencode({
    username = "app"
    password = var.db_password
  })
}