-- ============================================
-- Waste Recycling Tracker Database Setup
-- ============================================

-- Drop existing tables if they exist
DROP TABLE IF EXISTS FAMILY_WASTE CASCADE;
DROP TABLE IF EXISTS USERS CASCADE;

-- ============================================
-- Users Table
-- ============================================
CREATE TABLE USERS (
    ID BIGINT PRIMARY KEY AUTO_INCREMENT,
    USERNAME VARCHAR(255) NOT NULL UNIQUE,
    PASSWORD VARCHAR(255) NOT NULL,
    ROLE VARCHAR(50) NOT NULL CHECK (ROLE IN ('FAMILY', 'CENTER'))
);

-- ============================================
-- Family Waste Table
-- ============================================
CREATE TABLE FAMILY_WASTE (
    ID BIGINT PRIMARY KEY AUTO_INCREMENT,
    FAMILY_NAME VARCHAR(255) NOT NULL,
    WASTE_TYPE VARCHAR(255) NOT NULL,
    QUANTITY DOUBLE NOT NULL,
    STATUS VARCHAR(50) NOT NULL DEFAULT 'PENDING' 
        CHECK (STATUS IN ('PENDING', 'PROCESSING', 'RECYCLED')),
    CREATED_AT BIGINT NOT NULL
);

-- ============================================
-- Insert Sample Users
-- ============================================

-- Family User (password: family123)
INSERT INTO USERS (USERNAME, PASSWORD, ROLE) 
VALUES ('family_user', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36gZvWFm', 'FAMILY');

-- Center User (password: center123)
INSERT INTO USERS (USERNAME, PASSWORD, ROLE) 
VALUES ('center_admin', '$2a$10$slYQmyNdGzin7olVZeVaeuK1kDG.mHmCrDx8w9E.8XltsuWabnaHm', 'CENTER');

-- Family User 2
INSERT INTO USERS (USERNAME, PASSWORD, ROLE) 
VALUES ('smith_family', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36gZvWFm', 'FAMILY');

-- Center User 2
INSERT INTO USERS (USERNAME, PASSWORD, ROLE) 
VALUES ('recycling_center_02', '$2a$10$slYQmyNdGzin7olVZeVaeuK1kDG.mHmCrDx8w9E.8XltsuWabnaHm', 'CENTER');

-- ============================================
-- Insert Sample Waste Data
-- ============================================

-- Pending Waste Entries
INSERT INTO FAMILY_WASTE (FAMILY_NAME, WASTE_TYPE, QUANTITY, STATUS, CREATED_AT) 
VALUES ('Sharma Family', 'PLASTIC', 5.5, 'PENDING', UNIX_TIMESTAMP() * 1000);

INSERT INTO FAMILY_WASTE (FAMILY_NAME, WASTE_TYPE, QUANTITY, STATUS, CREATED_AT) 
VALUES ('Patel Family', 'GLASS', 3.2, 'PENDING', UNIX_TIMESTAMP() * 1000);

INSERT INTO FAMILY_WASTE (FAMILY_NAME, WASTE_TYPE, QUANTITY, STATUS, CREATED_AT) 
VALUES ('Kumar Family', 'PAPER', 7.8, 'PENDING', UNIX_TIMESTAMP() * 1000);

-- Processing Waste Entries
INSERT INTO FAMILY_WASTE (FAMILY_NAME, WASTE_TYPE, QUANTITY, STATUS, CREATED_AT) 
VALUES ('Gupta Family', 'METAL', 2.4, 'PROCESSING', UNIX_TIMESTAMP() * 1000);

INSERT INTO FAMILY_WASTE (FAMILY_NAME, WASTE_TYPE, QUANTITY, STATUS, CREATED_AT) 
VALUES ('Singh Family', 'PLASTIC', 4.1, 'PROCESSING', UNIX_TIMESTAMP() * 1000);

-- Recycled Waste Entries
INSERT INTO FAMILY_WASTE (FAMILY_NAME, WASTE_TYPE, QUANTITY, STATUS, CREATED_AT) 
VALUES ('Joshi Family', 'GLASS', 6.3, 'RECYCLED', UNIX_TIMESTAMP() * 1000);

INSERT INTO FAMILY_WASTE (FAMILY_NAME, WASTE_TYPE, QUANTITY, STATUS, CREATED_AT) 
VALUES ('Verma Family', 'PAPER', 9.5, 'RECYCLED', UNIX_TIMESTAMP() * 1000);

INSERT INTO FAMILY_WASTE (FAMILY_NAME, WASTE_TYPE, QUANTITY, STATUS, CREATED_AT) 
VALUES ('Reddy Family', 'METAL', 8.2, 'RECYCLED', UNIX_TIMESTAMP() * 1000);

-- ============================================
-- Useful Queries
-- ============================================

-- View all users
-- SELECT * FROM USERS;

-- View all waste entries
-- SELECT * FROM FAMILY_WASTE ORDER BY CREATED_AT DESC;

-- Count waste by status
-- SELECT STATUS, COUNT(*) as COUNT FROM FAMILY_WASTE GROUP BY STATUS;

-- Total waste quantity by type
-- SELECT WASTE_TYPE, SUM(QUANTITY) as TOTAL_QUANTITY FROM FAMILY_WASTE GROUP BY WASTE_TYPE;

-- Pending waste entries
-- SELECT * FROM FAMILY_WASTE WHERE STATUS = 'PENDING';

-- Recycled waste summary
-- SELECT FAMILY_NAME, WASTE_TYPE, QUANTITY FROM FAMILY_WASTE WHERE STATUS = 'RECYCLED';
