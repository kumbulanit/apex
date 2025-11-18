-- ============================================================================
-- VODACOM SIMPLE DATABASE SETUP
-- Oracle APEX Training Course
-- ============================================================================
-- Simple Vodacom mobile network database with sample data
-- 
-- TABLES CREATED:
-- 1. Departments - Vodacom departments
-- 2. Employees - Vodacom staff members
-- 3. Customers - Mobile customers
-- 4. Mobile_Numbers - Customer phone numbers
-- 5. Packages - Data/voice/SMS packages
-- 6. Transactions - Customer transactions
-- 7. Network_Towers - Cell towers and base stations
-- 8. Network_Issues - Network outages and issues
-- 9. Customer_Support - Support tickets
-- 10. Sales - Sales transactions
-- 11. VodaPay_Accounts - Mobile wallet accounts
-- 12. Invoices - Customer invoices
-- 13. Invoice_Items - Invoice line items
-- 
-- INSTRUCTIONS:
-- 1. Log into your APEX workspace
-- 2. Navigate to SQL Workshop > SQL Scripts
-- 3. Upload and run this script
-- ============================================================================

-- Clean up existing tables
BEGIN
    FOR rec IN (SELECT table_name FROM user_tables WHERE table_name IN (
        'VODACOM_CUSTOMERS', 'VODACOM_PACKAGES', 'VODACOM_SUBSCRIPTIONS', 
        'VODACOM_TRANSACTIONS', 'VODACOM_SUPPORT_TICKETS', 'VODACOM_CONTRACT_TYPES',
        'VODACOM_CUSTOMER_CONTRACTS', 'VODACOM_CONTRACT_RENEWALS', 
        'VODACOM_CONTRACT_PENALTIES', 'VODACOM_CONTRACT_BENEFITS',
        'VODACOM_DEPARTMENTS', 'VODACOM_EMPLOYEES', 'VODACOM_MOBILE_NUMBERS',
        'VODACOM_NETWORK_TOWERS', 'VODACOM_NETWORK_ISSUES', 'VODACOM_CUSTOMER_SUPPORT',
        'VODACOM_SALES', 'VODACOM_VODAPAY_ACCOUNTS', 'VODACOM_INVOICES', 'VODACOM_INVOICE_ITEMS'
    )) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS PURGE';
    END LOOP;
END;
/

-- ============================================================================
-- DEPARTMENTS TABLE
-- ============================================================================
CREATE TABLE vodacom_departments (
    dept_id           NUMBER PRIMARY KEY,
    dept_name         VARCHAR2(100) NOT NULL,
    dept_code         VARCHAR2(10) NOT NULL UNIQUE,
    location          VARCHAR2(100),
    budget            NUMBER(12,2),
    manager_id        NUMBER,
    cost_center       VARCHAR2(20)
);

CREATE SEQUENCE vodacom_departments_seq START WITH 1;

-- Insert 10 departments
INSERT INTO vodacom_departments VALUES (1, 'Customer Service', 'CS', 'Johannesburg', 5000000, NULL, 'CC-CS-001');
INSERT INTO vodacom_departments VALUES (2, 'Network Operations', 'NO', 'Midrand', 15000000, NULL, 'CC-NO-001');
INSERT INTO vodacom_departments VALUES (3, 'Sales', 'SAL', 'Sandton', 8000000, NULL, 'CC-SAL-001');
INSERT INTO vodacom_departments VALUES (4, 'Finance', 'FIN', 'Midrand', 3000000, NULL, 'CC-FIN-001');
INSERT INTO vodacom_departments VALUES (5, 'IT', 'IT', 'Midrand', 12000000, NULL, 'CC-IT-001');
INSERT INTO vodacom_departments VALUES (6, 'Marketing', 'MKT', 'Johannesburg', 10000000, NULL, 'CC-MKT-001');
INSERT INTO vodacom_departments VALUES (7, 'Human Resources', 'HR', 'Midrand', 2500000, NULL, 'CC-HR-001');
INSERT INTO vodacom_departments VALUES (8, 'VodaPay', 'VP', 'Cape Town', 6000000, NULL, 'CC-VP-001');
INSERT INTO vodacom_departments VALUES (9, 'Legal', 'LEG', 'Johannesburg', 1500000, NULL, 'CC-LEG-001');
INSERT INTO vodacom_departments VALUES (10, 'Procurement', 'PROC', 'Midrand', 2000000, NULL, 'CC-PROC-001');

COMMIT;

-- ============================================================================
-- EMPLOYEES TABLE
-- ============================================================================
CREATE TABLE vodacom_employees (
    emp_id            NUMBER PRIMARY KEY,
    employee_number   VARCHAR2(20) NOT NULL UNIQUE,
    first_name        VARCHAR2(50) NOT NULL,
    last_name         VARCHAR2(50) NOT NULL,
    email             VARCHAR2(100) NOT NULL UNIQUE,
    phone             VARCHAR2(20),
    dept_id           NUMBER,
    job_title         VARCHAR2(100),
    hire_date         DATE DEFAULT SYSDATE,
    salary            NUMBER(10,2),
    manager_id        NUMBER,
    status            VARCHAR2(20) DEFAULT 'Active',
    branch_code       VARCHAR2(10),
    CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES vodacom_departments(dept_id)
);

CREATE SEQUENCE vodacom_employees_seq START WITH 1;

-- Insert 10 employees
INSERT INTO vodacom_employees VALUES (1, 'VDC001001', 'Thabo', 'Molefe', 'thabo.molefe@vodacom.co.za', '0821111111', 1, 'Customer Service Manager', DATE '2018-01-15', 85000, NULL, 'Active', 'JHB-001');
INSERT INTO vodacom_employees VALUES (2, 'VDC001002', 'Lerato', 'Khumalo', 'lerato.khumalo@vodacom.co.za', '0822222222', 1, 'Senior Support Agent', DATE '2019-03-20', 45000, 1, 'Active', 'JHB-001');
INSERT INTO vodacom_employees VALUES (3, 'VDC001003', 'Sipho', 'Ndlovu', 'sipho.ndlovu@vodacom.co.za', '0823333333', 1, 'Support Agent', DATE '2020-06-10', 35000, 1, 'Active', 'JHB-001');
INSERT INTO vodacom_employees VALUES (4, 'VDC002001', 'Nomsa', 'Dlamini', 'nomsa.dlamini@vodacom.co.za', '0824444444', 2, 'Network Operations Manager', DATE '2017-05-12', 120000, NULL, 'Active', 'MDR-001');
INSERT INTO vodacom_employees VALUES (5, 'VDC002002', 'Bongani', 'Zulu', 'bongani.zulu@vodacom.co.za', '0825555555', 2, 'Senior Network Technician', DATE '2018-08-22', 65000, 4, 'Active', 'MDR-001');
INSERT INTO vodacom_employees VALUES (6, 'VDC003001', 'Zanele', 'Mthembu', 'zanele.mthembu@vodacom.co.za', '0826666666', 3, 'Sales Manager', DATE '2019-02-14', 95000, NULL, 'Active', 'SDN-001');
INSERT INTO vodacom_employees VALUES (7, 'VDC003002', 'Mandla', 'Sithole', 'mandla.sithole@vodacom.co.za', '0827777777', 3, 'Sales Agent', DATE '2020-09-05', 42000, 6, 'Active', 'SDN-001');
INSERT INTO vodacom_employees VALUES (8, 'VDC004001', 'Thandi', 'Cele', 'thandi.cele@vodacom.co.za', '0828888888', 4, 'Finance Manager', DATE '2016-11-30', 110000, NULL, 'Active', 'MDR-001');
INSERT INTO vodacom_employees VALUES (9, 'VDC005001', 'Lungile', 'Radebe', 'lungile.radebe@vodacom.co.za', '0829999999', 5, 'IT Manager', DATE '2017-07-18', 130000, NULL, 'Active', 'MDR-001');
INSERT INTO vodacom_employees VALUES (10, 'VDC006001', 'Zinhle', 'Nkosi', 'zinhle.nkosi@vodacom.co.za', '0820000000', 6, 'Marketing Manager', DATE '2018-04-25', 105000, NULL, 'Active', 'JHB-001');

