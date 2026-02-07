# GitHub Actions Workflow Troubleshooting Guide

This guide helps you resolve common issues with the optional service workflows in this repository.

## Table of Contents
- [Docker Hub Authentication](#docker-hub-authentication)
- [SonarCloud Configuration](#sonarcloud-configuration)
- [Vercel Deployment](#vercel-deployment)

---

## Docker Hub Authentication

### Problem
Docker Build workflow fails with authentication errors like:
```
Error response from daemon: Get "https://registry-1.docker.io/v2/": unauthorized: incorrect username or password
```

### Solution

#### Step 1: Generate a New Docker Hub Access Token

1. Go to [Docker Hub](https://hub.docker.com/)
2. Log in to your account
3. Click on your username in the top-right corner
4. Select **Account Settings** → **Security**
5. Click **New Access Token**
6. Give it a descriptive name (e.g., "GitHub Actions")
7. Set permissions to **Read, Write, Delete** (required for pushing images)
8. Click **Generate**
9. **Important:** Copy the token immediately - it won't be shown again!

#### Step 2: Update GitHub Secrets

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Update or create these secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username
   - `DOCKER_PASSWORD`: The access token you just generated (NOT your password)

#### Step 3: Verify Token Permissions

Make sure your Docker Hub token has:
- ✅ Read permission (to pull images)
- ✅ Write permission (to push images)
- ✅ Delete permission (to manage tags)

### Common Issues

- **Wrong username**: Double-check your Docker Hub username (case-sensitive)
- **Expired token**: Tokens can expire - regenerate if needed
- **Using password instead of token**: Always use an access token, not your account password
- **Insufficient permissions**: Token must have write permissions to push images

---

## SonarCloud Configuration

### Problem
SonarCloud Analysis workflow fails with:
```
ERROR You are running CI analysis while Automatic Analysis is enabled. 
Please consider disabling one or the other.
```

### Solution

#### Disable Automatic Analysis in SonarCloud

1. Go to [SonarCloud](https://sonarcloud.io/)
2. Log in to your account
3. Navigate to your project: **devops3rdBCA_WasteRecyclingTracker**
4. Click on **Administration** (bottom left)
5. Select **Analysis Method**
6. Find the **Automatic Analysis** section
7. **Disable** Automatic Analysis
8. Click **Save**

**Direct Link:** [Analysis Method Settings](https://sonarcloud.io/project/administration/analysis_method?id=devops3rdBCA_WasteRecyclingTracker)

### Why This Happens

SonarCloud offers two analysis methods:
- **Automatic Analysis**: SonarCloud automatically analyzes your code on each commit
- **CI-based Analysis**: Analysis runs via GitHub Actions workflow

You can only use **one** method at a time. This workflow uses CI-based analysis, so Automatic Analysis must be disabled.

### Common Issues

- **Token expired**: Generate a new token at [SonarCloud Tokens](https://sonarcloud.io/account/security/)
- **Wrong organization**: Verify `SONAR_ORGANIZATION` matches your SonarCloud organization key
- **Project key mismatch**: Project key in workflow must match SonarCloud project key

### Verify Configuration

After disabling Automatic Analysis:
1. Trigger the workflow again (push a commit or re-run workflow)
2. Check that analysis completes successfully
3. View results at: `https://sonarcloud.io/dashboard?id=devops3rdBCA_WasteRecyclingTracker`

---

## Vercel Deployment

### Problem
Vercel Deployment workflow fails with:
```
Error! Unexpected error. Please try again later. ()
```

### Solution

#### Step 1: Get Your Vercel Credentials

##### Get Vercel Token
1. Go to [Vercel Account Settings](https://vercel.com/account/tokens)
2. Click **Create Token**
3. Name it (e.g., "GitHub Actions")
4. Set scope: **Full Account**
5. Set expiration: Your choice (or never)
6. Click **Create**
7. Copy the token immediately

##### Get Vercel Org ID
1. Go to [Vercel Settings](https://vercel.com/account)
2. Look under **General** tab
3. Copy your **Team/User ID** (this is your ORG_ID)

##### Get Vercel Project ID
1. Go to your [Vercel Projects](https://vercel.com/)
2. Click on your project
3. Go to **Settings** → **General**
4. Scroll down to find **Project ID**
5. Copy the Project ID

#### Step 2: Update GitHub Secrets

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Update or create these secrets:
   - `VERCEL_TOKEN`: The token you generated
   - `VERCEL_ORG_ID`: Your team/user ID
   - `VERCEL_PROJECT_ID`: Your project ID

#### Step 3: Verify Project Configuration

Make sure:
- The project exists in your Vercel account
- The project is linked to the correct Git repository
- Your token has permissions for the organization
- The frontend directory structure matches Vercel expectations

### Common Issues

- **Token expired**: Regenerate token at [Vercel Tokens](https://vercel.com/account/tokens)
- **Wrong Org ID**: Make sure you're using the correct organization/team ID
- **Wrong Project ID**: Verify project ID from Vercel project settings
- **Deleted project**: If project was deleted, create a new one and update PROJECT_ID
- **Insufficient permissions**: Token must have deployment permissions
- **Build errors**: Check Vercel deployment logs for frontend build issues

### Verify Deployment

After fixing credentials:
1. Trigger the workflow again
2. Check workflow logs for successful deployment
3. Visit your Vercel project dashboard to see the deployment
4. Test the deployed application URL

---

## General Tips

### For All Workflows

1. **Check Secret Values**: 
   - Secrets are case-sensitive
   - No extra spaces before/after values
   - Use tokens, not passwords

2. **Re-run Failed Workflows**:
   - After updating secrets, re-run the workflow
   - Go to **Actions** → Select failed workflow → **Re-run failed jobs**

3. **View Detailed Logs**:
   - Click on any failed step in the workflow
   - Expand the log to see full error messages
   - Look for specific error codes or messages

4. **Test Credentials Locally**:
   - Docker: `docker login -u <username> -p <token>`
   - Vercel: `vercel --token <token> --prod`

### Need More Help?

- **Docker Hub**: [Docker Hub Support](https://hub.docker.com/support/)
- **SonarCloud**: [SonarCloud Docs](https://docs.sonarcloud.io/)
- **Vercel**: [Vercel Support](https://vercel.com/support)
- **GitHub Actions**: [GitHub Actions Docs](https://docs.github.com/en/actions)

### Checking Workflow Status

All workflows are **optional services**. Even if they fail:
- ✅ Your code builds will still succeed
- ✅ Your main application works fine
- ✅ You can continue development

These workflows enhance your project with:
- 🐳 Docker Hub: Containerized deployment
- 🔍 SonarCloud: Code quality analysis
- 🚀 Vercel: Automated frontend deployment
