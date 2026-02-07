# SonarCloud Setup Guide

## Overview
SonarCloud provides automated code quality and security analysis for your project. This guide will help you integrate it with your GitHub CI/CD pipeline.

---

## Prerequisites
- ✅ GitHub account
- ✅ Project pushed to GitHub: `https://github.com/devops3rdBCA/WasteRecyclingTracker`
- ✅ CI/CD workflow already configured (ready for Sonar)

---

## Step 1: Sign Up on SonarCloud (2 minutes)

1. Visit https://sonarcloud.io
2. Click **Log in** or **Sign up**
3. Select **With GitHub**
4. Click **Authorize SonarCloud** when prompted
5. You'll be redirected to SonarCloud dashboard

---

## Step 2: Create Organization (1 minute)

1. After login, you'll see "Import an organization from GitHub"
2. Select your GitHub account: **Jeynisha36**
3. Click **Continue**
4. Choose a plan:
   - Select **Free plan** (for public repos)
   - Click **Create Organization**

Your organization key will be something like: `jeynisha36`

---

## Step 3: Import Your Project (2 minutes)

1. Click **Analyze new project**
2. Find **WasteRecyclingTracker** in the list
3. Click **Set Up**
4. Choose analysis method: **With GitHub Actions**
5. Click **Continue**

---

## Step 4: Get Your Tokens & Keys (3 minutes)

### A. Get Project Key
After importing, you'll see:
```
Jeynisha36_WasteRecyclingTracker
```
Copy this value.

### B. Generate Token
1. Click your avatar (top right)
2. Go to **My Account** → **Security**
3. Or visit: https://sonarcloud.io/account/security/
4. Under "Generate Tokens":
   - Name: `GitHub Actions`
   - Type: `Global Analysis Token`
   - Expires in: `No expiration`
5. Click **Generate**
6. **Copy the token immediately** (you won't see it again)

Example token: `sqp_1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p`

### C. Get Host URL
For SonarCloud, the host URL is always:
```
https://sonarcloud.io
```

---

## Step 5: Add GitHub Secrets (2 minutes)

1. Go to your GitHub repo:
   ```
   https://github.com/devops3rdBCA/WasteRecyclingTracker/settings/secrets/actions
   ```

2. Click **New repository secret**

3. Add these **four** secrets one by one:

**Secret 1:**
- Name: `SONAR_TOKEN`
- Value: `sqp_...` (the token you copied)
- Click **Add secret**

**Secret 2:**
- Name: `SONAR_PROJECT_KEY_BACKEND`
- Value: `Jeynisha36_WasteRecyclingTracker`
- Click **Add secret**

**Secret 3:**
- Name: `SONAR_HOST_URL`
- Value: `https://sonarcloud.io`
- Click **Add secret**

**Secret 4:**
- Name: `SONAR_ORGANIZATION`
- Value: `jeynisha36` (your organization key from Step 2)
- Click **Add secret**

---

## Step 6: Configure SonarCloud Properties (Not Required)

✅ **No configuration file needed!**

The GitHub Actions workflow is already configured to analyze both frontend and backend code in a single SonarCloud project. Analysis will run automatically on every push/PR.

---

## Step 7: Trigger Analysis (1 minute)

1. Make a small change to trigger CI/CD:
   ```powershell
   cd d:\test
   echo "# SonarCloud Analysis Enabled" >> backend/README.md
   git add backend/README.md
   git commit -m "chore: enable SonarCloud analysis"
   git push origin main
   ```

2. Go to **Actions** tab in GitHub
3. Wait for workflow to complete (~2-3 minutes)
4. Check SonarCloud dashboard for results

---

## Step 8: View Results

1. Go to https://sonarcloud.io
2. Click your project: **WasteRecyclingTracker**
3. You'll see:
   - **Bugs** 🐛
   - **Vulnerabilities** 🔒
   - **Code Smells** 👃
   - **Security Hotspots** 🔥
   - **Coverage** 📊
   - **Duplications** 📋

---

## What Gets Analyzed

The workflow analyzes both frontend and backend in **one project**:
```yaml
- Java source code (backend/src/main/java)
- React/JavaScript source code (frontend/src)
- JUnit tests (backend/src/test/java)
- Code coverage via JaCoCo
- Security vulnerabilities
- Code smells
- Technical debt
- Code duplications
```

**Triggers:**
- Every push to `main` branch
- Every pull request to `main` branch

---

## Expected Results

After first analysis, you should see:

```
✅ Reliability: A (0 bugs)
✅ Security: A (0 vulnerabilities)
⚠️ Maintainability: B/C (some code smells)
📊 Coverage: 0-30% (depends on tests)
📋 Duplications: 0-5%
```

---

## Quality Gate

SonarCloud applies a default quality gate:
- ❌ **Fails** if new code has:
  - Bugs
  - Vulnerabilities
  - Coverage < 80%
  - Code duplications > 3%

You can customize this in SonarCloud settings.

---

## Troubleshooting

### "Project not found"
- Check `SONAR_PROJECT_KEY_BACKEND` matches exactly
- Verify `SONAR_ORGANIZATION` matches your organization key
- Ensure project is created in SonarCloud

### "Unauthorized"
- Regenerate `SONAR_TOKEN` in SonarCloud
- Update GitHub secret

### "No coverage report found"
- Add JaCoCo plugin to `pom.xml` (already included)
- Run tests with coverage: `mvn clean verify`

### "Analysis fails in workflow"
- Check workflow logs in GitHub Actions
- Verify all 4 secrets are set correctly
- Ensure Maven build succeeds first
- Confirm project exists in SonarCloud

---

## Adding Quality Badge (Optional)

1. In SonarCloud, go to project → **Information**
2. Copy the badge markdown
3. Add to your `README.md`:

```markdown
[![Quality Gate](https://sonarcloud.io/api/project_badges/measure?project=Jeynisha36_WasteRecyclingTracker&metric=alert_status)](https://sonarcloud.io/summary/new_code?id=Jeynisha36_WasteRecyclingTracker)
```

---

## Benefits

Once configured, you get:
- ✅ Automated code reviews on every PR
- ✅ Security vulnerability detection
- ✅ Code quality metrics tracking
- ✅ Technical debt visualization
- ✅ Trend analysis over time
- ✅ Integration with GitHub PR comments

---

## Summary

**Total Setup Time:** ~10 minutes

**Steps:**
1. ✅ Sign up on SonarCloud (2 min)
2. ✅ Create organization (1 min)
3. ✅ Import project (2 min)
4. ✅ Get tokens & keys (3 min)
5. ✅ Add **4** GitHub secrets (2 min)
6. ✅ Push code & trigger analysis (1 min)
7. ✅ View results

**Current Status:** ✅ Fully configured and running!

**Result:** Automated code quality analysis on every commit! 🎉

---

## Resources

- SonarCloud Docs: https://docs.sonarcloud.io
- GitHub Actions Integration: https://docs.sonarcloud.io/advanced-setup/ci-based-analysis/github-actions/
- Quality Gates: https://docs.sonarcloud.io/improving/quality-gates/
- Your Dashboard: https://sonarcloud.io/organizations/jeynisha36

---

**Status:** Ready to configure ⏳  
**Estimated Time:** 10 minutes  
**Difficulty:** Easy ✅