COMMIT;

-- ============================================================================
-- CUSTOMERS TABLE
-- ============================================================================
CREATE TABLE vodacom_customers (
    customer_id       NUMBER PRIMARY KEY,
    account_number    VARCHAR2(20) NOT NULL UNIQUE,
    first_name        VARCHAR2(50) NOT NULL,
    last_name         VARCHAR2(50) NOT NULL,
    id_number         VARCHAR2(20) NOT NULL UNIQUE,
    email             VARCHAR2(100),
    phone             VARCHAR2(20) NOT NULL,
    address_line1     VARCHAR2(200),
    city              VARCHAR2(100),
    province          VARCHAR2(50),
    postal_code       VARCHAR2(10),
    customer_type     VARCHAR2(20) DEFAULT 'Individual',
    account_status    VARCHAR2(20) DEFAULT 'Active',
    credit_limit      NUMBER(10,2) DEFAULT 0,
    registration_date DATE DEFAULT SYSDATE,
    assigned_agent_id NUMBER,
    vodapay_active    VARCHAR2(1) DEFAULT 'N',
    CONSTRAINT fk_cust_agent FOREIGN KEY (assigned_agent_id) REFERENCES vodacom_employees(emp_id)
);

CREATE SEQUENCE vodacom_customers_seq START WITH 1;

-- Insert 10 customers
INSERT INTO vodacom_customers VALUES (1, 'VDC-ACC-100001', 'Palesa', 'Mokoena', '8503145678083', 'palesa.mokoena@email.com', '0821234567', '45 Oxford Road', 'Johannesburg', 'Gauteng', '2196', 'Individual', 'Active', 5000, DATE '2023-01-15', 2, 'Y');
INSERT INTO vodacom_customers VALUES (2, 'VDC-ACC-100002', 'Thulani', 'Ngubane', '7809221234089', 'thulani.ngubane@email.com', '0839876543', '12 Smith Street', 'Durban', 'KwaZulu-Natal', '4001', 'Individual', 'Active', 3000, DATE '2023-02-20', 3, 'Y');
INSERT INTO vodacom_customers VALUES (3, 'VDC-ACC-100003', 'Mbali', 'Dlamini', '9201187890082', 'mbali.dlamini@email.com', '0765432109', '78 Long Street', 'Cape Town', 'Western Cape', '8001', 'Individual', 'Active', 8000, DATE '2023-03-10', 2, 'Y');
INSERT INTO vodacom_customers VALUES (4, 'VDC-ACC-100004', 'Sibusiso', 'Khumalo', '8607095432087', 'sibusiso.khumalo@email.com', '0734567890', '23 Church Street', 'Pretoria', 'Gauteng', '0002', 'Individual', 'Active', 4000, DATE '2023-04-05', 3, 'N');
INSERT INTO vodacom_customers VALUES (5, 'VDC-ACC-100005', 'Nthabiseng', 'Mahlangu', '9505218765085', 'nthabiseng.mahlangu@email.com', '0827654321', '56 Market Street', 'Port Elizabeth', 'Eastern Cape', '6001', 'Individual', 'Active', 6000, DATE '2023-05-12', 2, 'Y');
INSERT INTO vodacom_customers VALUES (6, 'VDC-ACC-200001', 'ABC Trading', 'PTY LTD', '2015/123456/07', 'accounts@abctrading.co.za', '0115551234', '100 Rivonia Road', 'Sandton', 'Gauteng', '2196', 'Business', 'Active', 50000, DATE '2023-06-18', 7, 'Y');
INSERT INTO vodacom_customers VALUES (7, 'VDC-ACC-100006', 'Zanele', 'Sithole', '8812094567082', 'zanele.sithole@email.com', '0789012345', '34 Main Road', 'Bloemfontein', 'Free State', '9301', 'Individual', 'Active', 3500, DATE '2023-07-22', 3, 'N');
INSERT INTO vodacom_customers VALUES (8, 'VDC-ACC-100007', 'Bongani', 'Radebe', '7703168901084', 'bongani.radebe@email.com', '0736789012', '67 Park Street', 'Polokwane', 'Limpopo', '0699', 'Individual', 'Active', 2500, DATE '2023-08-30', 2, 'Y');
INSERT INTO vodacom_customers VALUES (9, 'VDC-ACC-100008', 'Nomvula', 'Zwane', '9008124567089', 'nomvula.zwane@email.com', '0821231234', '90 Hope Street', 'East London', 'Eastern Cape', '5201', 'Individual', 'Active', 4500, DATE '2023-09-14', 3, 'Y');
INSERT INTO vodacom_customers VALUES (10, 'VDC-ACC-100009', 'Lungelo', 'Nkosi', '8401057890081', 'lungelo.nkosi@email.com', '0739876543', '12 Beach Road', 'Richards Bay', 'KwaZulu-Natal', '3900', 'Individual', 'Active', 3000, DATE '2023-10-08', 2, 'N');

COMMIT;

-- ============================================================================
-- MOBILE NUMBERS TABLE
-- ============================================================================
CREATE TABLE vodacom_mobile_numbers (
    number_id         NUMBER PRIMARY KEY,
    mobile_number     VARCHAR2(20) NOT NULL UNIQUE,
    customer_id       NUMBER NOT NULL,
    number_type       VARCHAR2(20) DEFAULT 'Prepaid',
    sim_card_number   VARCHAR2(50) UNIQUE,
    activation_date   DATE NOT NULL,
    status            VARCHAR2(20) DEFAULT 'Active',
    current_package   VARCHAR2(100),
    data_balance_mb   NUMBER(10,2) DEFAULT 0,
    CONSTRAINT fk_mobile_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id)
);

CREATE SEQUENCE vodacom_mobile_numbers_seq START WITH 1;

-- Insert 10 mobile numbers
INSERT INTO vodacom_mobile_numbers VALUES (1, '0821234567', 1, 'Prepaid', 'SIM8927012345678901', DATE '2023-01-15', 'Active', 'Smart S', 512);
INSERT INTO vodacom_mobile_numbers VALUES (2, '0839876543', 2, 'Contract', 'SIM8927012345678902', DATE '2023-02-20', 'Active', 'Red Plan 199', 1024);
INSERT INTO vodacom_mobile_numbers VALUES (3, '0765432109', 3, 'Prepaid', 'SIM8927012345678903', DATE '2023-03-10', 'Active', 'Smart L', 2560);
INSERT INTO vodacom_mobile_numbers VALUES (4, '0734567890', 4, 'Contract', 'SIM8927012345678904', DATE '2023-04-05', 'Active', 'Red Plan 299', 3072);
INSERT INTO vodacom_mobile_numbers VALUES (5, '0827654321', 5, 'Prepaid', 'SIM8927012345678905', DATE '2023-05-12', 'Active', 'Smart M', 1536);
INSERT INTO vodacom_mobile_numbers VALUES (6, '0115551234', 6, 'Contract', 'SIM8927012345678906', DATE '2023-06-18', 'Active', 'Red Plan 499', 10240);
INSERT INTO vodacom_mobile_numbers VALUES (7, '0789012345', 7, 'Prepaid', 'SIM8927012345678907', DATE '2023-07-22', 'Active', 'Smart XL', 5120);
INSERT INTO vodacom_mobile_numbers VALUES (8, '0736789012', 8, 'Prepaid', 'SIM8927012345678908', DATE '2023-08-30', 'Active', 'Smart S', 256);
INSERT INTO vodacom_mobile_numbers VALUES (9, '0821231234', 9, 'Prepaid', 'SIM8927012345678909', DATE '2023-09-14', 'Active', 'Smart M', 1024);
INSERT INTO vodacom_mobile_numbers VALUES (10, '0739876543', 10, 'Prepaid', 'SIM8927012345678910', DATE '2023-10-08', 'Active', 'Data Only 5GB', 2048);

COMMIT;

