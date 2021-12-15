data "aws_secretsmanager_secret" "strapi_database" {
  name = "app/kimbo-backoffice/strapi_database"
}

data "aws_secretsmanager_secret" "app" {
  name = "app/kimbo-backoffice/app"
}

data "aws_secretsmanager_secret_version" "strapi_database_values" {
  secret_id = data.aws_secretsmanager_secret.strapi_database.id
}

data "aws_secretsmanager_secret_version" "app_values" {
  secret_id = data.aws_secretsmanager_secret.app.id
}

locals {
  strapi_database_secrets = jsondecode(data.aws_secretsmanager_secret_version.strapi_database_values.secret_string)
  app_secrets             = jsondecode(data.aws_secretsmanager_secret_version.app_values.secret_string)
}
