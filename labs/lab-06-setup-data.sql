-- ============================================================================
-- Lab 06 Standalone SQL Setup - Security and Performance (Vodacom)
-- ============================================================================
-- PURPOSE: Self-contained alternative to running setup-sample-data-vodacom.sql
-- AND vodacom-complete-lab-setup.sql. Includes ALL tables needed for Lab 06.
-- Run this script ONLY if you have NOT already run the main setup scripts.
--
-- TABLES: All Lab 05 tables + vodacom_network_towers (with assigned_tech),
--         vodacom_network_issues, vodacom_sales, vodacom_customer_assignments,
--         vodacom_audit_log, vodacom_issue_seq, packages.category
-- RUN METHOD: SQL Workshop > SQL Scripts > Upload > Run
-- ============================================================================

-- ============================================================================
-- CLEANUP
-- ============================================================================
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_audit_log CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_customer_assignments CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_sa_suburbs CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_sa_cities CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_sa_provinces CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_network_issues CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_network_towers CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_sales CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_invoice_items CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_invoices CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_vodapay_accounts CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_customer_support CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_transactions CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_mobile_numbers CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_packages CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
/
BEGIN EXECUTE IMMEDIATE 'DROP TABLE vodacom_customers CASCADE CONSTRAINTS PURGE'; EXCEPTION WHEN OTHERS THEN IF SQLCODE != -942 THEN RAISE; END IF; END;
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

-- Base tables (same as Lab 04/05)
CREATE TABLE vodacom_departments (dept_id NUMBER PRIMARY KEY, dept_name VARCHAR2(100) NOT NULL UNIQUE, dept_code VARCHAR2(20) NOT NULL UNIQUE, manager_id NUMBER, budget NUMBER(14,2), location VARCHAR2(100), cost_center VARCHAR2(50), is_active VARCHAR2(1) DEFAULT 'Y', created_date DATE DEFAULT SYSDATE, created_by VARCHAR2(100) DEFAULT USER, modified_date DATE, modified_by VARCHAR2(100));

CREATE TABLE vodacom_employees (emp_id NUMBER PRIMARY KEY, first_name VARCHAR2(50) NOT NULL, last_name VARCHAR2(50) NOT NULL, email VARCHAR2(100) NOT NULL UNIQUE, phone VARCHAR2(20) NOT NULL, mobile_number VARCHAR2(20), hire_date DATE NOT NULL, dept_id NUMBER NOT NULL, job_title VARCHAR2(100) NOT NULL, manager_id NUMBER, salary NUMBER(10,2), employee_type VARCHAR2(20) DEFAULT 'Permanent', status VARCHAR2(20) DEFAULT 'Active', employee_number VARCHAR2(20) NOT NULL UNIQUE, branch_code VARCHAR2(20), commission_rate NUMBER(5,2), created_date DATE DEFAULT SYSDATE);

CREATE TABLE vodacom_customers (customer_id NUMBER PRIMARY KEY, account_number VARCHAR2(20) NOT NULL UNIQUE, first_name VARCHAR2(50) NOT NULL, last_name VARCHAR2(50) NOT NULL, id_number VARCHAR2(20) NOT NULL UNIQUE, email VARCHAR2(100), phone VARCHAR2(20) NOT NULL, alternate_phone VARCHAR2(20), address_line1 VARCHAR2(200), address_line2 VARCHAR2(200), city VARCHAR2(100), province VARCHAR2(50), postal_code VARCHAR2(10), customer_type VARCHAR2(20) DEFAULT 'Individual', account_status VARCHAR2(20) DEFAULT 'Active', credit_limit NUMBER(10,2) DEFAULT 0, registration_date DATE DEFAULT SYSDATE, last_updated DATE, assigned_agent_id NUMBER, vodapay_active VARCHAR2(1) DEFAULT 'N', created_date DATE DEFAULT SYSDATE);

CREATE TABLE vodacom_mobile_numbers (number_id NUMBER PRIMARY KEY, mobile_number VARCHAR2(20) NOT NULL UNIQUE, customer_id NUMBER NOT NULL, number_type VARCHAR2(20) DEFAULT 'Prepaid', sim_card_number VARCHAR2(50) UNIQUE, activation_date DATE NOT NULL, expiry_date DATE, status VARCHAR2(20) DEFAULT 'Active', current_package VARCHAR2(100), monthly_fee NUMBER(8,2) DEFAULT 0, data_balance_mb NUMBER(10,2) DEFAULT 0, airtime_balance NUMBER(8,2) DEFAULT 0, sms_balance NUMBER(6,0) DEFAULT 0, last_recharge_date DATE, last_usage_date DATE, created_date DATE DEFAULT SYSDATE);

-- Packages table WITH category column (Lab 06 specific)
CREATE TABLE vodacom_packages (package_id NUMBER PRIMARY KEY, package_code VARCHAR2(20) NOT NULL UNIQUE, package_name VARCHAR2(100) NOT NULL, description VARCHAR2(500), package_type VARCHAR2(30) NOT NULL, data_allocation_mb NUMBER(10,2), voice_minutes NUMBER(6,0), sms_count NUMBER(6,0), price NUMBER(8,2) NOT NULL, validity_days NUMBER(4,0), is_active VARCHAR2(1) DEFAULT 'Y', is_promotional VARCHAR2(1) DEFAULT 'N', promo_price NUMBER(8,2), promo_start_date DATE, promo_end_date DATE, category VARCHAR2(50), created_date DATE DEFAULT SYSDATE);

CREATE TABLE vodacom_transactions (transaction_id NUMBER PRIMARY KEY, transaction_ref VARCHAR2(30) NOT NULL UNIQUE, customer_id NUMBER NOT NULL, mobile_number VARCHAR2(20), transaction_type VARCHAR2(30) NOT NULL, amount NUMBER(10,2) NOT NULL, payment_method VARCHAR2(30) NOT NULL, package_id NUMBER, transaction_date TIMESTAMP DEFAULT SYSTIMESTAMP, status VARCHAR2(20) DEFAULT 'Completed', processed_by NUMBER, channel VARCHAR2(30), notes VARCHAR2(500), created_date DATE DEFAULT SYSDATE);

CREATE TABLE vodacom_customer_support (ticket_id NUMBER PRIMARY KEY, ticket_number VARCHAR2(30) NOT NULL UNIQUE, customer_id NUMBER NOT NULL, mobile_number VARCHAR2(20), issue_category VARCHAR2(50) NOT NULL, issue_type VARCHAR2(100) NOT NULL, description VARCHAR2(2000) NOT NULL, priority VARCHAR2(20) DEFAULT 'Normal', status VARCHAR2(20) DEFAULT 'Open', channel VARCHAR2(30), created_date TIMESTAMP DEFAULT SYSTIMESTAMP, assigned_to NUMBER, assigned_date TIMESTAMP, resolved_date TIMESTAMP, closed_date TIMESTAMP, resolution VARCHAR2(2000), customer_satisfaction NUMBER(1,0));

CREATE TABLE vodacom_vodapay_accounts (vodapay_id NUMBER PRIMARY KEY, customer_id NUMBER NOT NULL UNIQUE, wallet_number VARCHAR2(20) NOT NULL UNIQUE, linked_mobile VARCHAR2(20) NOT NULL, balance NUMBER(10,2) DEFAULT 0, daily_limit NUMBER(10,2) DEFAULT 5000, monthly_limit NUMBER(10,2) DEFAULT 50000, status VARCHAR2(20) DEFAULT 'Active', kyc_verified VARCHAR2(1) DEFAULT 'N', activation_date DATE, last_transaction DATE, total_spent NUMBER(12,2) DEFAULT 0, total_received NUMBER(12,2) DEFAULT 0, created_date DATE DEFAULT SYSDATE);

CREATE TABLE vodacom_invoices (invoice_id NUMBER PRIMARY KEY, invoice_number VARCHAR2(30) NOT NULL UNIQUE, customer_id NUMBER NOT NULL, mobile_number VARCHAR2(20), invoice_date DATE NOT NULL, due_date DATE NOT NULL, billing_period VARCHAR2(50) NOT NULL, subtotal NUMBER(10,2) NOT NULL, vat_amount NUMBER(10,2) NOT NULL, total_amount NUMBER(10,2) NOT NULL, amount_paid NUMBER(10,2) DEFAULT 0, balance NUMBER(10,2), status VARCHAR2(20) DEFAULT 'Issued', payment_date DATE, generated_by NUMBER, notes VARCHAR2(500), created_date DATE DEFAULT SYSDATE);