-- ============================================================================
-- PACKAGES TABLE
-- ============================================================================
CREATE TABLE vodacom_packages (
    package_id        NUMBER PRIMARY KEY,
    package_name      VARCHAR2(100) NOT NULL,
    package_type      VARCHAR2(20),
    data_mb           NUMBER(8,0),
    voice_minutes     NUMBER(6,0),
    sms_count         NUMBER(6,0),
    price             NUMBER(8,2) NOT NULL,
    validity_days     NUMBER(3,0) DEFAULT 30
);

CREATE SEQUENCE vodacom_packages_seq START WITH 1;

-- Insert 10 packages
INSERT INTO vodacom_packages VALUES (1, 'Smart S', 'Prepaid', 1024, 100, 100, 99.00, 30);
INSERT INTO vodacom_packages VALUES (2, 'Smart M', 'Prepaid', 2048, 200, 200, 149.00, 30);
INSERT INTO vodacom_packages VALUES (3, 'Smart L', 'Prepaid', 5120, 500, 500, 299.00, 30);
INSERT INTO vodacom_packages VALUES (4, 'Smart XL', 'Prepaid', 10240, 1000, 1000, 499.00, 30);
INSERT INTO vodacom_packages VALUES (5, 'Red Plan 199', 'Contract', 2048, 300, 300, 199.00, 30);
INSERT INTO vodacom_packages VALUES (6, 'Red Plan 299', 'Contract', 5120, 600, 600, 299.00, 30);
INSERT INTO vodacom_packages VALUES (7, 'Red Plan 499', 'Contract', 15360, 1200, 1200, 499.00, 30);
INSERT INTO vodacom_packages VALUES (8, 'Data Only 1GB', 'Data', 1024, 0, 0, 49.00, 7);
INSERT INTO vodacom_packages VALUES (9, 'Data Only 5GB', 'Data', 5120, 0, 0, 199.00, 30);
INSERT INTO vodacom_packages VALUES (10, 'Night Owl 10GB', 'Data', 10240, 0, 0, 99.00, 30);

COMMIT;

-- ============================================================================
-- NETWORK TOWERS TABLE
-- ============================================================================
CREATE TABLE vodacom_network_towers (
    tower_id          NUMBER PRIMARY KEY,
    tower_code        VARCHAR2(20) NOT NULL UNIQUE,
    tower_name        VARCHAR2(100) NOT NULL,
    latitude          NUMBER(10,7),
    longitude         NUMBER(10,7),
    province          VARCHAR2(50) NOT NULL,
    city              VARCHAR2(100),
    tower_type        VARCHAR2(30),
    capacity          NUMBER(6,0),
    status            VARCHAR2(20) DEFAULT 'Operational',
    installation_date DATE,
    monthly_cost      NUMBER(10,2),
    owner_type        VARCHAR2(20)
);

CREATE SEQUENCE vodacom_network_towers_seq START WITH 1;

-- Insert 10 network towers
INSERT INTO vodacom_network_towers VALUES (1, 'TWR-GP-001', 'Sandton Tower 1', -26.107192, 28.056305, 'Gauteng', 'Sandton', '5G', 10000, 'Operational', DATE '2020-01-15', 85000, 'Vodacom');
INSERT INTO vodacom_network_towers VALUES (2, 'TWR-GP-002', 'Johannesburg CBD Tower', -26.204103, 28.047305, 'Gauteng', 'Johannesburg', '4G', 8000, 'Operational', DATE '2018-06-20', 65000, 'Vodacom');
INSERT INTO vodacom_network_towers VALUES (3, 'TWR-WC-001', 'Cape Town Waterfront', -33.903657, 18.418230, 'Western Cape', 'Cape Town', '5G', 12000, 'Operational', DATE '2021-03-10', 95000, 'Vodacom');
INSERT INTO vodacom_network_towers VALUES (4, 'TWR-KZN-001', 'Durban Beachfront', -29.858680, 31.021840, 'KwaZulu-Natal', 'Durban', '4G', 9000, 'Operational', DATE '2019-08-15', 75000, 'Leased');
INSERT INTO vodacom_network_towers VALUES (5, 'TWR-GP-003', 'Pretoria Central', -25.746111, 28.188056, 'Gauteng', 'Pretoria', '4G', 7500, 'Operational', DATE '2017-11-22', 55000, 'Vodacom');
INSERT INTO vodacom_network_towers VALUES (6, 'TWR-EC-001', 'Port Elizabeth Tower', -33.961900, 25.601100, 'Eastern Cape', 'Port Elizabeth', '4G', 6000, 'Operational', DATE '2018-04-18', 45000, 'Shared');
INSERT INTO vodacom_network_towers VALUES (7, 'TWR-FS-001', 'Bloemfontein Central', -29.121700, 26.214200, 'Free State', 'Bloemfontein', '4G', 5500, 'Operational', DATE '2019-02-10', 40000, 'Vodacom');
INSERT INTO vodacom_network_towers VALUES (8, 'TWR-LP-001', 'Polokwane Tower', -23.905100, 29.468500, 'Limpopo', 'Polokwane', '4G', 5000, 'Maintenance', DATE '2018-09-25', 38000, 'Leased');
INSERT INTO vodacom_network_towers VALUES (9, 'TWR-MP-001', 'Nelspruit Tower', -25.474400, 30.969700, 'Mpumalanga', 'Nelspruit', '4G', 4500, 'Operational', DATE '2019-05-30', 35000, 'Vodacom');
INSERT INTO vodacom_network_towers VALUES (10, 'TWR-WC-002', 'Stellenbosch Tower', -33.932300, 18.860400, 'Western Cape', 'Stellenbosch', '4G', 4000, 'Operational', DATE '2020-07-12', 32000, 'Shared');

COMMIT;

-- ============================================================================
-- NETWORK ISSUES TABLE
-- ============================================================================
CREATE TABLE vodacom_network_issues (
    issue_id          NUMBER PRIMARY KEY,
    issue_ref         VARCHAR2(30) NOT NULL UNIQUE,
    tower_id          NUMBER,
    issue_type        VARCHAR2(50),
    description       VARCHAR2(500),
    severity          VARCHAR2(20),
    status            VARCHAR2(20) DEFAULT 'Open',
    reported_date     DATE DEFAULT SYSDATE,
    resolved_date     DATE,
    assigned_to       NUMBER,
    CONSTRAINT fk_issue_tower FOREIGN KEY (tower_id) REFERENCES vodacom_network_towers(tower_id),
    CONSTRAINT fk_issue_emp FOREIGN KEY (assigned_to) REFERENCES vodacom_employees(emp_id)
);

CREATE SEQUENCE vodacom_network_issues_seq START WITH 1;

-- Insert 10 network issues
INSERT INTO vodacom_network_issues VALUES (1, 'ISS-2024-001', 1, 'Signal Degradation', 'Intermittent signal loss reported by customers', 'High', 'In Progress', DATE '2024-01-10', NULL, 5);
INSERT INTO vodacom_network_issues VALUES (2, 'ISS-2024-002', 2, 'Power Outage', 'Tower experienced power failure', 'Critical', 'Resolved', DATE '2024-01-15', DATE '2024-01-16', 5);
INSERT INTO vodacom_network_issues VALUES (3, 'ISS-2024-003', 3, 'Equipment Malfunction', '5G antenna not responding', 'High', 'In Progress', DATE '2024-02-01', NULL, 5);
INSERT INTO vodacom_network_issues VALUES (4, 'ISS-2024-004', 4, 'Interference', 'External interference affecting signal quality', 'Medium', 'Open', DATE '2024-02-05', NULL, 5);
INSERT INTO vodacom_network_issues VALUES (5, 'ISS-2024-005', 5, 'Maintenance Required', 'Scheduled maintenance due', 'Low', 'Scheduled', DATE '2024-02-10', NULL, 5);
INSERT INTO vodacom_network_issues VALUES (6, 'ISS-2024-006', 6, 'Weather Damage', 'Lightning strike damaged equipment', 'Critical', 'Resolved', DATE '2024-01-20', DATE '2024-01-25', 5);
INSERT INTO vodacom_network_issues VALUES (7, 'ISS-2024-007', 7, 'Capacity Overload', 'Tower reaching capacity limits', 'Medium', 'Open', DATE '2024-02-12', NULL, 5);
INSERT INTO vodacom_network_issues VALUES (8, 'ISS-2024-008', 8, 'Cable Theft', 'Copper cables stolen', 'High', 'In Progress', DATE '2024-02-15', NULL, 5);
INSERT INTO vodacom_network_issues VALUES (9, 'ISS-2024-009', 9, 'Software Update', 'Firmware update required', 'Low', 'Scheduled', DATE '2024-02-18', NULL, 5);
INSERT INTO vodacom_network_issues VALUES (10, 'ISS-2024-010', 10, 'Signal Degradation', 'Poor coverage in surrounding area', 'Medium', 'Open', DATE '2024-02-20', NULL, 5);

