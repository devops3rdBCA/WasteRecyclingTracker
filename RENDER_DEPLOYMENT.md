# Render.com Backend Deployment Guide

## 🚀 Deploy Spring Boot Backend to Render.com

### **Why Render.com?**
- ✅ Free tier with generous limits
- ✅ Auto-deploys from GitHub (no manual pushes)
- ✅ Includes free PostgreSQL database
- ✅ Very simple UI, 5-minute setup
- ✅ No credit card required

---

## 📋 Complete Step-by-Step Guide

### **STEP 1: Sign Up (2 minutes)**

1. Go to: https://render.com
2. Click **"Get Started"** button
3. Click **"Sign up with GitHub"**
4. Authorize Render to access your GitHub repositories
5. Check your email and verify (if needed)

---

### **STEP 2: Create PostgreSQL Database (3 minutes)**

1. In Render dashboard, click **"New +"** (top right)
2. Select **"PostgreSQL"**
3. Configure:
   - **Name:** `waste-recycling-db`
   - **PostgreSQL Version:** 15 (or latest)
   - **Region:** Choose closest to you (e.g., Ohio, N. California)
   - **Datadog API Key:** Leave empty
   - **Billing Plan:** Free

4. Click **"Create Database"**
5. Wait for database to be ready (2-3 minutes)
6. Once ready, you'll see the connection string. **Copy it!**

**Connection string looks like:**
```
postgresql://[user]:[password]@[host]:[port]/[database]
```

Save this - you'll need it in Step 4.

---

### **STEP 3: Create Backend Web Service (2 minutes)**

1. Click **"New +"** button again
2. Select **"Web Service"**
3. Under "Connect a repository," search for:
   ```
   devops3rdBCA/WasteRecyclingTracker
   ```
4. Click to connect (authorize Render if prompted)
5. Select the repository and click **"Connect"**

---

### **STEP 4: Configure Web Service (3 minutes)**

Fill in the form:

| Field | Value |
|-------|-------|
| **Name** | `waste-recycling-api` |
| **Environment** | `Docker` |
| **Region** | Ohio (or your region) |
| **Branch** | `main` |
| **Root Directory** | `backend` |

**Build Command:**
```bash
mvn clean package -DskipTests
```

**Start Command:**
```bash
java -jar target/waste-recycling-tracker-backend-1.0.0.jar
```

---

### **STEP 5: Add Environment Variables (2 minutes)**

In the **"Environment"** section, click **"Add Environment Variable"** for each:

#### **Basic Configuration**
```
SPRING_PROFILES_ACTIVE = prod
SERVER_SERVLET_CONTEXT_PATH = /api
```

#### **Database Configuration**
Use the PostgreSQL connection string you got in Step 2:

```
SPRING_DATASOURCE_URL = postgresql://[user]:[password]@[host]:[port]/[database]
SPRING_DATASOURCE_USERNAME = [username from connection string]
SPRING_DATASOURCE_PASSWORD = [password from connection string]
SPRING_JPA_HIBERNATE_DDL_AUTO = update
SPRING_JPA_DATABASE_PLATFORM = org.hibernate.dialect.PostgreSQL10Dialect
```

#### **Optional (for CORS)**
```
APP_CORS_ALLOWED_ORIGINS = https://waste-recycling-tracker-production.vercel.app
```

---

### **STEP 6: Link Database to Backend (1 minute)**

1. Go to your **PostgreSQL** database dashboard
2. Copy the connection string
3. Go back to your **Web Service** (waste-recycling-api)
4. In **"Environment"** section, update:
   - `SPRING_DATASOURCE_URL` with the connection string

---

### **STEP 7: Deploy! (3-5 minutes)**

1. Scroll to bottom
2. Click **"Create Web Service"**
3. Render will:
   - Download your repo
   - Build with Maven
   - Create Docker image
   - Deploy to production
4. Monitor the **"Logs"** tab to see build progress
5. Status changes from `Creating` → `Building` → `Deploying` → **`Live`** ✅

**Expected output in logs:**
```
BUILD SUCCESS
Started WasteRecyclingTrackerApplication in X seconds
Tomcat started on port(s): 8080
```

