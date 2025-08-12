# 🚀 AWS Hello World Service

Un servicio "Hello World" implementado siguiendo los principios de **Domain-Driven Design (DDD)** y **Clean Architecture**, desplegado en **AWS ECS** con **Infrastructure as Code** usando **Terraform**.

## 🏗️ Arquitectura

### Clean Architecture + DDD
```
src/
├── domain/           # Entidades y lógica de negocio
├── application/      # Casos de uso y servicios de aplicación
├── interfaces/       # Controladores, middlewares y validadores
├── infrastructure/   # Configuración del servidor y tipos
└── shared/          # Utilidades y constantes compartidas
```

### Tecnologías
- **Backend**: Node.js + TypeScript + Fastify
- **Testing**: Jest + ts-jest
- **Linting**: ESLint + Prettier
- **CI/CD**: GitHub Actions
- **Git Hooks**: Husky + lint-staged
- **Containerización**: Docker
- **Infraestructura**: Terraform
- **AWS**: ECS, ECR, ALB, CloudWatch

## 🚀 Inicio Rápido

### Prerrequisitos
- Node.js 18+ 
- npm 9+
- Docker
- AWS CLI configurado

### Instalación
```bash
# Clonar el repositorio
git clone https://github.com/gtelesio/aws-hello-world-service.git
cd aws-hello-world-service

# Instalar dependencias
cd app
npm install

# Configurar variables de entorno
cp env.example .env
# Editar .env con tus valores

# Ejecutar tests
npm run test

# Ejecutar en desarrollo
npm run dev

# Construir para producción
npm run build
npm start
```

## 🧪 Testing

### Ejecutar Tests
```bash
# Todos los tests
npm run test

# Tests en modo watch
npm run test:watch

# Tests con coverage
npm run test:coverage
```

### Coverage Actual
- **Statements**: 79.91%
- **Branches**: 71.23%
- **Functions**: 82%
- **Lines**: 79.82%

## 🔧 Scripts Disponibles

### Desarrollo
```bash
npm run dev          # Servidor de desarrollo con hot reload
npm run build        # Construir para producción
npm run start        # Iniciar servidor de producción
```

### Testing
```bash
npm run test         # Ejecutar tests
npm run test:watch   # Tests en modo watch
npm run test:coverage # Tests con coverage
```

### Linting y Formateo
```bash
npm run lint         # Ejecutar ESLint
npm run lint:fix     # ESLint con auto-fix
npm run lint:staged  # ESLint en archivos staged
npm run format       # Formatear con Prettier
npm run format:check # Verificar formateo
```

## 🐕 Husky Git Hooks

El proyecto utiliza **Husky** para ejecutar automáticamente:

### Pre-commit
- Linting en archivos staged
- Formateo automático

### Pre-push
- Linting completo
- Tests completos
- Verificación de calidad

## 🚀 GitHub Actions

### Workflows Automatizados
- **🧪 Test Suite**: Tests en múltiples versiones de Node.js
- **🔒 Security Scan**: Auditoría de seguridad y Snyk
- **🏗️ Build Check**: Verificación de build
- **📊 Code Quality**: ESLint y Prettier

### Triggers
- Push a `main`, `develop`, `feature/*`, `hotfix/*`
- Pull Requests a `main`, `develop`

## 🌐 API Endpoints

### V1 API
```
GET  /v1/api/hello-world     # Hello World básico
POST /v1/api/hello-world     # Mensaje personalizado
GET  /v1/api/languages       # Idiomas soportados
GET  /v1/api/health          # Health check
```

### V2 API
```
GET  /v2/api/hello-world     # Hello World con metadatos
POST /v2/api/hello-world     # Mensaje personalizado avanzado
GET  /v2/api/languages       # Idiomas soportados
GET  /v2/api/health          # Health check detallado
```

## 🔐 Variables de Entorno

### Configuración del Servidor
```bash
PORT=3000                    # Puerto del servidor
HOST=0.0.0.0                # Host del servidor
LOG_LEVEL=info              # Nivel de logging
NODE_ENV=development        # Ambiente
```

### AWS Configuration
```bash
AWS_REGION=us-east-1        # Región de AWS
AWS_ACCESS_KEY_ID=...       # Access Key ID
AWS_SECRET_ACCESS_KEY=...   # Secret Access Key
```