COMMIT;

-- ============================================================================
-- CUSTOMER SUPPORT TABLE
-- ============================================================================
CREATE TABLE vodacom_customer_support (
    ticket_id         NUMBER PRIMARY KEY,
    ticket_ref        VARCHAR2(30) NOT NULL UNIQUE,
    customer_id       NUMBER NOT NULL,
    issue_type        VARCHAR2(50),
    priority          VARCHAR2(20) DEFAULT 'Medium',
    status            VARCHAR2(20) DEFAULT 'Open',
    description       VARCHAR2(1000),
    created_date      DATE DEFAULT SYSDATE,
    resolved_date     DATE,
    assigned_to       NUMBER,
    resolution_notes  VARCHAR2(1000),
    CONSTRAINT fk_support_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id),
    CONSTRAINT fk_support_emp FOREIGN KEY (assigned_to) REFERENCES vodacom_employees(emp_id)
);

CREATE SEQUENCE vodacom_customer_support_seq START WITH 1;

-- Insert 10 support tickets
INSERT INTO vodacom_customer_support VALUES (1, 'TKT-2024-001', 1, 'Billing Query', 'High', 'Resolved', 'Incorrect charge on bill', DATE '2024-01-10', DATE '2024-01-12', 2, 'Refund processed');
INSERT INTO vodacom_customer_support VALUES (2, 'TKT-2024-002', 2, 'Network Issue', 'High', 'In Progress', 'No signal at home', DATE '2024-01-15', NULL, 2, NULL);
INSERT INTO vodacom_customer_support VALUES (3, 'TKT-2024-003', 3, 'Data Issue', 'Medium', 'Resolved', 'Data not working', DATE '2024-01-20', DATE '2024-01-21', 3, 'APN settings corrected');
INSERT INTO vodacom_customer_support VALUES (4, 'TKT-2024-004', 4, 'SIM Card', 'High', 'Resolved', 'SIM not detected', DATE '2024-01-25', DATE '2024-01-26', 2, 'New SIM card issued');
INSERT INTO vodacom_customer_support VALUES (5, 'TKT-2024-005', 5, 'Account Access', 'Medium', 'Open', 'Cannot login to MyVodacom app', DATE '2024-02-01', NULL, 3, NULL);
INSERT INTO vodacom_customer_support VALUES (6, 'TKT-2024-006', 6, 'VodaPay Query', 'Low', 'Resolved', 'How to activate VodaPay', DATE '2024-02-05', DATE '2024-02-05', 2, 'Activation steps sent via SMS');
INSERT INTO vodacom_customer_support VALUES (7, 'TKT-2024-007', 7, 'Package Upgrade', 'Low', 'In Progress', 'Want to upgrade package', DATE '2024-02-10', NULL, 3, NULL);
INSERT INTO vodacom_customer_support VALUES (8, 'TKT-2024-008', 8, 'Network Issue', 'High', 'Open', 'Frequent call drops', DATE '2024-02-15', NULL, 2, NULL);
INSERT INTO vodacom_customer_support VALUES (9, 'TKT-2024-009', 9, 'Data Query', 'Medium', 'Resolved', 'Data depleting too fast', DATE '2024-02-18', DATE '2024-02-19', 3, 'Data usage report provided');
INSERT INTO vodacom_customer_support VALUES (10, 'TKT-2024-010', 10, 'General Query', 'Low', 'Resolved', 'Contract renewal options', DATE '2024-02-20', DATE '2024-02-20', 2, 'Options emailed to customer');

COMMIT;

-- ============================================================================
-- SALES TABLE
-- ============================================================================
CREATE TABLE vodacom_sales (
    sale_id           NUMBER PRIMARY KEY,
    sale_ref          VARCHAR2(30) NOT NULL UNIQUE,
    customer_id       NUMBER NOT NULL,
    sales_agent_id    NUMBER NOT NULL,
    sale_type         VARCHAR2(50),
    product_name      VARCHAR2(200),
    sale_amount       NUMBER(10,2) NOT NULL,
    sale_date         DATE DEFAULT SYSDATE,
    commission_amount NUMBER(8,2),
    payment_method    VARCHAR2(50),
    CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id),
    CONSTRAINT fk_sales_agent FOREIGN KEY (sales_agent_id) REFERENCES vodacom_employees(emp_id)
);

CREATE SEQUENCE vodacom_sales_seq START WITH 1;

-- Insert 10 sales transactions
INSERT INTO vodacom_sales VALUES (1, 'SAL-2024-001', 1, 7, 'Device Sale', 'Samsung Galaxy A54', 5999.00, DATE '2024-01-10', 599.90, 'Cash');
INSERT INTO vodacom_sales VALUES (2, 'SAL-2024-002', 2, 7, 'Contract Sign-up', 'Red Plan 199 with iPhone 14', 15999.00, DATE '2024-01-15', 1599.90, 'Contract');
INSERT INTO vodacom_sales VALUES (3, 'SAL-2024-003', 3, 7, 'Device Sale', 'Huawei P40', 8999.00, DATE '2024-01-20', 899.90, 'Card');
INSERT INTO vodacom_sales VALUES (4, 'SAL-2024-004', 4, 7, 'Contract Upgrade', 'Red Plan 299 with Samsung S23', 12999.00, DATE '2024-01-25', 1299.90, 'Contract');
INSERT INTO vodacom_sales VALUES (5, 'SAL-2024-005', 5, 7, 'Accessory Sale', 'Wireless Earbuds', 1299.00, DATE '2024-02-01', 129.90, 'Cash');
INSERT INTO vodacom_sales VALUES (6, 'SAL-2024-006', 6, 7, 'Device Sale', 'Samsung Galaxy Tab', 4999.00, DATE '2024-02-05', 499.90, 'EFT');
INSERT INTO vodacom_sales VALUES (7, 'SAL-2024-007', 7, 7, 'SIM Card Sale', 'Prepaid SIM Starter Pack', 10.00, DATE '2024-02-10', 1.00, 'Cash');
INSERT INTO vodacom_sales VALUES (8, 'SAL-2024-008', 8, 7, 'Device Sale', 'Xiaomi Redmi Note', 3999.00, DATE '2024-02-15', 399.90, 'Card');
INSERT INTO vodacom_sales VALUES (9, 'SAL-2024-009', 9, 7, 'Accessory Sale', 'Phone Case and Screen Protector', 399.00, DATE '2024-02-18', 39.90, 'Cash');
INSERT INTO vodacom_sales VALUES (10, 'SAL-2024-010', 10, 7, 'Contract Sign-up', 'Red Plan 299 with Samsung S24', 14999.00, DATE '2024-02-20', 1499.90, 'Contract');

COMMIT;

-- ============================================================================
-- VODAPAY ACCOUNTS TABLE
-- ============================================================================
CREATE TABLE vodacom_vodapay_accounts (
    vodapay_id        NUMBER PRIMARY KEY,
    customer_id       NUMBER NOT NULL UNIQUE,
    wallet_number     VARCHAR2(20) NOT NULL UNIQUE,
    balance           NUMBER(10,2) DEFAULT 0,
    status            VARCHAR2(20) DEFAULT 'Active',
    activation_date   DATE DEFAULT SYSDATE,
    kyc_verified      VARCHAR2(1) DEFAULT 'N',
    daily_limit       NUMBER(10,2) DEFAULT 5000,
    CONSTRAINT fk_vodapay_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id)
);

