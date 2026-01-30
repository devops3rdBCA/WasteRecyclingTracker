#!/bin/bash

# Deploy to Heroku - Waste Recycling Tracker Backend
# Prerequisites: Heroku CLI installed and logged in
# Usage: ./deploy-heroku.sh

set -e

echo "================================================"
echo "Deploying to Heroku"
echo "================================================"

# Check if Heroku CLI is installed
if ! command -v heroku &> /dev/null; then
    echo "❌ Heroku CLI is not installed."
    echo "Install from: https://devcenter.heroku.com/articles/heroku-cli"
    exit 1
fi

# Check if logged in to Heroku
if ! heroku auth:whoami &> /dev/null; then
    echo "❌ Not logged in to Heroku. Run: heroku login"
    exit 1
fi

APP_NAME="waste-recycling-tracker-api"

echo "📝 Heroku App: $APP_NAME"

# Create app if it doesn't exist
echo "🔍 Checking if app exists..."
if heroku apps:info --app $APP_NAME &> /dev/null; then
    echo "✅ App exists: $APP_NAME"
else
    echo "📦 Creating new Heroku app: $APP_NAME"
    heroku apps:create $APP_NAME || echo "App may already exist"
fi

# Add PostgreSQL addon
echo "🗄️  Adding PostgreSQL addon..."
heroku addons:create heroku-postgresql:standard-0 --app $APP_NAME 2>/dev/null || echo "PostgreSQL addon already exists"

# Set environment variables
echo "⚙️  Setting environment variables..."
heroku config:set \
    SPRING_PROFILES_ACTIVE=prod \
    ADMIN_PASSWORD="$(openssl rand -base64 12)" \
    --app $APP_NAME

# Add remote if not exists
if ! git remote | grep -q heroku; then
    heroku git:remote -a $APP_NAME
fi

# Deploy
echo "🚀 Deploying application..."
cd backend
git subtree push --prefix backend heroku main 2>/dev/null || git push heroku main

echo ""
echo "================================================"
echo "✅ Deployment to Heroku Complete!"
echo "================================================"
echo ""
echo "📍 Application URL: https://$APP_NAME.herokuapp.com"
echo "📊 View logs: heroku logs --tail --app $APP_NAME"
echo "🔧 Manage app: heroku apps:open --app $APP_NAME"
echo ""
