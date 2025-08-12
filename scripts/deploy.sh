#!/bin/bash

# AWS Hello World Service Deployment Script
# This script builds the Docker image, pushes it to ECR, and deploys the infrastructure

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
PROJECT_NAME="hello-world-service"
AWS_REGION="${AWS_REGION:-us-east-1}"
ECR_REPO_NAME="${PROJECT_NAME}"
IMAGE_TAG="${IMAGE_TAG:-latest}"
ENVIRONMENT="${ENVIRONMENT:-production}"

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
    log_info "Checking requirements..."
    
    # Check if AWS CLI is installed
    if ! command -v aws &> /dev/null; then
        log_error "AWS CLI is not installed. Please install it first."
        exit 1
    fi
    
    # Check if Docker is installed
    if ! command -v docker &> /dev/null; then
        log_error "Docker is not installed. Please install it first."
        exit 1
    fi
    
    # Check if Terraform is installed
    if ! command -v terraform &> /dev/null; then
        log_error "Terraform is not installed. Please install it first."
        exit 1
    fi
    
    # Check AWS credentials
    if ! aws sts get-caller-identity &> /dev/null; then
        log_error "AWS credentials not configured. Please run 'aws configure' first."
        exit 1
    fi
    
    log_success "All requirements met!"
}

build_and_push_image() {
    log_info "Building and pushing Docker image..."
    
    # Get ECR login token
    log_info "Getting ECR login token..."
    aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
    
    # Build image
    log_info "Building Docker image..."
    docker build -t $ECR_REPO_NAME:$IMAGE_TAG app/
    
    # Tag image for ECR
    ECR_REPO_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$ECR_REPO_NAME"
    docker tag $ECR_REPO_NAME:$IMAGE_TAG $ECR_REPO_URI:$IMAGE_TAG
    
    # Push image to ECR
    log_info "Pushing image to ECR..."
    docker push $ECR_REPO_URI:$IMAGE_TAG
    
    log_success "Docker image pushed successfully!"
}

deploy_infrastructure() {
    log_info "Deploying infrastructure with Terraform..."
    
    cd infra/
    
    # Initialize Terraform
    log_info "Initializing Terraform..."
    terraform init
    
    # Plan deployment
    log_info "Planning Terraform deployment..."
    terraform plan -var="aws_region=$AWS_REGION" -var="project_name=$PROJECT_NAME" -var="environment=$ENVIRONMENT"
    
    # Ask for confirmation
    read -p "Do you want to proceed with the deployment? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        log_warning "Deployment cancelled by user."
        exit 0
    fi
    
    # Apply deployment
    log_info "Applying Terraform configuration..."
    terraform apply -var="aws_region=$AWS_REGION" -var="project_name=$PROJECT_NAME" -var="environment=$ENVIRONMENT" -auto-approve
    
    # Get outputs
    log_info "Getting deployment outputs..."
    ALB_DNS_NAME=$(terraform output -raw alb_dns_name)
    ECR_REPO_URL=$(terraform output -raw ecr_repository_url)
    
    log_success "Infrastructure deployed successfully!"
    log_info "Application Load Balancer URL: http://$ALB_DNS_NAME"
    log_info "ECR Repository URL: $ECR_REPO_URL"
    
    cd ..
}

main() {
    log_info "Starting deployment of $PROJECT_NAME..."
    
    # Get AWS account ID
    AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
    log_info "Using AWS Account ID: $AWS_ACCOUNT_ID"
    
    # Check requirements
    check_requirements
    
    # Build and push Docker image
    build_and_push_image
    
    # Deploy infrastructure
    deploy_infrastructure
    
    log_success "Deployment completed successfully!"
    log_info "Your application should be available at the ALB URL above in a few minutes."
}

# Run main function
main "$@"
