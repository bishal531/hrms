-- =====================================================
-- HRMS Visitor Management System
-- PostgreSQL Database Schema
-- =====================================================

-- Drop tables if they already exist
DROP TABLE IF EXISTS pass_requests CASCADE;
DROP TABLE IF EXISTS officer CASCADE;

-- =====================================================
-- Officer Table
-- =====================================================

CREATE TABLE officer (
    officer_id SERIAL PRIMARY KEY,
    officer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(100) NOT NULL,
    designation VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- Pass Requests Table
-- =====================================================

CREATE TABLE pass_requests (
    request_id SERIAL PRIMARY KEY,

    -- Visitor Details
    visitor_name VARCHAR(100) NOT NULL,
    visitor_phone VARCHAR(15) NOT NULL,
    visitor_email VARCHAR(100),
    visitor_id_proof VARCHAR(50),

    -- Visit Information
    purpose TEXT NOT NULL,
    visit_date DATE NOT NULL,

    -- Time Slot Management
    time_from TIME NOT NULL,
    time_to TIME NOT NULL,
    slot_duration INT NOT NULL CHECK (slot_duration > 0),

    -- Officer Reference
    officer_id INT NOT NULL,

    -- Approval and Status Tracking
    status VARCHAR(20)
    CHECK (
        status IN (
            'PENDING',
            'APPROVED',
            'REJECTED',
            'CHECKED_IN',
            'CHECKED_OUT'
        )
    ) DEFAULT 'PENDING',

    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    approved_at TIMESTAMP,

    -- Check-In / Check-Out
    check_in TIMESTAMP,
    check_out TIMESTAMP,

    -- Foreign Key Constraint
    CONSTRAINT fk_officer
    FOREIGN KEY (officer_id)
    REFERENCES officer(officer_id)
    ON DELETE RESTRICT,

    -- Ensure end time is after start time
    CONSTRAINT valid_time_slot
    CHECK (time_to > time_from)
);

-- =====================================================
-- Insert Sample Officers
-- =====================================================

INSERT INTO officer (
    officer_name,
    email,
    department,
    designation,
    phone
)
VALUES
(
    'Rahul Sharma',
    'rahul@company.com',
    'HR',
    'Manager',
    '9876543210'
),
(
    'Priya Das',
    'priya@company.com',
    'IT',
    'Team Lead',
    '9876543211'
),
(
    'Subhas Choudhury',
    'subhas@company.com',
    'Administration',
    'Officer',
    '9876543212'
);

-- =====================================================
-- Insert Sample Pass Requests
-- =====================================================

INSERT INTO pass_requests (
    visitor_name,
    visitor_phone,
    visitor_email,
    visitor_id_proof,
    purpose,
    visit_date,
    time_from,
    time_to,
    slot_duration,
    officer_id
)
VALUES
(
    'Amit Kumar',
    '9123456789',
    'amit@gmail.com',
    'Aadhar',
    'Interview',
    CURRENT_DATE,
    '10:00:00',
    '10:30:00',
    30,
    1
),
(
    'Sneha Roy',
    '9234567890',
    'sneha@gmail.com',
    'PAN',
    'Project Discussion',
    CURRENT_DATE,
    '11:00:00',
    '11:30:00',
    30,
    2
),
(
    'Arkadeep Das',
    '9345678901',
    'arkadeep@gmail.com',
    'Driving License',
    'Official Meeting',
    CURRENT_DATE,
    '12:00:00',
    '12:30:00',
    30,
    3
);

-- =====================================================
-- Useful Queries
-- =====================================================

-- View all officers
SELECT * FROM officer;

-- View all pass requests
SELECT * FROM pass_requests;

-- View pending requests
SELECT *
FROM pass_requests
WHERE status = 'PENDING';

-- Approve a request
UPDATE pass_requests
SET status = 'APPROVED',
    approved_at = CURRENT_TIMESTAMP
WHERE request_id = 1;

-- Check In Visitor
UPDATE pass_requests
SET status = 'CHECKED_IN',
    check_in = CURRENT_TIMESTAMP
WHERE request_id = 1;

-- Check Out Visitor
UPDATE pass_requests
SET status = 'CHECKED_OUT',
    check_out = CURRENT_TIMESTAMP
WHERE request_id = 1;

-- Join Query
SELECT
    p.request_id,
    p.visitor_name,
    p.purpose,
    p.visit_date,
    p.time_from,
    p.time_to,
    p.status,
    o.officer_name,
    o.department,
    o.designation
FROM pass_requests p
JOIN officer o
ON p.officer_id = o.officer_id;