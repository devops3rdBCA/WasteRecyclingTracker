# 🔧 WORKFLOW SETUP GUIDE - ENABLE ALL FEATURES
**Complete Setup for All 11 Tasks**

---

## 🎯 QUICK SETUP CHECKLIST

Follow these steps to enable all GitHub Actions workflows:

- [ ] **Step 1**: Set up SonarCloud (5 minutes)
- [ ] **Step 2**: Configure Docker Hub (3 minutes)
- [ ] **Step 3**: Add GitHub Secrets (2 minutes)
- [ ] **Step 4**: Verify workflows (1 minute)

**Total Time**: ~11 minutes

---

## 📋 STEP 1: SONARCLOUD SETUP (Task 4 - 10 marks)

### 1.1 Create SonarCloud Account

1. Go to https://sonarcloud.io
2. Click **"Log in"**
3. Select **"Log in with GitHub"**
4. Authorize SonarCloud to access your GitHub account

### 1.2 Create Organization

1. Click **"+"** (top right) → **"Create new organization"**
2. Choose **"Free plan"** (for open-source projects)
3. Organization Key: `your-github-username` (e.g., `jeynisha36`)
4. Display Name: `Your Name`
5. Click **"Create Organization"**

### 1.3 Import Repository

1. Click **"Analyze new project"**
2. Select **"WasteRecyclingTracker"** repository
3. Click **"Set up"**

### 1.4 Create Two Projects

