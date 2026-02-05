# Backend Deployment Guide

## ⚡ Quick Deploy Backend to Railway.app (Recommended)

### **STEP 1: Create Railway Account (2 minutes)**
1. Visit: https://railway.app
2. Click "Start a New Project"
3. Sign up with GitHub
4. Authorize Railway to access your GitHub account

### **STEP 2: Create Backend Service (3 minutes)**

**Option A: From GitHub (Recommended)**
1. In Railway dashboard, click "New Project"
2. Select "Deploy from GitHub repo"
3. Choose: `Jeynisha36/WasteRecyclingTracker`
4. Select `backend` folder (when prompted)
5. Click "Deploy"

**Option B: Manual Upload**
1. Click "New Project" → "Database" → "PostgreSQL"
2. Click "New" → "GitHub repo"
3. Configure and deploy

### **STEP 3: Configure Environment Variables (2 minutes)**

Once deployed, click on your service and go to "Variables":

```
SPRING_DATASOURCE_URL=postgresql://[railway-db-host]:5432/railway
SPRING_DATASOURCE_USERNAME=postgres
SPRING_DATASOURCE_PASSWORD=[auto-filled]
SPRING_JPA_HIBERNATE_DDL_AUTO=update
SPRING_PROFILES_ACTIVE=prod
SERVER_SERVLET_CONTEXT_PATH=/api
```

Railway auto-configures PostgreSQL connection details. Just add:
```
SPRING_PROFILES_ACTIVE=prod
```

### **STEP 4: Get Backend URL (1 minute)**

1. In Railway, click your backend service
2. Go to "Settings" → "Public Networking"
3. Copy the public domain (e.g., `https://wrt-api-prod-xyz.up.railway.app`)
4. This is your `VITE_API_URL`

### **STEP 5: Update Frontend in Vercel (1 minute)**

1. Go to: https://vercel.com/dashboard
2. Select your project
3. Click "Settings" → "Environment Variables"
4. Update or create `VITE_API_URL`:
   ```
   https://wrt-api-prod-xyz.up.railway.app
   ```
5. Save changes

### **STEP 6: Redeploy Frontend (automatic)**

Vercel will automatically redeploy when you update environment variables, or:
1. Go to "Deployments"
2. Click the latest deployment
3. Click "Redeploy"

### **STEP 7: Test the Connection (2 minutes)**

1. Visit your Vercel URL: https://waste-recycling-tracker-production.vercel.app
2. Try to login
3. Open browser console (F12)
4. Check for any API errors
5. If successful, you'll see user dashboard load!

---

## 🔧 Common Issues & Fixes

### Issue: "Cannot POST /api/auth/login"
**Solution:** Backend URL is wrong. Check:
- `VITE_API_URL` in Vercel environment variables
- Backend is actually running (check Railway dashboard logs)
- CORS is enabled on backend

### Issue: "Database connection failed"
**Solution:** 
- Go to Railway → Your Project → PostgreSQL service
- Verify it's running (green status)
- Check connection string in backend logs

### Issue: Backend won't start
**Solution:**
1. Go to Railway → Backend service
2. Click "Logs" tab
3. Read error message
4. Common: Missing `application-prod.properties` in JAR
5. Ensure Maven builds include resources: `mvn clean package -DskipTests`

---

## 📊 Deployment Status Checklist

- [ ] Railway account created
- [ ] Backend deployed to Railway
- [ ] PostgreSQL database active
- [ ] Backend public URL copied
- [ ] `VITE_API_URL` updated in Vercel
- [ ] Frontend redeployed
- [ ] Login page loads without 404
- [ ] Can login successfully
- [ ] Dashboard shows data from API

---

## Alternative: Render.com (Free Tier)

If Railway has issues, try Render.com:

1. Visit: https://render.com
2. Sign up with GitHub
3. Click "New +" → "Web Service"
4. Select your GitHub repo
5. Set:
   - Root Directory: `backend`
   - Build Command: `mvn clean package -DskipTests`
   - Start Command: `java -jar target/*.jar --spring.profiles.active=prod`
6. Add environment variables (same as Railway)
7. Deploy

Render URL: `https://your-app.onrender.com`

---

## ✅ Final Verification

Once everything is deployed:

```
Frontend (Vercel) ✅
         ↓
  https://waste-recycling-tracker-production.vercel.app
         ↓
Backend (Railway) ✅
    https://wrt-api-prod-xyz.up.railway.app/api/users
         ↓
Database (PostgreSQL on Railway) ✅
```

All three layers connected = **FULL STACK DEPLOYED!** 🚀

---

## 📝 Notes

- Railway free tier includes 5GB storage, 100GB bandwidth/month
- If you exceed, upgrade is simple ($5+/month per service)
- Render free tier has some limitations but includes auto-deploys
- Both support custom domains if you have `waste-recycling-tracker.com`
- Monitor logs regularly: Railway → Service → Logs

