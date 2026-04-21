# ☁️ AWS Local Lab con Terraform + LocalStack

## 🚀 Descripción
Este proyecto simula una infraestructura AWS en entorno local utilizando **LocalStack**, **Terraform** y **Docker** sobre una máquina Ubuntu. El objetivo es practicar **Infraestructura como Código (IaC)** y conceptos de arquitectura cloud sin consumir recursos reales en AWS.

---

## 🎯 Objetivos del laboratorio
- Desplegar recursos AWS en local (S3 + Lambda).
- Automatizar infraestructura con Terraform.
- Simular arquitectura cloud en entorno aislado.
- Practicar flujos reales de trabajo DevOps.

---

## 🧠 Tecnologías utilizadas
- **Cloud**: AWS (simulado con LocalStack)
- **IaC**: Terraform
- **Contenedores**: Docker
- **Lenguaje**: Python (Lambda)
- **Sistema**: Ubuntu 20.04
- **Herramientas**: AWS CLI, Bash

---

## 🏗️ Arquitectura del laboratorio
El laboratorio incluye:
- **Bucket S3** simulado para almacenamiento.
- **Función Lambda** en Python para procesamiento.
- Infraestructura definida mediante **Terraform**.
- Ejecución sobre **LocalStack** (AWS local).

---

## 📂 Estructura del proyecto
```text
lab-terraform-aws/
├── provider.tf
├── s3.tf
├── lambda.tf
├── src/
│   └── index.py
├── holamundo.txt
├── .gitignore
└── README.md
```

---

## ⚙️ Preparación del entorno

### 1. Actualización e instalación de dependencias
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl unzip gnupg software-properties-common python3-pip
```

---

### 2. 🐳 Instalación de Docker
```bash
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
```

> ⚠️ Reinicia sesión para aplicar los permisos de Docker.

---

### 3. 📦 Instalación de Terraform
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update && sudo apt install terraform
```

---

### 4. ☁️ Configuración de LocalStack
```bash
docker run -d --name localstack_main \
  -p 4566:4566 -p 4510-4559:4510-4559 \
  -e LOCALSTACK_ACKNOWLEDGE_ACCOUNT_REQUIREMENT=1 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  localstack/localstack:3
```

---

## 🏗️ Despliegue con Terraform
```bash
terraform init
terraform plan
terraform apply --auto-approve
```

---

## 🧪 Pruebas de verificación

### 📦 S3
```bash
aws --endpoint-url=http://localhost:4566 s3 ls
aws --endpoint-url=http://localhost:4566 s3 cp holamundo.txt s3://bucket-local/
```

---

### ⚡ Lambda
```bash
aws --endpoint-url=http://localhost:4566 lambda invoke \
  --function-name mi-primera-lambda output.txt

cat output.txt
```

---

## 🧹 Limpieza de recursos
```bash
terraform destroy --auto-approve
docker stop localstack_main
```

---

## 📌 Notas adicionales
- LocalStack es un entorno de pruebas: los recursos se pierden al apagarlo.
- Los archivos `.tfstate` están excluidos en `.gitignore`.

---

## 🧠 Aprendizajes clave
- Uso de LocalStack como entorno AWS local
- Automatización con Terraform
- Configuración de endpoints personalizados
- Integración básica S3 + Lambda

---

## 👨‍💻 Autor
José Alfonso Panadero Estudillo
Técnico de Sistemas | Cloud Computing AWS
