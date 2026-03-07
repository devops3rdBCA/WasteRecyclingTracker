🟢 Waste Recycling Tracker
Hi! This is my full-stack project called Waste Recycling Tracker, built using React for the frontend and Spring Boot for the backend. It helps families submit their recyclable waste and lets recycling centers manage and update the status of those entries.

🌟 What It Does
Family Login: Add waste entries (name, type, quantity), view and update them.

Recycling Center Login: See all entries, change status (Pending → Processing → Recycled), and remove recycled ones.

Admin Panel (optional): Manage users and view statistics.

Email Notifications: Sends alerts when status changes or recycling is done.

Statistics Dashboard: Shows how much waste has been collected and recycled.

🧱 Tech Stack
Backend
Java 17 + Spring Boot

JPA + Hibernate

H2 (for testing), PostgreSQL (for production)

REST APIs with role-based access

Frontend
React + Vite

React Router

Axios for API calls

Bootstrap for styling

Deployment
Docker + Docker Compose

Vercel for frontend

Heroku/AWS/Azure for backend

GitHub Actions for CI/CD

📁 Folder Structure
Code
waste-recycling-tracker/
├── backend/         # Spring Boot app
├── frontend/        # React app
├── docker-compose.yml
├── .env.example     # Environment config
🚀 How to Run Locally
bash
# Clone the repo
git clone https://github.com/jeynisha36/WasteRecyclingTracker.git
cd waste-recycling-tracker

# Start backend
cd backend
mvn spring-boot:run

# Start frontend (in another terminal)
cd frontend
npm install
npm run dev

🐳 Docker Setup
bash
# Run both frontend and backend with Docker
docker-compose up -d
<img width="1366" height="768" alt="Screenshot (54)" src="https://github.com/user-attachments/assets/27935e5d-ad3d-491b-8638-4020f187e582" />


🔧 Environment Setup -
Copy .env.example to .env and fill in:

DB_HOST, DB_USER, DB_PASSWORD

REACT_APP_API_URL → your backend URL

CORS_ORIGINS → allowed frontend domains

📡 API Overview -
-Family
GET /api/family/{name},
POST /api/family,
PUT /api/family/{id},
DELETE /api/family/{id}.

-Center
GET /api/center,
PUT /api/center/{id},
DELETE /api/center/{id}.

-Admin & Stats
GET /api/statistics,
GET /api/admin/users.

🌐 Frontend Deployment (Vercel) -
 * Push code to GitHub
   
 * Go to vercel.com

 * Import your repo

 * Set REACT_APP_API_URL in Vercel settings

 * Deploy!
 
 * <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a8a4d5f1-095e-4221-8ac1-65f4a3414a75" />
 <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0c685441-8862-4d69-8457-53d274893702" />

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/057fe4b9-031c-40b4-86af-4bad5787624c" />

Sonar Cloud Quality Check:

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4290fd29-6036-48d3-9c23-a2db7b5f2ebd" />

🛡️ Security -
 * Role-based access (Family, Center, Admin)

 * Passwords encrypted with bcrypt

 * CORS and HTTPS support

🛠️ Troubleshooting -
 * If backend port is busy → change it with --server.port=9000

 * If frontend can't connect → check REACT_APP_API_URL and CORS settings

 * If DB fails → make sure PostgreSQL is running and credentials are correct

📄 Extra Docs -
 * DEPLOYMENT_GUIDE.md → how to deploy to cloud

 * DATABASE_MIGRATION.md → switch from H2 to PostgreSQL

🤝 Contributing -
          Feel free to fork the repo, make changes, and submit a pull request!

📝 License -
         This project is for learning and production use. Built with ❤️ by Jeynisha E, III-BCA (SF), aspiring full-stack developer.
