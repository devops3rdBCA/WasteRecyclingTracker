# GitHub & Vercel Deployment Guide

## Step 9: Push to GitHub ✅

Your local repository is now ready! Follow these steps to push to GitHub:

### 1. Create a New Repository on GitHub

1. Go to [github.com/new](https://github.com/new)
2. Repository name: `waste-recycling-tracker`
3. Description: "Full-stack waste recycling management system with Spring Boot and React"
4. Choose **Public** or **Private**
5. **DO NOT** initialize with README (we already have one)
6. Click **Create repository**

### 2. Add GitHub Remote & Push

Replace `<USERNAME>` with your GitHub username and `<REPO>` with your repo name:

```bash
# Add remote origin
git remote add origin https://github.com/<USERNAME>/<REPO>.git

# Verify remote
git remote -v

# Push to GitHub
git push -u origin main
```

**Using SSH (recommended for future pushes):**

```bash
# If you have SSH key configured
git remote set-url origin git@github.com:<USERNAME>/<REPO>.git
git push -u origin main
```

### 3. Verify on GitHub

- Visit `https://github.com/<USERNAME>/<REPO>`
- You should see all your files committed ✅

---

## Step 10: Deploy Frontend to Vercel 🚀

### Option A: Deploy from GitHub (Recommended)

#### 1. Sign Up / Login to Vercel

- Go to [vercel.com](https://vercel.com)
- Click **Sign Up** → Choose **GitHub**
- Authorize Vercel to access your GitHub account

#### 2. Import Your Repository

1. On Vercel dashboard, click **Add New** → **Project**
2. Click **Import Git Repository**
3. Find and select `waste-recycling-tracker` from the list
4. Click **Import**

#### 3. Configure Build Settings

Vercel auto-detects React + Vite configuration:

- **Framework**: Vite (auto-detected)
- **Root Directory**: `./frontend`
- **Build Command**: `npm run build`
- **Output Directory**: `dist`
- **Install Command**: `npm install`

**Keep defaults** - Vercel auto-configures these!

#### 4. Set Environment Variables

Add these in the Environment Variables section:

```
REACT_APP_API_URL=https://your-backend-api.com/api
REACT_APP_ENVIRONMENT=production
```

**For Development:**
```
REACT_APP_API_URL=http://localhost:8081/api
REACT_APP_ENVIRONMENT=development
```

#### 5. Deploy!

- Click **Deploy**
- Vercel builds and deploys automatically
- Get your live URL: `https://waste-recycling-tracker-xxxxx.vercel.app`

### Option B: Deploy from CLI

If you prefer the command line:

```bash
# Install Vercel CLI
npm install -g vercel

# Login to Vercel
vercel login

# Deploy from project root
cd frontend
vercel --prod

# Or deploy entire project
cd ..
vercel --prod
```

---

## 🔗 Connecting Frontend to Backend

### Update API Endpoint

Once your backend is deployed, update the API URL in Vercel:

1. Go to Vercel Dashboard → Your Project → Settings
2. Navigate to **Environment Variables**
3. Update `REACT_APP_API_URL` to your backend URL:
   - Heroku: `https://your-app-name.herokuapp.com/api`
   - AWS: `https://your-domain.com/api`
   - Azure: `https://your-app.azurewebsites.net/api`

4. Redeploy: Go to **Deployments** → Click latest deployment → **Redeploy**

### Configure CORS on Backend

Update backend CORS settings to allow Vercel domain:

**In `application-prod.properties`:**
```properties
app.cors.allowed-origins=https://waste-recycling-tracker-xxxxx.vercel.app,https://yourdomain.com
```

Or **in `WasteRecyclingTrackerApplication.java`:**
```java
configuration.setAllowedOrigins(Arrays.asList(
    "https://waste-recycling-tracker-xxxxx.vercel.app",
    "https://yourdomain.com"
));
```

Redeploy backend for changes to take effect.

---

## 📦 Backend Deployment Options

### Heroku (Easiest for Beginners)

```bash
# Install Heroku CLI from heroku.com/download
heroku login

# Create app
heroku create your-app-name-api

# Add PostgreSQL
heroku addons:create heroku-postgresql:standard-0

# Deploy
git push heroku main
```

### AWS EC2

1. Create EC2 instance (Ubuntu 22.04)
2. Install Java 17 and PostgreSQL
3. Upload and run JAR file
4. Configure security groups for port 8081
5. Point domain to instance IP

### Azure App Service

```bash
az login
az group create --name your-rg --location eastus
az appservice plan create --name your-plan --resource-group your-rg --sku B2 --is-linux
az webapp create --resource-group your-rg --plan your-plan --name your-api-name --runtime "JAVA|17"
az webapp deployment source config-zip --resource-group your-rg --name your-api-name --src app.jar
```

---

## ✅ Post-Deployment Checklist

### Frontend (Vercel)

- [ ] Frontend accessible at `https://your-app.vercel.app`
- [ ] Page loads without errors
- [ ] API calls connect to backend
- [ ] Login works correctly
- [ ] Dashboard displays data
- [ ] Statistics load properly

### Backend API

- [ ] Backend accessible at deployed URL
- [ ] API endpoints respond correctly
- [ ] Database connected
- [ ] CORS headers present
- [ ] Health check passes: `/actuator/health`

### Database

- [ ] PostgreSQL running
- [ ] Tables created
- [ ] Sample data loaded
- [ ] Backups configured

---

## 🔐 Security Best Practices

### Frontend (Vercel)

1. **Never commit `.env`** - Use Vercel's environment variables
2. **Enable branch protection** on GitHub
3. **Review deployments** before promoting to production
4. **Use Vercel's Edge Functions** for rate limiting

### Backend

1. **Use strong database passwords**
2. **Enable HTTPS only**
3. **Configure CORS properly** (whitelist domains)
4. **Rotate API keys/secrets** periodically
5. **Use environment variables** for sensitive data
6. **Enable SSL certificates** (use Let's Encrypt)

---

## 📊 Monitoring & Analytics

### Vercel Analytics

1. Dashboard → Settings → **Analytics**
2. Enable **Web Analytics**
3. View real-time traffic, page loads, user count

### Backend Monitoring

1. Use Vercel's **Log** feature
2. Setup **New Relic** for APM
3. Configure **CloudWatch** (if using AWS)
4. Monitor **performance metrics**

---

## 🐛 Troubleshooting

### Frontend won't load on Vercel

```bash
# Check build logs
vercel logs

# Rebuild
vercel redeploy --force

# Check environment variables
vercel env list
```

### Frontend can't reach backend

```bash
# Verify CORS is enabled on backend
# Check REACT_APP_API_URL in Vercel
# Ensure backend is running and accessible
```

### Database connection fails

```bash
# Verify PostgreSQL is running
# Check connection string in .env
# Verify firewall allows port 5432
```

---

## 🎯 Next Steps

1. ✅ Push code to GitHub
2. ✅ Deploy frontend to Vercel
3. Deploy backend to cloud (Heroku/AWS/Azure)
4. Connect frontend to backend API
5. Setup custom domain
6. Enable SSL/HTTPS
7. Configure monitoring
8. Setup backups and disaster recovery

---

## 📝 Useful Commands

```bash
# View git log
git log --oneline

# Create feature branch
git checkout -b feature/new-feature

# Push feature branch
git push origin feature/new-feature

# View Vercel deployments
vercel ls

# View Vercel analytics
vercel analytics
```

---

## 🔗 Useful Links

- GitHub: https://github.com
- Vercel: https://vercel.com
- Vercel Docs: https://vercel.com/docs
- Heroku: https://heroku.com
- AWS: https://aws.amazon.com
- Azure: https://azure.microsoft.com

---

## ✨ Congratulations!

Your Waste Recycling Tracker is now:
- ✅ Version controlled on GitHub
- ✅ Ready for deployment
- ✅ Deployed on Vercel
- ✅ Production-ready!

**Share your live app**: `https://your-app.vercel.app` 🎉