CREATE SEQUENCE vodacom_vodapay_accounts_seq START WITH 1;

-- Insert 10 VodaPay accounts
INSERT INTO vodacom_vodapay_accounts VALUES (1, 1, 'VP-0821234567', 1250.50, 'Active', DATE '2023-01-15', 'Y', 10000);
INSERT INTO vodacom_vodapay_accounts VALUES (2, 2, 'VP-0839876543', 3450.00, 'Active', DATE '2023-02-20', 'Y', 10000);
INSERT INTO vodacom_vodapay_accounts VALUES (3, 3, 'VP-0765432109', 5670.25, 'Active', DATE '2023-03-10', 'Y', 20000);
INSERT INTO vodacom_vodapay_accounts VALUES (4, 5, 'VP-0827654321', 890.75, 'Active', DATE '2023-05-12', 'Y', 10000);
INSERT INTO vodacom_vodapay_accounts VALUES (5, 6, 'VP-0115551234', 45000.00, 'Active', DATE '2023-06-18', 'Y', 100000);
INSERT INTO vodacom_vodapay_accounts VALUES (6, 8, 'VP-0736789012', 2340.50, 'Active', DATE '2023-08-30', 'Y', 10000);
INSERT INTO vodacom_vodapay_accounts VALUES (7, 9, 'VP-0821231234', 1567.80, 'Active', DATE '2023-09-14', 'Y', 10000);
INSERT INTO vodacom_vodapay_accounts VALUES (8, 1, 'VP-ALT-001', 450.00, 'Active', DATE '2023-11-01', 'N', 5000);
INSERT INTO vodacom_vodapay_accounts VALUES (9, 3, 'VP-ALT-002', 780.25, 'Active', DATE '2023-12-05', 'N', 5000);
INSERT INTO vodacom_vodapay_accounts VALUES (10, 5, 'VP-ALT-003', 320.00, 'Active', DATE '2024-01-10', 'N', 5000);

COMMIT;

-- ============================================================================
-- INVOICES TABLE
-- ============================================================================
CREATE TABLE vodacom_invoices (
    invoice_id        NUMBER PRIMARY KEY,
    invoice_number    VARCHAR2(30) NOT NULL UNIQUE,
    customer_id       NUMBER NOT NULL,
    invoice_date      DATE DEFAULT SYSDATE,
    due_date          DATE,
    total_amount      NUMBER(10,2) NOT NULL,
    tax_amount        NUMBER(10,2),
    status            VARCHAR2(20) DEFAULT 'Pending',
    payment_date      DATE,
    generated_by      NUMBER,
    CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id),
    CONSTRAINT fk_invoice_emp FOREIGN KEY (generated_by) REFERENCES vodacom_employees(emp_id)
);

CREATE SEQUENCE vodacom_invoices_seq START WITH 1;

-- Insert 10 invoices
INSERT INTO vodacom_invoices VALUES (1, 'INV-2024-001', 2, DATE '2024-01-01', DATE '2024-01-15', 199.00, 29.85, 'Paid', DATE '2024-01-10', 8);
INSERT INTO vodacom_invoices VALUES (2, 'INV-2024-002', 4, DATE '2024-01-01', DATE '2024-01-15', 299.00, 44.85, 'Paid', DATE '2024-01-12', 8);
INSERT INTO vodacom_invoices VALUES (3, 'INV-2024-003', 6, DATE '2024-01-01', DATE '2024-01-15', 2499.00, 374.85, 'Paid', DATE '2024-01-14', 8);
INSERT INTO vodacom_invoices VALUES (4, 'INV-2024-004', 2, DATE '2024-02-01', DATE '2024-02-15', 199.00, 29.85, 'Pending', NULL, 8);
INSERT INTO vodacom_invoices VALUES (5, 'INV-2024-005', 4, DATE '2024-02-01', DATE '2024-02-15', 299.00, 44.85, 'Pending', NULL, 8);
INSERT INTO vodacom_invoices VALUES (6, 'INV-2024-006', 6, DATE '2024-02-01', DATE '2024-02-15', 2499.00, 374.85, 'Paid', DATE '2024-02-10', 8);
INSERT INTO vodacom_invoices VALUES (7, 'INV-2024-007', 2, DATE '2024-03-01', DATE '2024-03-15', 199.00, 29.85, 'Pending', NULL, 8);
INSERT INTO vodacom_invoices VALUES (8, 'INV-2024-008', 4, DATE '2024-03-01', DATE '2024-03-15', 299.00, 44.85, 'Pending', NULL, 8);
INSERT INTO vodacom_invoices VALUES (9, 'INV-2024-009', 6, DATE '2024-03-01', DATE '2024-03-15', 2499.00, 374.85, 'Pending', NULL, 8);
INSERT INTO vodacom_invoices VALUES (10, 'INV-2024-010', 1, DATE '2024-01-05', DATE '2024-01-20', 549.00, 82.35, 'Overdue', NULL, 8);

COMMIT;

-- ============================================================================
-- INVOICE ITEMS TABLE
-- ============================================================================
CREATE TABLE vodacom_invoice_items (
    item_id           NUMBER PRIMARY KEY,
    invoice_id        NUMBER NOT NULL,
    item_type         VARCHAR2(50),
    description       VARCHAR2(200),
    quantity          NUMBER(8,2) DEFAULT 1,
    unit_price        NUMBER(10,2) NOT NULL,
    amount            NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_item_invoice FOREIGN KEY (invoice_id) REFERENCES vodacom_invoices(invoice_id) ON DELETE CASCADE
);

CREATE SEQUENCE vodacom_invoice_items_seq START WITH 1;

-- Insert 10 invoice items
INSERT INTO vodacom_invoice_items VALUES (1, 1, 'Subscription', 'Red Plan 199 Monthly Fee', 1, 199.00, 199.00);
INSERT INTO vodacom_invoice_items VALUES (2, 2, 'Subscription', 'Red Plan 299 Monthly Fee', 1, 299.00, 299.00);
INSERT INTO vodacom_invoice_items VALUES (3, 3, 'Subscription', 'Business Plan Monthly Fee', 1, 1999.00, 1999.00);
INSERT INTO vodacom_invoice_items VALUES (4, 3, 'Service', 'Additional Lines (5x)', 5, 100.00, 500.00);
INSERT INTO vodacom_invoice_items VALUES (5, 4, 'Subscription', 'Red Plan 199 Monthly Fee', 1, 199.00, 199.00);
INSERT INTO vodacom_invoice_items VALUES (6, 5, 'Subscription', 'Red Plan 299 Monthly Fee', 1, 299.00, 299.00);
INSERT INTO vodacom_invoice_items VALUES (7, 6, 'Subscription', 'Business Plan Monthly Fee', 1, 1999.00, 1999.00);
INSERT INTO vodacom_invoice_items VALUES (8, 6, 'Service', 'Additional Lines (5x)', 5, 100.00, 500.00);
INSERT INTO vodacom_invoice_items VALUES (9, 10, 'Purchase', 'Samsung Galaxy A54', 1, 549.00, 549.00);
INSERT INTO vodacom_invoice_items VALUES (10, 1, 'Service', 'Insurance Premium', 1, 49.00, 49.00);

COMMIT;

-- ============================================================================
-- TRANSACTIONS TABLE (Updated to include package reference)
-- ============================================================================
CREATE TABLE vodacom_subscriptions (
    subscription_id   NUMBER PRIMARY KEY,
    customer_id       NUMBER NOT NULL,
    package_id        NUMBER NOT NULL,
    start_date        DATE DEFAULT SYSDATE,
    end_date          DATE,
    status            VARCHAR2(20) DEFAULT 'Active',
    CONSTRAINT fk_sub_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id),
    CONSTRAINT fk_sub_package FOREIGN KEY (package_id) REFERENCES vodacom_packages(package_id)
);

CREATE SEQUENCE vodacom_subscriptions_seq START WITH 1;