#### Backend Project:
1. Project Key: `your-org_waste-recycling-tracker-backend`
2. Display Name: `Waste Tracker Backend`
3. Click **"Set Up"**
4. Choose **"With GitHub Actions"**
5. **Copy the SONAR_TOKEN shown** (you'll need this!)

#### Frontend Project:
1. Click **"+"** → **"Analyze new project"**
2. Create another project from same repository
3. Project Key: `your-org_waste-recycling-tracker-frontend`
4. Display Name: `Waste Tracker Frontend`
5. Use the same SONAR_TOKEN

### 1.5 Get Your Credentials

**You now have:**
- ✅ `SONAR_TOKEN`: (from step 1.4 - looks like: `sqp_1234567890abcdef...`)
- ✅ `SONAR_ORGANIZATION`: Your organization key (e.g., `jeynisha36`)

**Keep these safe!** You'll add them to GitHub Secrets in Step 3.

---

## 🐳 STEP 2: DOCKER HUB SETUP (Task 6 - 5 marks)

### 2.1 Create Docker Hub Account

1. Go to https://hub.docker.com
2. Click **"Sign Up"**
3. Create account with email
4. Verify email

### 2.2 Create Access Token

1. Log in to Docker Hub
2. Click your username (top right) → **"Account Settings"**
3. Click **"Security"** tab
4. Click **"New Access Token"**
5. Description: `GitHub Actions - Waste Tracker`
6. Access permissions: **"Read, Write, Delete"**
7. Click **"Generate"**
8. **Copy the token immediately!** (You won't see it again)

### 2.3 Get Your Credentials

**You now have:**
- ✅ `DOCKER_USERNAME`: Your Docker Hub username
- ✅ `DOCKER_PASSWORD`: The access token you just copied

**Keep these safe!** You'll add them to GitHub Secrets in Step 3.

---

## 🔐 STEP 3: ADD GITHUB SECRETS (2 minutes)

### 3.1 Navigate to Secrets Page

1. Go to your repository: https://github.com/devops3rdBCA/WasteRecyclingTracker
2. Click **"Settings"** tab
3. Click **"Secrets and variables"** (left sidebar)
4. Click **"Actions"**
5. Click **"New repository secret"** button

### 3.2 Add Each Secret

Add the following secrets one by one:

#### Secret 1: SONAR_TOKEN
```
Name: SONAR_TOKEN
Value: [Paste token from SonarCloud Step 1.4]
```
Click **"Add secret"**

#### Secret 2: SONAR_ORGANIZATION
```
Name: SONAR_ORGANIZATION
Value: [Your organization key, e.g., jeynisha36]
```
Click **"Add secret"**

#### Secret 3: DOCKER_USERNAME
```
Name: DOCKER_USERNAME
Value: [Your Docker Hub username]
```
Click **"Add secret"**

#### Secret 4: DOCKER_PASSWORD
```
Name: DOCKER_PASSWORD
Value: [Your Docker Hub access token from Step 2.2]
```
Click **"Add secret"**

### 3.3 Verify Existing Secrets

Make sure these are already present (from Vercel setup):
- ✅ `VERCEL_TOKEN`
- ✅ `VERCEL_ORG_ID`
- ✅ `VERCEL_PROJECT_ID`

**Total Secrets**: You should now have **7 secrets** configured.

---

## ✅ STEP 4: VERIFY WORKFLOWS (1 minute)

### 4.1 Trigger All Workflows

Push a dummy commit to trigger all workflows:

```powershell
# Navigate to project
cd d:\test

# Create empty commit to trigger workflows
git commit --allow-empty -m "trigger: enable all workflows with secrets"

# Push to GitHub
git push origin main
```

### 4.2 Check Workflow Status

1. Go to https://github.com/devops3rdBCA/WasteRecyclingTracker/actions
2. Watch the workflows run:
   - ✅ **Backend Build & Test** - Should pass
   - ✅ **Vercel Deployment** - Should pass (already working)
   - ✅ **SonarCloud Analysis** - Should pass (with new secrets)
   - ✅ **Docker Build & Push** - Should pass (with new secrets)

### 4.3 Expected Results

All workflows should show **green checkmarks** ✅

If any fail:
- Click on the failed workflow
- Check the logs for error messages
- Verify secrets are correctly named (case-sensitive!)
- Ensure tokens haven't expired

---

## 🎯 WHAT EACH SECRET ENABLES

| Secret | Workflow | Purpose |
|--------|----------|---------|
| `SONAR_TOKEN` | SonarCloud Analysis | Authenticate with SonarCloud |
| `SONAR_ORGANIZATION` | SonarCloud Analysis | Identify your SonarCloud org |
| `DOCKER_USERNAME` | Docker Build & Push | Login to Docker Hub |
| `DOCKER_PASSWORD` | Docker Build & Push | Authenticate Docker Hub |
| `VERCEL_TOKEN` | Vercel Deployment | Deploy to Vercel (already set) |
| `VERCEL_ORG_ID` | Vercel Deployment | Identify Vercel org (already set) |
| `VERCEL_PROJECT_ID` | Vercel Deployment | Identify project (already set) |

---

## 🔍 VERIFICATION CHECKLIST

After setup, verify everything works:

```powershell
# Check GitHub Actions
# Visit: https://github.com/devops3rdBCA/WasteRecyclingTracker/actions
# All 5 workflows should show green checkmarks

# Check SonarCloud
# Visit: https://sonarcloud.io/organizations/your-org/projects
# Both projects should show analysis results

# Check Docker Hub
# Visit: https://hub.docker.com/repositories
# Should see waste-tracker-backend and waste-tracker-frontend images

# Check Vercel
# Visit: https://vercel.com/dashboard
# Deployment should be live
```

**Expected Status:**
```
✅ Backend Build & Test - PASSING
✅ Vercel Deployment - PASSING  
✅ SonarCloud Analysis - PASSING (Backend + Frontend)
✅ Docker Build & Push - PASSING (2 images)

Total: 5 workflows, all green ✅
```

---

## 🚨 TROUBLESHOOTING

### Issue: SonarCloud workflow fails

**Error**: `Could not find a default branch to analyze`

**Solution**:
1. Go to SonarCloud project settings
2. Set **"Main Branch"** to `main`
3. Re-run workflow

---

### Issue: Docker push fails

**Error**: `unauthorized: authentication required`

**Solution**:
1. Verify `DOCKER_USERNAME` is correct (case-sensitive)
2. Verify `DOCKER_PASSWORD` is the access token (not your password)
3. Check token hasn't expired
4. Regenerate access token if needed

---

### Issue: Vercel deployment fails

**Error**: `Invalid token`

**Solution**:
1. Go to Vercel dashboard → Settings → Tokens
2. Regenerate token
3. Update `VERCEL_TOKEN` secret in GitHub

---

### Issue: Secrets not found

**Error**: `Secret SONAR_TOKEN not found`

**Solution**:
1. Check secret name spelling (exact match, case-sensitive)
2. Ensure secret is added at repository level (not environment level)
3. Wait 1-2 minutes after adding secrets before triggering workflow

---

## 📊 SUCCESS METRICS

After completing all steps:

**SonarCloud:**
- ✅ Backend project created and analyzed
- ✅ Frontend project created and analyzed
- ✅ Quality Gate: PASSED
- ✅ 0 bugs, 0 vulnerabilities

**Docker Hub:**
- ✅ Backend image published
- ✅ Frontend image published
- ✅ Both tagged with `latest` and `main`

**GitHub Actions:**
- ✅ All 5 workflows passing
- ✅ No failed runs
- ✅ Deployment artifacts available

**Vercel:**
- ✅ Production deployment live
- ✅ Preview deployments for PRs
- ✅ Custom domain configured

---

## 🎓 LEARNING OUTCOMES

By completing this setup, you've learned:

1. **SonarCloud Integration** - Code quality analysis
2. **Docker Hub** - Container registry management
3. **GitHub Secrets** - Secure credential management
4. **CI/CD Pipelines** - Automated workflows
5. **DevOps Best Practices** - Professional deployment pipeline

---

## 📞 NEED HELP?

### SonarCloud Issues
- Documentation: https://docs.sonarcloud.io
- Support: https://community.sonarsource.com

### Docker Hub Issues
- Documentation: https://docs.docker.com
- Support: https://hub.docker.com/support

### GitHub Actions Issues
- Documentation: https://docs.github.com/actions
- Community: https://github.community

---

## ✅ COMPLETION CONFIRMATION

Once all steps are complete, you should see:

```
GitHub Repository Secrets (7 total):
✅ SONAR_TOKEN
✅ SONAR_ORGANIZATION  
✅ DOCKER_USERNAME
✅ DOCKER_PASSWORD
✅ VERCEL_TOKEN
✅ VERCEL_ORG_ID
✅ VERCEL_PROJECT_ID

GitHub Actions Status:
✅ backend-build.yml - PASSING
✅ vercel-deploy.yml - PASSING
✅ sonarcloud.yml - PASSING  
✅ docker-build.yml - PASSING

SonarCloud Projects:
✅ waste-recycling-tracker-backend - Quality Gate PASSED
✅ waste-recycling-tracker-frontend - Quality Gate PASSED

Docker Hub Images:
✅ waste-tracker-backend:latest
✅ waste-tracker-frontend:latest

Vercel Deployment:
✅ https://waste-recycling-tracker-production.vercel.app
```

---

## 🎉 ALL WORKFLOWS ENABLED!

**Congratulations!** All 11 tasks are now fully operational with:
- ✅ Automated testing
- ✅ Code quality analysis
- ✅ Container builds
- ✅ Cloud deployment
- ✅ 100% marks (60/60)

Your project demonstrates professional-grade DevOps practices! 🚀

---

**Created**: February 2026  
**Status**: Ready for Implementation  
**Time Required**: ~11 minutes  
**Difficulty**: Easy (Step-by-step guide)
