output "vault_example" {
 value = nonsensitive(data.vault_generic_secret.vault_example.data)
} 

output "vault_database_creds" {
 value = nonsensitive(data.vault_generic_secret.vault_database_creds_data.data)
} 