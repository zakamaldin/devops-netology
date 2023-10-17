## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_mdb_mysql_database.db_name](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_database) | resource |
| [yandex_mdb_mysql_user.db_username](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_user) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_db_cluster_id"></a> [db\_cluster\_id](#input\_db\_cluster\_id) | Id of database cluster | `string` | `""` | no |
| <a name="input_db_name"></a> [db\_name](#input\_db\_name) | Database name | `string` | `"netoogy_database"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Password for user | `string` | `"admin"` | no |
| <a name="input_db_username"></a> [db\_username](#input\_db\_username) | Username for database | `string` | `"admin"` | no |

## Outputs

No outputs.