CREATE TABLE vodacom_invoice_items (item_id NUMBER PRIMARY KEY, invoice_id NUMBER NOT NULL, item_type VARCHAR2(50) NOT NULL, description VARCHAR2(200) NOT NULL, quantity NUMBER(10,2), unit_price NUMBER(10,2), amount NUMBER(10,2) NOT NULL, created_date DATE DEFAULT SYSDATE);

-- Network towers WITH assigned_tech column (Lab 06 VPD)
CREATE TABLE vodacom_network_towers (tower_id NUMBER PRIMARY KEY, tower_code VARCHAR2(20) NOT NULL UNIQUE, tower_name VARCHAR2(100) NOT NULL, latitude NUMBER(10,7), longitude NUMBER(10,7), province VARCHAR2(50) NOT NULL, city VARCHAR2(100), address VARCHAR2(200), tower_type VARCHAR2(30), capacity NUMBER(6,0), status VARCHAR2(20) DEFAULT 'Operational', installation_date DATE, last_maintenance DATE, next_maintenance DATE, owner_type VARCHAR2(20), monthly_cost NUMBER(10,2), assigned_tech NUMBER, created_date DATE DEFAULT SYSDATE);

CREATE TABLE vodacom_network_issues (issue_id NUMBER PRIMARY KEY, issue_ref VARCHAR2(30) NOT NULL UNIQUE, tower_id NUMBER, issue_type VARCHAR2(30) NOT NULL, severity VARCHAR2(20) DEFAULT 'Medium', description VARCHAR2(1000) NOT NULL, province VARCHAR2(50), city VARCHAR2(100), affected_customers NUMBER(10,0), reported_date TIMESTAMP DEFAULT SYSTIMESTAMP, acknowledged_date TIMESTAMP, resolved_date TIMESTAMP, status VARCHAR2(20) DEFAULT 'Open', assigned_to NUMBER, resolution_notes VARCHAR2(1000), created_date DATE DEFAULT SYSDATE);

-- Sales table
CREATE TABLE vodacom_sales (sale_id NUMBER PRIMARY KEY, sale_ref VARCHAR2(30) NOT NULL UNIQUE, customer_id NUMBER NOT NULL, sale_date DATE NOT NULL, sale_type VARCHAR2(30) NOT NULL, product_name VARCHAR2(200) NOT NULL, quantity NUMBER(4,0) DEFAULT 1, unit_price NUMBER(10,2) NOT NULL, discount_percent NUMBER(5,2) DEFAULT 0, discount_amount NUMBER(10,2) DEFAULT 0, total_amount NUMBER(10,2) NOT NULL, payment_method VARCHAR2(30), sales_agent_id NUMBER NOT NULL, commission_amount NUMBER(10,2), branch_code VARCHAR2(20), notes VARCHAR2(500), created_date DATE DEFAULT SYSDATE);

-- SA Address Lookup Tables (from Lab 05)
CREATE TABLE vodacom_sa_provinces (province_id NUMBER PRIMARY KEY, province_code VARCHAR2(5) NOT NULL UNIQUE, province_name VARCHAR2(100) NOT NULL);
CREATE TABLE vodacom_sa_cities (city_id NUMBER PRIMARY KEY, city_name VARCHAR2(100) NOT NULL, province_id NUMBER NOT NULL, CONSTRAINT fk_city_province FOREIGN KEY (province_id) REFERENCES vodacom_sa_provinces(province_id));
CREATE TABLE vodacom_sa_suburbs (suburb_id NUMBER PRIMARY KEY, suburb_name VARCHAR2(100) NOT NULL, postal_code VARCHAR2(10), city_id NUMBER NOT NULL, CONSTRAINT fk_suburb_city FOREIGN KEY (city_id) REFERENCES vodacom_sa_cities(city_id));

-- Lab 06 specific: Customer-Agent Assignment table (for VPD policy)
CREATE TABLE vodacom_customer_assignments (assignment_id NUMBER PRIMARY KEY, customer_id NUMBER NOT NULL, agent_emp_id NUMBER NOT NULL, assignment_date DATE DEFAULT SYSDATE, assignment_status VARCHAR2(20) DEFAULT 'Active' CHECK (assignment_status IN ('Active','Inactive','Transferred')), created_date DATE DEFAULT SYSDATE);

-- Lab 06 specific: POPIA Audit Log table (empty - populated by application)
CREATE TABLE vodacom_audit_log (audit_id NUMBER PRIMARY KEY, audit_timestamp TIMESTAMP DEFAULT SYSTIMESTAMP, app_user VARCHAR2(100), action_type VARCHAR2(50), table_name VARCHAR2(100), record_id NUMBER, old_values CLOB, new_values CLOB, ip_address VARCHAR2(50), session_id VARCHAR2(100));

-- Lab 06 specific: Issue sequence for generating issue reference numbers
CREATE SEQUENCE vodacom_issue_seq START WITH 100 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ============================================================================
-- INSERT DATA
-- ============================================================================

-- Departments (8)
INSERT INTO vodacom_departments (dept_id, dept_name, dept_code, budget, location, cost_center) VALUES (1, 'Customer Service', 'CS', 15000000, 'Midrand', 'CC-CS-001');
INSERT INTO vodacom_departments (dept_id, dept_name, dept_code, budget, location, cost_center) VALUES (2, 'Network Operations', 'NO', 50000000, 'Midrand', 'CC-NO-001');
INSERT INTO vodacom_departments (dept_id, dept_name, dept_code, budget, location, cost_center) VALUES (3, 'Sales and Distribution', 'SD', 25000000, 'Johannesburg', 'CC-SD-001');
INSERT INTO vodacom_departments (dept_id, dept_name, dept_code, budget, location, cost_center) VALUES (4, 'Finance and Billing', 'FB', 8000000, 'Midrand', 'CC-FB-001');
INSERT INTO vodacom_departments (dept_id, dept_name, dept_code, budget, location, cost_center) VALUES (5, 'Information Technology', 'IT', 35000000, 'Midrand', 'CC-IT-001');
INSERT INTO vodacom_departments (dept_id, dept_name, dept_code, budget, location, cost_center) VALUES (6, 'Marketing', 'MKT', 20000000, 'Johannesburg', 'CC-MKT-001');
INSERT INTO vodacom_departments (dept_id, dept_name, dept_code, budget, location, cost_center) VALUES (7, 'Human Resources', 'HR', 5000000, 'Midrand', 'CC-HR-001');
INSERT INTO vodacom_departments (dept_id, dept_name, dept_code, budget, location, cost_center) VALUES (8, 'VodaPay Division', 'VP', 30000000, 'Cape Town', 'CC-VP-001');
COMMIT;

