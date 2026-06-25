# ☁️ Arquitectura AWS Event-Driven con Terraform y LocalStack

![Terraform CI](https://github.com/josepanadero88/lab-terraform-aws-localstack/actions/workflows/terraform-ci.yml/badge.svg)

## 📌 Proyecto Portfolio

Proyecto orientado al aprendizaje práctico de Infraestructura como Código (IaC), automatización cloud y arquitecturas orientadas a eventos.

La infraestructura ha sido desplegada mediante Terraform utilizando LocalStack para simular servicios AWS en un entorno local, permitiendo validar conceptos y flujos habituales de automatización cloud sin consumir recursos reales en AWS.

---

## 🚀 Descripción

Implementación de una arquitectura orientada a eventos mediante Infraestructura como Código (Terraform), utilizando LocalStack para simular servicios AWS en un entorno local.

La solución integra almacenamiento S3, funciones Lambda, permisos IAM y automatización CI/CD para reproducir patrones habituales de automatización cloud.

Cuando un objeto es almacenado en un bucket S3, se genera automáticamente un evento que desencadena la ejecución de una función Lambda encargada de procesar la información y registrar la actividad correspondiente.

---

## 🎯 Objetivos técnicos

- Definir infraestructura mediante Terraform.
- Aplicar principios de Infraestructura como Código (IaC).
- Automatizar el procesamiento de eventos S3.
- Gestionar permisos mediante IAM.
- Integrar validaciones de seguridad en CI/CD.
- Aplicar controles básicos de hardening sobre recursos cloud.

---

## 🧠 Tecnologías utilizadas

### ☁️ Cloud
- AWS (simulado mediante LocalStack)
- Amazon S3
- AWS Lambda

### 🏗️ Infraestructura como Código
- Terraform

### ⚙️ Automatización
- AWS CLI
- Bash

### 🐳 Contenedores
- Docker
- LocalStack

### 💻 Desarrollo
- Python 3.9

### 🖥️ Sistema Operativo
- Ubuntu Linux

---

## 🛠️ Capacidades demostradas

- Aprovisionamiento automatizado de infraestructura mediante Terraform.
- Implementación de arquitecturas orientadas a eventos.
- Automatización de procesos mediante funciones Lambda.
- Gestión de permisos utilizando IAM.
- Parametrización y reutilización de recursos Terraform.
- Simulación de entornos AWS para pruebas y validación.
- Integración de controles DevSecOps mediante GitHub Actions.
- Aplicación de medidas básicas de hardening sobre almacenamiento S3.

---

## 🏗️ Arquitectura de la solución

La solución implementa los siguientes componentes:

- Bucket S3 para almacenamiento de objetos.
- Función Lambda desarrollada en Python.
- Roles y permisos IAM para acceso seguro entre servicios.
- Eventos S3 que desencadenan automáticamente la ejecución de la Lambda.
- Despliegue automatizado mediante Terraform.
- Ejecución local utilizando LocalStack y Docker.

![Diagrama-flujo](./img/diagrama-flujo.png)

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
  -p 4566:4566 \
  -p 4510-4559:4510-4559 \
  -e LOCALSTACK_ACKNOWLEDGE_ACCOUNT_REQUIREMENT=1 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  localstack/localstack:3
```

---

## 🚀 Despliegue de la infraestructura

```bash
terraform init
terraform plan
terraform apply --auto-approve
```

![Appply](./img/terraform2.png)

---

## 🧪 Verificación de funcionamiento

### 📦 Validación del Bucket S3

```bash
aws --endpoint-url=http://localhost:4566 s3 ls

aws --endpoint-url=http://localhost:4566 s3 cp holamundo.txt s3://bucket-local/
```

![Verificar S3](./img/terraform4.png)

---

### ⚡ Validación de Lambda

```bash
aws --endpoint-url=http://localhost:4566 lambda invoke \
  --function-name mi-primera-lambda output.txt

cat output.txt
```

![Llamada](./img/terraform5.png)

---

## 🔄 Evolución del proyecto: Arquitectura Event-Driven

En una segunda iteración se amplió la infraestructura incorporando automatización basada en eventos mediante S3 y AWS Lambda.

### Características implementadas

- Infraestructura desplegada completamente mediante Terraform.
- Roles y políticas IAM aplicando principio de mínimo privilegio.
- Parametrización mediante variables Terraform.
- Automatización basada en eventos S3.
- Registro de actividad mediante logs.

### Flujo de funcionamiento

1. Usuario sube un archivo a S3.
2. S3 detecta el evento `s3:ObjectCreated:*`.
3. Se invoca automáticamente la función Lambda.
4. La Lambda procesa el evento.
5. Se registran logs de ejecución.

![Lambda Logs v1.1](./img/log_lambda.png)

---

## 🔐 DevSecOps y CI/CD

En una tercera iteración se incorporó un pipeline de Integración Continua mediante GitHub Actions.

### Flujo implementado

1. **Terraform Format**
   - Verificación automática del formato del código Terraform.

2. **Terraform Validation**
   - Validación de sintaxis y consistencia de la infraestructura.

3. **Security Scan (tfsec)**
   - Auditoría de seguridad de la infraestructura.

### Controles de seguridad aplicados

- Cifrado AES256 en almacenamiento S3.
- Bloqueo de acceso público.
- Versionado de buckets.
- Revisión automática de configuraciones inseguras.
- Aplicación del principio de mínimo privilegio.

### Estado del Pipeline

![Terraform CI](https://github.com/josepanadero88/lab-terraform-aws-localstack/actions/workflows/terraform-ci.yml/badge.svg)

---

## 📊 Resultado

Este proyecto demuestra conocimientos prácticos en:

- Terraform.
- Infraestructura como Código (IaC).
- Automatización Cloud.
- AWS S3 y Lambda.
- IAM.
- DevSecOps.
- GitHub Actions.
- Docker y LocalStack.

---

## 🧹 Limpieza de recursos

```bash
terraform destroy --auto-approve
docker stop localstack_main
```

---

## 👨‍💻 Autor

José Alfonso Panadero Estudillo

**Systems Administrator | Linux | AWS | Terraform | Docker | Infrastructure as Code**