-- Insert 10 subscriptions
INSERT INTO vodacom_subscriptions VALUES (1, 1, 1, DATE '2024-01-01', DATE '2024-01-31', 'Active');
INSERT INTO vodacom_subscriptions VALUES (2, 2, 5, DATE '2024-01-01', DATE '2024-01-31', 'Active');
INSERT INTO vodacom_subscriptions VALUES (3, 3, 3, DATE '2024-01-05', DATE '2024-02-04', 'Active');
INSERT INTO vodacom_subscriptions VALUES (4, 4, 6, DATE '2024-01-10', DATE '2024-02-09', 'Active');
INSERT INTO vodacom_subscriptions VALUES (5, 5, 2, DATE '2024-01-15', DATE '2024-02-14', 'Active');
INSERT INTO vodacom_subscriptions VALUES (6, 6, 7, DATE '2024-01-20', DATE '2024-02-19', 'Active');
INSERT INTO vodacom_subscriptions VALUES (7, 7, 4, DATE '2024-01-25', DATE '2024-02-24', 'Active');
INSERT INTO vodacom_subscriptions VALUES (8, 8, 9, DATE '2024-02-01', DATE '2024-03-01', 'Active');
INSERT INTO vodacom_subscriptions VALUES (9, 9, 8, DATE '2024-02-05', DATE '2024-02-11', 'Expired');
INSERT INTO vodacom_subscriptions VALUES (10, 10, 10, DATE '2024-02-10', DATE '2024-03-10', 'Active');

COMMIT;

-- ============================================================================
-- TRANSACTIONS TABLE (Enhanced with package and employee references)
-- ============================================================================
CREATE TABLE vodacom_transactions (
    transaction_id    NUMBER PRIMARY KEY,
    transaction_ref   VARCHAR2(30) NOT NULL UNIQUE,
    customer_id       NUMBER NOT NULL,
    package_id        NUMBER,
    transaction_date  DATE DEFAULT SYSDATE,
    transaction_type  VARCHAR2(50),
    amount            NUMBER(10,2) NOT NULL,
    payment_method    VARCHAR2(50),
    description       VARCHAR2(200),
    processed_by      NUMBER,
    CONSTRAINT fk_trans_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id),
    CONSTRAINT fk_trans_package FOREIGN KEY (package_id) REFERENCES vodacom_packages(package_id),
    CONSTRAINT fk_trans_emp FOREIGN KEY (processed_by) REFERENCES vodacom_employees(emp_id)
);

CREATE SEQUENCE vodacom_transactions_seq START WITH 1;

-- Insert 10 transactions
INSERT INTO vodacom_transactions VALUES (1, 'TXN-2024-001', 1, 1, DATE '2024-01-01', 'Recharge', 99.00, 'Cash', 'Smart S package purchase', 2);
INSERT INTO vodacom_transactions VALUES (2, 'TXN-2024-002', 2, 5, DATE '2024-01-01', 'Subscription', 199.00, 'Debit Order', 'Red Plan 199 monthly payment', 8);
INSERT INTO vodacom_transactions VALUES (3, 'TXN-2024-003', 3, 3, DATE '2024-01-05', 'Recharge', 299.00, 'Card', 'Smart L package purchase', 2);
INSERT INTO vodacom_transactions VALUES (4, 'TXN-2024-004', 4, 6, DATE '2024-01-10', 'Subscription', 299.00, 'Debit Order', 'Red Plan 299 monthly payment', 8);
INSERT INTO vodacom_transactions VALUES (5, 'TXN-2024-005', 5, 2, DATE '2024-01-15', 'Recharge', 149.00, 'EFT', 'Smart M package purchase', 3);
INSERT INTO vodacom_transactions VALUES (6, 'TXN-2024-006', 6, 7, DATE '2024-01-20', 'Subscription', 499.00, 'Debit Order', 'Red Plan 499 monthly payment', 8);
INSERT INTO vodacom_transactions VALUES (7, 'TXN-2024-007', 7, 4, DATE '2024-01-25', 'Recharge', 499.00, 'Cash', 'Smart XL package purchase', 2);
INSERT INTO vodacom_transactions VALUES (8, 'TXN-2024-008', 8, 9, DATE '2024-02-01', 'Data Purchase', 199.00, 'VodaPay', 'Data Only 5GB purchase', 3);
INSERT INTO vodacom_transactions VALUES (9, 'TXN-2024-009', 9, 8, DATE '2024-02-05', 'Data Purchase', 49.00, 'Card', 'Data Only 1GB purchase', 2);
INSERT INTO vodacom_transactions VALUES (10, 'TXN-2024-010', 10, 10, DATE '2024-02-10', 'Data Purchase', 99.00, 'Cash', 'Night Owl 10GB purchase', 3);

COMMIT;

-- ============================================================================
-- SUPPORT TICKETS TABLE
-- ============================================================================
CREATE TABLE vodacom_support_tickets (
    ticket_id         NUMBER PRIMARY KEY,
    customer_id       NUMBER NOT NULL,
    issue_type        VARCHAR2(50),
    description       VARCHAR2(500),
    created_date      DATE DEFAULT SYSDATE,
    status            VARCHAR2(20) DEFAULT 'Open',
    priority          VARCHAR2(20) DEFAULT 'Medium',
    CONSTRAINT fk_ticket_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id)
);

CREATE SEQUENCE vodacom_support_tickets_seq START WITH 1;

-- Insert 10 support tickets
INSERT INTO vodacom_support_tickets VALUES (1, 1, 'Network Issue', 'Poor signal strength in my area', DATE '2024-01-10', 'Open', 'High');
INSERT INTO vodacom_support_tickets VALUES (2, 2, 'Billing Query', 'Incorrect charge on my account', DATE '2024-01-15', 'Resolved', 'Medium');
INSERT INTO vodacom_support_tickets VALUES (3, 3, 'Data Issue', 'Data not working after recharge', DATE '2024-01-20', 'In Progress', 'High');
INSERT INTO vodacom_support_tickets VALUES (4, 4, 'SIM Issue', 'SIM card not detected', DATE '2024-01-25', 'Resolved', 'High');
INSERT INTO vodacom_support_tickets VALUES (5, 5, 'Account Issue', 'Cannot access my account online', DATE '2024-02-01', 'Open', 'Medium');
INSERT INTO vodacom_support_tickets VALUES (6, 6, 'Network Issue', 'No network coverage at home', DATE '2024-02-05', 'In Progress', 'High');
INSERT INTO vodacom_support_tickets VALUES (7, 7, 'Billing Query', 'Need invoice for last month', DATE '2024-02-10', 'Resolved', 'Low');
INSERT INTO vodacom_support_tickets VALUES (8, 8, 'General Inquiry', 'Want to upgrade my package', DATE '2024-02-15', 'Open', 'Low');
INSERT INTO vodacom_support_tickets VALUES (9, 9, 'Data Issue', 'Data finished too quickly', DATE '2024-02-20', 'In Progress', 'Medium');
INSERT INTO vodacom_support_tickets VALUES (10, 10, 'Network Issue', 'Dropped calls frequently', DATE '2024-02-25', 'Open', 'High');

COMMIT;

-- ============================================================================
-- CONTRACT TYPES TABLE
-- ============================================================================
CREATE TABLE vodacom_contract_types (
    contract_type_id  NUMBER PRIMARY KEY,
    type_name         VARCHAR2(100) NOT NULL,
    duration_months   NUMBER(3,0) NOT NULL,
    min_spend         NUMBER(8,2),
    cancellation_fee  NUMBER(8,2),
    description       VARCHAR2(500)
);

CREATE SEQUENCE vodacom_contract_types_seq START WITH 1;

