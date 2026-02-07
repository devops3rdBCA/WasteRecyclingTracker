# GitHub Secrets Configuration Guide

This document explains all the secrets used in the CI/CD workflows for the Waste Recycling Tracker project.

## Overview

All secrets listed below are **OPTIONAL**. The project is designed to build and run locally without any external services. These secrets are only needed if you want to enable specific deployment or analysis features.

## Required Secrets by Workflow

### Docker Build & Push Workflow

The Docker workflow will build images locally for all pull requests and pushes. It only requires credentials to push images to Docker Hub.

| Secret | Required For | Description |
|--------|-------------|-------------|
| `DOCKER_USERNAME` | Optional | Your Docker Hub username. Only needed to push images to Docker Hub. |
| `DOCKER_PASSWORD` | Optional | Your Docker Hub password or access token. Only needed to push images to Docker Hub. |

**Behavior without secrets:**
- ✅ Docker images will be built successfully
- ✅ Images are cached for faster builds
- ℹ️ Images will NOT be pushed to Docker Hub
- ℹ️ Pull requests always skip push regardless of credentials

**How to configure:**
1. Create a Docker Hub account at https://hub.docker.com
2. Generate an access token in Docker Hub settings
3. Add `DOCKER_USERNAME` and `DOCKER_PASSWORD` to GitHub repository secrets
4. Images will be pushed to Docker Hub on push to main branch

### SonarCloud Analysis Workflow

The SonarCloud workflow performs code quality and security analysis. It's completely optional.

| Secret | Required For | Description |
|--------|-------------|-------------|
| `SONAR_TOKEN` | Optional | Your SonarCloud authentication token. Only needed for code analysis. |
| `SONAR_ORGANIZATION` | Optional | Your SonarCloud organization name. Only needed for code analysis. |

**Behavior without secrets:**
- ✅ Workflow completes successfully
- ℹ️ Code analysis is skipped
- ℹ️ Clear messages explain why analysis was skipped

**How to configure:**
1. Sign up at https://sonarcloud.io
2. Create a new organization
3. Generate an authentication token
4. Add `SONAR_TOKEN` and `SONAR_ORGANIZATION` to GitHub repository secrets
5. Analysis will run automatically on all pushes and pull requests

### Vercel Deployment Workflow

The Vercel workflow deploys the frontend to Vercel's hosting platform. It's completely optional.

| Secret | Required For | Description |
|--------|-------------|-------------|
| `VERCEL_TOKEN` | Optional | Your Vercel authentication token. Only needed for deployment. |
| `VERCEL_ORG_ID` | Optional | Your Vercel organization ID. Only needed for deployment. |
| `VERCEL_PROJECT_ID` | Optional | Your Vercel project ID. Only needed for deployment. |

**Behavior without secrets:**
- ✅ Workflow completes successfully
- ℹ️ Deployment is skipped
- ℹ️ Clear messages explain why deployment was skipped

**How to configure:**
1. Sign up at https://vercel.com
2. Install Vercel CLI: `npm install -g vercel`
3. Run `vercel link` in the frontend directory
4. Get your credentials from `.vercel/project.json`
5. Generate a token at https://vercel.com/account/tokens
6. Add `VERCEL_TOKEN`, `VERCEL_ORG_ID`, and `VERCEL_PROJECT_ID` to GitHub repository secrets
7. Frontend will be deployed automatically on all pushes to main

### Backend Build & Test Workflow

The backend build workflow has no secret dependencies. It will always run successfully.

**Behavior:**
- ✅ Always builds the backend with Maven
- ✅ Always runs all backend tests
- ✅ No external services required

## Local Development

You don't need any of these secrets for local development. To run the project locally:

```bash
# Backend
cd backend
mvn clean install
mvn spring-boot:run

# Frontend
cd frontend
npm install
npm run dev
```

## Setting Up GitHub Secrets

To add secrets to your repository:

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Enter the secret name and value
5. Click **Add secret**

## Security Best Practices

- Never commit secrets to the repository
- Use access tokens instead of passwords where possible
- Rotate tokens regularly
- Remove tokens you're no longer using
- Use repository secrets for public repos, environment secrets for sensitive deployments

## Troubleshooting

### Workflow shows "action_required" status
This means the workflow requires secrets that aren't configured. This is normal and expected. The workflow will skip the parts that need credentials and complete successfully.

### Docker build failing
If Docker builds are failing (not just skipping push), this is likely a Dockerfile issue, not a credentials issue. Check the workflow logs for build errors.

### SonarCloud analysis not running
Ensure both `SONAR_TOKEN` and `SONAR_ORGANIZATION` are configured. One without the other will skip analysis.

### Vercel deployment not running
Ensure all three Vercel secrets are configured: `VERCEL_TOKEN`, `VERCEL_ORG_ID`, and `VERCEL_PROJECT_ID`.

## Questions?

If you have questions about configuring secrets, please:
- Check the workflow logs for detailed messages
- Review the workflow YAML files in `.github/workflows/`
- Open an issue in the repository

---

**Remember:** All external services are optional. The project works perfectly fine without any of them!