-- Employees (29)
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (1, 'Thabo', 'Molefe', 'thabo.molefe@vodacom.co.za', '0836547890', DATE '2018-03-15', 1, 'Customer Service Manager', 65000, 'Permanent', 'VDC001234', 'JHB-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (2, 'Nomsa', 'Dlamini', 'nomsa.dlamini@vodacom.co.za', '0827654321', DATE '2019-07-22', 1, 'Senior Customer Service Rep', 35000, 'Permanent', 'VDC001235', 'JHB-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (3, 'Sipho', 'Khumalo', 'sipho.khumalo@vodacom.co.za', '0731234567', DATE '2020-01-10', 1, 'Customer Service Representative', 25000, 'Permanent', 'VDC001236', 'JHB-002');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (4, 'Zanele', 'Ndlovu', 'zanele.ndlovu@vodacom.co.za', '0829876543', DATE '2021-05-18', 1, 'Customer Service Representative', 24000, 'Permanent', 'VDC001237', 'DBN-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (5, 'Lerato', 'Mokoena', 'lerato.mokoena@vodacom.co.za', '0765432109', DATE '2022-02-14', 1, 'Customer Service Representative', 23000, 'Permanent', 'VDC001238', 'CPT-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (6, 'Mandla', 'Zulu', 'mandla.zulu@vodacom.co.za', '0834567890', DATE '2015-06-01', 2, 'Network Operations Director', 120000, 'Permanent', 'VDC002001', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (7, 'Thandi', 'Ngwenya', 'thandi.ngwenya@vodacom.co.za', '0721234567', DATE '2017-09-12', 2, 'Senior Network Engineer', 85000, 'Permanent', 'VDC002002', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (8, 'Bongani', 'Mthembu', 'bongani.mthembu@vodacom.co.za', '0789012345', DATE '2019-03-20', 2, 'Network Technician', 45000, 'Permanent', 'VDC002003', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (9, 'Nonhlanhla', 'Sithole', 'nonhlanhla.sithole@vodacom.co.za', '0736789012', DATE '2020-08-15', 2, 'Network Support Specialist', 40000, 'Permanent', 'VDC002004', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES (10, 'Themba', 'Radebe', 'themba.radebe@vodacom.co.za', '0845678901', DATE '2018-11-05', 3, 'Sales Manager', 70000, 'Permanent', 'VDC003001', 'JHB-001', 5.00);
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES (11, 'Nandi', 'Mahlangu', 'nandi.mahlangu@vodacom.co.za', '0723456789', DATE '2019-04-22', 3, 'Senior Sales Agent', 40000, 'Permanent', 'VDC003002', 'JHB-001', 8.00);
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES (12, 'Tshepo', 'Vilakazi', 'tshepo.vilakazi@vodacom.co.za', '0756789012', DATE '2020-09-10', 3, 'Sales Agent', 28000, 'Permanent', 'VDC003003', 'JHB-002', 10.00);
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES (13, 'Precious', 'Nkosi', 'precious.nkosi@vodacom.co.za', '0789876543', DATE '2021-01-12', 3, 'Sales Agent', 26000, 'Permanent', 'VDC003004', 'DBN-001', 10.00);
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES (14, 'Mpho', 'Tshabalala', 'mpho.tshabalala@vodacom.co.za', '0765432198', DATE '2022-06-01', 3, 'Sales Agent', 25000, 'Permanent', 'VDC003005', 'CPT-001', 10.00);
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (15, 'Sizwe', 'Mthethwa', 'sizwe.mthethwa@vodacom.co.za', '0834567123', DATE '2016-02-18', 4, 'Finance Manager', 95000, 'Permanent', 'VDC004001', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (16, 'Lindiwe', 'Naidoo', 'lindiwe.naidoo@vodacom.co.za', '0721234876', DATE '2018-05-20', 4, 'Billing Specialist', 42000, 'Permanent', 'VDC004002', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (17, 'Kagiso', 'Mohlala', 'kagiso.mohlala@vodacom.co.za', '0789012876', DATE '2019-11-15', 4, 'Accounts Receivable Clerk', 32000, 'Permanent', 'VDC004003', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (18, 'Mpumelelo', 'Dube', 'mpumelelo.dube@vodacom.co.za', '0836789234', DATE '2017-01-10', 5, 'IT Director', 130000, 'Permanent', 'VDC005001', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (19, 'Ntombi', 'Shabalala', 'ntombi.shabalala@vodacom.co.za', '0723456234', DATE '2018-08-22', 5, 'Senior Systems Analyst', 75000, 'Permanent', 'VDC005002', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (20, 'Andile', 'Ngubane', 'andile.ngubane@vodacom.co.za', '0756789234', DATE '2020-02-15', 5, 'Database Administrator', 60000, 'Permanent', 'VDC005003', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (21, 'Busisiwe', 'Khoza', 'busisiwe.khoza@vodacom.co.za', '0789876234', DATE '2021-07-01', 5, 'Software Developer', 55000, 'Permanent', 'VDC005004', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (22, 'Sello', 'Maseko', 'sello.maseko@vodacom.co.za', '0834561234', DATE '2017-04-12', 6, 'Marketing Director', 110000, 'Permanent', 'VDC006001', 'JHB-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (23, 'Zinhle', 'Mbatha', 'zinhle.mbatha@vodacom.co.za', '0721231234', DATE '2019-06-18', 6, 'Digital Marketing Manager', 65000, 'Permanent', 'VDC006002', 'JHB-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (24, 'Khethiwe', 'Cele', 'khethiwe.cele@vodacom.co.za', '0789011234', DATE '2020-10-05', 6, 'Marketing Coordinator', 38000, 'Permanent', 'VDC006003', 'JHB-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (25, 'Siphiwe', 'Zungu', 'siphiwe.zungu@vodacom.co.za', '0836785678', DATE '2016-09-01', 7, 'HR Director', 105000, 'Permanent', 'VDC007001', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (26, 'Nokuthula', 'Mkhize', 'nokuthula.mkhize@vodacom.co.za', '0721235678', DATE '2018-12-10', 7, 'HR Business Partner', 55000, 'Permanent', 'VDC007002', 'MDR-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (27, 'Lwazi', 'Ntuli', 'lwazi.ntuli@vodacom.co.za', '0834565678', DATE '2019-08-20', 8, 'VodaPay Director', 125000, 'Permanent', 'VDC008001', 'CPT-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (28, 'Thandeka', 'Madonsela', 'thandeka.madonsela@vodacom.co.za', '0721235555', DATE '2020-03-15', 8, 'VodaPay Product Manager', 80000, 'Permanent', 'VDC008002', 'CPT-001');
INSERT INTO vodacom_employees (emp_id, first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES (29, 'Mlungisi', 'Hadebe', 'mlungisi.hadebe@vodacom.co.za', '0756785555', DATE '2021-09-01', 8, 'VodaPay Support Specialist', 45000, 'Permanent', 'VDC008003', 'CPT-001');
UPDATE vodacom_employees SET manager_id = 1 WHERE emp_id IN (2,3,4,5);
UPDATE vodacom_employees SET manager_id = 6 WHERE emp_id IN (7,8,9);
UPDATE vodacom_employees SET manager_id = 10 WHERE emp_id IN (11,12,13,14);
UPDATE vodacom_employees SET manager_id = 15 WHERE emp_id IN (16,17);
UPDATE vodacom_employees SET manager_id = 18 WHERE emp_id IN (19,20,21);
UPDATE vodacom_employees SET manager_id = 22 WHERE emp_id IN (23,24);
UPDATE vodacom_employees SET manager_id = 25 WHERE emp_id = 26;
UPDATE vodacom_employees SET manager_id = 27 WHERE emp_id IN (28,29);
UPDATE vodacom_departments SET manager_id = 1 WHERE dept_id = 1;
UPDATE vodacom_departments SET manager_id = 6 WHERE dept_id = 2;
UPDATE vodacom_departments SET manager_id = 10 WHERE dept_id = 3;
UPDATE vodacom_departments SET manager_id = 15 WHERE dept_id = 4;
UPDATE vodacom_departments SET manager_id = 18 WHERE dept_id = 5;
UPDATE vodacom_departments SET manager_id = 22 WHERE dept_id = 6;
UPDATE vodacom_departments SET manager_id = 25 WHERE dept_id = 7;
UPDATE vodacom_departments SET manager_id = 27 WHERE dept_id = 8;
COMMIT;

-- Customers (22)
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (1, 'VDC-ACC-100001', 'Palesa', 'Mokoena', '8503145678083', 'palesa.mokoena@email.com', '0821234567', '45 Oxford Road', 'Johannesburg', 'Gauteng', '2196', 'Individual', 5000, 2, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (2, 'VDC-ACC-100002', 'Thulani', 'Ngubane', '7809221234089', 'thulani.ngubane@email.com', '0839876543', '12 Smith Street', 'Durban', 'KwaZulu-Natal', '4001', 'Individual', 3000, 4, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (3, 'VDC-ACC-100003', 'Mbali', 'Dlamini', '9201187890082', 'mbali.dlamini@email.com', '0765432109', '78 Long Street', 'Cape Town', 'Western Cape', '8001', 'Individual', 8000, 5, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (4, 'VDC-ACC-100004', 'Sibusiso', 'Khumalo', '8607095432087', 'sibusiso.khumalo@email.com', '0734567890', '23 Church Street', 'Pretoria', 'Gauteng', '0002', 'Individual', 4000, 2, 'N');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (5, 'VDC-ACC-100005', 'Nthabiseng', 'Mahlangu', '9505218765085', 'nthabiseng.mahlangu@email.com', '0827654321', '56 Market Street', 'Port Elizabeth', 'Eastern Cape', '6001', 'Individual', 6000, 3, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (6, 'VDC-ACC-200001', 'ABC Trading PTY LTD', 'N/A', '2015/123456/07', 'accounts@abctrading.co.za', '0115551234', '100 Rivonia Road', 'Sandton', 'Gauteng', '2196', 'Business', 50000, 11, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (7, 'VDC-ACC-200002', 'Tech Solutions SA', 'N/A', '2018/987654/07', 'info@techsolutions.co.za', '0215552345', '45 Adderley Street', 'Cape Town', 'Western Cape', '8001', 'Business', 75000, 12, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (8, 'VDC-ACC-200003', 'Retail Group Limited', 'N/A', '2010/456789/07', 'contact@retailgroup.co.za', '0315553456', '88 West Street', 'Durban', 'KwaZulu-Natal', '4001', 'Business', 100000, 13, 'N');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (9, 'VDC-ACC-100006', 'Zanele', 'Sithole', '8812094567082', 'zanele.sithole@email.com', '0789012345', '34 Main Road', 'Bloemfontein', 'Free State', '9301', 'Individual', 3500, 4, 'N');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (10, 'VDC-ACC-100007', 'Bongani', 'Radebe', '7703168901084', 'bongani.radebe@email.com', '0736789012', '67 Park Street', 'Polokwane', 'Limpopo', '0699', 'Individual', 2500, 5, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (11, 'VDC-ACC-100008', 'Nomvula', 'Zwane', '9008124567089', 'nomvula.zwane@email.com', '0821231234', '90 Hope Street', 'East London', 'Eastern Cape', '5201', 'Individual', 4500, 2, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (12, 'VDC-ACC-100009', 'Lungelo', 'Nkosi', '8401057890081', 'lungelo.nkosi@email.com', '0739876543', '12 Beach Road', 'Richards Bay', 'KwaZulu-Natal', '3900', 'Individual', 3000, 3, 'N');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (13, 'VDC-ACC-100010', 'Khethiwe', 'Mthembu', '9306192345086', 'khethiwe.mthembu@email.com', '0756781234', '45 Nelson Mandela Drive', 'Nelspruit', 'Mpumalanga', '1200', 'Individual', 5500, 4, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (14, 'VDC-ACC-300001', 'Government Department X', 'N/A', 'GOV-2020-001', 'procurement@govdeptx.gov.za', '0125551234', 'Government Buildings', 'Pretoria', 'Gauteng', '0001', 'Government', 500000, 11, 'N');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (15, 'VDC-ACC-100011', 'Sizwe', 'Cele', '8109143456088', 'sizwe.cele@email.com', '0789011111', '23 Victoria Street', 'Pietermaritzburg', 'KwaZulu-Natal', '3201', 'Individual', 4000, 5, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (16, 'VDC-ACC-100012', 'Thandeka', 'Mbatha', '9207245678084', 'thandeka.mbatha@email.com', '0821112222', '78 Commissioner Street', 'Johannesburg', 'Gauteng', '2001', 'Individual', 7000, 2, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (17, 'VDC-ACC-200004', 'Construction Corp', 'N/A', '2012/234567/07', 'admin@constructioncorp.co.za', '0215554567', '150 Loop Street', 'Cape Town', 'Western Cape', '8001', 'Business', 60000, 12, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (19, 'VDC-ACC-100013', 'Mpho', 'Vilakazi', '8605196789085', 'mpho.vilakazi@email.com', '0733334444', '56 Church Square', 'Pretoria', 'Gauteng', '0002', 'Individual', 3500, 3, 'N');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (20, 'VDC-ACC-100014', 'Lindiwe', 'Zungu', '9101088901083', 'lindiwe.zungu@email.com', '0765555666', '89 Railway Street', 'Kimberley', 'Northern Cape', '8301', 'Individual', 2800, 4, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (21, 'VDC-ACC-100015', 'Thabo', 'Ndlovu', '7808127654082', 'thabo.ndlovu@email.com', '0826667777', '34 High Street', 'Grahamstown', 'Eastern Cape', '6139', 'Individual', 4200, 5, 'Y');
INSERT INTO vodacom_customers (customer_id, account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active) VALUES (22, 'VDC-ACC-200005', 'Logistics Express PTY', ' ', '2019/345678/07', 'dispatch@logisticsexpress.co.za', '0315555678', '200 Umgeni Road', 'Durban', 'KwaZulu-Natal', '4001', 'Business', 80000, 13, 'Y');
COMMIT;

-- Mobile Numbers (15)
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance, sms_balance) VALUES (1, '0821234567', 1, 'Postpaid', 'SIM-8927100012345678901', DATE '2022-01-15', 'Smart XL', 5120, 0, 0);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance) VALUES (2, '0839876543', 2, 'Prepaid', 'SIM-8927100098765432109', DATE '2021-06-20', 850, 45.50, 25);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, monthly_fee, data_balance_mb, airtime_balance) VALUES (3, '0765432109', 3, 'Contract', 'SIM-8927100011111222233', DATE '2020-11-10', 'Red 1GB', 299, 750, 0);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance) VALUES (4, '0734567890', 4, 'Prepaid', 'SIM-8927100022222333344', DATE '2023-03-05', 0, 12.00, 5);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance, sms_balance) VALUES (5, '0827654321', 5, 'Postpaid', 'SIM-8927100033333444455', DATE '2021-09-12', 'Smart L', 3072, 0, 0);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance) VALUES (6, '0789012345', 9, 'Prepaid', 'SIM-8927100044444555566', DATE '2022-07-18', 1500, 85.00, 50);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance) VALUES (7, '0736789012', 10, 'Prepaid', 'SIM-8927100055555666677', DATE '2023-01-22', 2048, 120.00, 100);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, monthly_fee, data_balance_mb, airtime_balance) VALUES (8, '0821231234', 11, 'Contract', 'SIM-8927100066666777788', DATE '2021-04-08', 'Red 2GB', 399, 1024, 0);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance) VALUES (9, '0739876543', 12, 'Prepaid', 'SIM-8927100077777888899', DATE '2022-10-30', 500, 30.00, 10);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance) VALUES (10, '0756781234', 13, 'Postpaid', 'SIM-8927100088888999900', DATE '2020-08-14', 'Smart M', 2048, 0);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance) VALUES (11, '0789011111', 15, 'Prepaid', 'SIM-8927100099999000011', DATE '2023-02-05', 3072, 150.00, 75);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, monthly_fee, data_balance_mb, airtime_balance) VALUES (12, '0821112222', 16, 'Contract', 'SIM-8927100010101010101', DATE '2021-12-20', 'Red 5GB', 599, 4096, 0);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance) VALUES (13, '0733334444', 19, 'Prepaid', 'SIM-8927100020202020202', DATE '2022-05-15', 256, 18.50, 8);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance) VALUES (14, '0765555666', 20, 'Prepaid', 'SIM-8927100030303030303', DATE '2023-04-10', 512, 55.00, 20);
INSERT INTO vodacom_mobile_numbers (number_id, mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance) VALUES (15, '0826667777', 21, 'Postpaid', 'SIM-8927100040404040404', DATE '2021-07-25', 'Smart L', 3072, 0);
COMMIT;

-- Packages (21) WITH category populated
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, category) VALUES (1, 'DATA-DAILY-50', 'Daily 50MB', '50MB data valid for 24 hours', 'Data Only', 50, 10, 1, 'Data');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, category) VALUES (2, 'DATA-DAILY-250', 'Daily 250MB', '250MB data valid for 24 hours', 'Data Only', 250, 25, 1, 'Data');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, category) VALUES (3, 'DATA-WEEKLY-1G', 'Weekly 1GB', '1GB data valid for 7 days', 'Data Only', 1024, 75, 7, 'Data');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, category) VALUES (4, 'DATA-WEEKLY-2G', 'Weekly 2GB', '2GB data valid for 7 days', 'Data Only', 2048, 135, 7, 'Data');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional, promo_price, promo_start_date, promo_end_date, category) VALUES (5, 'DATA-MONTHLY-1G', 'Monthly 1GB', '1GB data valid for 30 days', 'Data Only', 1024, 149, 30, 'Y', 99, DATE '2024-01-01', DATE '2024-12-31', 'Data');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, category) VALUES (6, 'DATA-MONTHLY-2G', 'Monthly 2GB', '2GB data valid for 30 days', 'Data Only', 2048, 249, 30, 'Data');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, category) VALUES (7, 'DATA-MONTHLY-5G', 'Monthly 5GB', '5GB data valid for 30 days', 'Data Only', 5120, 499, 30, 'Data');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, category) VALUES (8, 'DATA-MONTHLY-10G', 'Monthly 10GB', '10GB data valid for 30 days', 'Data Only', 10240, 849, 30, 'Data');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional, promo_price, promo_start_date, promo_end_date, category) VALUES (9, 'DATA-MONTHLY-20G', 'Monthly 20GB', '20GB data valid for 30 days', 'Data Only', 20480, 1499, 30, 'Y', 1199, DATE '2024-01-01', DATE '2024-06-30', 'Data');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, voice_minutes, price, validity_days, category) VALUES (10, 'VOICE-50MIN', '50 Minutes Anytime', '50 minutes to any network', 'Voice Only', 50, 50, 30, 'Voice');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, voice_minutes, price, validity_days, category) VALUES (11, 'VOICE-100MIN', '100 Minutes Anytime', '100 minutes to any network', 'Voice Only', 100, 90, 30, 'Voice');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, voice_minutes, price, validity_days, category) VALUES (12, 'VOICE-250MIN', '250 Minutes Anytime', '250 minutes to any network', 'Voice Only', 250, 200, 30, 'Voice');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, sms_count, price, validity_days, category) VALUES (13, 'SMS-100', '100 SMS Bundle', '100 SMS to any network', 'SMS Only', 100, 25, 30, 'SMS');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, sms_count, price, validity_days, category) VALUES (14, 'SMS-250', '250 SMS Bundle', '250 SMS to any network', 'SMS Only', 250, 50, 30, 'SMS');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, category) VALUES (15, 'COMBO-SMART-S', 'Smart Combo S', '500MB + 50min + 50SMS', 'Combo', 500, 50, 50, 99, 30, 'Bundle');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, category) VALUES (16, 'COMBO-SMART-M', 'Smart Combo M', '2GB + 100min + 100SMS', 'Combo', 2048, 100, 100, 299, 30, 'Bundle');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, category) VALUES (17, 'COMBO-SMART-L', 'Smart Combo L', '5GB + 250min + 200SMS', 'Combo', 5120, 250, 200, 599, 30, 'Bundle');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, is_promotional, promo_price, promo_start_date, promo_end_date, category) VALUES (18, 'COMBO-SMART-XL', 'Smart Combo XL', '10GB + 500min + 500SMS', 'Combo', 10240, 500, 500, 999, 30, 'Y', 799, DATE '2024-01-01', DATE '2024-12-31', 'Bundle');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, category) VALUES (19, 'CONTRACT-RED-1G', 'Red Contract 1GB', 'Monthly contract: 1GB + Unlimited calls + 200 SMS', 'Contract', 1024, 9999, 200, 299, 'Contract');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, category) VALUES (20, 'CONTRACT-RED-2G', 'Red Contract 2GB', 'Monthly contract: 2GB + Unlimited calls + 500 SMS', 'Contract', 2048, 9999, 500, 399, 'Contract');
INSERT INTO vodacom_packages (package_id, package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, category) VALUES (21, 'CONTRACT-RED-5G', 'Red Contract 5GB', 'Monthly contract: 5GB + Unlimited calls + 1000 SMS', 'Contract', 5120, 9999, 1000, 599, 'Contract');
COMMIT;

