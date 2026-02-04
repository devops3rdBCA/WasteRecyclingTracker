# 🎬 Project Demo - Waste Recycling Tracker

## Quick Start Demo Flow

Follow these steps to see all features in action:

---

## 1. Launch the Application

### Local Development Demo
```bash
# Terminal 1: Start Backend
cd d:\test\backend
java -Dfile.encoding=UTF-8 -jar target/waste-recycling-tracker-backend-1.0.0.jar --server.port=8081 --spring.profiles.active=dev

# Terminal 2: Start Frontend
cd d:\test\frontend
npm run dev
```

Access:
- **Frontend:** http://localhost:5173
- **Backend API:** http://localhost:8081/api
- **Health Check:** http://localhost:8081/actuator/health
- **H2 Database:** http://localhost:8081/h2-console

### Production Demo
- **Live URL:** https://waste-recycling-tracker-production.vercel.app
- **Custom Domain:** https://waste-recycling-tracker.com (once DNS propagates)

---

## 2. User Registration & Login

### Demo Credentials (Existing Users)
```
Family Users:
- Email: sharma@example.com | Password: password123
- Email: patel@example.com | Password: password123

Center Admin:
- Email: admin@center.com | Password: admin123
```

### Steps:
1. Navigate to login page
2. Click "Create Account" for registration
3. Fill in:
   - Full Name: "John Doe"
   - Email: "john@example.com"
   - Password: "secure123"
   - User Type: "Family User"
4. Click "Register"
5. Login with new credentials

**Expected Result:** Dashboard loads showing empty waste entries

---

## 3. Create Waste Entries (Family Dashboard)

### Feature: Log Waste
1. Click "Add New Entry" button
2. Fill in the form:
   - **Waste Type:** Select from dropdown (Plastic, Glass, Paper, Metal, etc.)
   - **Quantity:** 2.5 kg
   - **Description:** "Plastic bottles from kitchen"
   - **Collection Center:** Select from list
   - **Status:** "Pending"
3. Click "Submit Entry"

**Expected Result:**
- Entry added to table below
- Card shows updated count
- Status badge displays "Pending"

### Multiple Entries Example
Create 3-5 different entries:
| Waste Type | Quantity | Status |
|-----------|----------|--------|
| Plastic | 2.5 kg | Pending |
| Glass | 1.0 kg | Collected |
| Paper | 3.0 kg | Recycled |
| Metal | 0.5 kg | Processing |

---

## 4. View Statistics Dashboard

### Navigation
1. Click "Statistics" in navbar
2. Observe dashboard cards:

**Card 1: Total Entries**
- Shows count of all waste entries created
- Example: "5 Entries"

**Card 2: Total Quantity**
- Sums all waste quantities
- Example: "7.0 kg"

**Card 3: Active Families**
- Count of unique families logging waste
- Example: "2 Families"

**Card 4: Recycled Amount**
- Sum of waste marked as "Recycled"
- Example: "3.0 kg"

### Charts & Tables
1. **Waste Distribution by Type** - Shows breakdown of plastic vs glass vs paper vs metal
2. **Status Breakdown** - Pie chart showing Pending/Collected/Recycled/Processing percentages
3. **Recent Entries Table** - Lists latest 10 entries with filters

**Interactive Features:**
- Click on chart segments to filter table
- Sort by column headers
- Search by waste type

---

## 5. User Management (Admin Only)

### Access Requirements
Login with: `admin@center.com` / `admin123`

### Features:

#### User List View
1. Click "User Management" menu
2. View all registered users in table:
   - User ID, Name, Email, Type (Family/Center), Registration Date
   - Status (Active/Inactive)

#### User Actions
1. **View Details:** Click user row to see profile
   - Profile picture, contact info, waste history
   - Statistics (total entries, total quantity)

2. **Edit User:** Click edit icon
   - Change name, email, phone
   - Update user type
   - Save changes

3. **Deactivate User:** Click deactivate icon
   - User marked inactive but data preserved
   - Can be reactivated

4. **Delete User:** Click delete icon (with confirmation)
   - Removes user and associated data

#### Add New User (Admin)
1. Click "Add User" button
2. Enter details (Name, Email, Password, Type)
3. System sends welcome email
4. User can login immediately

---

## 6. Recycling Center Management

### Access
Click "Centers" in navbar