---

### **STEP 8: Get Your Backend URL (1 minute)**

Once service is **Live**, you'll see the public URL at the top:

**It looks like:**
```
https://waste-recycling-api-xyz123.onrender.com
```

**Copy this URL** - you need it for Vercel.

---

### **STEP 9: Update Vercel Environment Variables (2 minutes)**

1. Go to: https://vercel.com/dashboard
2. Select your project: **waste-recycling-tracker-production**
3. Click **Settings** → **Environment Variables**
4. Find or create: **`VITE_API_URL`**
5. Update value to your Render backend URL:
   ```
   https://waste-recycling-api-xyz123.onrender.com
   ```
6. Click **"Save"**

---

### **STEP 10: Redeploy Frontend (2 minutes)**

1. Still in Vercel dashboard
2. Click **"Deployments"** tab
3. Find the latest deployment
4. Click the **three dots** → **"Redeploy"**
5. Wait for redeployment to complete (1-2 minutes)

---

### **STEP 11: Test Everything! (2 minutes)**

1. Open your Vercel URL:
   ```
   https://waste-recycling-tracker-production.vercel.app
   ```

2. Open browser console: **F12** → **Console** tab

3. Try to login with test credentials:
   - Email: `test@example.com`
   - Password: `Test@123`

4. **Expected result:**
   - Login succeeds
   - Dashboard loads with data
   - No console errors about API

5. If successful: **FULL STACK DEPLOYED!** 🚀

---

## 🔧 Troubleshooting

### Issue: "Database connection failed"

**Solution:**
1. Go to Render → PostgreSQL database
2. Check status is **"Available"** (green)
3. Copy exact connection string
4. Verify all variables in Web Service match exactly
5. Redeploy web service

### Issue: "Service still building..."

**Solution:**
1. Wait 5-10 minutes (first build takes longer)
2. Check Logs tab for errors
3. Common error: `mvn: command not found`
   - Ensure Root Directory is `backend`
   - Java/Maven should auto-install

### Issue: "Cannot connect to database" in logs

**Solution:**
1. Database variables might be wrong
2. Go to PostgreSQL service → copy full connection string
3. Paste into `SPRING_DATASOURCE_URL` exactly
4. Redeploy

### Issue: Frontend gets "Cannot POST /api/login"

**Solution:**
1. Check `VITE_API_URL` in Vercel environment variables
2. Must match Render backend URL exactly
3. No trailing slash
4. Redeploy frontend after change

---

## 📊 Deployment Summary

```
┌─────────────────────────────────────────────────────┐
│                                                     │
│  Frontend (Vercel)                            ✅   │
│  https://waste-recycling-tracker-prod.vercel.app   │
│             ↓                                       │
│  API (Render)                                 ✅   │
│  https://waste-recycling-api-xyz.onrender.com      │
│             ↓                                       │
│  Database (PostgreSQL on Render)              ✅   │
│  postgresql://user:pass@host:5432/database        │
│                                                     │
│  ALL CONNECTED = FULL STACK! 🚀                   │
│                                                     │
└─────────────────────────────────────────────────────┘
```

---

## 💡 Pro Tips

1. **First deployment is slow** (3-5 min) - Maven downloads dependencies
2. **Subsequent deployments are faster** (1-2 min) - cached deps
3. **Free tier benefits:**
   - 0.5 GB RAM per service
   - Automatic deployments on push
   - Free PostgreSQL database
   - No credit card

4. **Want faster builds?** Render has paid plans ($7+/month)
5. **Custom domain?** Add at Settings → Custom Domain (if you own waste-recycling-tracker.com)

---

## ✅ Final Checklist

- [ ] Render account created
- [ ] PostgreSQL database running
- [ ] Backend web service deployed
- [ ] All environment variables set
- [ ] Backend URL copied
- [ ] Vercel `VITE_API_URL` updated
- [ ] Frontend redeployed
- [ ] Can access https://waste-recycling-tracker-production.vercel.app
- [ ] Can login successfully
- [ ] Dashboard loads with data

**DONE!** 🎉 Your full-stack app is live!