-- Transactions (15)
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel) VALUES (1, 'TXN-2024-00001', 1, '0821234567', 'Package Purchase', 999, 'Card', 18, TIMESTAMP '2024-01-05 10:15:30', 'Completed', 'App');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, channel) VALUES (2, 'TXN-2024-00002', 2, '0839876543', 'Airtime Purchase', 50, 'Cash', TIMESTAMP '2024-01-08 14:22:15', 'Completed', 'Store');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel) VALUES (3, 'TXN-2024-00003', 3, '0765432109', 'Data Purchase', 149, 'VodaPay', 5, TIMESTAMP '2024-01-10 09:45:00', 'Completed', 'USSD');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, processed_by, channel) VALUES (4, 'TXN-2024-00004', 4, '0734567890', 'Airtime Purchase', 20, 'Cash', TIMESTAMP '2024-01-12 16:30:45', 'Completed', 14, 'Store');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel) VALUES (5, 'TXN-2024-00005', 9, '0789012345', 'Data Purchase', 75, 'Card', 3, TIMESTAMP '2024-01-15 11:20:30', 'Completed', 'Web');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, transaction_type, amount, payment_method, transaction_date, status, channel) VALUES (6, 'TXN-2024-00006', 1, 'VodaPay Transfer', 500, 'VodaPay', TIMESTAMP '2024-01-18 13:05:20', 'Completed', 'App');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel) VALUES (7, 'TXN-2024-00007', 10, '0736789012', 'Data Purchase', 249, 'VodaPay', 6, TIMESTAMP '2024-01-20 08:15:00', 'Completed', 'App');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, transaction_type, amount, payment_method, transaction_date, status, channel) VALUES (8, 'TXN-2024-00008', 3, 'VodaPay Purchase', 350, 'VodaPay', TIMESTAMP '2024-01-22 17:40:15', 'Completed', 'App');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, channel) VALUES (9, 'TXN-2024-00009', 11, '0821231234', 'Airtime Purchase', 100, 'Card', TIMESTAMP '2024-01-25 12:30:00', 'Completed', 'Web');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel) VALUES (10, 'TXN-2024-00010', 13, '0756781234', 'Package Purchase', 599, 'Direct Debit', 17, TIMESTAMP '2024-01-28 10:00:00', 'Completed', 'App');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, channel) VALUES (11, 'TXN-2024-00011', 2, '0839876543', 'Airtime Purchase', 30, 'Voucher', TIMESTAMP '2024-02-01 15:45:30', 'Completed', 'USSD');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel) VALUES (12, 'TXN-2024-00012', 15, '0789011111', 'Data Purchase', 499, 'Card', 7, TIMESTAMP '2024-02-03 09:20:15', 'Completed', 'App');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, transaction_type, amount, payment_method, transaction_date, status, channel) VALUES (13, 'TXN-2024-00013', 5, 'Bill Payment', 850, 'VodaPay', TIMESTAMP '2024-02-05 14:10:00', 'Completed', 'App');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel) VALUES (14, 'TXN-2024-00014', 16, '0821112222', 'Package Purchase', 999, 'Card', 18, TIMESTAMP '2024-02-08 11:35:45', 'Completed', 'Web');
INSERT INTO vodacom_transactions (transaction_id, transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, processed_by, channel) VALUES (15, 'TXN-2024-00015', 19, '0733334444', 'Airtime Purchase', 15, 'Cash', TIMESTAMP '2024-02-10 16:50:20', 'Completed', 12, 'Store');
COMMIT;

