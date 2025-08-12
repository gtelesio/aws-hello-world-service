.PHONY: help install build test lint format clean docker-build docker-run docker-stop setup

# Default target
help:
	@echo "🚀 AWS Hello World Service - Available Commands:"
	@echo ""
	@echo "📦 Development:"
	@echo "  install     Install all dependencies"
	@echo "  dev         Start development server"
	@echo "  build       Build for production"
	@echo "  start       Start production server"
	@echo ""
	@echo "🧪 Testing:"
	@echo "  test        Run all tests"
	@echo "  test:watch  Run tests in watch mode"
	@echo "  test:cov    Run tests with coverage"
	@echo ""
	@echo "🔍 Quality:"
	@echo "  lint        Run ESLint"
	@echo "  lint:fix    Fix ESLint issues"
	@echo "  format      Format code with Prettier"
	@echo "  format:check Check code formatting"
	@echo ""
	@echo "🐳 Docker:"
	@echo "  docker-build Build Docker image"
	@echo "  docker-run   Run Docker container"
	@echo "  docker-stop  Stop Docker container"
	@echo ""
	@echo "🧹 Maintenance:"
	@echo "  clean       Clean build artifacts"
	@echo "  setup       Complete project setup"
	@echo ""

# Install dependencies
install:
	@echo "📦 Installing dependencies..."
	npm install
	cd app && npm install
	@echo "✅ Dependencies installed!"

# Development
dev:
	@echo "🚀 Starting development server..."
	cd app && npm run dev

# Build
build:
	@echo "🏗️ Building application..."
	cd app && npm run build
	@echo "✅ Build completed!"

# Start production
start:
	@echo "🚀 Starting production server..."
	cd app && npm start

# Testing
test:
	@echo "🧪 Running tests..."
	cd app && npm run test

test:watch:
	@echo "🧪 Running tests in watch mode..."
	cd app && npm run test:watch

test:cov:
	@echo "📊 Running tests with coverage..."
	cd app && npm run test:coverage

# Linting and formatting
lint:
	@echo "🔍 Running ESLint..."
	cd app && npm run lint

lint:fix:
	@echo "🔧 Fixing ESLint issues..."
	cd app && npm run lint:fix

format:
	@echo "💅 Formatting code..."
	cd app && npm run format

format:check:
	@echo "✅ Checking code formatting..."
	cd app && npm run format:check

# Docker
docker-build:
	@echo "🐳 Building Docker image..."
	docker build -t aws-hello-world-service .
	@echo "✅ Docker image built!"

docker-run:
	@echo "🐳 Running Docker container..."
	docker run -d --name aws-hello-world-service -p 3000:3000 aws-hello-world-service
	@echo "✅ Container started on port 3000!"

docker-stop:
	@echo "🐳 Stopping Docker container..."
	docker stop aws-hello-world-service || true
	docker rm aws-hello-world-service || true
	@echo "✅ Container stopped!"

# Docker Compose
docker-compose-up:
	@echo "🐳 Starting services with Docker Compose..."
	docker-compose up -d
	@echo "✅ Services started!"

docker-compose-down:
	@echo "🐳 Stopping services..."
	docker-compose down
	@echo "✅ Services stopped!"

docker-compose-logs:
	@echo "📋 Showing service logs..."
	docker-compose logs -f

# Clean
clean:
	@echo "🧹 Cleaning build artifacts..."
	rm -rf node_modules app/node_modules app/dist app/coverage
	@echo "✅ Clean completed!"

# Setup
setup: install
	@echo "🔧 Setting up project..."
	@echo "📋 Running linting and formatting..."
	$(MAKE) lint:fix
	$(MAKE) format
	@echo "✅ Project setup completed!"

# Git hooks
husky-install:
	@echo "🐕 Installing Husky hooks..."
	cd app && npx husky install
	@echo "✅ Husky hooks installed!"

# Security
security-audit:
	@echo "🔒 Running security audit..."
	cd app && npm audit
	@echo "✅ Security audit completed!"

# All-in-one development
dev-full: install
	@echo "🚀 Starting full development environment..."
	$(MAKE) docker-compose-up
	@echo "✅ Development environment ready!"
	@echo "📱 App running on http://localhost:3000"
	@echo "🔍 Health check: http://localhost:3000/health"