### View Centers
- Map showing all active recycling centers
- List of centers with:
  - Name, Location, Contact
  - Operating hours
  - Capacity and current load
  - Accepted waste types

### Center Details
Click on any center to see:
- Current waste inventory
- Pending pickups
- Processing schedule
- Contact information

### Demo Data
```
Center 1: Green Valley Recycling
- Location: 123 Main St
- Hours: 8 AM - 6 PM
- Capacity: 500 kg
- Current: 250 kg (50%)
- Accepted: Plastic, Glass, Paper, Metal

Center 2: Eco Hub
- Location: 456 Park Ave
- Hours: 9 AM - 5 PM
- Capacity: 1000 kg
- Current: 400 kg (40%)
- Accepted: All types
```

---

## 7. Notifications & Alerts

### Types of Notifications

#### Entry Status Changes
1. Create entry with status "Pending"
2. Admin updates to "Collected"
3. **User receives notification:**
   - "Your waste entry has been collected"
   - Timestamp and details shown

#### Email Notifications (if configured)
- Entry created → Confirmation email
- Entry collected → Collection notification
- Entry recycled → Recycling success notification
- Important alerts → Priority emails

### View Notifications
1. Click bell icon in navbar
2. See all notifications with timestamps
3. Mark as read/unread
4. Clear old notifications

---

## 8. Data Filtering & Search

### Statistics Dashboard Filters
1. **Date Range:** Select from/to dates
   - Example: Last 7 days, Last month
2. **Waste Type:** Filter by Plastic, Glass, Paper, Metal
3. **Status:** Show only Pending, Collected, Recycled, Processing
4. **Family:** Filter by specific family

### Example Filter Scenario
1. Set date range to "Last 7 days"
2. Select Waste Type = "Plastic"
3. Select Status = "Recycled"
4. **Result:** Shows only plastic entries recycled in last 7 days

---

## 9. Database H2 Console Demo (Development Only)

### Access
- URL: http://localhost:8081/h2-console
- Driver: org.h2.Driver
- JDBC URL: jdbc:h2:mem:testdb
- User: sa
- Password: (leave blank)

### View Data
```sql
-- View all users
SELECT * FROM users;

-- View all waste entries
SELECT * FROM family_waste;

-- Statistics query
SELECT 
  waste_type, 
  COUNT(*) as count,
  SUM(quantity) as total_quantity
FROM family_waste
GROUP BY waste_type;

-- Status breakdown
SELECT 
  status, 
  COUNT(*) as count
FROM family_waste
GROUP BY status;
```

---

## 10. API Endpoints Demo (Using Postman/cURL)

### Authentication
```bash
# Get JWT Token
curl -X POST http://localhost:8081/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "sharma@example.com",
    "password": "password123"
  }'
```

### Waste Entries
```bash
# Get all entries
curl -X GET http://localhost:8081/api/waste \
  -H "Authorization: Bearer {TOKEN}"

# Create new entry
curl -X POST http://localhost:8081/api/waste \
  -H "Authorization: Bearer {TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "wasteType": "PLASTIC",
    "quantity": 2.5,
    "description": "Demo entry",
    "status": "PENDING"
  }'

# Get statistics
curl -X GET http://localhost:8081/api/statistics \
  -H "Authorization: Bearer {TOKEN}"
```

---

## 11. Docker Demo

### Build and Run Full Stack
```bash
# Build all images
docker-compose up --build

# Access services:
# Frontend: http://localhost:3000
# Backend: http://localhost:8081
# Database: postgres://localhost:5432/waste_recycling_db
```

### Individual Services
```bash
# Backend only
docker build -t waste-backend ./backend
docker run -p 8081:8081 waste-backend

# Frontend only
docker build -t waste-frontend ./frontend
docker run -p 3000:3000 waste-frontend
```

---

## 12. CI/CD Pipeline Demo

### GitHub Actions Workflows

#### 1. Backend Build & Test
Triggered on: Push to main branch
```
Steps:
1. Checkout code
2. Setup Java 17
3. Run Maven build (mvn clean package)
4. Execute tests
5. Upload artifacts
Status: ✅ Passing
```

#### 2. Frontend Build
Triggered on: Push to main branch
```
Steps:
1. Checkout code
2. Setup Node 18
3. Install dependencies (npm ci)
4. Build for production (npm run build)
5. Upload build artifacts
Status: ✅ Passing
```

