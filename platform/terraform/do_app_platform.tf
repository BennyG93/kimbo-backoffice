# resource "digitalocean_app" "kimbo_backoffice" {
#   spec {
#     name   = "kimbo-backoffice"
#     region = "lon"

#     service {
#       name               = "go-service"
#       environment_slug   = "go"
#       instance_count     = 1
#       instance_size_slug = "professional-xs"

#       git {
#         repo_clone_url = "https://github.com/digitalocean/sample-golang.git"
#         branch         = "main"
#       }
#     }
#   }
# }

resource "digitalocean_app" "kimbo_backoffice" {
  spec {
    name   = "kimbo-backoffice"
    region = "lon"

    domain {
      name = "backoffice.kimboapp.com"
      type = "PRIMARY"
    }

    service {
      dockerfile_path    = "platform/cicd/Dockerfile"
      name               = "kimbo-backoffice"
      http_port          = 80
      instance_count     = 1
      instance_size_slug = "basic-xxs"

      routes {
        path = "/"
      }

      env {
        key   = "ADMIN_JWT_SECRET"
        scope = "RUN_AND_BUILD_TIME"
        type  = "SECRET"
        value = jsondecode(data.aws_secretsmanager_secret_version.app_values.secret_string)["ADMIN_JWT_SECRET"]
      }

      env {
        key   = "AWS_ACCESS_KEY_ID"
        scope = "RUN_AND_BUILD_TIME"
        type  = "SECRET"
        value = local.app_secrets["AWS_ACCESS_KEY_ID"]
      }

      env {
        key   = "AWS_ACCESS_SECRET"
        scope = "RUN_AND_BUILD_TIME"
        type  = "SECRET"
        value = local.app_secrets["AWS_ACCESS_SECRET"]
      }

      env {
        key   = "AWS_DEFAULT_REGION"
        scope = "RUN_AND_BUILD_TIME"
        type  = "GENERAL"
        value = "eu-west-1"
      }

      env {
        key   = "AWS_S3_UPLOADS_BUCKET_NAME"
        scope = "RUN_AND_BUILD_TIME"
        type  = "GENERAL"
        value = "kimbo-backoffice"
      }

      env {
        key   = "AWS_S3_UPLOADS_BUCKET_PATH"
        scope = "RUN_AND_BUILD_TIME"
        value = "/uploads"
      }

      env {
        key   = "DATABASE_HOST"
        scope = "RUN_AND_BUILD_TIME"
        type  = "SECRET"
        value = local.strapi_database_secrets["host"]
      }

      env {
        key   = "DATABASE_NAME"
        scope = "RUN_AND_BUILD_TIME"
        type  = "GENERAL"
        value = "strapi"
      }

      env {
        key   = "DATABASE_PASSWORD"
        scope = "RUN_AND_BUILD_TIME"
        type  = "SECRET"
        value = local.strapi_database_secrets["password"]
      }

      env {
        key   = "DATABASE_PORT"
        scope = "RUN_AND_BUILD_TIME"
        type  = "SECRET"
        value = local.strapi_database_secrets["port"]
      }

      env {
        key   = "DATABASE_SSL"
        scope = "RUN_AND_BUILD_TIME"
        type  = "GENERAL"
        value = "false"
      }

      env {
        key   = "DATABASE_USERNAME"
        scope = "RUN_AND_BUILD_TIME"
        type  = "GENERAL"
        value = "root"
      }

      env {
        key   = "HOST"
        scope = "RUN_AND_BUILD_TIME"
        type  = "GENERAL"
        value = "0.0.0.0"
      }

      env {
        key   = "NODE_ENV"
        scope = "RUN_AND_BUILD_TIME"
        type  = "GENERAL"
        value = "production"
      }

      env {
        key   = "SERVER_URL"
        scope = "RUN_AND_BUILD_TIME"
        type  = "GENERAL"
        value = "http://backoffice.kimboapp.com"
      }

      env {
        key   = "STRAPI_LOG_PRETTY_PRINT"
        scope = "RUN_AND_BUILD_TIME"
        type  = "GENERAL"
        value = "true"
      }

      env {
        key   = "STRAPI_LOG_TIMESTAMP"
        scope = "RUN_AND_BUILD_TIME"
        type  = "GENERAL"
        value = "false"
      }

      github {
        branch         = "master"
        deploy_on_push = true
        repo           = "BennyG93/kimbo-backoffice"
      }
    }
  }

  lifecycle {
    ignore_changes = []
  }
}
