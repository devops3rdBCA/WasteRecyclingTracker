# Database initialization script for PostgreSQL
# This script is automatically executed when the postgres container starts

-- Create extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create FAMILY_WASTE table
CREATE TABLE IF NOT EXISTS family_waste (
    id SERIAL PRIMARY KEY,
    family_name VARCHAR(255) NOT NULL,
    waste_type VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create USERS table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    family_name VARCHAR(255),
    role VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_family_waste_family_name ON family_waste(family_name);
CREATE INDEX IF NOT EXISTS idx_family_waste_status ON family_waste(status);
CREATE INDEX IF NOT EXISTS idx_family_waste_created_at ON family_waste(created_at);
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

-- Insert default admin user (password: admin123)
INSERT INTO users (username, family_name, role)
VALUES ('admin', 'Admin Family', 'ADMIN')
ON CONFLICT (username) DO NOTHING;

-- Insert sample families
INSERT INTO users (username, family_name, role)
VALUES 
    ('family1', 'Green Family', 'FAMILY'),
    ('family2', 'Eco Warriors', 'FAMILY'),
    ('center1', 'Central Recycling Center', 'CENTER'),
    ('center2', 'East Side Recycling', 'CENTER')
ON CONFLICT (username) DO NOTHING;

-- Create function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers to automatically update updated_at
DROP TRIGGER IF EXISTS update_family_waste_updated_at ON family_waste;
CREATE TRIGGER update_family_waste_updated_at BEFORE UPDATE
    ON family_waste FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_users_updated_at ON users;
CREATE TRIGGER update_users_updated_at BEFORE UPDATE
    ON users FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Insert sample waste data for testing
INSERT INTO family_waste (family_name, waste_type, quantity, status)
VALUES 
    ('Green Family', 'Plastic', 5, 'PENDING'),
    ('Green Family', 'Glass', 3, 'PROCESSING'),
    ('Eco Warriors', 'Metal', 2, 'RECYCLED'),
    ('Eco Warriors', 'Paper', 8, 'PENDING')
ON CONFLICT DO NOTHING;
