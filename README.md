# 🚀 AWS Hello World Service

A "Hello World" service implemented following **Domain-Driven Design (DDD)** and **Clean Architecture** principles, deployed on **AWS ECS** with **Infrastructure as Code** using **Terraform**.

## 🏗️ Architecture

### Clean Architecture + DDD
```
src/
├── domain/           # Business entities and logic
├── application/      # Use cases and application services
├── interfaces/       # Controllers, middlewares and validators
├── infrastructure/   # Server configuration and types
└── shared/          # Shared utilities and constants
```

### Technologies
- **Backend**: Node.js + TypeScript + Fastify
- **Testing**: Jest + ts-jest
- **Linting**: ESLint + Prettier
- **CI/CD**: GitHub Actions
- **Git Hooks**: Husky + lint-staged
- **Containerization**: Docker
- **Infrastructure**: Terraform
- **AWS**: ECS, ECR, ALB, CloudWatch

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ 
- npm 9+
- Docker
- AWS CLI configured

### Installation
```bash
# Clone the repository
git clone https://github.com/gtelesio/aws-hello-world-service.git
cd aws-hello-world-service

# Install dependencies
cd app
npm install

# Configure environment variables
cp env.example .env
# Edit .env with your values

# Run tests
npm run test

# Run in development
npm run dev

# Build for production
npm run build
npm start
```

## 🧪 Testing

### Run Tests
```bash
# All tests
npm run test

# Tests in watch mode
npm run test:watch

# Tests with coverage
npm run test:coverage
```

### Current Coverage
- **Statements**: 79.91%
- **Branches**: 71.23%
- **Functions**: 82%
- **Lines**: 79.82%

## 🔧 Available Scripts

### Development
```bash
npm run dev          # Development server with hot reload
npm run build        # Build for production
npm run start        # Start production server
```

### Testing
```bash
npm run test         # Run tests
npm run test:watch   # Tests in watch mode
npm run test:coverage # Tests with coverage
```

### Linting and Formatting
```bash
npm run lint         # Run ESLint
npm run lint:fix     # ESLint with auto-fix
npm run lint:staged  # ESLint on staged files
npm run format       # Format with Prettier
npm run format:check # Check formatting
```

## 🐕 Husky Git Hooks

The project uses **Husky** to automatically execute:

### Pre-commit
- Linting on staged files
- Automatic formatting

### Pre-push
- Complete linting
- Complete tests
- Quality verification

## 🚀 GitHub Actions

### Automated Workflows
- **🧪 Test Suite**: Tests on multiple Node.js versions
- **🔒 Security Scan**: Security audit and Snyk
- **🏗️ Build Check**: Build verification
- **📊 Code Quality**: ESLint and Prettier

### Triggers
- Push to `main`, `develop`, `feature/*`, `hotfix/*`
- Pull Requests to `main`, `develop`

## 🌐 API Endpoints

### V1 API
```
GET  /v1/api/hello-world     # Basic Hello World
POST /v1/api/hello-world     # Custom message
GET  /v1/api/languages       # Supported languages
GET  /v1/api/health          # Health check
```

### V2 API
```
GET  /v2/api/hello-world     # Hello World with metadata
POST /v2/api/hello-world     # Advanced custom message
GET  /v2/api/languages       # Supported languages
GET  /v2/api/health          # Detailed health check
```

## 🔐 Environment Variables

### Server Configuration
```bash
PORT=3000                    # Server port
HOST=0.0.0.0                # Server host
LOG_LEVEL=info              # Logging level
NODE_ENV=development        # Environment
```

### AWS Configuration
```bash
AWS_REGION=us-east-1        # AWS region
AWS_ACCESS_KEY_ID=...       # Access Key ID
AWS_SECRET_ACCESS_KEY=...   # Secret Access Key
```

### See `env.example` file for all available variables.

## 🐳 Docker

### Build Image
```bash
docker build -t aws-hello-world-service .
```

### Run Container
```bash
docker run -p 3000:3000 aws-hello-world-service
```

## 🏗️ Infrastructure (Terraform)

### Deploy Infrastructure
```bash
cd infrastructure
terraform init
terraform plan
terraform apply
```

### AWS Components
- **ECS Cluster**: Containerized service
- **ECR Repository**: Docker images
- **Application Load Balancer**: Load balancing
- **CloudWatch**: Logs and metrics
- **IAM**: Roles and policies with minimum privilege

## 📁 Project Structure

```
aws-hello-world-service/
├── .github/                 # GitHub Actions
├── .husky/                  # Git hooks
├── app/                     # Application code
│   ├── src/                # Source code
│   ├── package.json        # Dependencies
│   └── jest.config.js      # Jest configuration
├── infrastructure/          # Terraform code
├── .gitignore              # Files ignored by Git
├── env.example             # Example environment variables
├── HUSKY.md                # Husky documentation
└── README.md               # This file
```

## 🧪 Run Tests

### Unit Tests
```bash
cd app
npm run test
```

### Tests with Coverage
```bash
cd app
npm run test:coverage
```

### Tests in Watch Mode
```bash
cd app
npm run test:watch
```

## 🔍 Linting and Formatting

### ESLint
```bash
cd app
npm run lint        # Verify
npm run lint:fix    # Auto-fix
```

### Prettier
```bash
cd app
npm run format        # Format
npm run format:check  # Check formatting
```

## 🚀 Deployment

### Local Development
```bash
cd app
npm run dev
```

### Production
```bash
cd app
npm run build
npm start
```

### AWS ECS
```bash
# Build and push image
docker build -t aws-hello-world-service .
docker tag aws-hello-world-service:latest $ECR_REPOSITORY_URI:latest
docker push $ECR_REPOSITORY_URI:latest

# Deploy with Terraform
cd infrastructure
terraform apply
```

## 📊 Monitoring

### Health Checks
- **Endpoint**: `/health` and `/v1/api/health`
- **Metrics**: Uptime, memory, CPU
- **Logs**: CloudWatch Logs

### AWS Metrics
- **ECS**: CPU, memory, containers
- **ALB**: Requests, latency, errors
- **CloudWatch**: Structured logs

## 🤝 Contributing

### Workflow
1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

### Code Standards
- **TypeScript**: Strict typing
- **ESLint**: Configured rules
- **Prettier**: Automatic formatting
- **Tests**: Minimum 80% coverage
- **Commits**: Conventional convention

## 📝 License

This project is under the MIT License. See the `LICENSE` file for more details.

## 🆘 Support

### Issues
- **Bug Reports**: [GitHub Issues](https://github.com/gtelesio/aws-hello-world-service/issues)
- **Feature Requests**: [GitHub Issues](https://github.com/gtelesio/aws-hello-world-service/issues)

### Documentation
- **Husky**: See `HUSKY.md`
- **API**: See endpoint documentation
- **Infrastructure**: See `infrastructure/README.md`

## 🎯 Roadmap

### Upcoming Features
- [ ] **API v3** with GraphQL
- [ ] **JWT Authentication**
- [ ] **Advanced Rate Limiting**
- [ ] **Prometheus Metrics**
- [ ] **Tracing** with Jaeger
- [ ] **Multi-tenancy** support
- [ ] **WebSocket** for real-time

### Infrastructure Improvements
- [ ] **Auto-scaling** based on metrics
- [ ] **Blue-Green** deployments
- [ ] **Canary** releases
- [ ] **Multi-region** deployment
- [ ] **CDN** with CloudFront

---

**Developed with ❤️ following Clean Architecture and DDD best practices**
