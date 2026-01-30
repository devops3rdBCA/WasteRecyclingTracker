# Waste Recycling Tracker - Production Deployment Guide

## 🚀 Complete Deployment Instructions

### System Requirements
- Java 17+
- Node.js 18+
- PostgreSQL 12+ (for production database)
- Docker (optional)
- Git

---

## 📋 Pre-Deployment Checklist

- [ ] Update database from H2 to PostgreSQL
- [ ] Configure environment variables
- [ ] Update API URLs for production
- [ ] Build production JAR for backend
- [ ] Build optimized frontend
- [ ] Setup SSL/HTTPS
- [ ] Configure CORS for production domain
- [ ] Setup backup strategy
- [ ] Configure logging
- [ ] Setup monitoring

---

## 🗄️ **Phase 1: Database Setup (PostgreSQL)**

### Local Installation
```bash
# Windows
# Download from https://www.postgresql.org/download/windows/

# Or use Docker
docker run --name postgres-wrt \
  -e POSTGRES_DB=waste_recycling_db \
  -e POSTGRES_USER=wrt_user \
  -e POSTGRES_PASSWORD=secure_password \
  -p 5432:5432 \
  -d postgres:15
```

### Create Database
```sql
CREATE DATABASE waste_recycling_db;
CREATE USER wrt_user WITH PASSWORD 'secure_password';
ALTER ROLE wrt_user SET client_encoding TO 'utf8';
ALTER ROLE wrt_user SET default_transaction_isolation TO 'read committed';
ALTER ROLE wrt_user SET default_transaction_deferrable TO on;
ALTER ROLE wrt_user SET default_transaction_read_only TO off;
GRANT ALL PRIVILEGES ON DATABASE waste_recycling_db TO wrt_user;
```

---

## ⚙️ **Phase 2: Backend Configuration**

### Update application-prod.properties
See `application-prod.properties` file in the backend

### Build Production JAR
```bash
cd backend
mvn clean package -DskipTests -P prod
java -jar target/waste-recycling-tracker-backend-1.0.0.jar --spring.profiles.active=prod
```

### Enable HTTPS
Add to `application-prod.properties`:
```properties
server.ssl.key-store=keystore.p12
server.ssl.key-store-password=your-keystore-password
server.ssl.key-store-type=PKCS12
server.ssl.key-alias=tomcat
```

Generate keystore:
```bash
keytool -genkeypair -alias tomcat -keyalg RSA -keysize 2048 \
  -keystore keystore.p12 -keypass password -storepass password \
  -storetype PKCS12 -validity 365 -dname "CN=yourdomain.com"
```

---

## 🎨 **Phase 3: Frontend Build**

### Build Optimized Production Version
```bash
cd frontend
npm install
npm run build
```

### Configure API Endpoint for Production
Update `src/services/api.js`:
```javascript
const API_HOST = 'https://api.yourdomain.com'; // Your production API
```

### Build and Test
```bash
npm run build
npm run preview
```

### Deploy to CDN/Hosting
**Options:**
1. **Vercel** (Recommended for React)
   ```bash
   npm install -g vercel
   vercel --prod
   ```

2. **Netlify**
   ```bash
   npm install -g netlify-cli
   netlify deploy --prod --dir=dist
   ```

3. **AWS S3 + CloudFront**
   ```bash
   aws s3 sync dist/ s3://your-bucket-name/
   ```

4. **Firebase Hosting**
   ```bash
   npm install -g firebase-tools
   firebase deploy
   ```

---

## 🌐 **Phase 4: Backend Deployment**

### Option A: Deploy to Heroku
```bash
# Install Heroku CLI
npm install -g heroku

# Login
heroku login

# Create app
heroku create waste-recycling-tracker-api

# Add PostgreSQL addon
heroku addons:create heroku-postgresql:standard-0

# Set environment variables
heroku config:set SPRING_PROFILES_ACTIVE=prod
heroku config:set DB_HOST=<postgres-host>
heroku config:set DB_USER=<postgres-user>
heroku config:set DB_PASSWORD=<postgres-password>

# Deploy
git push heroku main
```

