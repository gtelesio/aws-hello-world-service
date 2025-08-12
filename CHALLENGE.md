# 🧪 Prueba Técnica - Arquitectura AWS

Este proyecto implementa un servicio HTTP básico (Hello World), generando un container con Docker, desplegado en Amazon ECS detrás de un Application Load Balancer, utilizando infraestructura como código.

## 📁 Estructura del Proyecto

```
.
├── app/                  # Código fuente del servicio
│   └── main
├── Dockerfile
├── infra/                # Infraestructura (Terraform o CloudFormation)
│   └── main.tf           # O main.yaml, main.ts, main.js 
└── README.md
```

# ✅ Requisitos minimos de la prueba

- Crear una API HTTP que responda "Hello World" (puede ser en cualquier lenguaje).
- Contenerizar la aplicación con Docker.
- Subir la imagen a Amazon ECR.
- Crear un servicio en Amazon ECS:
  - Modo EC2 (preferido) o Fargate (opcional).
  - Una única tarea que ejecute el contenedor.
- Crear un Application Load Balancer:
  - Expuesto públicamente.
- Enruta tráfico HTTP a la tarea ECS.
- Exponer la URL del endpoint funcional.
- Usar CloudFormation o Terraform para definir toda la infraestructura.
- Proveer instrucciones de ejecución (README.md).

# 🔐 Requisitos adicionales (extra pero valorados)

- Logs del contenedor enviados a CloudWatch Logs.
- Manejo de variables sensibles con SSM Parameter Store o Secrets Manager.
- Modularidad en la IaC (separar VPC, ECS, ALB, etc.).
- Roles e IAM Policies con principio de mínimo privilegio.
- Seguridad básica con Security Groups bien configurados.
- Comentarios explicativos en el código o archivo README.md.

# 📦 Entregables
- Código fuente del servicio (app/)
- Dockerfile
- Archivos de Terraform o CloudFormation (infra/)
- Instrucciones en un README.md que expliquen:
  - Cómo construir y subir la imagen
  - Cómo desplegar la infraestructura
  - Cómo acceder al endpoint

