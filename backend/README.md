# Waste Recycling Tracker - Spring Boot Backend

A Spring Boot backend application for managing waste recycling tracking with family submissions and center operations.

## Project Structure

```
src/main/java/com/wasterecyclingtracker/
├── WasteRecyclingTrackerApplication.java (Main Spring Boot Application)
├── config/
│   └── SecurityConfig.java (Security & CORS Configuration)
├── controller/
│   ├── FamilyController.java (Family Waste Endpoints)
│   └── CenterController.java (Center Management Endpoints)
├── service/
│   ├── FamilyWasteService.java (Family Waste Operations)
│   └── CenterService.java (Center Operations)
├── repository/
│   ├── FamilyWasteRepository.java (JPA Repository for Waste)
│   └── UserRepository.java (JPA Repository for Users)
└── entity/
    ├── FamilyWaste.java (Waste Entity)
    └── User.java (User Entity)
```

## Features

- **H2 In-Memory Database** with JPA/Hibernate ORM
- **Family Waste Management**: Create, read, update, delete waste entries
- **Center Operations**: View all entries, update status, delete recycled entries
- **Role-Based Access**: FAMILY and CENTER user roles
- **CORS Enabled** for React frontend on localhost:5173
- **RESTful API** with proper error handling

## Prerequisites

- Java 17 or higher
- Maven 3.6+
- Spring Boot 3.2.0

## Installation

1. **Navigate to the backend directory:**
   ```bash
   cd backend
   ```

2. **Install dependencies:**
   ```bash
   mvn clean install
   ```

3. **Run the application:**
   ```bash
   mvn spring-boot:run
   ```

The server will start on **http://localhost:8080**

## API Endpoints

### Family Controller (`/api/family`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/family` | Add a new waste entry |
| GET | `/api/family/{familyName}` | Get all entries for a family |
| GET | `/api/family/entry/{id}` | Get a specific waste entry |
| PUT | `/api/family/{id}` | Update a waste entry |
| DELETE | `/api/family/{id}` | Delete a waste entry |
| GET | `/api/family/status/{status}` | Get entries by status |

### Center Controller (`/api/center`)

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/center` | Get all waste entries |
| GET | `/api/center/status/{status}` | Get entries by status |
| GET | `/api/center/family/{familyName}` | Get entries for a family |
| PUT | `/api/center/{id}` | Update entry status |
| DELETE | `/api/center/{id}` | Delete recycled entry |

## Database Schema

### FamilyWaste Table
```sql
CREATE TABLE family_waste (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    family_name VARCHAR(255) NOT NULL,
    waste_type VARCHAR(255) NOT NULL,
    quantity DOUBLE NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at BIGINT
);
```

### Users Table
```sql
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(50) NOT NULL
);
```

## Waste Status Values

- `PENDING` - Waste entry awaiting processing
- `PROCESSING` - Waste is currently being processed
- `RECYCLED` - Waste has been successfully recycled

## H2 Console

Access the H2 database console at:
```
http://localhost:8080/h2-console
```

**Default Credentials:**
- JDBC URL: `jdbc:h2:mem:testdb`
- Username: `sa`
- Password: (empty)

## Example Requests

### Add a Waste Entry
```bash
curl -X POST http://localhost:8080/api/family \
  -H "Content-Type: application/json" \
  -d '{
    "familyName": "Smith Family",
    "wasteType": "Plastic",
    "quantity": 5.5
  }'
```

### Update Entry Status (Center)
```bash
curl -X PUT http://localhost:8080/api/center/1 \
  -H "Content-Type: application/json" \
  -d '{
    "status": "PROCESSING"
  }'
```

### Get All Entries
```bash
curl http://localhost:8080/api/center
```

## Configuration

Edit `src/main/resources/application.properties` to modify:
- Database URL
- JPA auto-update strategy
- Server port
- Logging levels

## Frontend Integration

This backend is configured to work with the React frontend running on `http://localhost:5173`. CORS is enabled for seamless API communication.

## Development

For development with hot reload:
```bash
mvn spring-boot:run -Dspring-boot.run.fork=false
```

## Notes

- The database is in-memory (H2) and resets on each restart
- Security is simplified (permissive) for development
- Role-based authentication can be enhanced with JWT tokens
- Password storage should use proper encryption (BCrypt) in production
