# Terraform: Yandex Cloud S3 Bucket

Этот проект создаёт Object Storage бакет в Яндекс.Облаке с помощью Terraform.

### Что делает:
- Создаёт сервисный аккаунт
- Назначает роль `storage.admin`
- Генерирует ключи доступа
- Создаёт приватный S3-бакет с уникальным именем

### Использование

1. Заполни `terraform.tfvars` своими значениями.
2. Выполни:
```bash
terraform init
terraform apply
