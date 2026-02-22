-- ============================================================================
-- Lab 03 Standalone SQL Setup - Pages and Page Designer (Vodacom)
-- ============================================================================
-- PURPOSE: Self-contained alternative to setup-sample-data-vodacom.sql
-- Run this script ONLY if you have NOT already run the main setup script.
-- This creates only the tables and data needed for Lab 03.
--
-- TABLES CREATED: vodacom_departments, vodacom_employees,
--                 vodacom_network_towers, vodacom_network_issues
-- SEQUENCE: vodacom_issue_seq
-- RUN METHOD: SQL Workshop > SQL Scripts > Upload > Run
-- ============================================================================

-- ============================================================================
-- CLEANUP: Drop existing objects safely
-- ============================================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_network_issues CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_network_towers CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_employees CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_departments CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_issue_seq'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -2289 THEN RAISE; END IF; END;
/

-- ============================================================================
-- CREATE TABLES
-- ============================================================================

CREATE TABLE vodacom_departments (
    dept_id           NUMBER PRIMARY KEY,
    dept_name         VARCHAR2(100) NOT NULL UNIQUE,
    dept_code         VARCHAR2(20) NOT NULL UNIQUE,
    manager_id        NUMBER,
    budget            NUMBER(14,2),
    location          VARCHAR2(100),
    cost_center       VARCHAR2(50),
    is_active         VARCHAR2(1) DEFAULT 'Y' CHECK (is_active IN ('Y','N')),
    created_date      DATE DEFAULT SYSDATE,
    created_by        VARCHAR2(100) DEFAULT USER,
    modified_date     DATE,
    modified_by       VARCHAR2(100)
);

CREATE TABLE vodacom_employees (
    emp_id            NUMBER PRIMARY KEY,
    first_name        VARCHAR2(50) NOT NULL,
    last_name         VARCHAR2(50) NOT NULL,
    email             VARCHAR2(100) NOT NULL UNIQUE,
    phone             VARCHAR2(20) NOT NULL,
    mobile_number     VARCHAR2(20),
    hire_date         DATE NOT NULL,
    dept_id           NUMBER NOT NULL,
    job_title         VARCHAR2(100) NOT NULL,
    manager_id        NUMBER,
    salary            NUMBER(10,2),
    employee_type     VARCHAR2(20) DEFAULT 'Permanent',
    status            VARCHAR2(20) DEFAULT 'Active',
    employee_number   VARCHAR2(20) NOT NULL UNIQUE,
    branch_code       VARCHAR2(20),
    commission_rate   NUMBER(5,2),
    created_date      DATE DEFAULT SYSDATE
);

CREATE TABLE vodacom_network_towers (
    tower_id          NUMBER PRIMARY KEY,
    tower_code        VARCHAR2(20) NOT NULL UNIQUE,
    tower_name        VARCHAR2(100) NOT NULL,
    latitude          NUMBER(10,7),
    longitude         NUMBER(10,7),
    province          VARCHAR2(50) NOT NULL,
    city              VARCHAR2(100),
    address           VARCHAR2(200),
    tower_type        VARCHAR2(30),
    capacity          NUMBER(6,0),
    status            VARCHAR2(20) DEFAULT 'Operational',
    installation_date DATE,
    last_maintenance  DATE,
    next_maintenance  DATE,
    owner_type        VARCHAR2(20),
    monthly_cost      NUMBER(10,2),
    created_date      DATE DEFAULT SYSDATE
);

CREATE TABLE vodacom_network_issues (
    issue_id          NUMBER PRIMARY KEY,
    issue_ref         VARCHAR2(30) NOT NULL UNIQUE,
    tower_id          NUMBER,
    issue_type        VARCHAR2(30) NOT NULL,
    severity          VARCHAR2(20) DEFAULT 'Medium',
    description       VARCHAR2(1000) NOT NULL,
    province          VARCHAR2(50),
    city              VARCHAR2(100),
    affected_customers NUMBER(10,0),
    reported_date     TIMESTAMP DEFAULT SYSTIMESTAMP,
    acknowledged_date TIMESTAMP,
    resolved_date     TIMESTAMP,
    status            VARCHAR2(20) DEFAULT 'Open',
    assigned_to       NUMBER,
    resolution_notes  VARCHAR2(1000),
    created_date      DATE DEFAULT SYSDATE
);

-- ============================================================================
-- INSERT DATA
-- ============================================================================

