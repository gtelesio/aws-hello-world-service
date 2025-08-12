#!/bin/bash

# AWS Hello World Service Development Script
# This script sets up the development environment and runs the service locally

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="hello-world-service"
PORT="${PORT:-3000}"
HOST="${HOST:-localhost}"

# Functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_requirements() {
    log_info "Checking development requirements..."
    
    # Check if Node.js is installed
    if ! command -v node &> /dev/null; then
        log_error "Node.js is not installed. Please install it first."
        exit 1
    fi
    
    # Check Node.js version
    NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 16 ]; then
        log_error "Node.js version 16 or higher is required. Current version: $(node --version)"
        exit 1
    fi
    
    # Check if npm is installed
    if ! command -v npm &> /dev/null; then
        log_error "npm is not installed. Please install it first."
        exit 1
    fi
    
    log_success "All development requirements met!"
}

install_dependencies() {
    log_info "Installing dependencies..."
    
    cd app/
    
    if [ ! -d "node_modules" ]; then
        log_info "Installing npm dependencies..."
        npm install
        log_success "Dependencies installed successfully!"
    else
        log_info "Dependencies already installed, skipping..."
    fi
    
    cd ..
}

build_project() {
    log_info "Building project..."
    
    cd app/
    
    log_info "Building TypeScript project..."
    npm run build
    
    log_success "Project built successfully!"
    
    cd ..
}

run_tests() {
    log_info "Running tests..."
    
    cd app/
    
    if npm run test &> /dev/null; then
        log_success "Tests passed successfully!"
    else
        log_warning "Tests failed or not configured. Continuing..."
    fi
    
    cd ..
}

start_dev_server() {
    log_info "Starting development server..."
    
    cd app/
    
    log_info "Starting development server on http://$HOST:$PORT"
    log_info "Press Ctrl+C to stop the server"
    
    # Set environment variables for development
    export NODE_ENV=development
    export PORT=$PORT
    export HOST=$HOST
    
    # Start development server
    npm run dev
    
    cd ..
}

run_linting() {
    log_info "Running linting..."
    
    cd app/
    
    if npm run lint &> /dev/null; then
        log_success "Linting passed successfully!"
    else
        log_warning "Linting failed or not configured. Continuing..."
    fi
    
    cd ..
}

format_code() {
    log_info "Formatting code..."
    
    cd app/
    
    if npm run format &> /dev/null; then
        log_success "Code formatted successfully!"
    else
        log_warning "Code formatting failed or not configured. Continuing..."
    fi
    
    cd ..
}

show_help() {
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  install     Install dependencies"
    echo "  build       Build the project"
    echo "  test        Run tests"
    echo "  lint        Run linting"
    echo "  format      Format code"
    echo "  dev         Start development server (default)"
    echo "  all         Install, build, test, and start dev server"
    echo "  help        Show this help message"
    echo ""
    echo "Environment variables:"
    echo "  PORT        Port to run the server on (default: 3000)"
    echo "  HOST        Host to bind the server to (default: localhost)"
}

main() {
    case "${1:-dev}" in
        "install")
            check_requirements
            install_dependencies
            ;;
        "build")
            check_requirements
            install_dependencies
            build_project
            ;;
        "test")
            check_requirements
            install_dependencies
            run_tests
            ;;
        "lint")
            check_requirements
            install_dependencies
            run_linting
            ;;
        "format")
            check_requirements
            install_dependencies
            format_code
            ;;
        "dev")
            check_requirements
            install_dependencies
            build_project
            start_dev_server
            ;;
        "all")
            check_requirements
            install_dependencies
            build_project
            run_tests
            run_linting
            start_dev_server
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            log_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
}

# Run main function
main "$@"