### Option B: Deploy to AWS EC2
```bash
# Connect to EC2 instance
ssh -i your-key.pem ec2-user@your-instance-ip

# Install Java
sudo amazon-linux-extras install java-openjdk17

# Upload JAR
scp -i your-key.pem target/waste-recycling-tracker-backend-1.0.0.jar ec2-user@your-instance-ip:/home/ec2-user/

# Run as service
sudo systemctl start waste-recycling-tracker
```

### Option C: Deploy with Docker
See `Dockerfile` configuration

### Option D: Deploy to Azure App Service
```bash
az login
az group create --name waste-recycling-rg --location eastus
az appservice plan create --name waste-recycling-plan --resource-group waste-recycling-rg --sku B2 --is-linux
az webapp create --resource-group waste-recycling-rg --plan waste-recycling-plan --name waste-recycling-api --runtime "JAVA|17-java17"
az webapp deployment source config-zip --resource-group waste-recycling-rg --name waste-recycling-api --src target/waste-recycling-tracker-backend-1.0.0.jar
```

---

## 🔒 **Phase 5: Security Configuration**

### Environment Variables
Create `.env.production`:
```
# Database
DB_HOST=your-postgres-host
DB_PORT=5432
DB_NAME=waste_recycling_db
DB_USER=wrt_user
DB_PASSWORD=your-secure-password

# API
API_PORT=8081
API_TIMEOUT=30000

# Frontend
REACT_APP_API_URL=https://api.yourdomain.com

# JWT (if implementing)
JWT_SECRET=your-very-long-secret-key
JWT_EXPIRATION=86400

# Logging
LOG_LEVEL=INFO
```

### SSL/TLS Certificate
Use **Let's Encrypt** (free):
```bash
sudo apt-get install certbot
sudo certbot certonly --standalone -d yourdomain.com
```

### Update CORS for Production
In `WasteRecyclingTrackerApplication.java`:
```java
configuration.setAllowedOrigins(Arrays.asList(
    "https://yourdomain.com",
    "https://www.yourdomain.com"
));
```

---

## 📊 **Phase 6: Monitoring & Logging**

### Application Logging
Add to `application-prod.properties`:
```properties
logging.file.name=/var/log/wrt/application.log
logging.level.root=INFO
logging.level.com.wasterecyclingtracker=DEBUG
```

### Setup Monitoring
- **New Relic**: APM monitoring
- **DataDog**: Log aggregation
- **Sentry**: Error tracking
- **Prometheus + Grafana**: Metrics

---

## 🔄 **Phase 7: Continuous Integration/Deployment**

### GitHub Actions Workflow
Create `.github/workflows/deploy.yml`:
```yaml
name: Deploy to Production
on:
  push:
    branches: [main]
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Build Backend
        run: cd backend && mvn clean package -DskipTests
      - name: Build Frontend
        run: cd frontend && npm ci && npm run build
      - name: Deploy
        run: ./deploy.sh
```

---

## 📈 **Phase 8: Performance Optimization**

### Backend
- Enable response compression
- Setup caching (Redis)
- Database indexing
- Connection pooling

### Frontend
- Code splitting
- Lazy loading
- Image optimization
- Minification

---

## 🚨 **Phase 9: Backup & Disaster Recovery**

### Database Backup
```bash
# Daily backup
pg_dump waste_recycling_db > backup_$(date +%Y%m%d).sql

# Store on S3
aws s3 cp backup_*.sql s3://your-backup-bucket/
```

### Recovery Plan
- Document recovery procedures
- Test recovery regularly
- Setup automated backups
- Store backups in multiple locations

---

## ✅ **Post-Deployment Verification**

- [ ] Backend API accessible at production URL
- [ ] Frontend loads correctly
- [ ] Database connections working
- [ ] SSL certificates valid
- [ ] Monitoring active
- [ ] Backups configured
- [ ] Logging configured
- [ ] CORS working properly
- [ ] Performance acceptable
- [ ] All endpoints tested

---

## 📞 **Support & Maintenance**

### Monitoring Dashboard
- Setup uptime monitoring
- Configure alerts
- Log important events
- Track performance metrics

### Regular Maintenance
- Monthly security updates
- Database optimization
- Log rotation
- Backup verification

---

## 🎯 Summary

Your Waste Recycling Tracker is now ready for production! Follow each phase carefully and test thoroughly before going live.

**Estimated Deployment Time**: 2-4 hours
**Difficulty Level**: Intermediate