-- Departments (only Network Ops needed, but include Customer Service for completeness)
INSERT INTO vodacom_departments (dept_id, dept_name, dept_code, budget, location, cost_center) VALUES (1, 'Customer Service', 'CS', 15000000, 'Midrand', 'CC-CS-001');
INSERT INTO vodacom_departments (dept_id, dept_name, dept_code, budget, location, cost_center) VALUES (2, 'Network Operations', 'NO', 50000000, 'Midrand', 'CC-NO-001');
COMMIT;

-- Employees (Network Operations team - referenced by network_issues.assigned_to)
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (6, 'Mandla', 'Zulu', 'mandla.zulu@vodacom.co.za', '0834567890', DATE '2015-06-01', 2, 'Network Operations Director', 120000, 'Permanent', 'VDC002001', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (7, 'Thandi', 'Ngwenya', 'thandi.ngwenya@vodacom.co.za', '0721234567', DATE '2017-09-12', 2, 'Senior Network Engineer', 85000, 'Permanent', 'VDC002002', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (8, 'Bongani', 'Mthembu', 'bongani.mthembu@vodacom.co.za', '0789012345', DATE '2019-03-20', 2, 'Network Technician', 45000, 'Permanent', 'VDC002003', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (9, 'Nonhlanhla', 'Sithole', 'nonhlanhla.sithole@vodacom.co.za', '0736789012', DATE '2020-08-15', 2, 'Network Support Specialist', 40000, 'Permanent', 'VDC002004', 'MDR-001');
UPDATE vodacom_employees SET manager_id = 6 WHERE emp_id IN (7, 8, 9);
UPDATE vodacom_departments SET manager_id = 6 WHERE dept_id = 2;
COMMIT;

-- Network Towers (12 towers across South Africa)
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (1, 'JHB-T001', 'Sandton City Tower', -26.107730, 28.056305, 'Gauteng', 'Johannesburg', '5G', 5000, DATE '2022-03-15', 85000, 'Vodacom');
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (2, 'JHB-T002', 'Rosebank Mall Tower', -26.147780, 28.040650, 'Gauteng', 'Johannesburg', 'Hybrid', 4500, DATE '2021-08-20', 75000, 'Vodacom');
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (3, 'CPT-T001', 'V&A Waterfront Tower', -33.904500, 18.419180, 'Western Cape', 'Cape Town', '5G', 5500, DATE '2022-06-10', 90000, 'Vodacom');
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (4, 'CPT-T002', 'Century City Tower', -33.892890, 18.508890, 'Western Cape', 'Cape Town', 'Hybrid', 4000, DATE '2021-05-15', 70000, 'Leased');
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (5, 'DBN-T001', 'Umhlanga Rocks Tower', -29.729550, 31.082300, 'KwaZulu-Natal', 'Durban', '5G', 4800, DATE '2022-09-05', 82000, 'Vodacom');
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (6, 'DBN-T002', 'Gateway Mall Tower', -29.763330, 31.048890, 'KwaZulu-Natal', 'Durban', 'Hybrid', 4200, DATE '2021-11-20', 72000, 'Shared');
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (7, 'PTA-T001', 'Menlyn Tower', -25.781670, 28.276390, 'Gauteng', 'Pretoria', '5G', 4600, DATE '2022-04-12', 80000, 'Vodacom');
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (8, 'PTA-T002', 'Hatfield Plaza Tower', -25.749170, 28.238610, 'Gauteng', 'Pretoria', 'Hybrid', 3800, DATE '2021-07-08', 68000, 'Leased');
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (9, 'BFN-T001', 'Bloemfontein Central', -29.121110, 26.214440, 'Free State', 'Bloemfontein', '4G', 3500, DATE '2020-10-15', 55000, 'Vodacom');
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (10, 'PLK-T001', 'Polokwane Mall Tower', -23.905000, 29.458330, 'Limpopo', 'Polokwane', '4G', 3200, DATE '2020-12-01', 52000, 'Shared');
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (11, 'ELS-T001', 'East London Beachfront', -33.015000, 27.911670, 'Eastern Cape', 'East London', '4G', 3000, DATE '2021-02-18', 50000, 'Leased');
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type) VALUES (12, 'NPT-T001', 'Nelspruit City Tower', -25.474440, 30.970000, 'Mpumalanga', 'Nelspruit', '4G', 2800, DATE '2021-04-22', 48000, 'Vodacom');
COMMIT;

-- Network Issues (10 incidents for good report data)
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status) VALUES (1, 'INC-2024-001', 1, 'Maintenance', 'Low', 'Scheduled upgrade to 5G equipment', 'Gauteng', 'Johannesburg', 0, TIMESTAMP '2024-02-15 02:00:00', 'Resolved');
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to) VALUES (2, 'INC-2024-002', 5, 'Outage', 'Critical', 'Complete tower failure - power supply issue', 'KwaZulu-Natal', 'Durban', 4800, TIMESTAMP '2024-02-10 14:30:00', 'Resolved', 7);
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to) VALUES (3, 'INC-2024-003', 3, 'Degraded Service', 'High', 'Intermittent connectivity - investigating hardware', 'Western Cape', 'Cape Town', 2500, TIMESTAMP '2024-02-18 09:15:00', 'In Progress', 8);
INSERT INTO vodacom_network_issues (issue_id, issue_ref, issue_type, severity, description, province, city, affected_customers, reported_date, status) VALUES (4, 'INC-2024-004', 'Weather Damage', 'Medium', 'Lightning damage to fiber connection', 'Free State', 'Bloemfontein', 1200, TIMESTAMP '2024-02-12 18:45:00', 'Resolved');
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to) VALUES (5, 'INC-2024-005', 7, 'Vandalism', 'High', 'Cable theft affecting tower connectivity', 'Gauteng', 'Pretoria', 3200, TIMESTAMP '2024-02-20 06:30:00', 'Acknowledged', 6);
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to) VALUES (6, 'INC-2024-006', 2, 'Hardware Failure', 'High', 'Antenna malfunction on sector 3', 'Gauteng', 'Johannesburg', 1800, TIMESTAMP '2024-03-01 08:00:00', 'Open', 7);
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to) VALUES (7, 'INC-2024-007', 8, 'Power Failure', 'Critical', 'Generator failure during load-shedding', 'Gauteng', 'Pretoria', 3800, TIMESTAMP '2024-03-05 18:30:00', 'In Progress', 9);
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status) VALUES (8, 'INC-2024-008', 10, 'Degraded Service', 'Medium', 'Reduced throughput on 4G band', 'Limpopo', 'Polokwane', 900, TIMESTAMP '2024-03-08 11:15:00', 'Acknowledged');
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to) VALUES (9, 'INC-2024-009', 4, 'Maintenance', 'Low', 'Scheduled battery replacement', 'Western Cape', 'Cape Town', 0, TIMESTAMP '2024-03-10 06:00:00', 'Resolved', 8);
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to) VALUES (10, 'INC-2024-010', 12, 'Outage', 'High', 'Fiber cut near tower site', 'Mpumalanga', 'Nelspruit', 2800, TIMESTAMP '2024-03-12 14:45:00', 'Open', 8);
COMMIT;