-- Customer Support Tickets (10)
INSERT INTO vodacom_customer_support (ticket_id, ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, channel, assigned_to) VALUES (1, 'TKT-2024-00001', 1, '0821234567', 'Billing', 'Incorrect Charge', 'Charged twice for the same data bundle purchase', 'High', 'Call Center', 2);
INSERT INTO vodacom_customer_support (ticket_id, ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction) VALUES (2, 'TKT-2024-00002', 2, '0839876543', 'Network', 'No Signal', 'No network coverage at home address', 'Urgent', 'Resolved', 'App', 3, TIMESTAMP '2024-01-10 16:30:00', 'Escalated to Network Operations. Tower maintenance completed.', 5);
INSERT INTO vodacom_customer_support (ticket_id, ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel) VALUES (3, 'TKT-2024-00003', 4, '0734567890', 'Technical', 'Data Not Working', 'Purchased data but cannot browse internet', 'Normal', 'In Progress', 'Call Center');
INSERT INTO vodacom_customer_support (ticket_id, ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction) VALUES (4, 'TKT-2024-00004', 3, '0765432109', 'Account', 'Password Reset', 'Cannot access online account - forgot password', 'Low', 'Closed', 'Web', 5, TIMESTAMP '2024-01-15 10:20:00', 'Password reset link sent to registered email', 4);
INSERT INTO vodacom_customer_support (ticket_id, ticket_number, customer_id, issue_category, issue_type, description, priority, channel, assigned_to) VALUES (5, 'TKT-2024-00005', 1, 'VodaPay', 'Transaction Failed', 'VodaPay transfer failed but amount was deducted', 'Urgent', 'App', 28);
INSERT INTO vodacom_customer_support (ticket_id, ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to) VALUES (6, 'TKT-2024-00006', 9, '0789012345', 'Billing', 'Invoice Query', 'Requesting breakdown of last month charges', 'Normal', 'Assigned', 'Email', 16);
INSERT INTO vodacom_customer_support (ticket_id, ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction) VALUES (7, 'TKT-2024-00007', 11, '0821231234', 'Complaint', 'Poor Service', 'Multiple dropped calls in past week', 'High', 'Resolved', 'Call Center', 2, TIMESTAMP '2024-01-22 14:45:00', 'Network issue identified and fixed. Compensated with 1GB data', 3);
INSERT INTO vodacom_customer_support (ticket_id, ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, channel) VALUES (8, 'TKT-2024-00008', 15, '0789011111', 'Query', 'Package Information', 'Want to know about available monthly packages', 'Low', 'Social Media');
INSERT INTO vodacom_customer_support (ticket_id, ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to) VALUES (9, 'TKT-2024-00009', 16, '0821112222', 'Technical', 'SIM Card Issue', 'SIM card not detected by phone', 'High', 'In Progress', 'Walk-in', 3);
INSERT INTO vodacom_customer_support (ticket_id, ticket_number, customer_id, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction) VALUES (10, 'TKT-2024-00010', 5, 'Request', 'Upgrade Package', 'Want to upgrade to higher data package', 'Normal', 'Closed', 'App', 11, TIMESTAMP '2024-02-05 11:15:00', 'Customer upgraded to Smart L package successfully', 5);
COMMIT;