### Ver archivo `env.example` para todas las variables disponibles.

## 🐳 Docker

### Construir Imagen
```bash
docker build -t aws-hello-world-service .
```

### Ejecutar Contenedor
```bash
docker run -p 3000:3000 aws-hello-world-service
```

## 🏗️ Infraestructura (Terraform)

### Desplegar Infraestructura
```bash
cd infrastructure
terraform init
terraform plan
terraform apply
```

### Componentes AWS
- **ECS Cluster**: Servicio containerizado
- **ECR Repository**: Imágenes Docker
- **Application Load Balancer**: Balanceo de carga
- **CloudWatch**: Logs y métricas
- **IAM**: Roles y políticas con mínimo privilegio

## 📁 Estructura del Proyecto

```
aws-hello-world-service/
├── .github/                 # GitHub Actions
├── .husky/                  # Git hooks
├── app/                     # Código de la aplicación
│   ├── src/                # Código fuente
│   ├── package.json        # Dependencias
│   └── jest.config.js      # Configuración de Jest
├── infrastructure/          # Código de Terraform
├── .gitignore              # Archivos ignorados por Git
├── env.example             # Variables de entorno de ejemplo
├── HUSKY.md                # Documentación de Husky
└── README.md               # Este archivo
```

## 🧪 Ejecutar Tests

### Tests Unitarios
```bash
cd app
npm run test
```

### Tests con Coverage
```bash
cd app
npm run test:coverage
```

### Tests en Modo Watch
```bash
cd app
npm run test:watch
```

## 🔍 Linting y Formateo

### ESLint
```bash
cd app
npm run lint        # Verificar
npm run lint:fix    # Corregir automáticamente
```

### Prettier
```bash
cd app
npm run format        # Formatear
npm run format:check  # Verificar formateo
```

## 🚀 Despliegue

### Desarrollo Local
```bash
cd app
npm run dev
```

### Producción
```bash
cd app
npm run build
npm start
```

### AWS ECS
```bash
# Construir y push imagen
docker build -t aws-hello-world-service .
docker tag aws-hello-world-service:latest $ECR_REPOSITORY_URI:latest
docker push $ECR_REPOSITORY_URI:latest

# Desplegar con Terraform
cd infrastructure
terraform apply
```

## 📊 Monitoreo

### Health Checks
- **Endpoint**: `/health` y `/v1/api/health`
- **Métricas**: Uptime, memoria, CPU
- **Logs**: CloudWatch Logs

### Métricas AWS
- **ECS**: CPU, memoria, contenedores
- **ALB**: Requests, latencia, errores
- **CloudWatch**: Logs estructurados

## 🤝 Contribuir

### Flujo de Trabajo
1. Fork del repositorio
2. Crear feature branch (`git checkout -b feature/amazing-feature`)
3. Commit cambios (`git commit -m 'Add amazing feature'`)
4. Push al branch (`git push origin feature/amazing-feature`)
5. Abrir Pull Request

### Estándares de Código
- **TypeScript**: Tipado estricto
- **ESLint**: Reglas configuradas
- **Prettier**: Formateo automático
- **Tests**: Coverage mínimo 80%
- **Commits**: Convención convencional

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🆘 Soporte

### Issues
- **Bug Reports**: [GitHub Issues](https://github.com/gtelesio/aws-hello-world-service/issues)
- **Feature Requests**: [GitHub Issues](https://github.com/gtelesio/aws-hello-world-service/issues)

### Documentación
- **Husky**: Ver `HUSKY.md`
- **API**: Ver documentación de endpoints
- **Infraestructura**: Ver `infrastructure/README.md`

## 🎯 Roadmap

### Próximas Características
- [ ] **API v3** con GraphQL
- [ ] **Autenticación** JWT
- [ ] **Rate Limiting** avanzado
- [ ] **Métricas** Prometheus
- [ ] **Tracing** con Jaeger
- [ ] **Multi-tenancy** soporte
- [ ] **WebSocket** para tiempo real

### Mejoras de Infraestructura
- [ ] **Auto-scaling** basado en métricas
- [ ] **Blue-Green** deployments
- [ ] **Canary** releases
- [ ] **Multi-region** deployment
- [ ] **CDN** con CloudFront

---

**Desarrollado con ❤️ siguiendo las mejores prácticas de Clean Architecture y DDD**
