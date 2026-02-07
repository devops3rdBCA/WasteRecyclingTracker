# GitHub Secrets Configuration Guide

This document explains all the secrets used in the CI/CD workflows for the Waste Recycling Tracker project.

## Overview

All secrets listed below are **OPTIONAL**. The project is designed to build and run locally without any external services. The current workflows are configured as placeholders that always pass - they need to be updated when you're ready to enable the optional services.

## Current Workflow Status

### ✅ Always Enabled (No Secrets Required)
- **Backend Build & Test** - Builds backend with Maven and runs tests
- **Docker Build** - Builds Docker images locally (no push to registry)

### ℹ️ Currently Disabled (Placeholders)
- **SonarCloud Analysis** - Placeholder workflow, always passes
- **Vercel Deployment** - Placeholder workflow, always passes

## Optional Services and Required Secrets

### Docker Build & Push Workflow

The Docker workflow currently builds images locally without pushing them anywhere.

| Secret | Status | Description |
|--------|--------|-------------|
| `DOCKER_USERNAME` | Not configured | Your Docker Hub username (for future use) |
| `DOCKER_PASSWORD` | Not configured | Your Docker Hub password or access token (for future use) |

**Current behavior:**
- ✅ Docker images are built successfully for both backend and frontend
- ✅ Images are cached for faster builds
- ✅ Workflow always passes with success status
- ℹ️ Images are NOT pushed to any registry

**To enable Docker Hub push:**
1. Add `DOCKER_USERNAME` and `DOCKER_PASSWORD` secrets
2. Update `.github/workflows/docker-build.yml` to use the docker/login-action
3. Enable push for non-PR builds

### SonarCloud Analysis Workflow

The SonarCloud workflow is currently a placeholder that always passes.

| Secret | Status | Description |
|--------|--------|-------------|
| `SONAR_TOKEN` | Not configured | SonarCloud authentication token (for future use) |
| `SONAR_ORGANIZATION` | Not configured | SonarCloud organization name (for future use) |

**Current behavior:**
- ✅ Workflow always passes with success status
- ℹ️ No actual code analysis is performed
- ℹ️ Shows instructions on how to enable SonarCloud

**To enable SonarCloud analysis:**
1. Sign up at https://sonarcloud.io and create a project
2. Add `SONAR_TOKEN` and `SONAR_ORGANIZATION` secrets
3. Update `.github/workflows/sonarcloud.yml` to run actual analysis (see commented example in the file)

### Vercel Deployment Workflow

The Vercel workflow is currently a placeholder that always passes.

| Secret | Status | Description |
|--------|--------|-------------|
| `VERCEL_TOKEN` | Not configured | Vercel authentication token (for future use) |
| `VERCEL_ORG_ID` | Not configured | Vercel organization ID (for future use) |
| `VERCEL_PROJECT_ID` | Not configured | Vercel project ID (for future use) |

**Current behavior:**
- ✅ Workflow always passes with success status
- ℹ️ No actual deployment is performed
- ℹ️ Shows instructions on how to enable Vercel

**To enable Vercel deployment:**
1. Sign up at https://vercel.com and link the repository
2. Get credentials from `.vercel/project.json` or Vercel dashboard
3. Add `VERCEL_TOKEN`, `VERCEL_ORG_ID`, and `VERCEL_PROJECT_ID` secrets
4. Update `.github/workflows/vercel-deploy.yml` to run actual deployment (see commented example in the file)

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