-- VodaPay Accounts (9)
INSERT INTO vodacom_vodapay_accounts (vodapay_id, customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received) VALUES (1, 1, 'VP-821234567', '0821234567', 1250.50, 5000, 50000, 'Y', DATE '2022-06-15', 15680.00, 8950.50);
INSERT INTO vodacom_vodapay_accounts (vodapay_id, customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received) VALUES (2, 3, 'VP-765432109', '0765432109', 3420.75, 10000, 100000, 'Y', DATE '2021-03-20', 42350.00, 38770.75);
INSERT INTO vodacom_vodapay_accounts (vodapay_id, customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received) VALUES (3, 5, 'VP-827654321', '0827654321', 580.00, 5000, 50000, 'Y', DATE '2022-11-08', 8920.00, 6500.00);
INSERT INTO vodacom_vodapay_accounts (vodapay_id, customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received) VALUES (4, 10, 'VP-736789012', '0736789012', 2150.30, 5000, 50000, 'Y', DATE '2023-01-25', 12450.00, 10600.30);
INSERT INTO vodacom_vodapay_accounts (vodapay_id, customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received) VALUES (5, 13, 'VP-756781234', '0756781234', 4850.00, 10000, 100000, 'Y', DATE '2021-07-12', 65200.00, 58050.00);
INSERT INTO vodacom_vodapay_accounts (vodapay_id, customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received) VALUES (6, 15, 'VP-789011111', '0789011111', 620.45, 5000, 50000, 'Y', DATE '2023-02-18', 4380.00, 3000.45);
INSERT INTO vodacom_vodapay_accounts (vodapay_id, customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received) VALUES (7, 16, 'VP-821112222', '0821112222', 8920.80, 15000, 150000, 'Y', DATE '2022-01-05', 98450.00, 92370.80);
INSERT INTO vodacom_vodapay_accounts (vodapay_id, customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received) VALUES (8, 20, 'VP-765555666', '0765555666', 150.20, 5000, 50000, 'Y', DATE '2023-04-22', 2850.00, 1000.20);
INSERT INTO vodacom_vodapay_accounts (vodapay_id, customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received) VALUES (9, 21, 'VP-826667777', '0826667777', 1780.90, 5000, 50000, 'Y', DATE '2022-08-30', 18920.00, 14700.90);
COMMIT;

-- Invoices (6)
INSERT INTO vodacom_invoices (invoice_id, invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by) VALUES (1, 'INV-2024-01-001', 1, '0821234567', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 869.57, 130.43, 1000.00, 1000.00, 0, 'Paid', 16);
INSERT INTO vodacom_invoices (invoice_id, invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by) VALUES (2, 'INV-2024-01-002', 3, '0765432109', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 521.74, 78.26, 600.00, 600.00, 0, 'Paid', 16);
INSERT INTO vodacom_invoices (invoice_id, invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, payment_date, generated_by) VALUES (3, 'INV-2024-01-003', 11, '0821231234', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 695.65, 104.35, 800.00, 800.00, 0, 'Paid', DATE '2024-02-10', 16);
INSERT INTO vodacom_invoices (invoice_id, invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by) VALUES (4, 'INV-2024-01-004', 13, '0756781234', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 434.78, 65.22, 500.00, 0, 500.00, 'Issued', 16);
INSERT INTO vodacom_invoices (invoice_id, invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by) VALUES (5, 'INV-2024-01-005', 16, '0821112222', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 1043.48, 156.52, 1200.00, 0, 1200.00, 'Issued', 16);
INSERT INTO vodacom_invoices (invoice_id, invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by) VALUES (6, 'INV-2024-01-006', 21, '0826667777', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 782.61, 117.39, 900.00, 450.00, 450.00, 'Partially Paid', 16);
COMMIT;

-- Invoice Items (17)
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, amount) VALUES (1, 1, 'Monthly Rental', 'Smart XL Package Monthly Fee', 1, 999, 999);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, amount) VALUES (2, 1, 'Voice Calls', 'Out-of-bundle calls', 1.00);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, amount) VALUES (3, 2, 'Monthly Rental', 'Red 1GB Contract Monthly Fee', 1, 299, 299);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, amount) VALUES (4, 2, 'Data Usage', 'Out-of-bundle data usage', 250, 0.99, 247.50);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, amount) VALUES (5, 2, 'SMS Charges', 'Additional SMS', 75.24);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, amount) VALUES (6, 3, 'Monthly Rental', 'Red 2GB Contract Monthly Fee', 1, 399, 399);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, amount) VALUES (7, 3, 'Data Usage', 'Out-of-bundle data usage', 400, 0.99, 396.00);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, amount) VALUES (8, 3, 'International Calls', 'International calls', 5.65);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, amount) VALUES (9, 4, 'Monthly Rental', 'Smart M Package Monthly Fee', 1, 299, 299);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, amount) VALUES (10, 4, 'Data Usage', 'Out-of-bundle data usage', 150, 0.99, 148.50);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, amount) VALUES (11, 4, 'Value Added Services', 'Music streaming service', 52.28);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, amount) VALUES (12, 5, 'Monthly Rental', 'Red 5GB Contract Monthly Fee', 1, 599, 599);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, amount) VALUES (13, 5, 'Device Installment', 'iPhone 15 Pro - Month 3 of 24', 1, 590, 590);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, amount) VALUES (14, 5, 'Data Usage', 'Out-of-bundle data', 54.48);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, amount) VALUES (15, 6, 'Monthly Rental', 'Smart L Package Monthly Fee', 1, 599, 599);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, quantity, unit_price, amount) VALUES (16, 6, 'Data Usage', 'Out-of-bundle data usage', 180, 0.99, 178.20);
INSERT INTO vodacom_invoice_items (item_id, invoice_id, item_type, description, amount) VALUES (17, 6, 'Roaming', 'Data roaming charges', 105.41);
COMMIT;

-- Network Towers (12) WITH assigned_tech pre-populated
-- JHB towers -> emp_id 7 (Thandi Ngwenya), CPT -> emp_id 8 (Bongani Mthembu)
-- DBN -> emp_id 7, PTA -> emp_id 9 (Nonhlanhla Sithole), Others -> emp_id 8
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (1, 'JHB-T001', 'Sandton City Tower', -26.107730, 28.056305, 'Gauteng', 'Johannesburg', '5G', 5000, DATE '2022-03-15', 85000, 'Vodacom', 7);
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (2, 'JHB-T002', 'Rosebank Mall Tower', -26.147780, 28.040650, 'Gauteng', 'Johannesburg', 'Hybrid', 4500, DATE '2021-08-20', 75000, 'Vodacom', 7);
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (3, 'CPT-T001', 'V&A Waterfront Tower', -33.904500, 18.419180, 'Western Cape', 'Cape Town', '5G', 5500, DATE '2022-06-10', 90000, 'Vodacom', 8);
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (4, 'CPT-T002', 'Century City Tower', -33.892890, 18.508890, 'Western Cape', 'Cape Town', 'Hybrid', 4000, DATE '2021-05-15', 70000, 'Leased', 8);
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (5, 'DBN-T001', 'Umhlanga Rocks Tower', -29.729550, 31.082300, 'KwaZulu-Natal', 'Durban', '5G', 4800, DATE '2022-09-05', 82000, 'Vodacom', 7);
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (6, 'DBN-T002', 'Gateway Mall Tower', -29.763330, 31.048890, 'KwaZulu-Natal', 'Durban', 'Hybrid', 4200, DATE '2021-11-20', 72000, 'Shared', 7);
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (7, 'PTA-T001', 'Menlyn Tower', -25.781670, 28.276390, 'Gauteng', 'Pretoria', '5G', 4600, DATE '2022-04-12', 80000, 'Vodacom', 9);
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (8, 'PTA-T002', 'Hatfield Plaza Tower', -25.749170, 28.238610, 'Gauteng', 'Pretoria', 'Hybrid', 3800, DATE '2021-07-08', 68000, 'Leased', 9);
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (9, 'BFN-T001', 'Bloemfontein Central', -29.121110, 26.214440, 'Free State', 'Bloemfontein', '4G', 3500, DATE '2020-10-15', 55000, 'Vodacom', 8);
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (10, 'PLK-T001', 'Polokwane Mall Tower', -23.905000, 29.458330, 'Limpopo', 'Polokwane', '4G', 3200, DATE '2020-12-01', 52000, 'Shared', 8);
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (11, 'ELS-T001', 'East London Beachfront', -33.015000, 27.911670, 'Eastern Cape', 'East London', '4G', 3000, DATE '2021-02-18', 50000, 'Leased', 8);
INSERT INTO vodacom_network_towers (tower_id, tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type, assigned_tech) VALUES (12, 'NPT-T001', 'Nelspruit City Tower', -25.474440, 30.970000, 'Mpumalanga', 'Nelspruit', '4G', 2800, DATE '2021-04-22', 48000, 'Vodacom', 8);
COMMIT;

