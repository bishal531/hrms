HRMS Visitor Management System - Database Module

Overview

This project implements the PostgreSQL database schema for the Visitor Management Module of an HRMS (Human Resource Management System). The database is designed to efficiently manage visitor requests, officer approvals, appointment scheduling, and visitor tracking.

Features Implemented

- Officer Management
  
  - Stores officer details including name, email, department, designation, and contact information.

- Visitor Pass Request Management
  
  - Maintains visitor details and visit purposes.
  - Associates visitors with the respective officer.

- Appointment Scheduling
  
  - Supports visit date allocation.
  - Implements time slot management using start time, end time, and slot duration.

- Visitor Status Tracking
  
  - Tracks visitor lifecycle using statuses:
    - PENDING
    - APPROVED
    - REJECTED
    - CHECKED_IN
    - CHECKED_OUT

- Database Integrity
  
  - Primary Key and Foreign Key constraints.
  - Status validation using CHECK constraints.
  - Time slot validation rules.
  - Automatic timestamp generation for records.

Technologies Used

- PostgreSQL 18
- pgAdmin 4
- Git
- GitHub

Author

Bishal Debnath