-- ============================================================================
-- FOREIGN KEYS AND INDEXES
-- ============================================================================
ALTER TABLE vodacom_employees ADD CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES vodacom_departments(dept_id);
ALTER TABLE vodacom_network_issues ADD CONSTRAINT fk_issue_tower FOREIGN KEY (tower_id) REFERENCES vodacom_network_towers(tower_id);
ALTER TABLE vodacom_network_issues ADD CONSTRAINT fk_issue_emp FOREIGN KEY (assigned_to) REFERENCES vodacom_employees(emp_id);

CREATE INDEX idx_issue_status ON vodacom_network_issues(status);
CREATE INDEX idx_issue_severity ON vodacom_network_issues(severity);
CREATE INDEX idx_issue_tower ON vodacom_network_issues(tower_id);
CREATE INDEX idx_tower_status ON vodacom_network_towers(status);
CREATE INDEX idx_tower_province ON vodacom_network_towers(province);

-- ============================================================================
-- SEQUENCE (used in Lab 03 PL/SQL computation for issue reference numbers)
-- ============================================================================
CREATE SEQUENCE vodacom_issue_seq START WITH 100 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ============================================================================
-- VERIFICATION
-- ============================================================================
DECLARE
    v_count NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Lab 03 Setup Verification');
    DBMS_OUTPUT.PUT_LINE('============================================');
    SELECT COUNT(*) INTO v_count FROM vodacom_departments;
    DBMS_OUTPUT.PUT_LINE('vodacom_departments:    ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_employees;
    DBMS_OUTPUT.PUT_LINE('vodacom_employees:      ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_network_towers;
    DBMS_OUTPUT.PUT_LINE('vodacom_network_towers: ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_network_issues;
    DBMS_OUTPUT.PUT_LINE('vodacom_network_issues: ' || v_count || ' rows');
    DBMS_OUTPUT.PUT_LINE('vodacom_issue_seq:      CREATED');
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Lab 03 setup complete!');
    DBMS_OUTPUT.PUT_LINE('============================================');
END;
/
