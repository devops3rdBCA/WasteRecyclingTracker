# GitHub Secrets Configuration Guide

This document describes the GitHub secrets required for various workflows in this repository.

## Overview

The workflows in this repository have been configured to work without secrets by default. They will skip deployment steps and show placeholder messages when secrets are not configured. This allows the workflows to pass successfully in public repositories or forks without requiring sensitive credentials.

## Required Secrets (Optional)

The following secrets can be configured to enable full functionality:

### Docker Hub Deployment

To enable Docker image pushing to Docker Hub, configure these secrets:

- `DOCKER_USERNAME` - Your Docker Hub username
- `DOCKER_PASSWORD` - Your Docker Hub password or access token

**Used by:** `.github/workflows/docker-build.yml`

### SonarCloud Analysis

To enable code quality analysis with SonarCloud, configure these secrets:

- `SONAR_TOKEN` - Your SonarCloud authentication token
- `SONAR_ORGANIZATION` - Your SonarCloud organization key

**Used by:** `.github/workflows/sonarcloud.yml`

### Vercel Deployment

To enable frontend deployment to Vercel, configure these secrets:

- `VERCEL_TOKEN` - Your Vercel authentication token
- `VERCEL_ORG_ID` - Your Vercel organization ID
- `VERCEL_PROJECT_ID` - Your Vercel project ID

**Used by:** `.github/workflows/vercel-deploy.yml`

## How to Add Secrets

1. Go to your repository on GitHub
2. Click on **Settings** tab
3. Navigate to **Secrets and variables** > **Actions**
4. Click **New repository secret**
5. Enter the secret name and value
6. Click **Add secret**

## Workflow Behavior

### With Secrets Configured

When secrets are properly configured:
- Docker images will be built and pushed to Docker Hub
- Code will be analyzed and results sent to SonarCloud
- Frontend will be deployed to Vercel

### Without Secrets (Default)

When secrets are not configured:
- Docker images will be built locally but not pushed
- SonarCloud analysis will be skipped with a placeholder message
- Vercel deployment will be skipped with a placeholder message
- **All workflows will still pass successfully** ✅

This approach ensures:
- ✅ Workflows are always green in public repositories
- ✅ No "action_required" statuses from missing secrets
- ✅ Easy onboarding for contributors
- ✅ Deployments can be enabled when needed

## Security Best Practices

- Never commit secrets directly to code
- Use GitHub Secrets for all sensitive credentials
- Rotate tokens and passwords regularly
- Use tokens with minimal required permissions
- Review secret access logs periodically

## Further Reading

- [GitHub Actions Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [Docker Hub Access Tokens](https://docs.docker.com/docker-hub/access-tokens/)
- [SonarCloud Token Generation](https://docs.sonarcloud.io/advanced-setup/ci-based-analysis/github-actions-for-sonarcloud/)
- [Vercel Deployment Tokens](https://vercel.com/docs/rest-api#creating-an-access-token)
