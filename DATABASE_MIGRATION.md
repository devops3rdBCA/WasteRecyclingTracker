# Database Migration Scripts for Waste Recycling Tracker
# Place migration files in: backend/src/main/resources/db/migration/

## Location: backend/src/main/resources/db/migration/V1__Initial_schema.sql

```sql
-- Create FAMILY_WASTE table
CREATE TABLE family_waste (
    id SERIAL PRIMARY KEY,
    family_name VARCHAR(255) NOT NULL,
    waste_type VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create USERS table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    family_name VARCHAR(255),
    role VARCHAR(50) NOT NULL DEFAULT 'FAMILY',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes
CREATE INDEX idx_family_waste_family_name ON family_waste(family_name);
CREATE INDEX idx_family_waste_status ON family_waste(status);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_role ON users(role);
```

## Location: backend/src/main/resources/db/migration/V2__Add_audit_columns.sql

```sql
-- Add audit tracking columns if not already present
ALTER TABLE family_waste 
ADD COLUMN IF NOT EXISTS modified_by VARCHAR(255),
ADD COLUMN IF NOT EXISTS created_by VARCHAR(255) DEFAULT 'system';

ALTER TABLE users 
ADD COLUMN IF NOT EXISTS last_login TIMESTAMP,
ADD COLUMN IF NOT EXISTS is_active BOOLEAN DEFAULT true;

-- Create audit log table
CREATE TABLE IF NOT EXISTS audit_log (
    id SERIAL PRIMARY KEY,
    entity_type VARCHAR(100) NOT NULL,
    entity_id INT NOT NULL,
    action VARCHAR(50) NOT NULL,
    changed_by VARCHAR(255),
    change_details TEXT,
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_audit_log_entity ON audit_log(entity_type, entity_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_changed_at ON audit_log(changed_at);
```

## Location: backend/src/main/resources/db/migration/V3__Add_notifications_table.sql

```sql
-- Create notifications table
CREATE TABLE IF NOT EXISTS notifications (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    notification_type VARCHAR(100) NOT NULL,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Create notification preferences table
CREATE TABLE IF NOT EXISTS notification_preferences (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    email_notifications BOOLEAN DEFAULT true,
    sms_notifications BOOLEAN DEFAULT false,
    push_notifications BOOLEAN DEFAULT true,
    notification_frequency VARCHAR(50) DEFAULT 'IMMEDIATE',
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE(user_id)
);

CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_created_at ON notifications(created_at);
```

## Migration Instructions

### Step 1: Enable Flyway in application-prod.properties
```properties
spring.flyway.enabled=true
spring.flyway.locations=classpath:db/migration
spring.flyway.baseline-on-migrate=true
spring.jpa.hibernate.ddl-auto=validate
```

### Step 2: Create migration files
1. Create directory: `backend/src/main/resources/db/migration/`
2. Add migration files following Flyway naming convention: `V<version>__<description>.sql`
3. Example: `V1__Initial_schema.sql`, `V2__Add_audit_columns.sql`

### Step 3: Build and run
```bash
mvn clean package -DskipTests
java -jar target/waste-recycling-tracker-backend-1.0.0.jar --spring.profiles.active=prod
```

### Step 4: Verify migrations
Check logs for: `Successfully validated X migrations`

## Migration from H2 to PostgreSQL

### Option 1: Using H2 Export
```bash
# In H2 Console, export data:
SCRIPT TO '/path/to/export.sql';
```

### Option 2: Using Hibernate
Update `application.properties` to export schema:
```properties
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.H2Dialect
spring.jpa.properties.hibernate.format_sql=true
spring.jpa.properties.hibernate.use_sql_comments=true
```

Then use DDL export tools.

### Option 3: Backup and restore
```bash
# H2 backup
java -cp h2-1.x.jar org.h2.tools.Script -url jdbc:h2:./db -user sa -script backup.sql

# PostgreSQL restore
psql -U wrt_user -d waste_recycling_db -f backup.sql
```

## Verification Checklist
- [ ] All tables created successfully
- [ ] All indexes created
- [ ] Primary keys in place
- [ ] Foreign keys configured
- [ ] Triggers working (if using)
- [ ] Sample data inserted
- [ ] Application connects to database
- [ ] Queries execute correctly
