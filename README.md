# Waste Recycling Tracker

A comprehensive full-stack waste recycling management system built with Spring Boot and React.

## 🌍 Features

- **Family Dashboard**: Track and manage household waste entries
- **Recycling Center Dashboard**: Monitor and process waste from multiple families
- **Statistics & Reports**: Real-time analytics on waste collection and recycling
- **User Management**: Role-based access control (Family, Center, Admin)
- **Notifications**: Email alerts for status changes and recycling completion
- **Production Ready**: Dockerized, scalable architecture with PostgreSQL

## 🏗️ Architecture

### Backend (Spring Boot)
- Java 17 with Spring Boot 3.2.0
- JPA/Hibernate ORM
- PostgreSQL database (H2 for development)
- RESTful API with CORS support
- Role-based security

### Frontend (React + Vite)
- React 18.2.0
- React Router for navigation
- Bootstrap 5 for UI
- Axios for API communication

### Deployment
- Docker containerization
- Docker Compose for local development
- GitHub Actions CI/CD
- Vercel for frontend deployment
- Heroku/AWS/Azure for backend deployment

## 📦 Project Structure

```
waste-recycling-tracker/
├── backend/                    # Spring Boot application
│   ├── src/main/java/
│   ├── src/main/resources/
│   ├── pom.xml
│   ├── Dockerfile
│   └── target/
├── frontend/                   # React application
│   ├── src/
│   ├── package.json
│   ├── Dockerfile
│   └── dist/
├── docker-compose.yml          # Full stack orchestration
├── DEPLOYMENT_GUIDE.md         # Production deployment guide
├── DATABASE_MIGRATION.md       # Database migration scripts
└── .env.example                # Environment variables template
```

## 🚀 Quick Start

### Development (Local)

```bash
# Clone repository
git clone <your-repo-url>
cd waste-recycling-tracker

# Backend
cd backend
mvn clean install
mvn spring-boot:run

# Frontend (new terminal)
cd frontend
npm install
npm run dev
```

### Production (Docker)

```bash
# Windows
deploy-docker.bat prod

# Linux/Mac
chmod +x deploy-docker.sh
./deploy-docker.sh prod
```

## 📋 Prerequisites

- Java 17+
- Node.js 18+
- PostgreSQL 12+ (for production)
- Docker & Docker Compose (for containerized deployment)
- Git

## 🔧 Configuration

### Environment Variables

Copy `.env.example` to `.env` and configure:

```bash
cp .env.example .env
```

Update the following variables:
- `DB_HOST`: PostgreSQL host
- `DB_USER`: Database user
- `DB_PASSWORD`: Database password
- `REACT_APP_API_URL`: Backend API URL
- `CORS_ORIGINS`: Allowed frontend origins

### Backend Configuration

- **Development**: `application.properties` (H2 in-memory)
- **Production**: `application-prod.properties` (PostgreSQL)

Start with production profile:
```bash
java -jar app.jar --spring.profiles.active=prod
```

## 📊 API Endpoints

### Family Dashboard
- `GET /api/family/{name}` - Get family waste entries
- `POST /api/family` - Add new waste entry
- `PUT /api/family/{id}` - Update waste entry
- `DELETE /api/family/{id}` - Delete waste entry

### Recycling Center
- `GET /api/center` - Get all entries
- `PUT /api/center/{id}` - Update entry status
- `DELETE /api/center/{id}` - Delete recycled entry

### Statistics
- `GET /api/statistics` - Get overall statistics
- `GET /api/statistics/family/{name}` - Get family-specific statistics

### User Management
- `GET /api/admin/users` - List all users
- `POST /api/admin/users` - Create user
- `PUT /api/admin/users/{id}` - Update user
- `DELETE /api/admin/users/{id}` - Delete user

### Notifications
- `POST /api/notifications/status-change` - Send status change notification
- `POST /api/notifications/pickup` - Send pickup notification
- `POST /api/notifications/recycling-completed` - Send completion notification

## 🐳 Docker Deployment

### Single Container Development

```bash
docker-compose up -d
```

### Production Deployment

See [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) for detailed instructions on:
- Database migration from H2 to PostgreSQL
- Heroku deployment
- AWS EC2 deployment
- Azure App Service deployment
- SSL/TLS certificate setup

## 🌐 Frontend Deployment (Vercel)

1. Push code to GitHub
2. Go to [vercel.com](https://vercel.com)
3. Import GitHub repository
4. Vercel auto-detects React + Vite
5. Configure environment variables:
   - `REACT_APP_API_URL`: Your backend API URL
6. Deploy!

## 🔐 Security

- CORS configured for production domains
- Role-based access control (RBAC)
- Spring Security enabled
- Password encryption (bcrypt)
- HTTPS/SSL support
- Environment variables for sensitive data

## 📊 Monitoring

Endpoints available at `/actuator`:
- `/actuator/health` - Application health
- `/actuator/metrics` - Performance metrics
- `/actuator/info` - Application info

## 🐛 Troubleshooting

### Backend won't start
```bash
# Check if port 8081 is in use
lsof -i :8081

# Use different port
java -jar app.jar --server.port=9000
```

### Database connection issues
```bash
# Verify PostgreSQL is running
pg_isready -h localhost -p 5432

# Check database credentials in .env
```

### Frontend won't connect to backend
```bash
# Verify CORS is properly configured
# Check REACT_APP_API_URL in environment variables
# Ensure backend is running on the correct port
```

## 📄 Documentation

- [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) - Complete production deployment guide
- [DATABASE_MIGRATION.md](DATABASE_MIGRATION.md) - Database migration strategies
- See `.env.example` for all configuration options

## 🤝 Contributing

1. Create a feature branch: `git checkout -b feature/your-feature`
2. Commit changes: `git commit -m "Add your feature"`
3. Push to branch: `git push origin feature/your-feature`
4. Submit a pull request

## 📝 License

This project is provided as-is for educational and production use.

## 📞 Support

For issues, questions, or suggestions, please open an GitHub issue or contact the development team.

---

**Last Updated**: January 30, 2026
**Status**: Production Ready ✅