-- Network Issues (5)
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status) VALUES (1, 'INC-2024-001', 1, 'Maintenance', 'Low', 'Scheduled upgrade to 5G equipment', 'Gauteng', 'Johannesburg', 0, TIMESTAMP '2024-02-15 02:00:00', 'Resolved');
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to) VALUES (2, 'INC-2024-002', 5, 'Outage', 'Critical', 'Complete tower failure - power supply issue', 'KwaZulu-Natal', 'Durban', 4800, TIMESTAMP '2024-02-10 14:30:00', 'Resolved', 7);
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to) VALUES (3, 'INC-2024-003', 3, 'Degraded Service', 'High', 'Intermittent connectivity - investigating hardware', 'Western Cape', 'Cape Town', 2500, TIMESTAMP '2024-02-18 09:15:00', 'In Progress', 8);
INSERT INTO vodacom_network_issues (issue_id, issue_ref, issue_type, severity, description, province, city, affected_customers, reported_date, status) VALUES (4, 'INC-2024-004', 'Weather Damage', 'Medium', 'Lightning damage to fiber connection', 'Free State', 'Bloemfontein', 1200, TIMESTAMP '2024-02-12 18:45:00', 'Resolved');
INSERT INTO vodacom_network_issues (issue_id, issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to) VALUES (5, 'INC-2024-005', 7, 'Vandalism', 'High', 'Cable theft affecting tower connectivity', 'Gauteng', 'Pretoria', 3200, TIMESTAMP '2024-02-20 06:30:00', 'Acknowledged', 6);
COMMIT;

-- Sales (10)
INSERT INTO vodacom_sales (sale_id, sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code) VALUES (1, 'SALE-2024-00001', 1, DATE '2024-01-10', 'New Contract', 'Red 5GB - 24 Month Contract', 1, 599, 0, 0, 599, 'Direct Debit', 11, 29.95, 'JHB-001');
INSERT INTO vodacom_sales (sale_id, sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code) VALUES (2, 'SALE-2024-00002', 9, DATE '2024-01-12', 'Device', 'Samsung Galaxy A34 5G', 1, 6999, 10, 700, 6299, 'Card', 12, 503.92, 'JHB-002');
INSERT INTO vodacom_sales (sale_id, sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code) VALUES (3, 'SALE-2024-00003', 4, DATE '2024-01-15', 'SIM Card', 'Prepaid SIM Starter Pack', 1, 5, 0, 0, 5, 'Cash', 14, 0.50, 'DBN-001');
INSERT INTO vodacom_sales (sale_id, sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code) VALUES (4, 'SALE-2024-00004', 3, DATE '2024-01-18', 'Upgrade', 'iPhone 15 Pro - Contract Upgrade', 1, 24999, 15, 3750, 21249, 'Card', 11, 1062.45, 'CPT-001');
INSERT INTO vodacom_sales (sale_id, sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code) VALUES (5, 'SALE-2024-00005', 11, DATE '2024-01-20', 'Accessory', 'Wireless Earbuds', 1, 1299, 0, 0, 1299, 'Card', 12, 103.92, 'JHB-001');
INSERT INTO vodacom_sales (sale_id, sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code) VALUES (6, 'SALE-2024-00006', 15, DATE '2024-01-25', 'Device', 'Huawei WiFi Router 5G', 1, 3999, 5, 200, 3799, 'VodaPay', 13, 303.92, 'DBN-001');
INSERT INTO vodacom_sales (sale_id, sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code) VALUES (7, 'SALE-2024-00007', 6, DATE '2024-01-28', 'Enterprise', 'Corporate Package - 50 Lines', 50, 399, 20, 3990, 15960, 'EFT', 11, 798.00, 'JHB-001');
INSERT INTO vodacom_sales (sale_id, sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code) VALUES (8, 'SALE-2024-00008', 16, DATE '2024-02-01', 'Device', 'Samsung Galaxy S24', 1, 17999, 0, 0, 17999, 'Card', 14, 1439.92, 'CPT-001');
INSERT INTO vodacom_sales (sale_id, sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code) VALUES (9, 'SALE-2024-00009', 19, DATE '2024-02-05', 'Accessory', 'Phone Case + Screen Protector', 1, 299, 0, 0, 299, 'Cash', 12, 23.92, 'JHB-002');
INSERT INTO vodacom_sales (sale_id, sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code) VALUES (10, 'SALE-2024-00010', 21, DATE '2024-02-08', 'New Contract', 'Red 2GB - 24 Month Contract', 1, 399, 0, 0, 399, 'Direct Debit', 13, 19.95, 'DBN-001');
COMMIT;

-- ============================================================================
-- LAB 05 SPECIFIC: SA Address Lookup Tables
-- ============================================================================

-- Provinces (9)
INSERT INTO vodacom_sa_provinces (province_id, province_code, province_name) VALUES (1, 'GP', 'Gauteng');
INSERT INTO vodacom_sa_provinces (province_id, province_code, province_name) VALUES (2, 'WC', 'Western Cape');
INSERT INTO vodacom_sa_provinces (province_id, province_code, province_name) VALUES (3, 'KZN', 'KwaZulu-Natal');
INSERT INTO vodacom_sa_provinces (province_id, province_code, province_name) VALUES (4, 'EC', 'Eastern Cape');
INSERT INTO vodacom_sa_provinces (province_id, province_code, province_name) VALUES (5, 'FS', 'Free State');
INSERT INTO vodacom_sa_provinces (province_id, province_code, province_name) VALUES (6, 'LP', 'Limpopo');
INSERT INTO vodacom_sa_provinces (province_id, province_code, province_name) VALUES (7, 'MP', 'Mpumalanga');
INSERT INTO vodacom_sa_provinces (province_id, province_code, province_name) VALUES (8, 'NC', 'Northern Cape');
INSERT INTO vodacom_sa_provinces (province_id, province_code, province_name) VALUES (9, 'NW', 'North West');
COMMIT;

-- Cities (15)
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (1, 'Johannesburg', 1);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (2, 'Pretoria', 1);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (3, 'Sandton', 1);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (4, 'Midrand', 1);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (5, 'Cape Town', 2);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (6, 'Stellenbosch', 2);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (7, 'Paarl', 2);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (8, 'Durban', 3);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (9, 'Pietermaritzburg', 3);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (10, 'Port Elizabeth', 4);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (11, 'Bloemfontein', 5);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (12, 'Polokwane', 6);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (13, 'Nelspruit', 7);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (14, 'Kimberley', 8);
INSERT INTO vodacom_sa_cities (city_id, city_name, province_id) VALUES (15, 'Rustenburg', 9);
COMMIT;

