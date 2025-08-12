#!/bin/bash

# AWS Hello World Service Destruction Script
# This script destroys the infrastructure created by Terraform

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

destroy_infrastructure() {
    log_info "Destroying infrastructure with Terraform..."
    
    cd infra/
    
    # Initialize Terraform if not already done
    if [ ! -d ".terraform" ]; then
        log_info "Initializing Terraform..."
        terraform init
    fi
    
    # Plan destruction
    log_info "Planning Terraform destruction..."
    terraform plan -destroy -var="aws_region=$AWS_REGION" -var="project_name=$PROJECT_NAME" -var="environment=$ENVIRONMENT"
    
    # Ask for confirmation
    echo
    log_warning "This will destroy ALL resources created by this project!"
    read -p "Are you sure you want to proceed? This action cannot be undone! (yes/NO): " -r
    if [[ ! $REPLY =~ ^[Yy][Ee][Ss]$ ]]; then
        log_warning "Destruction cancelled by user."
        exit 0
    fi
    
    # Apply destruction
    log_info "Destroying infrastructure..."
    terraform destroy -var="aws_region=$AWS_REGION" -var="project_name=$PROJECT_NAME" -var="environment=$ENVIRONMENT" -auto-approve
    
    log_success "Infrastructure destroyed successfully!"
    
    cd ..
}

cleanup_ecr_images() {
    log_info "Cleaning up ECR images..."
    
    # Get ECR repository URI
    ECR_REPO_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$PROJECT_NAME"
    
    # Check if repository exists
    if aws ecr describe-repositories --repository-names $PROJECT_NAME --region $AWS_REGION &> /dev/null; then
        log_info "Deleting ECR repository: $PROJECT_NAME"
        aws ecr delete-repository --repository-name $PROJECT_NAME --force --region $AWS_REGION
        log_success "ECR repository deleted successfully!"
    else
        log_info "ECR repository does not exist, skipping cleanup."
    fi
}

main() {
    log_info "Starting destruction of $PROJECT_NAME..."
    
    # Get AWS account ID
    AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
    log_info "Using AWS Account ID: $AWS_ACCOUNT_ID"
    
    # Check requirements
    check_requirements
    
    # Destroy infrastructure
    destroy_infrastructure
    
    # Cleanup ECR images
    cleanup_ecr_images
    
    log_success "Destruction completed successfully!"
    log_info "All resources have been cleaned up."
}

# Run main function
main "$@"
