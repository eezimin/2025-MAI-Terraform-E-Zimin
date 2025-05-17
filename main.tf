terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.84.0"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = "ru-central1-a"
}

# Уникальный суффикс для имени бакета
resource "random_id" "suffix" {
  byte_length = 4
}

# Сервисный аккаунт для Object Storage
resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "tf-object-storage-sa"
}

# Назначение роли storage.admin
resource "yandex_resourcemanager_folder_iam_member" "sa_storage_admin" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

# Генерация статических ключей
resource "yandex_iam_service_account_static_access_key" "sa_key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "Access key for Object Storage"
}

# Создание S3-бакета через IAM-подход
resource "yandex_storage_bucket" "bucket" {
  folder_id     = var.folder_id
  bucket        = "tf-bucket-${random_id.suffix.hex}"
  acl           = "private"
  force_destroy = true
}