-- Insert 10 contract types
INSERT INTO vodacom_contract_types VALUES (1, '12 Month Flexi', 12, 199.00, 500.00, 'Flexible 12-month contract with upgrade options');
INSERT INTO vodacom_contract_types VALUES (2, '24 Month Standard', 24, 299.00, 1000.00, 'Standard 24-month contract with device subsidy');
INSERT INTO vodacom_contract_types VALUES (3, '36 Month Premium', 36, 499.00, 2000.00, 'Premium 36-month contract with free device');
INSERT INTO vodacom_contract_types VALUES (4, '24 Month Red VIP', 24, 599.00, 1500.00, 'VIP Red contract with priority support');
INSERT INTO vodacom_contract_types VALUES (5, '12 Month Business', 12, 399.00, 800.00, 'Business contract with corporate benefits');
INSERT INTO vodacom_contract_types VALUES (6, '24 Month Family', 24, 249.00, 900.00, 'Family plan with shared data');
INSERT INTO vodacom_contract_types VALUES (7, '18 Month Smart', 18, 349.00, 700.00, 'Smart contract with data rollover');
INSERT INTO vodacom_contract_types VALUES (8, '24 Month Student', 24, 149.00, 400.00, 'Student contract with special rates');
INSERT INTO vodacom_contract_types VALUES (9, '36 Month Enterprise', 36, 999.00, 3000.00, 'Enterprise contract for corporate clients');
INSERT INTO vodacom_contract_types VALUES (10, '12 Month Trial', 12, 99.00, 200.00, 'Trial contract for new customers');

COMMIT;

-- ============================================================================
-- CUSTOMER CONTRACTS TABLE
-- ============================================================================
CREATE TABLE vodacom_customer_contracts (
    contract_id       NUMBER PRIMARY KEY,
    customer_id       NUMBER NOT NULL,
    contract_type_id  NUMBER NOT NULL,
    package_id        NUMBER NOT NULL,
    start_date        DATE NOT NULL,
    end_date          DATE NOT NULL,
    monthly_fee       NUMBER(8,2) NOT NULL,
    device_name       VARCHAR2(100),
    device_cost       NUMBER(10,2),
    status            VARCHAR2(20) DEFAULT 'Active',
    CONSTRAINT fk_contract_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id),
    CONSTRAINT fk_contract_type FOREIGN KEY (contract_type_id) REFERENCES vodacom_contract_types(contract_type_id),
    CONSTRAINT fk_contract_package FOREIGN KEY (package_id) REFERENCES vodacom_packages(package_id)
);

CREATE SEQUENCE vodacom_customer_contracts_seq START WITH 1;

-- Insert 10 customer contracts
INSERT INTO vodacom_customer_contracts VALUES (1, 2, 2, 5, DATE '2024-01-01', DATE '2026-01-01', 199.00, 'Samsung Galaxy S23', 12999.00, 'Active');
INSERT INTO vodacom_customer_contracts VALUES (2, 4, 2, 6, DATE '2024-01-10', DATE '2026-01-10', 299.00, 'iPhone 14', 15999.00, 'Active');
INSERT INTO vodacom_customer_contracts VALUES (3, 6, 3, 7, DATE '2024-01-20', DATE '2027-01-20', 499.00, 'iPhone 15 Pro', 24999.00, 'Active');
INSERT INTO vodacom_customer_contracts VALUES (4, 1, 1, 5, DATE '2023-06-01', DATE '2024-06-01', 199.00, 'Samsung A54', 5999.00, 'Active');
INSERT INTO vodacom_customer_contracts VALUES (5, 3, 2, 6, DATE '2023-08-15', DATE '2025-08-15', 299.00, 'Huawei P40', 8999.00, 'Active');
INSERT INTO vodacom_customer_contracts VALUES (6, 5, 5, 7, DATE '2024-02-01', DATE '2025-02-01', 399.00, 'Samsung Galaxy Tab', 4999.00, 'Active');
INSERT INTO vodacom_customer_contracts VALUES (7, 7, 7, 6, DATE '2023-10-10', DATE '2025-04-10', 349.00, 'iPhone 13', 13999.00, 'Active');
INSERT INTO vodacom_customer_contracts VALUES (8, 8, 8, 5, DATE '2023-07-01', DATE '2025-07-01', 149.00, 'Samsung A34', 4499.00, 'Active');
INSERT INTO vodacom_customer_contracts VALUES (9, 9, 1, 5, DATE '2023-12-01', DATE '2024-12-01', 199.00, 'Xiaomi Redmi', 3999.00, 'Active');
INSERT INTO vodacom_customer_contracts VALUES (10, 10, 2, 6, DATE '2024-02-10', DATE '2026-02-10', 299.00, 'Samsung S24', 14999.00, 'Active');

COMMIT;

-- ============================================================================
-- CONTRACT RENEWALS TABLE
-- ============================================================================
CREATE TABLE vodacom_contract_renewals (
    renewal_id        NUMBER PRIMARY KEY,
    contract_id       NUMBER NOT NULL,
    renewal_date      DATE DEFAULT SYSDATE,
    old_contract_type NUMBER NOT NULL,
    new_contract_type NUMBER NOT NULL,
    new_device        VARCHAR2(100),
    device_cost       NUMBER(10,2),
    renewal_bonus     NUMBER(8,2),
    status            VARCHAR2(20) DEFAULT 'Completed',
    CONSTRAINT fk_renewal_contract FOREIGN KEY (contract_id) REFERENCES vodacom_customer_contracts(contract_id),
    CONSTRAINT fk_renewal_old_type FOREIGN KEY (old_contract_type) REFERENCES vodacom_contract_types(contract_type_id),
    CONSTRAINT fk_renewal_new_type FOREIGN KEY (new_contract_type) REFERENCES vodacom_contract_types(contract_type_id)
);

CREATE SEQUENCE vodacom_contract_renewals_seq START WITH 1;

-- Insert 10 contract renewals
INSERT INTO vodacom_contract_renewals VALUES (1, 4, DATE '2024-06-01', 1, 2, 'Samsung S24', 14999.00, 500.00, 'Completed');
INSERT INTO vodacom_contract_renewals VALUES (2, 5, DATE '2025-08-15', 2, 3, 'iPhone 16', 25999.00, 1000.00, 'Pending');
INSERT INTO vodacom_contract_renewals VALUES (3, 7, DATE '2025-04-10', 7, 2, 'iPhone 15', 18999.00, 750.00, 'Pending');
INSERT INTO vodacom_contract_renewals VALUES (4, 8, DATE '2025-07-01', 8, 2, 'Samsung A55', 6999.00, 300.00, 'Pending');
INSERT INTO vodacom_contract_renewals VALUES (5, 9, DATE '2024-12-01', 1, 2, 'Xiaomi 14', 8999.00, 400.00, 'Pending');
INSERT INTO vodacom_contract_renewals VALUES (6, 1, DATE '2026-01-01', 2, 3, 'Samsung S26', 22999.00, 1200.00, 'Scheduled');
INSERT INTO vodacom_contract_renewals VALUES (7, 2, DATE '2026-01-10', 2, 2, 'iPhone 16 Pro', 28999.00, 1500.00, 'Scheduled');
INSERT INTO vodacom_contract_renewals VALUES (8, 3, DATE '2027-01-20', 3, 3, 'iPhone 17 Pro Max', 35999.00, 2000.00, 'Scheduled');
INSERT INTO vodacom_contract_renewals VALUES (9, 6, DATE '2025-02-01', 5, 5, 'Samsung Galaxy Tab S9', 8999.00, 600.00, 'Pending');
INSERT INTO vodacom_contract_renewals VALUES (10, 10, DATE '2026-02-10', 2, 2, 'Samsung S26 Ultra', 24999.00, 1800.00, 'Scheduled');

COMMIT;

-- ============================================================================
-- CONTRACT PENALTIES TABLE
-- ============================================================================
CREATE TABLE vodacom_contract_penalties (
    penalty_id        NUMBER PRIMARY KEY,
    contract_id       NUMBER NOT NULL,
    penalty_date      DATE DEFAULT SYSDATE,
    penalty_type      VARCHAR2(50),
    penalty_amount    NUMBER(10,2) NOT NULL,
    months_remaining  NUMBER(3,0),
    reason            VARCHAR2(500),
    status            VARCHAR2(20) DEFAULT 'Pending',
    CONSTRAINT fk_penalty_contract FOREIGN KEY (contract_id) REFERENCES vodacom_customer_contracts(contract_id)
);