#### 3. SonarCloud Analysis
Triggered on: Push and PR
```
Steps:
1. Checkout code
2. Setup JDK
3. Run SonarCloud scan
4. Post quality metrics
Status: ✅ Quality Gate Passed
```

#### 4. Vercel Deployment
Triggered on: Push to main
```
Steps:
1. Checkout code
2. Setup Node
3. Deploy to Vercel (--prod)
4. Verify deployment
Status: ✅ Deployed Successfully
```

### View Workflows
1. Go to GitHub → Actions tab
2. Click on workflow name
3. Select latest run
4. View logs and results

---

## 13. Responsive Design Demo

### Test on Different Devices

#### Desktop (1920x1080)
- Full sidebar visible
- All components displayed
- Optimal layout

#### Tablet (768x1024)
- Collapsible sidebar
- Responsive cards
- Touch-friendly buttons

#### Mobile (375x667)
- Full-screen layout
- Hamburger menu
- Stacked components
- Optimized touch targets

**Test in Browser DevTools:**
1. Press F12 to open DevTools
2. Click device toolbar icon
3. Select different devices
4. Verify layout adapts

---

## 14. Performance & Loading Demo

### Metrics to Observe
1. **Page Load Time:** Should be < 3 seconds
2. **API Response Time:** < 500ms per endpoint
3. **Database Query Time:** < 100ms

### Check Performance
```bash
# Frontend performance
npm run build  # View bundle size
# Check in Network tab of DevTools

# Backend performance  
curl http://localhost:8081/actuator/metrics
```

---

## 15. Error Handling Demo

### Test Error Scenarios

#### Invalid Login
1. Try login with wrong email
2. **Expected:** "Invalid credentials" message

#### Validation Error
1. Try creating entry without waste type
2. **Expected:** "Please select waste type" error

#### Network Error
1. Stop backend server
2. Try loading statistics
3. **Expected:** "Unable to connect to server" message with retry option

#### Database Error
1. Stop database
2. Try any operation
3. **Expected:** "Server error" with error code

---

## Quick Reference: Feature Checklist

| Feature | Status | How to Test |
|---------|--------|------------|
| User Registration | ✅ | Create new account |
| User Login | ✅ | Login with credentials |
| Create Waste Entry | ✅ | Family Dashboard → Add Entry |
| View Statistics | ✅ | Statistics → View Dashboard |
| User Management | ✅ | Admin Panel → Users |
| Center Management | ✅ | Centers → View List |
| Notifications | ✅ | Bell icon in navbar |
| API Endpoints | ✅ | Use Postman/cURL |
| Docker Deployment | ✅ | docker-compose up |
| CI/CD Pipeline | ✅ | GitHub Actions |
| Responsive Design | ✅ | Test in DevTools |
| Performance | ✅ | Check metrics |
| Error Handling | ✅ | Test invalid inputs |

---

## Demo Video Script (2-3 minutes)

**Intro (15 sec):**
"Welcome to the Waste Recycling Tracker demo. This application helps families and recycling centers manage waste collection efficiently."

**Registration (20 sec):**
"First, I'll create a new account by clicking Register, entering my details, and submitting."

**Waste Entry (30 sec):**
"Now I'll log waste entries. I can select the waste type, enter quantity, and submit. Multiple entries can be tracked simultaneously."

**Statistics (25 sec):**
"The Statistics dashboard shows real-time metrics: total entries, total quantity, active families, and recycled amount. Data updates instantly as new entries are added."

**Admin Features (30 sec):**
"Administrators can manage users, view center information, and monitor the entire system. The user management panel shows all registered users and their activity."

**Technology (20 sec):**
"The backend is built with Spring Boot and Java, frontend with React and Vite, and deployed on Vercel with automated CI/CD via GitHub Actions."

**Closing (10 sec):**
"This demonstrates all key features of the Waste Recycling Tracker application. Questions?"

---

## Troubleshooting Demo Issues

| Issue | Solution |
|-------|----------|
| Backend won't start | Check port 8081 is free, Java 17 installed |
| Frontend won't load | Ensure npm dependencies installed, port 5173 free |
| Database not connecting | Start backend with correct profile, check H2 config |
| Statistics show 0 | Wait for backend to fully load, check API URL in console |
| Docker fails | Ensure Docker Desktop running, sufficient disk space |

---

**Ready to impress your evaluators!** 🚀
