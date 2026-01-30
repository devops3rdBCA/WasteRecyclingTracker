#!/bin/bash

# Waste Recycling Tracker - Docker Deployment Script
# Usage: ./deploy-docker.sh [dev|prod]

set -e

ENVIRONMENT=${1:-prod}
PROJECT_NAME="waste-recycling-tracker"

echo "================================================"
echo "Deploying Waste Recycling Tracker - $ENVIRONMENT"
echo "================================================"

# Load environment variables
if [ -f ".env.$ENVIRONMENT" ]; then
    echo "Loading environment variables from .env.$ENVIRONMENT"
    export $(cat ".env.$ENVIRONMENT" | grep -v '#' | xargs)
else
    echo "Warning: .env.$ENVIRONMENT not found, using defaults"
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Build images
echo "🔨 Building Docker images..."
docker-compose build --no-cache

# Stop and remove old containers
echo "⏹️  Stopping existing containers..."
docker-compose down 2>/dev/null || true

# Start services
echo "🚀 Starting services..."
if [ "$ENVIRONMENT" = "dev" ]; then
    docker-compose --profile dev up -d
else
    docker-compose up -d
fi

# Wait for services to be healthy
echo "⏳ Waiting for services to be healthy..."
sleep 10

# Check health status
echo "🏥 Checking service health..."
if docker ps | grep -q waste_recycling_api; then
    echo "✅ Backend API is running"
else
    echo "❌ Backend API failed to start"
    docker-compose logs backend
    exit 1
fi

if docker ps | grep -q waste_recycling_ui; then
    echo "✅ Frontend UI is running"
else
    echo "❌ Frontend UI failed to start"
    docker-compose logs frontend
    exit 1
fi

if docker ps | grep -q waste_recycling_db; then
    echo "✅ Database is running"
else
    echo "❌ Database failed to start"
    docker-compose logs postgres
    exit 1
fi

# Display service endpoints
echo ""
echo "================================================"
echo "✅ Deployment Successful!"
echo "================================================"
echo ""
echo "📍 Service Endpoints:"
echo "   Frontend:    http://localhost:3000"
echo "   Backend API: http://localhost:8081"
echo "   Database:    postgres://localhost:5432"
if [ "$ENVIRONMENT" = "dev" ]; then
    echo "   PgAdmin:     http://localhost:5050"
fi
echo ""
echo "📊 View logs with: docker-compose logs -f"
echo "🛑 Stop services with: docker-compose down"
echo ""