-- Suburbs (11)
INSERT INTO vodacom_sa_suburbs (suburb_id, suburb_name, postal_code, city_id) VALUES (1, 'Sandton', '2196', 1);
INSERT INTO vodacom_sa_suburbs (suburb_id, suburb_name, postal_code, city_id) VALUES (2, 'Rosebank', '2196', 1);
INSERT INTO vodacom_sa_suburbs (suburb_id, suburb_name, postal_code, city_id) VALUES (3, 'Fourways', '2055', 1);
INSERT INTO vodacom_sa_suburbs (suburb_id, suburb_name, postal_code, city_id) VALUES (4, 'Bryanston', '2021', 1);
INSERT INTO vodacom_sa_suburbs (suburb_id, suburb_name, postal_code, city_id) VALUES (5, 'Sea Point', '8005', 5);
INSERT INTO vodacom_sa_suburbs (suburb_id, suburb_name, postal_code, city_id) VALUES (6, 'Camps Bay', '8040', 5);
INSERT INTO vodacom_sa_suburbs (suburb_id, suburb_name, postal_code, city_id) VALUES (7, 'Century City', '7441', 5);
INSERT INTO vodacom_sa_suburbs (suburb_id, suburb_name, postal_code, city_id) VALUES (8, 'Umhlanga', '4319', 8);
INSERT INTO vodacom_sa_suburbs (suburb_id, suburb_name, postal_code, city_id) VALUES (9, 'Morningside', '4001', 8);
INSERT INTO vodacom_sa_suburbs (suburb_id, suburb_name, postal_code, city_id) VALUES (10, 'Hatfield', '0028', 2);
INSERT INTO vodacom_sa_suburbs (suburb_id, suburb_name, postal_code, city_id) VALUES (11, 'Brooklyn', '0181', 2);
COMMIT;

-- ============================================================================
-- LAB 06 SPECIFIC: Customer Assignments (for VPD policy)
-- ============================================================================
-- Populated from vodacom_customers.assigned_agent_id
-- Agent emp_id 2 (Nomsa Dlamini) -> customers 1, 4, 11, 16
-- Agent emp_id 3 (Sipho Khumalo) -> customers 5, 12, 19
-- Agent emp_id 4 (Zanele Ndlovu) -> customers 2, 9, 13, 20
-- Agent emp_id 5 (Lerato Mokoena) -> customers 3, 10, 15, 21
-- Agent emp_id 11 (Nandi Mahlangu) -> customers 6, 14
-- Agent emp_id 12 (Tshepo Vilakazi) -> customers 7, 17
-- Agent emp_id 13 (Precious Nkosi) -> customers 8, 22
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (1, 1, 2);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (2, 2, 4);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (3, 3, 5);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (4, 4, 2);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (5, 5, 3);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (6, 6, 11);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (7, 7, 12);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (8, 8, 13);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (9, 9, 4);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (10, 10, 5);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (11, 11, 2);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (12, 12, 3);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (13, 13, 4);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (14, 14, 11);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (15, 15, 5);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (16, 16, 2);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (17, 17, 12);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (18, 19, 3);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (19, 20, 4);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (20, 21, 5);
INSERT INTO vodacom_customer_assignments (assignment_id, customer_id, agent_emp_id) VALUES (21, 22, 13);
COMMIT;

-- ============================================================================
-- FOREIGN KEYS AND INDEXES
-- ============================================================================
ALTER TABLE vodacom_employees ADD CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES vodacom_departments(dept_id);
ALTER TABLE vodacom_customers ADD CONSTRAINT fk_cust_agent FOREIGN KEY (assigned_agent_id) REFERENCES vodacom_employees(emp_id);
ALTER TABLE vodacom_mobile_numbers ADD CONSTRAINT fk_num_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_transactions ADD CONSTRAINT fk_trans_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_transactions ADD CONSTRAINT fk_trans_package FOREIGN KEY (package_id) REFERENCES vodacom_packages(package_id);
ALTER TABLE vodacom_vodapay_accounts ADD CONSTRAINT fk_vodapay_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_invoices ADD CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_invoice_items ADD CONSTRAINT fk_item_invoice FOREIGN KEY (invoice_id) REFERENCES vodacom_invoices(invoice_id) ON DELETE CASCADE;
ALTER TABLE vodacom_network_towers ADD CONSTRAINT fk_tower_tech FOREIGN KEY (assigned_tech) REFERENCES vodacom_employees(emp_id);
ALTER TABLE vodacom_network_issues ADD CONSTRAINT fk_issue_tower FOREIGN KEY (tower_id) REFERENCES vodacom_network_towers(tower_id);
ALTER TABLE vodacom_sales ADD CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_sales ADD CONSTRAINT fk_sales_agent FOREIGN KEY (sales_agent_id) REFERENCES vodacom_employees(emp_id);
ALTER TABLE vodacom_customer_assignments ADD CONSTRAINT fk_assign_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_customer_assignments ADD CONSTRAINT fk_assign_agent FOREIGN KEY (agent_emp_id) REFERENCES vodacom_employees(emp_id);

CREATE INDEX idx_cust_type ON vodacom_customers(customer_type);
CREATE INDEX idx_cust_province ON vodacom_customers(province);
CREATE INDEX idx_mobile_customer ON vodacom_mobile_numbers(customer_id);
CREATE INDEX idx_invoice_customer ON vodacom_invoices(customer_id);
CREATE INDEX idx_city_province ON vodacom_sa_cities(province_id);
CREATE INDEX idx_suburb_city ON vodacom_sa_suburbs(city_id);
CREATE INDEX idx_tower_tech ON vodacom_network_towers(assigned_tech);
CREATE INDEX idx_tower_status ON vodacom_network_towers(status);
CREATE INDEX idx_tower_province ON vodacom_network_towers(province);
CREATE INDEX idx_issue_status ON vodacom_network_issues(status);
CREATE INDEX idx_issue_tower ON vodacom_network_issues(tower_id);
CREATE INDEX idx_sale_customer ON vodacom_sales(customer_id);
CREATE INDEX idx_sale_agent ON vodacom_sales(sales_agent_id);
CREATE INDEX idx_assign_customer ON vodacom_customer_assignments(customer_id);
CREATE INDEX idx_assign_agent ON vodacom_customer_assignments(agent_emp_id);
CREATE INDEX idx_assign_status ON vodacom_customer_assignments(assignment_status);
CREATE INDEX idx_pkg_category ON vodacom_packages(category);

-- ============================================================================
-- VERIFICATION
-- ============================================================================
DECLARE
    v_count NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Lab 06 Setup Verification');
    DBMS_OUTPUT.PUT_LINE('============================================');
    SELECT COUNT(*) INTO v_count FROM vodacom_departments; DBMS_OUTPUT.PUT_LINE('vodacom_departments:          ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_employees; DBMS_OUTPUT.PUT_LINE('vodacom_employees:            ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_customers; DBMS_OUTPUT.PUT_LINE('vodacom_customers:            ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_mobile_numbers; DBMS_OUTPUT.PUT_LINE('vodacom_mobile_numbers:       ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_packages; DBMS_OUTPUT.PUT_LINE('vodacom_packages:             ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_transactions; DBMS_OUTPUT.PUT_LINE('vodacom_transactions:         ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_customer_support; DBMS_OUTPUT.PUT_LINE('vodacom_customer_support:     ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_vodapay_accounts; DBMS_OUTPUT.PUT_LINE('vodacom_vodapay_accounts:     ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_invoices; DBMS_OUTPUT.PUT_LINE('vodacom_invoices:             ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_invoice_items; DBMS_OUTPUT.PUT_LINE('vodacom_invoice_items:        ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_network_towers; DBMS_OUTPUT.PUT_LINE('vodacom_network_towers:       ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_network_issues; DBMS_OUTPUT.PUT_LINE('vodacom_network_issues:       ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_sales; DBMS_OUTPUT.PUT_LINE('vodacom_sales:                ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_sa_provinces; DBMS_OUTPUT.PUT_LINE('vodacom_sa_provinces:         ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_sa_cities; DBMS_OUTPUT.PUT_LINE('vodacom_sa_cities:            ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_sa_suburbs; DBMS_OUTPUT.PUT_LINE('vodacom_sa_suburbs:           ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_customer_assignments; DBMS_OUTPUT.PUT_LINE('vodacom_customer_assignments: ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_network_towers WHERE assigned_tech IS NOT NULL; DBMS_OUTPUT.PUT_LINE('towers with assigned_tech:    ' || v_count || ' rows');
    SELECT COUNT(*) INTO v_count FROM vodacom_packages WHERE category IS NOT NULL; DBMS_OUTPUT.PUT_LINE('packages with category:       ' || v_count || ' rows');
    DBMS_OUTPUT.PUT_LINE('vodacom_audit_log:            0 rows (empty - populated by app)');
    DBMS_OUTPUT.PUT_LINE('vodacom_issue_seq:            EXISTS');
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Lab 06 setup complete!');
    DBMS_OUTPUT.PUT_LINE('============================================');
END;
/