CREATE SEQUENCE vodacom_contract_penalties_seq START WITH 1;

-- Insert 10 contract penalties
INSERT INTO vodacom_contract_penalties VALUES (1, 1, DATE '2024-06-15', 'Early Termination', 5000.00, 18, 'Customer moving overseas', 'Paid');
INSERT INTO vodacom_contract_penalties VALUES (2, 2, DATE '2024-08-20', 'Late Payment', 150.00, 16, 'Payment overdue by 30 days', 'Paid');
INSERT INTO vodacom_contract_penalties VALUES (3, 3, DATE '2024-09-10', 'Late Payment', 200.00, 28, 'Payment overdue by 15 days', 'Pending');
INSERT INTO vodacom_contract_penalties VALUES (4, 4, DATE '2024-04-01', 'Early Termination', 2000.00, 2, 'Switching to competitor', 'Waived');
INSERT INTO vodacom_contract_penalties VALUES (5, 5, DATE '2024-07-15', 'Late Payment', 120.00, 12, 'Payment overdue by 20 days', 'Paid');
INSERT INTO vodacom_contract_penalties VALUES (6, 6, DATE '2024-10-05', 'Excess Usage', 450.00, 3, 'Exceeded data limit significantly', 'Paid');
INSERT INTO vodacom_contract_penalties VALUES (7, 7, DATE '2024-11-01', 'Late Payment', 180.00, 6, 'Payment overdue by 45 days', 'Pending');
INSERT INTO vodacom_contract_penalties VALUES (8, 8, DATE '2024-05-20', 'Excess Usage', 250.00, 14, 'International roaming charges', 'Paid');
INSERT INTO vodacom_contract_penalties VALUES (9, 9, DATE '2024-09-15', 'Late Payment', 100.00, 3, 'Payment overdue by 10 days', 'Paid');
INSERT INTO vodacom_contract_penalties VALUES (10, 10, DATE '2024-08-25', 'Excess Usage', 320.00, 18, 'Exceeded voice minutes', 'Paid');

COMMIT;

-- ============================================================================
-- CONTRACT BENEFITS TABLE
-- ============================================================================
CREATE TABLE vodacom_contract_benefits (
    benefit_id        NUMBER PRIMARY KEY,
    contract_id       NUMBER NOT NULL,
    benefit_type      VARCHAR2(50),
    benefit_name      VARCHAR2(100),
    benefit_value     NUMBER(10,2),
    grant_date        DATE DEFAULT SYSDATE,
    expiry_date       DATE,
    status            VARCHAR2(20) DEFAULT 'Active',
    CONSTRAINT fk_benefit_contract FOREIGN KEY (contract_id) REFERENCES vodacom_customer_contracts(contract_id)
);

CREATE SEQUENCE vodacom_contract_benefits_seq START WITH 1;

-- Insert 10 contract benefits
INSERT INTO vodacom_contract_benefits VALUES (1, 1, 'Loyalty Reward', '1GB Bonus Data', 49.00, DATE '2024-01-01', DATE '2024-02-01', 'Claimed');
INSERT INTO vodacom_contract_benefits VALUES (2, 2, 'Loyalty Reward', '2GB Bonus Data', 98.00, DATE '2024-01-10', DATE '2024-02-10', 'Active');
INSERT INTO vodacom_contract_benefits VALUES (3, 3, 'VIP Benefit', 'Airport Lounge Access', 500.00, DATE '2024-01-20', DATE '2025-01-20', 'Active');
INSERT INTO vodacom_contract_benefits VALUES (4, 4, 'Anniversary Gift', '500MB Data', 24.50, DATE '2024-06-01', DATE '2024-07-01', 'Active');
INSERT INTO vodacom_contract_benefits VALUES (5, 5, 'Loyalty Reward', 'Free Device Insurance', 99.00, DATE '2024-08-15', DATE '2025-08-15', 'Active');
INSERT INTO vodacom_contract_benefits VALUES (6, 6, 'Business Perk', 'Conference Calling', 150.00, DATE '2024-02-01', DATE '2025-02-01', 'Active');
INSERT INTO vodacom_contract_benefits VALUES (7, 7, 'Loyalty Reward', '1.5GB Bonus Data', 73.50, DATE '2024-10-10', DATE '2024-11-10', 'Active');
INSERT INTO vodacom_contract_benefits VALUES (8, 8, 'Student Discount', '20% Monthly Discount', 29.80, DATE '2024-07-01', DATE '2025-07-01', 'Active');
INSERT INTO vodacom_contract_benefits VALUES (9, 9, 'Welcome Bonus', '2GB Welcome Data', 98.00, DATE '2023-12-01', DATE '2024-01-01', 'Expired');
INSERT INTO vodacom_contract_benefits VALUES (10, 10, 'Loyalty Reward', 'Free Spotify Premium', 119.00, DATE '2024-02-10', DATE '2025-02-10', 'Active');

COMMIT;

-- ============================================================================
-- VERIFICATION
-- ============================================================================
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('VODACOM DATABASE SETUP COMPLETE!');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('✓ 13 CORE ENTERPRISE TABLES (10 records each):');
    DBMS_OUTPUT.PUT_LINE('  1. VODACOM_DEPARTMENTS');
    DBMS_OUTPUT.PUT_LINE('  2. VODACOM_EMPLOYEES');
    DBMS_OUTPUT.PUT_LINE('  3. VODACOM_CUSTOMERS');
    DBMS_OUTPUT.PUT_LINE('  4. VODACOM_MOBILE_NUMBERS');
    DBMS_OUTPUT.PUT_LINE('  5. VODACOM_PACKAGES');
    DBMS_OUTPUT.PUT_LINE('  6. VODACOM_TRANSACTIONS');
    DBMS_OUTPUT.PUT_LINE('  7. VODACOM_NETWORK_TOWERS');
    DBMS_OUTPUT.PUT_LINE('  8. VODACOM_NETWORK_ISSUES');
    DBMS_OUTPUT.PUT_LINE('  9. VODACOM_CUSTOMER_SUPPORT');
    DBMS_OUTPUT.PUT_LINE('  10. VODACOM_SALES');
    DBMS_OUTPUT.PUT_LINE('  11. VODACOM_VODAPAY_ACCOUNTS');
    DBMS_OUTPUT.PUT_LINE('  12. VODACOM_INVOICES');
    DBMS_OUTPUT.PUT_LINE('  13. VODACOM_INVOICE_ITEMS');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('✓ 7 CONTRACT MANAGEMENT TABLES (10 records each):');
    DBMS_OUTPUT.PUT_LINE('  14. VODACOM_SUBSCRIPTIONS');
    DBMS_OUTPUT.PUT_LINE('  15. VODACOM_SUPPORT_TICKETS');
    DBMS_OUTPUT.PUT_LINE('  16. VODACOM_CONTRACT_TYPES');
    DBMS_OUTPUT.PUT_LINE('  17. VODACOM_CUSTOMER_CONTRACTS');
    DBMS_OUTPUT.PUT_LINE('  18. VODACOM_CONTRACT_RENEWALS');
    DBMS_OUTPUT.PUT_LINE('  19. VODACOM_CONTRACT_PENALTIES');
    DBMS_OUTPUT.PUT_LINE('  20. VODACOM_CONTRACT_BENEFITS');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('TOTAL: 20 TABLES WITH 200 SAMPLE RECORDS');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('ALL TABLES FROM SETUP-SAMPLE-DATA-VODACOM.SQL');
    DBMS_OUTPUT.PUT_LINE('Now fully compatible with all lab exercises!');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Quick test queries:');
    DBMS_OUTPUT.PUT_LINE('  -- Core business tables');
    DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_customers;');
    DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_employees;');
    DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_network_towers;');
    DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_invoices;');
    DBMS_OUTPUT.PUT_LINE('  -- Contract tables');
    DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_customer_contracts;');
    DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_contract_types;');
    DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_contract_renewals;');
    DBMS_OUTPUT.PUT_LINE('========================================');
END;
/
