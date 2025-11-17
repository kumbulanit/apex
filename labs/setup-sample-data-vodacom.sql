-- ============================================================================
-- Vodacom Network Services Sample Database Setup Script
-- Oracle APEX Training Course
-- ============================================================================
-- This script creates the complete Vodacom database schema with sample data
-- for all hands-on labs throughout the training course.
--
-- BUSINESS CONTEXT:
-- Vodacom is a leading cellular network service provider offering:
-- - Mobile voice and data services
-- - Prepaid and postpaid packages
-- - VodaPay (mobile payment system)
-- - Enterprise solutions
-- - Broadband and fiber services
--
-- ⚠️ IMPORTANT INSTRUCTIONS - READ BEFORE RUNNING:
--
-- METHOD 1: SQL Scripts (RECOMMENDED):
-- 1. Log into your APEX workspace as the workspace administrator
-- 2. Navigate to SQL Workshop > SQL Scripts
-- 3. Click "Upload" and select this file
-- 4. Click "Run" button (NOT "Run Now")
-- 5. Review the results - all tables should be created successfully
--
-- METHOD 2: SQL Commands (NOT RECOMMENDED - Will show errors):
-- Running in SQL Commands will show "table or view does not exist" errors
-- because it tries to parse all statements before executing them.
-- Always use SQL Scripts instead.
--
-- ESTIMATED TIME: 2-3 minutes
-- TABLES CREATED: 13 tables with sample data
-- SAMPLE RECORDS: ~200+ records across all tables
-- ============================================================================

-- ============================================================================
-- CLEANUP: Drop existing objects (if re-running script)
-- ============================================================================
BEGIN
    -- Drop tables in reverse dependency order
    FOR rec IN (SELECT table_name FROM user_tables WHERE table_name LIKE 'VODACOM_%' ORDER BY table_name DESC) LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS';
            DBMS_OUTPUT.PUT_LINE('Dropped table: ' || rec.table_name);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Could not drop ' || rec.table_name || ': ' || SQLERRM);
        END;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Cleanup complete.');
END;
/

-- ============================================================================
-- PHASE 1: CREATE ALL TABLES (WITHOUT foreign keys first)
-- ============================================================================

-- ============================================================================
-- VODACOM_DEPARTMENTS TABLE
-- Organizational structure (Customer Service, Network Operations, Sales, etc.)
-- ============================================================================
CREATE TABLE vodacom_departments (
    dept_id           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
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

-- ============================================================================
-- VODACOM_EMPLOYEES TABLE
-- Staff members including customer service reps, technicians, sales agents
-- ============================================================================
CREATE TABLE vodacom_employees (
    emp_id            NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
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
    employee_type     VARCHAR2(20) DEFAULT 'Permanent' 
                      CHECK (employee_type IN ('Permanent','Contract','Temporary','Commission')),
    status            VARCHAR2(20) DEFAULT 'Active' 
                      CHECK (status IN ('Active','On Leave','Suspended','Terminated')),
    employee_number   VARCHAR2(20) NOT NULL UNIQUE,
    branch_code       VARCHAR2(20),
    commission_rate   NUMBER(5,2),
    created_date      DATE DEFAULT SYSDATE
);

-- ============================================================================
-- VODACOM_CUSTOMERS TABLE
-- Customers (both prepaid and postpaid subscribers)
-- ============================================================================
CREATE TABLE vodacom_customers (
    customer_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_number    VARCHAR2(20) NOT NULL UNIQUE,
    first_name        VARCHAR2(50) NOT NULL,
    last_name         VARCHAR2(50) NOT NULL,
    id_number         VARCHAR2(20) NOT NULL UNIQUE,
    email             VARCHAR2(100),
    phone             VARCHAR2(20) NOT NULL,
    alternate_phone   VARCHAR2(20),
    address_line1     VARCHAR2(200),
    address_line2     VARCHAR2(200),
    city              VARCHAR2(100),
    province          VARCHAR2(50),
    postal_code       VARCHAR2(10),
    customer_type     VARCHAR2(20) DEFAULT 'Individual' 
                      CHECK (customer_type IN ('Individual','Business','Corporate','Government')),
    account_status    VARCHAR2(20) DEFAULT 'Active' 
                      CHECK (account_status IN ('Active','Suspended','Closed','Blacklisted')),
    credit_limit      NUMBER(10,2) DEFAULT 0,
    registration_date DATE DEFAULT SYSDATE,
    last_updated      DATE,
    assigned_agent_id NUMBER,
    vodapay_active    VARCHAR2(1) DEFAULT 'N' CHECK (vodapay_active IN ('Y','N')),
    created_date      DATE DEFAULT SYSDATE
);

-- ============================================================================
-- VODACOM_MOBILE_NUMBERS TABLE
-- Mobile numbers assigned to customers (one customer can have multiple numbers)
-- ============================================================================
CREATE TABLE vodacom_mobile_numbers (
    number_id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    mobile_number     VARCHAR2(20) NOT NULL UNIQUE,
    customer_id       NUMBER NOT NULL,
    number_type       VARCHAR2(20) DEFAULT 'Prepaid' 
                      CHECK (number_type IN ('Prepaid','Postpaid','Contract')),
    sim_card_number   VARCHAR2(50) UNIQUE,
    activation_date   DATE NOT NULL,
    expiry_date       DATE,
    status            VARCHAR2(20) DEFAULT 'Active' 
                      CHECK (status IN ('Active','Suspended','Deactivated','Ported Out')),
    current_package   VARCHAR2(100),
    monthly_fee       NUMBER(8,2) DEFAULT 0,
    data_balance_mb   NUMBER(10,2) DEFAULT 0,
    airtime_balance   NUMBER(8,2) DEFAULT 0,
    sms_balance       NUMBER(6,0) DEFAULT 0,
    last_recharge_date DATE,
    last_usage_date   DATE,
    created_date      DATE DEFAULT SYSDATE
);

-- ============================================================================
-- VODACOM_PACKAGES TABLE
-- Service packages (data bundles, voice plans, SMS bundles)
-- ============================================================================
CREATE TABLE vodacom_packages (
    package_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    package_code      VARCHAR2(20) NOT NULL UNIQUE,
    package_name      VARCHAR2(100) NOT NULL,
    description       VARCHAR2(500),
    package_type      VARCHAR2(30) NOT NULL 
                      CHECK (package_type IN ('Data Only','Voice Only','SMS Only','Combo','Contract','Postpaid Plan')),
    data_allocation_mb NUMBER(10,2),
    voice_minutes     NUMBER(6,0),
    sms_count         NUMBER(6,0),
    price             NUMBER(8,2) NOT NULL,
    validity_days     NUMBER(4,0),
    is_active         VARCHAR2(1) DEFAULT 'Y' CHECK (is_active IN ('Y','N')),
    is_promotional    VARCHAR2(1) DEFAULT 'N' CHECK (is_promotional IN ('Y','N')),
    promo_price       NUMBER(8,2),
    promo_start_date  DATE,
    promo_end_date    DATE,
    created_date      DATE DEFAULT SYSDATE
);

-- ============================================================================
-- VODACOM_TRANSACTIONS TABLE
-- All transactions (recharges, purchases, payments, VodaPay)
-- ============================================================================
CREATE TABLE vodacom_transactions (
    transaction_id    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    transaction_ref   VARCHAR2(30) NOT NULL UNIQUE,
    customer_id       NUMBER NOT NULL,
    mobile_number     VARCHAR2(20),
    transaction_type  VARCHAR2(30) NOT NULL 
                      CHECK (transaction_type IN ('Airtime Purchase','Data Purchase','SMS Purchase',
                                                  'Package Purchase','Payment','VodaPay Transfer',
                                                  'VodaPay Purchase','Bill Payment','International Topup')),
    amount            NUMBER(10,2) NOT NULL,
    payment_method    VARCHAR2(30) NOT NULL 
                      CHECK (payment_method IN ('Cash','Card','EFT','VodaPay','Direct Debit','Voucher')),
    package_id        NUMBER,
    transaction_date  TIMESTAMP DEFAULT SYSTIMESTAMP,
    status            VARCHAR2(20) DEFAULT 'Completed' 
                      CHECK (status IN ('Pending','Completed','Failed','Reversed','Cancelled')),
    processed_by      NUMBER,
    channel           VARCHAR2(30) 
                      CHECK (channel IN ('USSD','App','Web','Store','Call Center','ATM','Agent')),
    notes             VARCHAR2(500),
    created_date      DATE DEFAULT SYSDATE
);

-- ============================================================================
-- VODACOM_NETWORK_TOWERS TABLE
-- Cell towers and network infrastructure
-- ============================================================================
CREATE TABLE vodacom_network_towers (
    tower_id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tower_code        VARCHAR2(20) NOT NULL UNIQUE,
    tower_name        VARCHAR2(100) NOT NULL,
    latitude          NUMBER(10,7),
    longitude         NUMBER(10,7),
    province          VARCHAR2(50) NOT NULL,
    city              VARCHAR2(100),
    address           VARCHAR2(200),
    tower_type        VARCHAR2(30) 
                      CHECK (tower_type IN ('2G','3G','4G','5G','Hybrid')),
    capacity          NUMBER(6,0),
    status            VARCHAR2(20) DEFAULT 'Operational' 
                      CHECK (status IN ('Operational','Maintenance','Offline','Under Construction')),
    installation_date DATE,
    last_maintenance  DATE,
    next_maintenance  DATE,
    owner_type        VARCHAR2(20) 
                      CHECK (owner_type IN ('Vodacom','Leased','Shared')),
    monthly_cost      NUMBER(10,2),
    created_date      DATE DEFAULT SYSDATE
);

-- ============================================================================
-- VODACOM_NETWORK_ISSUES TABLE
-- Network outages, maintenance, and technical issues
-- ============================================================================
CREATE TABLE vodacom_network_issues (
    issue_id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    issue_ref         VARCHAR2(30) NOT NULL UNIQUE,
    tower_id          NUMBER,
    issue_type        VARCHAR2(30) NOT NULL 
                      CHECK (issue_type IN ('Outage','Degraded Service','Maintenance','Hardware Failure',
                                           'Power Failure','Vandalism','Weather Damage')),
    severity          VARCHAR2(20) DEFAULT 'Medium' 
                      CHECK (severity IN ('Critical','High','Medium','Low')),
    description       VARCHAR2(1000) NOT NULL,
    province          VARCHAR2(50),
    city              VARCHAR2(100),
    affected_customers NUMBER(10,0),
    reported_date     TIMESTAMP DEFAULT SYSTIMESTAMP,
    acknowledged_date TIMESTAMP,
    resolved_date     TIMESTAMP,
    status            VARCHAR2(20) DEFAULT 'Open' 
                      CHECK (status IN ('Open','Acknowledged','In Progress','Resolved','Closed')),
    assigned_to       NUMBER,
    resolution_notes  VARCHAR2(1000),
    created_date      DATE DEFAULT SYSDATE
);

-- ============================================================================
-- VODACOM_CUSTOMER_SUPPORT TABLE
-- Customer service tickets and support requests
-- ============================================================================
CREATE TABLE vodacom_customer_support (
    ticket_id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ticket_number     VARCHAR2(30) NOT NULL UNIQUE,
    customer_id       NUMBER NOT NULL,
    mobile_number     VARCHAR2(20),
    issue_category    VARCHAR2(50) NOT NULL 
                      CHECK (issue_category IN ('Billing','Network','Technical','Account',
                                               'VodaPay','Complaint','Query','Request')),
    issue_type        VARCHAR2(100) NOT NULL,
    description       VARCHAR2(2000) NOT NULL,
    priority          VARCHAR2(20) DEFAULT 'Normal' 
                      CHECK (priority IN ('Low','Normal','High','Urgent')),
    status            VARCHAR2(20) DEFAULT 'Open' 
                      CHECK (status IN ('Open','Assigned','In Progress','Pending Customer',
                                       'Resolved','Closed','Escalated')),
    channel           VARCHAR2(30) 
                      CHECK (channel IN ('Call Center','Walk-in','Email','App','Web','Social Media')),
    created_date      TIMESTAMP DEFAULT SYSTIMESTAMP,
    assigned_to       NUMBER,
    assigned_date     TIMESTAMP,
    resolved_date     TIMESTAMP,
    closed_date       TIMESTAMP,
    resolution        VARCHAR2(2000),
    customer_satisfaction NUMBER(1,0) CHECK (customer_satisfaction BETWEEN 1 AND 5)
);

-- ============================================================================
-- VODACOM_SALES TABLE
-- Sales transactions for new contracts, devices, and accessories
-- ============================================================================
CREATE TABLE vodacom_sales (
    sale_id           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    sale_ref          VARCHAR2(30) NOT NULL UNIQUE,
    customer_id       NUMBER NOT NULL,
    sale_date         DATE NOT NULL,
    sale_type         VARCHAR2(30) NOT NULL 
                      CHECK (sale_type IN ('New Contract','Upgrade','Device','Accessory',
                                          'SIM Card','Package','Fiber','Enterprise')),
    product_name      VARCHAR2(200) NOT NULL,
    quantity          NUMBER(4,0) DEFAULT 1,
    unit_price        NUMBER(10,2) NOT NULL,
    discount_percent  NUMBER(5,2) DEFAULT 0,
    discount_amount   NUMBER(10,2) DEFAULT 0,
    total_amount      NUMBER(10,2) NOT NULL,
    payment_method    VARCHAR2(30),
    sales_agent_id    NUMBER NOT NULL,
    commission_amount NUMBER(10,2),
    branch_code       VARCHAR2(20),
    notes             VARCHAR2(500),
    created_date      DATE DEFAULT SYSDATE
);

-- ============================================================================
-- VODACOM_VODAPAY_ACCOUNTS TABLE
-- VodaPay digital wallet accounts
-- ============================================================================
CREATE TABLE vodacom_vodapay_accounts (
    vodapay_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id       NUMBER NOT NULL UNIQUE,
    wallet_number     VARCHAR2(20) NOT NULL UNIQUE,
    linked_mobile     VARCHAR2(20) NOT NULL,
    balance           NUMBER(10,2) DEFAULT 0,
    daily_limit       NUMBER(10,2) DEFAULT 5000,
    monthly_limit     NUMBER(10,2) DEFAULT 50000,
    status            VARCHAR2(20) DEFAULT 'Active' 
                      CHECK (status IN ('Active','Suspended','Closed','Pending Verification')),
    kyc_verified      VARCHAR2(1) DEFAULT 'N' CHECK (kyc_verified IN ('Y','N')),
    activation_date   DATE,
    last_transaction  DATE,
    total_spent       NUMBER(12,2) DEFAULT 0,
    total_received    NUMBER(12,2) DEFAULT 0,
    created_date      DATE DEFAULT SYSDATE
);

-- ============================================================================
-- VODACOM_INVOICES TABLE
-- Monthly invoices for postpaid customers
-- ============================================================================
CREATE TABLE vodacom_invoices (
    invoice_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    invoice_number    VARCHAR2(30) NOT NULL UNIQUE,
    customer_id       NUMBER NOT NULL,
    mobile_number     VARCHAR2(20),
    invoice_date      DATE NOT NULL,
    due_date          DATE NOT NULL,
    billing_period    VARCHAR2(50) NOT NULL,
    subtotal          NUMBER(10,2) NOT NULL,
    vat_amount        NUMBER(10,2) NOT NULL,
    total_amount      NUMBER(10,2) NOT NULL,
    amount_paid       NUMBER(10,2) DEFAULT 0,
    balance           NUMBER(10,2),
    status            VARCHAR2(20) DEFAULT 'Issued' 
                      CHECK (status IN ('Draft','Issued','Partially Paid','Paid','Overdue','Written Off')),
    payment_date      DATE,
    generated_by      NUMBER,
    notes             VARCHAR2(500),
    created_date      DATE DEFAULT SYSDATE
);

-- ============================================================================
-- VODACOM_INVOICE_ITEMS TABLE
-- Line items for each invoice (calls, data, SMS, services)
-- ============================================================================
CREATE TABLE vodacom_invoice_items (
    item_id           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    invoice_id        NUMBER NOT NULL,
    item_type         VARCHAR2(50) NOT NULL 
                      CHECK (item_type IN ('Monthly Rental','Voice Calls','Data Usage',
                                          'SMS Charges','International Calls','Roaming',
                                          'Value Added Services','Device Installment','Other')),
    description       VARCHAR2(200) NOT NULL,
    quantity          NUMBER(10,2),
    unit_price        NUMBER(10,2),
    amount            NUMBER(10,2) NOT NULL,
    created_date      DATE DEFAULT SYSDATE
);

-- Commit table creation
COMMIT;

-- ============================================================================
-- PHASE 2: ADD FOREIGN KEYS, INDEXES, AND COMMENTS
-- ============================================================================

-- Add Foreign Keys
ALTER TABLE vodacom_employees ADD CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES vodacom_departments(dept_id);
ALTER TABLE vodacom_employees ADD CONSTRAINT fk_emp_manager FOREIGN KEY (manager_id) REFERENCES vodacom_employees(emp_id);
ALTER TABLE vodacom_departments ADD CONSTRAINT fk_dept_manager FOREIGN KEY (manager_id) REFERENCES vodacom_employees(emp_id);
ALTER TABLE vodacom_customers ADD CONSTRAINT fk_cust_agent FOREIGN KEY (assigned_agent_id) REFERENCES vodacom_employees(emp_id);
ALTER TABLE vodacom_mobile_numbers ADD CONSTRAINT fk_num_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_transactions ADD CONSTRAINT fk_trans_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_transactions ADD CONSTRAINT fk_trans_package FOREIGN KEY (package_id) REFERENCES vodacom_packages(package_id);
ALTER TABLE vodacom_transactions ADD CONSTRAINT fk_trans_emp FOREIGN KEY (processed_by) REFERENCES vodacom_employees(emp_id);
ALTER TABLE vodacom_network_issues ADD CONSTRAINT fk_issue_tower FOREIGN KEY (tower_id) REFERENCES vodacom_network_towers(tower_id);
ALTER TABLE vodacom_network_issues ADD CONSTRAINT fk_issue_emp FOREIGN KEY (assigned_to) REFERENCES vodacom_employees(emp_id);
ALTER TABLE vodacom_customer_support ADD CONSTRAINT fk_support_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_customer_support ADD CONSTRAINT fk_support_emp FOREIGN KEY (assigned_to) REFERENCES vodacom_employees(emp_id);
ALTER TABLE vodacom_sales ADD CONSTRAINT fk_sales_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_sales ADD CONSTRAINT fk_sales_agent FOREIGN KEY (sales_agent_id) REFERENCES vodacom_employees(emp_id);
ALTER TABLE vodacom_vodapay_accounts ADD CONSTRAINT fk_vodapay_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_invoices ADD CONSTRAINT fk_invoice_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id);
ALTER TABLE vodacom_invoices ADD CONSTRAINT fk_invoice_emp FOREIGN KEY (generated_by) REFERENCES vodacom_employees(emp_id);
ALTER TABLE vodacom_invoice_items ADD CONSTRAINT fk_item_invoice FOREIGN KEY (invoice_id) REFERENCES vodacom_invoices(invoice_id) ON DELETE CASCADE;

-- Create Indexes
CREATE INDEX idx_emp_dept ON vodacom_employees(dept_id);
CREATE INDEX idx_emp_status ON vodacom_employees(status);
CREATE INDEX idx_emp_manager ON vodacom_employees(manager_id);
CREATE INDEX idx_cust_type ON vodacom_customers(customer_type);
CREATE INDEX idx_cust_province ON vodacom_customers(province);
CREATE INDEX idx_cust_agent ON vodacom_customers(assigned_agent_id);
CREATE INDEX idx_cust_status ON vodacom_customers(account_status);
CREATE INDEX idx_cust_vodapay ON vodacom_customers(vodapay_active);
CREATE INDEX idx_mobile_customer ON vodacom_mobile_numbers(customer_id);
CREATE INDEX idx_mobile_type ON vodacom_mobile_numbers(number_type);
CREATE INDEX idx_mobile_status ON vodacom_mobile_numbers(status);
CREATE INDEX idx_mobile_sim ON vodacom_mobile_numbers(sim_card_number);
CREATE INDEX idx_pkg_category ON vodacom_packages(category);
CREATE INDEX idx_pkg_type ON vodacom_packages(package_type);
CREATE INDEX idx_pkg_active ON vodacom_packages(is_active);
CREATE INDEX idx_tower_status ON vodacom_network_towers(status);
CREATE INDEX idx_tower_type ON vodacom_network_towers(tower_type);
CREATE INDEX idx_tower_province ON vodacom_network_towers(province);
CREATE INDEX idx_issue_status ON vodacom_network_issues(status);
CREATE INDEX idx_issue_severity ON vodacom_network_issues(severity);
CREATE INDEX idx_issue_tower ON vodacom_network_issues(tower_id);
CREATE INDEX idx_issue_date ON vodacom_network_issues(reported_date);
CREATE INDEX idx_support_customer ON vodacom_customer_support(customer_id);
CREATE INDEX idx_support_status ON vodacom_customer_support(status);
CREATE INDEX idx_support_priority ON vodacom_customer_support(priority);
CREATE INDEX idx_support_assigned ON vodacom_customer_support(assigned_to);
CREATE INDEX idx_support_date ON vodacom_customer_support(created_date);
CREATE INDEX idx_sale_customer ON vodacom_sales(customer_id);
CREATE INDEX idx_sale_date ON vodacom_sales(sale_date);
CREATE INDEX idx_sale_type ON vodacom_sales(sale_type);
CREATE INDEX idx_sale_agent ON vodacom_sales(sales_agent_id);
CREATE INDEX idx_vodapay_customer ON vodacom_vodapay_accounts(customer_id);
CREATE INDEX idx_vodapay_wallet ON vodacom_vodapay_accounts(wallet_number);
CREATE INDEX idx_vodapay_status ON vodacom_vodapay_accounts(status);
CREATE INDEX idx_invoice_customer ON vodacom_invoices(customer_id);
CREATE INDEX idx_invoice_date ON vodacom_invoices(invoice_date);
CREATE INDEX idx_invoice_status ON vodacom_invoices(status);
CREATE INDEX idx_item_invoice ON vodacom_invoice_items(invoice_id);
CREATE INDEX idx_item_type ON vodacom_invoice_items(item_type);

-- Add Table Comments
COMMENT ON TABLE vodacom_departments IS 'Vodacom organizational departments and divisions';
COMMENT ON COLUMN vodacom_departments.dept_code IS 'Short code for department (e.g., CS=Customer Service, NO=Network Ops)';
COMMENT ON COLUMN vodacom_departments.cost_center IS 'Financial cost center code';
COMMENT ON TABLE vodacom_employees IS 'Vodacom employees and staff members';
COMMENT ON COLUMN vodacom_employees.employee_number IS 'Unique employee ID (e.g., VDC001234)';
COMMENT ON COLUMN vodacom_employees.branch_code IS 'Branch location code';
COMMENT ON COLUMN vodacom_employees.commission_rate IS 'Sales commission percentage';
COMMENT ON TABLE vodacom_customers IS 'Vodacom customer master data';
COMMENT ON COLUMN vodacom_customers.account_number IS 'Unique customer account (e.g., VDC-ACC-100001)';
COMMENT ON COLUMN vodacom_customers.customer_type IS 'Individual consumer or Business entity';
COMMENT ON TABLE vodacom_mobile_numbers IS 'Mobile phone numbers assigned to customers';
COMMENT ON COLUMN vodacom_mobile_numbers.number_type IS 'Prepaid, Postpaid, or Contract';
COMMENT ON COLUMN vodacom_mobile_numbers.sim_card_number IS 'Physical SIM card ICCID';
COMMENT ON TABLE vodacom_packages IS 'Available data, voice, and SMS packages';
COMMENT ON TABLE vodacom_transactions IS 'All customer transactions including purchases and payments';
COMMENT ON COLUMN vodacom_transactions.channel IS 'Transaction channel/source';
COMMENT ON TABLE vodacom_network_towers IS 'Network towers and base stations';
COMMENT ON COLUMN vodacom_network_towers.capacity IS 'Maximum concurrent connections';
COMMENT ON TABLE vodacom_network_issues IS 'Network outages and technical issues';
COMMENT ON TABLE vodacom_customer_support IS 'Customer support tickets and service requests';
COMMENT ON TABLE vodacom_sales IS 'Sales transactions for contracts and devices';
COMMENT ON TABLE vodacom_vodapay_accounts IS 'VodaPay mobile wallet accounts';
COMMENT ON TABLE vodacom_invoices IS 'Monthly invoices for postpaid customers';
COMMENT ON TABLE vodacom_invoice_items IS 'Detailed line items for customer invoices';

COMMIT;

-- ============================================================================
-- PHASE 3: INSERT SAMPLE DATA
-- ============================================================================

-- Insert Departments
INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
('Customer Service', 'CS', 15000000, 'Midrand', 'CC-CS-001');
INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
('Network Operations', 'NO', 50000000, 'Midrand', 'CC-NO-001');
INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
('Sales and Distribution', 'SD', 25000000, 'Johannesburg', 'CC-SD-001');
INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
('Finance and Billing', 'FB', 8000000, 'Midrand', 'CC-FB-001');
INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
('Information Technology', 'IT', 35000000, 'Midrand', 'CC-IT-001');
INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
('Marketing', 'MKT', 20000000, 'Johannesburg', 'CC-MKT-001');
INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
('Human Resources', 'HR', 5000000, 'Midrand', 'CC-HR-001');
INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
('VodaPay Division', 'VP', 30000000, 'Cape Town', 'CC-VP-001');

COMMIT;

-- Insert Employees
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Thabo', 'Molefe', 'thabo.molefe@vodacom.co.za', '0836547890', DATE '2018-03-15', 1, 'Customer Service Manager', 65000, 'Permanent', 'VDC001234', 'JHB-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Nomsa', 'Dlamini', 'nomsa.dlamini@vodacom.co.za', '0827654321', DATE '2019-07-22', 1, 'Senior Customer Service Rep', 35000, 'Permanent', 'VDC001235', 'JHB-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Sipho', 'Khumalo', 'sipho.khumalo@vodacom.co.za', '0731234567', DATE '2020-01-10', 1, 'Customer Service Representative', 25000, 'Permanent', 'VDC001236', 'JHB-002');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Zanele', 'Ndlovu', 'zanele.ndlovu@vodacom.co.za', '0829876543', DATE '2021-05-18', 1, 'Customer Service Representative', 24000, 'Permanent', 'VDC001237', 'DBN-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Lerato', 'Mokoena', 'lerato.mokoena@vodacom.co.za', '0765432109', DATE '2022-02-14', 1, 'Customer Service Representative', 23000, 'Permanent', 'VDC001238', 'CPT-001');

INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Mandla', 'Zulu', 'mandla.zulu@vodacom.co.za', '0834567890', DATE '2015-06-01', 2, 'Network Operations Director', 120000, 'Permanent', 'VDC002001', 'MDR-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Thandi', 'Ngwenya', 'thandi.ngwenya@vodacom.co.za', '0721234567', DATE '2017-09-12', 2, 'Senior Network Engineer', 85000, 'Permanent', 'VDC002002', 'MDR-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Bongani', 'Mthembu', 'bongani.mthembu@vodacom.co.za', '0789012345', DATE '2019-03-20', 2, 'Network Technician', 45000, 'Permanent', 'VDC002003', 'MDR-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Nonhlanhla', 'Sithole', 'nonhlanhla.sithole@vodacom.co.za', '0736789012', DATE '2020-08-15', 2, 'Network Support Specialist', 40000, 'Permanent', 'VDC002004', 'MDR-001');

INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES 
('Themba', 'Radebe', 'themba.radebe@vodacom.co.za', '0845678901', DATE '2018-11-05', 3, 'Sales Manager', 70000, 'Permanent', 'VDC003001', 'JHB-001', 5.00);
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES 
('Nandi', 'Mahlangu', 'nandi.mahlangu@vodacom.co.za', '0723456789', DATE '2019-04-22', 3, 'Senior Sales Agent', 40000, 'Permanent', 'VDC003002', 'JHB-001', 8.00);
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES 
('Tshepo', 'Vilakazi', 'tshepo.vilakazi@vodacom.co.za', '0756789012', DATE '2020-09-10', 3, 'Sales Agent', 28000, 'Permanent', 'VDC003003', 'JHB-002', 10.00);
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES 
('Precious', 'Nkosi', 'precious.nkosi@vodacom.co.za', '0789876543', DATE '2021-01-12', 3, 'Sales Agent', 26000, 'Permanent', 'VDC003004', 'DBN-001', 10.00);
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES 
('Mpho', 'Tshabalala', 'mpho.tshabalala@vodacom.co.za', '0765432198', DATE '2022-06-01', 3, 'Sales Agent', 25000, 'Permanent', 'VDC003005', 'CPT-001', 10.00);

INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Sizwe', 'Mthethwa', 'sizwe.mthethwa@vodacom.co.za', '0834567123', DATE '2016-02-18', 4, 'Finance Manager', 95000, 'Permanent', 'VDC004001', 'MDR-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Lindiwe', 'Naidoo', 'lindiwe.naidoo@vodacom.co.za', '0721234876', DATE '2018-05-20', 4, 'Billing Specialist', 42000, 'Permanent', 'VDC004002', 'MDR-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Kagiso', 'Mohlala', 'kagiso.mohlala@vodacom.co.za', '0789012876', DATE '2019-11-15', 4, 'Accounts Receivable Clerk', 32000, 'Permanent', 'VDC004003', 'MDR-001');

INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Mpumelelo', 'Dube', 'mpumelelo.dube@vodacom.co.za', '0836789234', DATE '2017-01-10', 5, 'IT Director', 130000, 'Permanent', 'VDC005001', 'MDR-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Ntombi', 'Shabalala', 'ntombi.shabalala@vodacom.co.za', '0723456234', DATE '2018-08-22', 5, 'Senior Systems Analyst', 75000, 'Permanent', 'VDC005002', 'MDR-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Andile', 'Ngubane', 'andile.ngubane@vodacom.co.za', '0756789234', DATE '2020-02-15', 5, 'Database Administrator', 60000, 'Permanent', 'VDC005003', 'MDR-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Busisiwe', 'Khoza', 'busisiwe.khoza@vodacom.co.za', '0789876234', DATE '2021-07-01', 5, 'Software Developer', 55000, 'Permanent', 'VDC005004', 'MDR-001');

INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Sello', 'Maseko', 'sello.maseko@vodacom.co.za', '0834561234', DATE '2017-04-12', 6, 'Marketing Director', 110000, 'Permanent', 'VDC006001', 'JHB-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Zinhle', 'Mbatha', 'zinhle.mbatha@vodacom.co.za', '0721231234', DATE '2019-06-18', 6, 'Digital Marketing Manager', 65000, 'Permanent', 'VDC006002', 'JHB-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Khethiwe', 'Cele', 'khethiwe.cele@vodacom.co.za', '0789011234', DATE '2020-10-05', 6, 'Marketing Coordinator', 38000, 'Permanent', 'VDC006003', 'JHB-001');

INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Siphiwe', 'Zungu', 'siphiwe.zungu@vodacom.co.za', '0836785678', DATE '2016-09-01', 7, 'HR Director', 105000, 'Permanent', 'VDC007001', 'MDR-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Nokuthula', 'Mkhize', 'nokuthula.mkhize@vodacom.co.za', '0721235678', DATE '2018-12-10', 7, 'HR Business Partner', 55000, 'Permanent', 'VDC007002', 'MDR-001');

INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Lwazi', 'Ntuli', 'lwazi.ntuli@vodacom.co.za', '0834565678', DATE '2019-08-20', 8, 'VodaPay Director', 125000, 'Permanent', 'VDC008001', 'CPT-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Thandeka', 'Madonsela', 'thandeka.madonsela@vodacom.co.za', '0721235555', DATE '2020-03-15', 8, 'VodaPay Product Manager', 80000, 'Permanent', 'VDC008002', 'CPT-001');
INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
('Mlungisi', 'Hadebe', 'mlungisi.hadebe@vodacom.co.za', '0756785555', DATE '2021-09-01', 8, 'VodaPay Support Specialist', 45000, 'Permanent', 'VDC008003', 'CPT-001');

COMMIT;

-- Update manager relationships
UPDATE vodacom_employees SET manager_id = 1 WHERE emp_id IN (2, 3, 4, 5);
UPDATE vodacom_employees SET manager_id = 6 WHERE emp_id IN (7, 8, 9);
UPDATE vodacom_employees SET manager_id = 10 WHERE emp_id IN (11, 12, 13, 14);
UPDATE vodacom_employees SET manager_id = 15 WHERE emp_id IN (16, 17);
UPDATE vodacom_employees SET manager_id = 18 WHERE emp_id IN (19, 20, 21);
UPDATE vodacom_employees SET manager_id = 22 WHERE emp_id IN (23, 24);
UPDATE vodacom_employees SET manager_id = 25 WHERE emp_id = 26;
UPDATE vodacom_employees SET manager_id = 27 WHERE emp_id IN (28, 29);

UPDATE vodacom_departments SET manager_id = 1 WHERE dept_id = 1;
UPDATE vodacom_departments SET manager_id = 6 WHERE dept_id = 2;
UPDATE vodacom_departments SET manager_id = 10 WHERE dept_id = 3;
UPDATE vodacom_departments SET manager_id = 15 WHERE dept_id = 4;
UPDATE vodacom_departments SET manager_id = 18 WHERE dept_id = 5;
UPDATE vodacom_departments SET manager_id = 22 WHERE dept_id = 6;
UPDATE vodacom_departments SET manager_id = 25 WHERE dept_id = 7;
UPDATE vodacom_departments SET manager_id = 27 WHERE dept_id = 8;

COMMIT;

-- Insert Customers (30 sample customers)
INSERT ALL
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100001', 'Palesa', 'Mokoena', '8503145678083', 'palesa.mokoena@email.com', '0821234567', '45 Oxford Road', 'Johannesburg', 'Gauteng', '2196', 'Individual', 5000, 2, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100002', 'Thulani', 'Ngubane', '7809221234089', 'thulani.ngubane@email.com', '0839876543', '12 Smith Street', 'Durban', 'KwaZulu-Natal', '4001', 'Individual', 3000, 4, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100003', 'Mbali', 'Dlamini', '9201187890082', 'mbali.dlamini@email.com', '0765432109', '78 Long Street', 'Cape Town', 'Western Cape', '8001', 'Individual', 8000, 5, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100004', 'Sibusiso', 'Khumalo', '8607095432087', 'sibusiso.khumalo@email.com', '0734567890', '23 Church Street', 'Pretoria', 'Gauteng', '0002', 'Individual', 4000, 2, 'N')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100005', 'Nthabiseng', 'Mahlangu', '9505218765085', 'nthabiseng.mahlangu@email.com', '0827654321', '56 Market Street', 'Port Elizabeth', 'Eastern Cape', '6001', 'Individual', 6000, 3, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-200001', 'ABC Trading PTY LTD', 'N/A', '2015/123456/07', 'accounts@abctrading.co.za', '0115551234', '100 Rivonia Road', 'Sandton', 'Gauteng', '2196', 'Business', 50000, 11, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-200002', 'Tech Solutions SA', 'N/A', '2018/987654/07', 'info@techsolutions.co.za', '0215552345', '45 Adderley Street', 'Cape Town', 'Western Cape', '8001', 'Business', 75000, 12, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-200003', 'Retail Group Limited', 'N/A', '2010/456789/07', 'contact@retailgroup.co.za', '0315553456', '88 West Street', 'Durban', 'KwaZulu-Natal', '4001', 'Business', 100000, 13, 'N')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100006', 'Zanele', 'Sithole', '8812094567082', 'zanele.sithole@email.com', '0789012345', '34 Main Road', 'Bloemfontein', 'Free State', '9301', 'Individual', 3500, 4, 'N')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100007', 'Bongani', 'Radebe', '7703168901084', 'bongani.radebe@email.com', '0736789012', '67 Park Street', 'Polokwane', 'Limpopo', '0699', 'Individual', 2500, 5, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100008', 'Nomvula', 'Zwane', '9008124567089', 'nomvula.zwane@email.com', '0821231234', '90 Hope Street', 'East London', 'Eastern Cape', '5201', 'Individual', 4500, 2, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100009', 'Lungelo', 'Nkosi', '8401057890081', 'lungelo.nkosi@email.com', '0739876543', '12 Beach Road', 'Richards Bay', 'KwaZulu-Natal', '3900', 'Individual', 3000, 3, 'N')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100010', 'Khethiwe', 'Mthembu', '9306192345086', 'khethiwe.mthembu@email.com', '0756781234', '45 Nelson Mandela Drive', 'Nelspruit', 'Mpumalanga', '1200', 'Individual', 5500, 4, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-300001', 'Government Department X', 'N/A', 'GOV-2020-001', 'procurement@govdeptx.gov.za', '0125551234', 'Government Buildings', 'Pretoria', 'Gauteng', '0001', 'Government', 500000, 11, 'N')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100011', 'Sizwe', 'Cele', '8109143456088', 'sizwe.cele@email.com', '0789011111', '23 Victoria Street', 'Pietermaritzburg', 'KwaZulu-Natal', '3201', 'Individual', 4000, 5, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100012', 'Thandeka', 'Mbatha', '9207245678084', 'thandeka.mbatha@email.com', '0821112222', '78 Commissioner Street', 'Johannesburg', 'Gauteng', '2001', 'Individual', 7000, 2, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-200004', 'Construction Corp', 'N/A', '2012/234567/07', 'admin@constructioncorp.co.za', '0215554567', '150 Loop Street', 'Cape Town', 'Western Cape', '8001', 'Business', 60000, 12, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100013', 'Mpho', 'Vilakazi', '8605196789085', 'mpho.vilakazi@email.com', '0733334444', '56 Church Square', 'Pretoria', 'Gauteng', '0002', 'Individual', 3500, 3, 'N')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100014', 'Lindiwe', 'Zungu', '9101088901083', 'lindiwe.zungu@email.com', '0765555666', '89 Railway Street', 'Kimberley', 'Northern Cape', '8301', 'Individual', 2800, 4, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-100015', 'Thabo', 'Ndlovu', '7808127654082', 'thabo.ndlovu@email.com', '0826667777', '34 High Street', 'Grahamstown', 'Eastern Cape', '6139', 'Individual', 4200, 5, 'Y')
  INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
  VALUES ('VDC-ACC-200005', 'Logistics Express PTY', '', '2019/345678/07', 'dispatch@logisticsexpress.co.za', '0315555678', '200 Umgeni Road', 'Durban', 'KwaZulu-Natal', '4001', 'Business', 80000, 13, 'Y')
SELECT * FROM dual;

COMMIT;

-- Insert Mobile Numbers for customers
INSERT ALL
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance, sms_balance)
  VALUES ('0821234567', 1, 'Postpaid', 'SIM-8927100012345678901', DATE '2022-01-15', 'Smart XL', 5120, 0, 0)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
  VALUES ('0839876543', 2, 'Prepaid', 'SIM-8927100098765432109', DATE '2021-06-20', NULL, 850, 45.50, 25)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, monthly_fee, data_balance_mb, airtime_balance)
  VALUES ('0765432109', 3, 'Contract', 'SIM-8927100011111222233', DATE '2020-11-10', 'Red 1GB', 299, 750, 0, 0)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
  VALUES ('0734567890', 4, 'Prepaid', 'SIM-8927100022222333344', DATE '2023-03-05', NULL, 0, 12.00, 5)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance, sms_balance)
  VALUES ('0827654321', 5, 'Postpaid', 'SIM-8927100033333444455', DATE '2021-09-12', 'Smart L', 3072, 0, 0)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
  VALUES ('0789012345', 9, 'Prepaid', 'SIM-8927100044444555566', DATE '2022-07-18', NULL, 1500, 85.00, 50)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
  VALUES ('0736789012', 10, 'Prepaid', 'SIM-8927100055555666677', DATE '2023-01-22', NULL, 2048, 120.00, 100)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, monthly_fee, data_balance_mb)
  VALUES ('0821231234', 11, 'Contract', 'SIM-8927100066666777788', DATE '2021-04-08', 'Red 2GB', 399, 1024, 0, 0)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
  VALUES ('0739876543', 12, 'Prepaid', 'SIM-8927100077777888899', DATE '2022-10-30', NULL, 500, 30.00, 10)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance)
  VALUES ('0756781234', 13, 'Postpaid', 'SIM-8927100088888999900', DATE '2020-08-14', 'Smart M', 2048, 0, 0)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
  VALUES ('0789011111', 15, 'Prepaid', 'SIM-8927100099999000011', DATE '2023-02-05', NULL, 3072, 150.00, 75)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, monthly_fee, data_balance_mb)
  VALUES ('0821112222', 16, 'Contract', 'SIM-8927100010101010101', DATE '2021-12-20', 'Red 5GB', 599, 4096, 0, 0)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
  VALUES ('0733334444', 19, 'Prepaid', 'SIM-8927100020202020202', DATE '2022-05-15', NULL, 256, 18.50, 8)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
  VALUES ('0765555666', 20, 'Prepaid', 'SIM-8927100030303030303', DATE '2023-04-10', NULL, 512, 55.00, 20)
  INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance)
  VALUES ('0826667777', 21, 'Postpaid', 'SIM-8927100040404040404', DATE '2021-07-25', 'Smart L', 3072, 0, 0)
SELECT * FROM dual;

COMMIT;

-- Insert Packages (Data, Voice, SMS bundles)
INSERT ALL
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
  VALUES ('DATA-DAILY-50', 'Daily 50MB', '50MB data valid for 24 hours', 'Data Only', 50, 10, 1, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
  VALUES ('DATA-DAILY-250', 'Daily 250MB', '250MB data valid for 24 hours', 'Data Only', 250, 25, 1, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
  VALUES ('DATA-WEEKLY-1G', 'Weekly 1GB', '1GB data valid for 7 days', 'Data Only', 1024, 75, 7, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
  VALUES ('DATA-WEEKLY-2G', 'Weekly 2GB', '2GB data valid for 7 days', 'Data Only', 2048, 135, 7, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional, promo_price, promo_start_date, promo_end_date)
  VALUES ('DATA-MONTHLY-1G', 'Monthly 1GB', '1GB data valid for 30 days', 'Data Only', 1024, 149, 30, 'Y', 99, DATE '2024-01-01', DATE '2024-12-31')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
  VALUES ('DATA-MONTHLY-2G', 'Monthly 2GB', '2GB data valid for 30 days', 'Data Only', 2048, 249, 30, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
  VALUES ('DATA-MONTHLY-5G', 'Monthly 5GB', '5GB data valid for 30 days', 'Data Only', 5120, 499, 30, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
  VALUES ('DATA-MONTHLY-10G', 'Monthly 10GB', '10GB data valid for 30 days', 'Data Only', 10240, 849, 30, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional, promo_price, promo_start_date, promo_end_date)
  VALUES ('DATA-MONTHLY-20G', 'Monthly 20GB', '20GB data valid for 30 days', 'Data Only', 20480, 1499, 30, 'Y', 1199, DATE '2024-01-01', DATE '2024-06-30')
  INTO vodacom_packages (package_code, package_name, description, package_type, voice_minutes, price, validity_days, is_promotional)
  VALUES ('VOICE-50MIN', '50 Minutes Anytime', '50 minutes to any network', 'Voice Only', NULL, 50, 30, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, voice_minutes, price, validity_days, is_promotional)
  VALUES ('VOICE-100MIN', '100 Minutes Anytime', '100 minutes to any network', 'Voice Only', NULL, 90, 30, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, voice_minutes, price, validity_days, is_promotional)
  VALUES ('VOICE-250MIN', '250 Minutes Anytime', '250 minutes to any network', 'Voice Only', NULL, 200, 30, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, sms_count, price, validity_days, is_promotional)
  VALUES ('SMS-100', '100 SMS Bundle', '100 SMS to any network', 'SMS Only', NULL, NULL, 100, 25, 30, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, sms_count, price, validity_days, is_promotional)
  VALUES ('SMS-250', '250 SMS Bundle', '250 SMS to any network', 'SMS Only', NULL, NULL, 250, 50, 30, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, is_promotional)
  VALUES ('COMBO-SMART-S', 'Smart Combo S', '500MB + 50min + 50SMS', 'Combo', 500, 50, 50, 99, 30, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, is_promotional)
  VALUES ('COMBO-SMART-M', 'Smart Combo M', '2GB + 100min + 100SMS', 'Combo', 2048, 100, 100, 299, 30, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, is_promotional)
  VALUES ('COMBO-SMART-L', 'Smart Combo L', '5GB + 250min + 200SMS', 'Combo', 5120, 250, 200, 599, 30, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, is_promotional, promo_price, promo_start_date, promo_end_date)
  VALUES ('COMBO-SMART-XL', 'Smart Combo XL', '10GB + 500min + 500SMS', 'Combo', 10240, 500, 500, 999, 30, 'Y', 799, DATE '2024-01-01', DATE '2024-12-31')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, monthly_fee, is_promotional)
  VALUES ('CONTRACT-RED-1G', 'Red Contract 1GB', 'Monthly contract: 1GB + Unlimited calls + 200 SMS', 'Contract', 1024, 9999, 200, 299, 0, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, monthly_fee, is_promotional)
  VALUES ('CONTRACT-RED-2G', 'Red Contract 2GB', 'Monthly contract: 2GB + Unlimited calls + 500 SMS', 'Contract', 2048, 9999, 500, 399, 0, 'N')
  INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, monthly_fee, is_promotional)
  VALUES ('CONTRACT-RED-5G', 'Red Contract 5GB', 'Monthly contract: 5GB + Unlimited calls + 1000 SMS', 'Contract', 5120, 9999, 1000, 599, 0, 'N')
SELECT * FROM dual;

COMMIT;

-- Insert Transactions (mix of airtime, data, VodaPay)
INSERT ALL
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
  VALUES ('TXN-2024-00001', 1, '0821234567', 'Package Purchase', 999, 'Card', 18, TIMESTAMP '2024-01-05 10:15:30', 'Completed', 'App')
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, channel)
  VALUES ('TXN-2024-00002', 2, '0839876543', 'Airtime Purchase', 50, 'Cash', TIMESTAMP '2024-01-08 14:22:15', 'Completed', 'Store')
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
  VALUES ('TXN-2024-00003', 3, '0765432109', 'Data Purchase', 149, 'VodaPay', 5, TIMESTAMP '2024-01-10 09:45:00', 'Completed', 'USSD')
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, processed_by, channel)
  VALUES ('TXN-2024-00004', 4, '0734567890', 'Airtime Purchase', 20, 'Cash', TIMESTAMP '2024-01-12 16:30:45', 'Completed', 14, 'Store')
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
  VALUES ('TXN-2024-00005', 9, '0789012345', 'Data Purchase', 75, 'Card', 3, TIMESTAMP '2024-01-15 11:20:30', 'Completed', 'Web')
  INTO vodacom_transactions (transaction_ref, customer_id, transaction_type, amount, payment_method, transaction_date, status, channel)
  VALUES ('TXN-2024-00006', 1, 'VodaPay Transfer', 500, 'VodaPay', TIMESTAMP '2024-01-18 13:05:20', 'Completed', 'App')
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
  VALUES ('TXN-2024-00007', 10, '0736789012', 'Data Purchase', 249, 'VodaPay', 6, TIMESTAMP '2024-01-20 08:15:00', 'Completed', 'App')
  INTO vodacom_transactions (transaction_ref, customer_id, transaction_type, amount, payment_method, transaction_date, status, channel)
  VALUES ('TXN-2024-00008', 3, 'VodaPay Purchase', 350, 'VodaPay', TIMESTAMP '2024-01-22 17:40:15', 'Completed', 'App')
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, channel)
  VALUES ('TXN-2024-00009', 11, '0821231234', 'Airtime Purchase', 100, 'Card', TIMESTAMP '2024-01-25 12:30:00', 'Completed', 'Web')
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
  VALUES ('TXN-2024-00010', 13, '0756781234', 'Package Purchase', 599, 'Direct Debit', 17, TIMESTAMP '2024-01-28 10:00:00', 'Completed', 'App')
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, channel)
  VALUES ('TXN-2024-00011', 2, '0839876543', 'Airtime Purchase', 30, 'Voucher', TIMESTAMP '2024-02-01 15:45:30', 'Completed', 'USSD')
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
  VALUES ('TXN-2024-00012', 15, '0789011111', 'Data Purchase', 499, 'Card', 7, TIMESTAMP '2024-02-03 09:20:15', 'Completed', 'App')
  INTO vodacom_transactions (transaction_ref, customer_id, transaction_type, amount, payment_method, transaction_date, status, channel)
  VALUES ('TXN-2024-00013', 5, 'Bill Payment', 850, 'VodaPay', TIMESTAMP '2024-02-05 14:10:00', 'Completed', 'App')
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
  VALUES ('TXN-2024-00014', 16, '0821112222', 'Package Purchase', 999, 'Card', 18, TIMESTAMP '2024-02-08 11:35:45', 'Completed', 'Web')
  INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, processed_by, channel)
  VALUES ('TXN-2024-00015', 19, '0733334444', 'Airtime Purchase', 15, 'Cash', TIMESTAMP '2024-02-10 16:50:20', 'Completed', 12, 'Store')
SELECT * FROM dual;

COMMIT;

-- Insert Network Towers
INSERT ALL
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('JHB-T001', 'Sandton City Tower', -26.107730, 28.056305, 'Gauteng', 'Johannesburg', '5G', 5000, DATE '2022-03-15', 85000, 'Vodacom')
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('JHB-T002', 'Rosebank Mall Tower', -26.147780, 28.040650, 'Gauteng', 'Johannesburg', 'Hybrid', 4500, DATE '2021-08-20', 75000, 'Vodacom')
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('CPT-T001', 'V&A Waterfront Tower', -33.904500, 18.419180, 'Western Cape', 'Cape Town', '5G', 5500, DATE '2022-06-10', 90000, 'Vodacom')
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('CPT-T002', 'Century City Tower', -33.892890, 18.508890, 'Western Cape', 'Cape Town', 'Hybrid', 4000, DATE '2021-05-15', 70000, 'Leased')
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('DBN-T001', 'Umhlanga Rocks Tower', -29.729550, 31.082300, 'KwaZulu-Natal', 'Durban', '5G', 4800, DATE '2022-09-05', 82000, 'Vodacom')
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('DBN-T002', 'Gateway Mall Tower', -29.763330, 31.048890, 'KwaZulu-Natal', 'Durban', 'Hybrid', 4200, DATE '2021-11-20', 72000, 'Shared')
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('PTA-T001', 'Menlyn Tower', -25.781670, 28.276390, 'Gauteng', 'Pretoria', '5G', 4600, DATE '2022-04-12', 80000, 'Vodacom')
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('PTA-T002', 'Hatfield Plaza Tower', -25.749170, 28.238610, 'Gauteng', 'Pretoria', 'Hybrid', 3800, DATE '2021-07-08', 68000, 'Leased')
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('BFN-T001', 'Bloemfontein Central', -29.121110, 26.214440, 'Free State', 'Bloemfontein', '4G', 3500, DATE '2020-10-15', 55000, 'Vodacom')
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('PLK-T001', 'Polokwane Mall Tower', -23.905000, 29.458330, 'Limpopo', 'Polokwane', '4G', 3200, DATE '2020-12-01', 52000, 'Shared')
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('ELS-T001', 'East London Beachfront', -33.015000, 27.911670, 'Eastern Cape', 'East London', '4G', 3000, DATE '2021-02-18', 50000, 'Leased')
  INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
  VALUES ('NPT-T001', 'Nelspruit City Tower', -25.474440, 30.970000, 'Mpumalanga', 'Nelspruit', '4G', 2800, DATE '2021-04-22', 48000, 'Vodacom')
SELECT * FROM dual;

COMMIT;

-- Insert Network Issues (sample incidents)
INSERT ALL
  INTO vodacom_network_issues (issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status)
  VALUES ('INC-2024-001', 1, 'Maintenance', 'Low', 'Scheduled upgrade to 5G equipment', 'Gauteng', 'Johannesburg', 0, TIMESTAMP '2024-02-15 02:00:00', 'Resolved')
  INTO vodacom_network_issues (issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to)
  VALUES ('INC-2024-002', 5, 'Outage', 'Critical', 'Complete tower failure - power supply issue', 'KwaZulu-Natal', 'Durban', 4800, TIMESTAMP '2024-02-10 14:30:00', 'Resolved', 7)
  INTO vodacom_network_issues (issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to)
  VALUES ('INC-2024-003', 3, 'Degraded Service', 'High', 'Intermittent connectivity - investigating hardware', 'Western Cape', 'Cape Town', 2500, TIMESTAMP '2024-02-18 09:15:00', 'In Progress', 8)
  INTO vodacom_network_issues (issue_ref, issue_type, severity, description, province, city, affected_customers, reported_date, status)
  VALUES ('INC-2024-004', 'Weather Damage', 'Medium', 'Lightning damage to fiber connection', 'Free State', 'Bloemfontein', 1200, TIMESTAMP '2024-02-12 18:45:00', 'Resolved')
  INTO vodacom_network_issues (issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to)
  VALUES ('INC-2024-005', 7, 'Vandalism', 'High', 'Cable theft affecting tower connectivity', 'Gauteng', 'Pretoria', 3200, TIMESTAMP '2024-02-20 06:30:00', 'Acknowledged', 6)
SELECT * FROM dual;

COMMIT;

-- Insert Customer Support Tickets
INSERT ALL
  INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, channel, assigned_to)
  VALUES ('TKT-2024-00001', 1, '0821234567', 'Billing', 'Incorrect Charge', 'Charged twice for the same data bundle purchase', 'High', 'Call Center', 2)
  INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction)
  VALUES ('TKT-2024-00002', 2, '0839876543', 'Network', 'No Signal', 'No network coverage at home address', 'Urgent', 'Resolved', 'App', 3, TIMESTAMP '2024-01-10 16:30:00', 'Escalated to Network Operations. Tower maintenance completed.', 5)
  INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel)
  VALUES ('TKT-2024-00003', 4, '0734567890', 'Technical', 'Data Not Working', 'Purchased data but cannot browse internet', 'Normal', 'In Progress', 'Call Center', 4)
  INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction)
  VALUES ('TKT-2024-00004', 3, '0765432109', 'Account', 'Password Reset', 'Cannot access online account - forgot password', 'Low', 'Closed', 'Web', 5, TIMESTAMP '2024-01-15 10:20:00', 'Password reset link sent to registered email', 4)
  INTO vodacom_customer_support (ticket_number, customer_id, issue_category, issue_type, description, priority, channel, assigned_to)
  VALUES ('TKT-2024-00005', 1, 'VodaPay', 'Transaction Failed', 'VodaPay transfer failed but amount was deducted', 'Urgent', 'App', 28)
  INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to)
  VALUES ('TKT-2024-00006', 9, '0789012345', 'Billing', 'Invoice Query', 'Requesting breakdown of last month charges', 'Normal', 'Assigned', 'Email', 16)
  INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction)
  VALUES ('TKT-2024-00007', 11, '0821231234', 'Complaint', 'Poor Service', 'Multiple dropped calls in past week', 'High', 'Resolved', 'Call Center', 2, TIMESTAMP '2024-01-22 14:45:00', 'Network issue identified and fixed. Compensated with 1GB data', 3)
  INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, channel)
  VALUES ('TKT-2024-00008', 15, '0789011111', 'Query', 'Package Information', 'Want to know about available monthly packages', 'Low', 'Open', 'Social Media')
  INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to)
  VALUES ('TKT-2024-00009', 16, '0821112222', 'Technical', 'SIM Card Issue', 'SIM card not detected by phone', 'High', 'In Progress', 'Walk-in', 3)
  INTO vodacom_customer_support (ticket_number, customer_id, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction)
  VALUES ('TKT-2024-00010', 5, 'Request', 'Upgrade Package', 'Want to upgrade to higher data package', 'Normal', 'Closed', 'App', 11, TIMESTAMP '2024-02-05 11:15:00', 'Customer upgraded to Smart L package successfully', 5)
SELECT * FROM dual;

COMMIT;

-- Insert Sales transactions
INSERT ALL
  INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
  VALUES ('SALE-2024-00001', 1, DATE '2024-01-10', 'New Contract', 'Red 5GB - 24 Month Contract', 1, 599, 0, 0, 599, 'Direct Debit', 11, 29.95, 'JHB-001')
  INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
  VALUES ('SALE-2024-00002', 9, DATE '2024-01-12', 'Device', 'Samsung Galaxy A34 5G', 1, 6999, 10, 700, 6299, 'Card', 12, 503.92, 'JHB-002')
  INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
  VALUES ('SALE-2024-00003', 4, DATE '2024-01-15', 'SIM Card', 'Prepaid SIM Starter Pack', 1, 5, 0, 0, 5, 'Cash', 14, 0.50, 'DBN-001')
  INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
  VALUES ('SALE-2024-00004', 3, DATE '2024-01-18', 'Upgrade', 'iPhone 15 Pro - Contract Upgrade', 1, 24999, 15, 3750, 21249, 'Card', 11, 1062.45, 'CPT-001')
  INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
  VALUES ('SALE-2024-00005', 11, DATE '2024-01-20', 'Accessory', 'Wireless Earbuds', 1, 1299, 0, 0, 1299, 'Card', 12, 103.92, 'JHB-001')
  INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
  VALUES ('SALE-2024-00006', 15, DATE '2024-01-25', 'Device', 'Huawei WiFi Router 5G', 1, 3999, 5, 200, 3799, 'VodaPay', 13, 303.92, 'DBN-001')
  INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
  VALUES ('SALE-2024-00007', 6, DATE '2024-01-28', 'Enterprise', 'Corporate Package - 50 Lines', 50, 399, 20, 3990, 15960, 'EFT', 11, 798.00, 'JHB-001')
  INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
  VALUES ('SALE-2024-00008', 16, DATE '2024-02-01', 'Device', 'Samsung Galaxy S24', 1, 17999, 0, 0, 17999, 'Card', 14, 1439.92, 'CPT-001')
  INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
  VALUES ('SALE-2024-00009', 19, DATE '2024-02-05', 'Accessory', 'Phone Case + Screen Protector', 1, 299, 0, 0, 299, 'Cash', 12, 23.92, 'JHB-002')
  INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
  VALUES ('SALE-2024-00010', 21, DATE '2024-02-08', 'New Contract', 'Red 2GB - 24 Month Contract', 1, 399, 0, 0, 399, 'Direct Debit', 13, 19.95, 'DBN-001')
SELECT * FROM dual;

COMMIT;

-- Insert VodaPay Accounts
INSERT ALL
  INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
  VALUES (1, 'VP-821234567', '0821234567', 1250.50, 5000, 50000, 'Y', DATE '2022-06-15', 15680.00, 8950.50)
  INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
  VALUES (3, 'VP-765432109', '0765432109', 3420.75, 10000, 100000, 'Y', DATE '2021-03-20', 42350.00, 38770.75)
  INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
  VALUES (5, 'VP-827654321', '0827654321', 580.00, 5000, 50000, 'Y', DATE '2022-11-08', 8920.00, 6500.00)
  INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
  VALUES (10, 'VP-736789012', '0736789012', 2150.30, 5000, 50000, 'Y', DATE '2023-01-25', 12450.00, 10600.30)
  INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
  VALUES (13, 'VP-756781234', '0756781234', 4850.00, 10000, 100000, 'Y', DATE '2021-07-12', 65200.00, 58050.00)
  INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
  VALUES (15, 'VP-789011111', '0789011111', 620.45, 5000, 50000, 'Y', DATE '2023-02-18', 4380.00, 3000.45)
  INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
  VALUES (16, 'VP-821112222', '0821112222', 8920.80, 15000, 150000, 'Y', DATE '2022-01-05', 98450.00, 92370.80)
  INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
  VALUES (20, 'VP-765555666', '0765555666', 150.20, 5000, 50000, 'Y', DATE '2023-04-22', 2850.00, 1000.20)
  INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
  VALUES (21, 'VP-826667777', '0826667777', 1780.90, 5000, 50000, 'Y', DATE '2022-08-30', 18920.00, 14700.90)
SELECT * FROM dual;

COMMIT;

-- Insert Invoices (for postpaid customers)
INSERT ALL
  INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by)
  VALUES ('INV-2024-01-001', 1, '0821234567', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 869.57, 130.43, 1000.00, 1000.00, 0, 'Paid', 16)
  INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by)
  VALUES ('INV-2024-01-002', 3, '0765432109', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 521.74, 78.26, 600.00, 600.00, 0, 'Paid', 16)
  INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, payment_date, generated_by)
  VALUES ('INV-2024-01-003', 11, '0821231234', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 695.65, 104.35, 800.00, 800.00, 0, 'Paid', DATE '2024-02-10', 16)
  INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by)
  VALUES ('INV-2024-01-004', 13, '0756781234', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 434.78, 65.22, 500.00, 0, 500.00, 'Issued', 16)
  INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by)
  VALUES ('INV-2024-01-005', 16, '0821112222', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 1043.48, 156.52, 1200.00, 0, 1200.00, 'Issued', 16)
  INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by)
  VALUES ('INV-2024-01-006', 21, '0826667777', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 782.61, 117.39, 900.00, 450.00, 450.00, 'Partially Paid', 16)
SELECT * FROM dual;

COMMIT;

-- Insert Invoice Items
INSERT ALL
  INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
  VALUES (1, 'Monthly Rental', 'Smart XL Package Monthly Fee', 1, 999, 999)
  INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
  VALUES (1, 'Voice Calls', 'Out-of-bundle calls', 1.00)
  INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
  VALUES (2, 'Monthly Rental', 'Red 1GB Contract Monthly Fee', 1, 299, 299)
  INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
  VALUES (2, 'Data Usage', 'Out-of-bundle data usage', 250, 0.99, 247.50)
  INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
  VALUES (2, 'SMS Charges', 'Additional SMS', 75.24)
  INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
  VALUES (3, 'Monthly Rental', 'Red 2GB Contract Monthly Fee', 1, 399, 399)
  INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
  VALUES (3, 'Data Usage', 'Out-of-bundle data usage', 400, 0.99, 396.00)
  INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
  VALUES (3, 'International Calls', 'International calls', 5.65)
  INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
  VALUES (4, 'Monthly Rental', 'Smart M Package Monthly Fee', 1, 299, 299)
  INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
  VALUES (4, 'Data Usage', 'Out-of-bundle data usage', 150, 0.99, 148.50)
  INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
  VALUES (4, 'Value Added Services', 'Music streaming service', 52.28)
  INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
  VALUES (5, 'Monthly Rental', 'Red 5GB Contract Monthly Fee', 1, 599, 599)
  INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
  VALUES (5, 'Device Installment', 'iPhone 15 Pro - Month 3 of 24', 1, 590, 590)
  INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
  VALUES (5, 'Data Usage', 'Out-of-bundle data', 54.48)
  INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
  VALUES (6, 'Monthly Rental', 'Smart L Package Monthly Fee', 1, 599, 599)
  INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
  VALUES (6, 'Data Usage', 'Out-of-bundle data usage', 180, 0.99, 178.20)
  INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
  VALUES (6, 'Roaming', 'Data roaming charges', 105.41)
SELECT * FROM dual;

COMMIT;

-- ============================================================================
-- DATA RE-INSERTION CHECK
-- ============================================================================
-- If any tables are empty, this block will re-insert the data
-- ============================================================================

DECLARE
    v_count NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Checking for missing data and re-inserting if needed...');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Check and re-insert Departments
    SELECT COUNT(*) INTO v_count FROM vodacom_departments;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Departments...');
        INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
        ('Customer Service', 'CS', 15000000, 'Midrand', 'CC-CS-001');
        INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
        ('Network Operations', 'NO', 50000000, 'Midrand', 'CC-NO-001');
        INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
        ('Sales and Distribution', 'SD', 25000000, 'Johannesburg', 'CC-SD-001');
        INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
        ('Finance and Billing', 'FB', 8000000, 'Midrand', 'CC-FB-001');
        INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
        ('Information Technology', 'IT', 35000000, 'Midrand', 'CC-IT-001');
        INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
        ('Marketing', 'MKT', 20000000, 'Johannesburg', 'CC-MKT-001');
        INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
        ('Human Resources', 'HR', 5000000, 'Midrand', 'CC-HR-001');
        INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) VALUES 
        ('VodaPay Division', 'VP', 30000000, 'Cape Town', 'CC-VP-001');
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Departments re-inserted: 8 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Departments already populated: ' || v_count || ' records');
    END IF;
    
    -- Check and re-insert Employees
    SELECT COUNT(*) INTO v_count FROM vodacom_employees;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Employees...');
        
        -- Customer Service employees
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Thabo', 'Molefe', 'thabo.molefe@vodacom.co.za', '0836547890', DATE '2018-03-15', 1, 'Customer Service Manager', 65000, 'Permanent', 'VDC001234', 'JHB-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Nomsa', 'Dlamini', 'nomsa.dlamini@vodacom.co.za', '0827654321', DATE '2019-07-22', 1, 'Senior Customer Service Rep', 35000, 'Permanent', 'VDC001235', 'JHB-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Sipho', 'Khumalo', 'sipho.khumalo@vodacom.co.za', '0731234567', DATE '2020-01-10', 1, 'Customer Service Representative', 25000, 'Permanent', 'VDC001236', 'JHB-002');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Zanele', 'Ndlovu', 'zanele.ndlovu@vodacom.co.za', '0829876543', DATE '2021-05-18', 1, 'Customer Service Representative', 24000, 'Permanent', 'VDC001237', 'DBN-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Lerato', 'Mokoena', 'lerato.mokoena@vodacom.co.za', '0765432109', DATE '2022-02-14', 1, 'Customer Service Representative', 23000, 'Permanent', 'VDC001238', 'CPT-001');
        
        -- Network Operations employees
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Mandla', 'Zulu', 'mandla.zulu@vodacom.co.za', '0834567890', DATE '2015-06-01', 2, 'Network Operations Director', 120000, 'Permanent', 'VDC002001', 'MDR-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Thandi', 'Ngwenya', 'thandi.ngwenya@vodacom.co.za', '0721234567', DATE '2017-09-12', 2, 'Senior Network Engineer', 85000, 'Permanent', 'VDC002002', 'MDR-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Bongani', 'Mthembu', 'bongani.mthembu@vodacom.co.za', '0789012345', DATE '2019-03-20', 2, 'Network Technician', 45000, 'Permanent', 'VDC002003', 'MDR-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Nonhlanhla', 'Sithole', 'nonhlanhla.sithole@vodacom.co.za', '0736789012', DATE '2020-08-15', 2, 'Network Support Specialist', 40000, 'Permanent', 'VDC002004', 'MDR-001');
        
        -- Sales employees
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES 
        ('Themba', 'Radebe', 'themba.radebe@vodacom.co.za', '0845678901', DATE '2018-11-05', 3, 'Sales Manager', 70000, 'Permanent', 'VDC003001', 'JHB-001', 5.00);
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES 
        ('Nandi', 'Mahlangu', 'nandi.mahlangu@vodacom.co.za', '0723456789', DATE '2019-04-22', 3, 'Senior Sales Agent', 40000, 'Permanent', 'VDC003002', 'JHB-001', 8.00);
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES 
        ('Tshepo', 'Vilakazi', 'tshepo.vilakazi@vodacom.co.za', '0756789012', DATE '2020-09-10', 3, 'Sales Agent', 28000, 'Permanent', 'VDC003003', 'JHB-002', 10.00);
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES 
        ('Precious', 'Nkosi', 'precious.nkosi@vodacom.co.za', '0789876543', DATE '2021-01-12', 3, 'Sales Agent', 26000, 'Permanent', 'VDC003004', 'DBN-001', 10.00);
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code, commission_rate) VALUES 
        ('Mpho', 'Tshabalala', 'mpho.tshabalala@vodacom.co.za', '0765432198', DATE '2022-06-01', 3, 'Sales Agent', 25000, 'Permanent', 'VDC003005', 'CPT-001', 10.00);
        
        -- Finance employees
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Sizwe', 'Mthethwa', 'sizwe.mthethwa@vodacom.co.za', '0834567123', DATE '2016-02-18', 4, 'Finance Manager', 95000, 'Permanent', 'VDC004001', 'MDR-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Lindiwe', 'Naidoo', 'lindiwe.naidoo@vodacom.co.za', '0721234876', DATE '2018-05-20', 4, 'Billing Specialist', 42000, 'Permanent', 'VDC004002', 'MDR-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Kagiso', 'Mohlala', 'kagiso.mohlala@vodacom.co.za', '0789012876', DATE '2019-11-15', 4, 'Accounts Receivable Clerk', 32000, 'Permanent', 'VDC004003', 'MDR-001');
        
        -- IT employees
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Mpumelelo', 'Dube', 'mpumelelo.dube@vodacom.co.za', '0836789234', DATE '2017-01-10', 5, 'IT Director', 130000, 'Permanent', 'VDC005001', 'MDR-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Ntombi', 'Shabalala', 'ntombi.shabalala@vodacom.co.za', '0723456234', DATE '2018-08-22', 5, 'Senior Systems Analyst', 75000, 'Permanent', 'VDC005002', 'MDR-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Andile', 'Ngubane', 'andile.ngubane@vodacom.co.za', '0756789234', DATE '2020-02-15', 5, 'Database Administrator', 60000, 'Permanent', 'VDC005003', 'MDR-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Busisiwe', 'Khoza', 'busisiwe.khoza@vodacom.co.za', '0789876234', DATE '2021-07-01', 5, 'Software Developer', 55000, 'Permanent', 'VDC005004', 'MDR-001');
        
        -- Marketing employees
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Sello', 'Maseko', 'sello.maseko@vodacom.co.za', '0834561234', DATE '2017-04-12', 6, 'Marketing Director', 110000, 'Permanent', 'VDC006001', 'JHB-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Zinhle', 'Mbatha', 'zinhle.mbatha@vodacom.co.za', '0721231234', DATE '2019-06-18', 6, 'Digital Marketing Manager', 65000, 'Permanent', 'VDC006002', 'JHB-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Khethiwe', 'Cele', 'khethiwe.cele@vodacom.co.za', '0789011234', DATE '2020-10-05', 6, 'Marketing Coordinator', 38000, 'Permanent', 'VDC006003', 'JHB-001');
        
        -- HR employees
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Siphiwe', 'Zungu', 'siphiwe.zungu@vodacom.co.za', '0836785678', DATE '2016-09-01', 7, 'HR Director', 105000, 'Permanent', 'VDC007001', 'MDR-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Nokuthula', 'Mkhize', 'nokuthula.mkhize@vodacom.co.za', '0721235678', DATE '2018-12-10', 7, 'HR Business Partner', 55000, 'Permanent', 'VDC007002', 'MDR-001');
        
        -- VodaPay employees
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Lwazi', 'Ntuli', 'lwazi.ntuli@vodacom.co.za', '0834565678', DATE '2019-08-20', 8, 'VodaPay Director', 125000, 'Permanent', 'VDC008001', 'CPT-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Thandeka', 'Madonsela', 'thandeka.madonsela@vodacom.co.za', '0721235555', DATE '2020-03-15', 8, 'VodaPay Product Manager', 80000, 'Permanent', 'VDC008002', 'CPT-001');
        INSERT INTO vodacom_employees (first_name, last_name, email, phone, hire_date, dept_id, job_title, salary, employee_type, employee_number, branch_code) VALUES 
        ('Mlungisi', 'Hadebe', 'mlungisi.hadebe@vodacom.co.za', '0756785555', DATE '2021-09-01', 8, 'VodaPay Support Specialist', 45000, 'Permanent', 'VDC008003', 'CPT-001');
        
        -- Update manager relationships
        UPDATE vodacom_employees SET manager_id = 1 WHERE emp_id IN (2, 3, 4, 5);
        UPDATE vodacom_employees SET manager_id = 6 WHERE emp_id IN (7, 8, 9);
        UPDATE vodacom_employees SET manager_id = 10 WHERE emp_id IN (11, 12, 13, 14);
        UPDATE vodacom_employees SET manager_id = 15 WHERE emp_id IN (16, 17);
        UPDATE vodacom_employees SET manager_id = 18 WHERE emp_id IN (19, 20, 21);
        UPDATE vodacom_employees SET manager_id = 22 WHERE emp_id IN (23, 24);
        UPDATE vodacom_employees SET manager_id = 25 WHERE emp_id = 26;
        UPDATE vodacom_employees SET manager_id = 27 WHERE emp_id IN (28, 29);
        
        UPDATE vodacom_departments SET manager_id = 1 WHERE dept_id = 1;
        UPDATE vodacom_departments SET manager_id = 6 WHERE dept_id = 2;
        UPDATE vodacom_departments SET manager_id = 10 WHERE dept_id = 3;
        UPDATE vodacom_departments SET manager_id = 15 WHERE dept_id = 4;
        UPDATE vodacom_departments SET manager_id = 18 WHERE dept_id = 5;
        UPDATE vodacom_departments SET manager_id = 22 WHERE dept_id = 6;
        UPDATE vodacom_departments SET manager_id = 25 WHERE dept_id = 7;
        UPDATE vodacom_departments SET manager_id = 27 WHERE dept_id = 8;
        
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Employees re-inserted: 29 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Employees already populated: ' || v_count || ' records');
    END IF;
    
    -- Check and re-insert Customers
    SELECT COUNT(*) INTO v_count FROM vodacom_customers;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Customers...');
        INSERT ALL
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100001', 'Palesa', 'Mokoena', '8503145678083', 'palesa.mokoena@email.com', '0821234567', '45 Oxford Road', 'Johannesburg', 'Gauteng', '2196', 'Individual', 5000, 2, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100002', 'Thulani', 'Ngubane', '7809221234089', 'thulani.ngubane@email.com', '0839876543', '12 Smith Street', 'Durban', 'KwaZulu-Natal', '4001', 'Individual', 3000, 4, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100003', 'Mbali', 'Dlamini', '9201187890082', 'mbali.dlamini@email.com', '0765432109', '78 Long Street', 'Cape Town', 'Western Cape', '8001', 'Individual', 8000, 5, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100004', 'Sibusiso', 'Khumalo', '8607095432087', 'sibusiso.khumalo@email.com', '0734567890', '23 Church Street', 'Pretoria', 'Gauteng', '0002', 'Individual', 4000, 2, 'N')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100005', 'Nthabiseng', 'Mahlangu', '9505218765085', 'nthabiseng.mahlangu@email.com', '0827654321', '56 Market Street', 'Port Elizabeth', 'Eastern Cape', '6001', 'Individual', 6000, 3, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-200001', 'ABC Trading PTY LTD', 'N/A', '2015/123456/07', 'accounts@abctrading.co.za', '0115551234', '100 Rivonia Road', 'Sandton', 'Gauteng', '2196', 'Business', 50000, 11, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-200002', 'Tech Solutions SA', 'N/A', '2018/987654/07', 'info@techsolutions.co.za', '0215552345', '45 Adderley Street', 'Cape Town', 'Western Cape', '8001', 'Business', 75000, 12, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-200003', 'Retail Group Limited', 'N/A', '2010/456789/07', 'contact@retailgroup.co.za', '0315553456', '88 West Street', 'Durban', 'KwaZulu-Natal', '4001', 'Business', 100000, 13, 'N')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100006', 'Zanele', 'Sithole', '8812094567082', 'zanele.sithole@email.com', '0789012345', '34 Main Road', 'Bloemfontein', 'Free State', '9301', 'Individual', 3500, 4, 'N')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100007', 'Bongani', 'Radebe', '7703168901084', 'bongani.radebe@email.com', '0736789012', '67 Park Street', 'Polokwane', 'Limpopo', '0699', 'Individual', 2500, 5, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100008', 'Nomvula', 'Zwane', '9008124567089', 'nomvula.zwane@email.com', '0821231234', '90 Hope Street', 'East London', 'Eastern Cape', '5201', 'Individual', 4500, 2, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100009', 'Lungelo', 'Nkosi', '8401057890081', 'lungelo.nkosi@email.com', '0739876543', '12 Beach Road', 'Richards Bay', 'KwaZulu-Natal', '3900', 'Individual', 3000, 3, 'N')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100010', 'Khethiwe', 'Mthembu', '9306192345086', 'khethiwe.mthembu@email.com', '0756781234', '45 Nelson Mandela Drive', 'Nelspruit', 'Mpumalanga', '1200', 'Individual', 5500, 4, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-300001', 'Government Department X', 'N/A', 'GOV-2020-001', 'procurement@govdeptx.gov.za', '0125551234', 'Government Buildings', 'Pretoria', 'Gauteng', '0001', 'Government', 500000, 11, 'N')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100011', 'Sizwe', 'Cele', '8109143456088', 'sizwe.cele@email.com', '0789011111', '23 Victoria Street', 'Pietermaritzburg', 'KwaZulu-Natal', '3201', 'Individual', 4000, 5, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100012', 'Thandeka', 'Mbatha', '9207245678084', 'thandeka.mbatha@email.com', '0821112222', '78 Commissioner Street', 'Johannesburg', 'Gauteng', '2001', 'Individual', 7000, 2, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-200004', 'Construction Corp', 'N/A', '2012/234567/07', 'admin@constructioncorp.co.za', '0215554567', '150 Loop Street', 'Cape Town', 'Western Cape', '8001', 'Business', 60000, 12, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100013', 'Mpho', 'Vilakazi', '8605196789085', 'mpho.vilakazi@email.com', '0733334444', '56 Church Square', 'Pretoria', 'Gauteng', '0002', 'Individual', 3500, 3, 'N')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100014', 'Lindiwe', 'Zungu', '9101088901083', 'lindiwe.zungu@email.com', '0765555666', '89 Railway Street', 'Kimberley', 'Northern Cape', '8301', 'Individual', 2800, 4, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-100015', 'Thabo', 'Ndlovu', '7808127654082', 'thabo.ndlovu@email.com', '0826667777', '34 High Street', 'Grahamstown', 'Eastern Cape', '6139', 'Individual', 4200, 5, 'Y')
          INTO vodacom_customers (account_number, first_name, last_name, id_number, email, phone, address_line1, city, province, postal_code, customer_type, credit_limit, assigned_agent_id, vodapay_active)
          VALUES ('VDC-ACC-200005', 'Logistics Express PTY', '', '2019/345678/07', 'dispatch@logisticsexpress.co.za', '0315555678', '200 Umgeni Road', 'Durban', 'KwaZulu-Natal', '4001', 'Business', 80000, 13, 'Y')
        SELECT * FROM dual;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Customers re-inserted: 22 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Customers already populated: ' || v_count || ' records');
    END IF;
    
    -- Check and re-insert Mobile Numbers
    SELECT COUNT(*) INTO v_count FROM vodacom_mobile_numbers;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Mobile Numbers...');
        INSERT ALL
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance, sms_balance)
          VALUES ('0821234567', 1, 'Postpaid', 'SIM-8927100012345678901', DATE '2022-01-15', 'Smart XL', 5120, 0, 0)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
          VALUES ('0839876543', 2, 'Prepaid', 'SIM-8927100098765432109', DATE '2021-06-20', 850, 45.50, 25)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, monthly_fee, data_balance_mb, airtime_balance)
          VALUES ('0765432109', 3, 'Contract', 'SIM-8927100011111222233', DATE '2020-11-10', 'Red 1GB', 299, 750, 0, 0)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
          VALUES ('0734567890', 4, 'Prepaid', 'SIM-8927100022222333344', DATE '2023-03-05', 0, 12.00, 5)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance, sms_balance)
          VALUES ('0827654321', 5, 'Postpaid', 'SIM-8927100033333444455', DATE '2021-09-12', 'Smart L', 3072, 0, 0)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
          VALUES ('0789012345', 9, 'Prepaid', 'SIM-8927100044444555566', DATE '2022-07-18', 1500, 85.00, 50)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
          VALUES ('0736789012', 10, 'Prepaid', 'SIM-8927100055555666677', DATE '2023-01-22', 2048, 120.00, 100)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, monthly_fee, data_balance_mb)
          VALUES ('0821231234', 11, 'Contract', 'SIM-8927100066666777788', DATE '2021-04-08', 'Red 2GB', 399, 1024, 0, 0)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
          VALUES ('0739876543', 12, 'Prepaid', 'SIM-8927100077777888899', DATE '2022-10-30', 500, 30.00, 10)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance)
          VALUES ('0756781234', 13, 'Postpaid', 'SIM-8927100088888999900', DATE '2020-08-14', 'Smart M', 2048, 0, 0)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
          VALUES ('0789011111', 15, 'Prepaid', 'SIM-8927100099999000011', DATE '2023-02-05', 3072, 150.00, 75)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, monthly_fee, data_balance_mb)
          VALUES ('0821112222', 16, 'Contract', 'SIM-8927100010101010101', DATE '2021-12-20', 'Red 5GB', 599, 4096, 0, 0)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
          VALUES ('0733334444', 19, 'Prepaid', 'SIM-8927100020202020202', DATE '2022-05-15', 256, 18.50, 8)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, data_balance_mb, airtime_balance, sms_balance)
          VALUES ('0765555666', 20, 'Prepaid', 'SIM-8927100030303030303', DATE '2023-04-10', 512, 55.00, 20)
          INTO vodacom_mobile_numbers (mobile_number, customer_id, number_type, sim_card_number, activation_date, current_package, data_balance_mb, airtime_balance)
          VALUES ('0826667777', 21, 'Postpaid', 'SIM-8927100040404040404', DATE '2021-07-25', 'Smart L', 3072, 0, 0)
        SELECT * FROM dual;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Mobile Numbers re-inserted: 15 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Mobile Numbers already populated: ' || v_count || ' records');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Data re-insertion check completed!');
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Check and re-insert Packages
    SELECT COUNT(*) INTO v_count FROM vodacom_packages;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Packages...');
        INSERT ALL
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
          VALUES ('DATA-DAILY-50', 'Daily 50MB', '50MB data valid for 24 hours', 'Data Only', 50, 10, 1, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
          VALUES ('DATA-DAILY-250', 'Daily 250MB', '250MB data valid for 24 hours', 'Data Only', 250, 25, 1, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
          VALUES ('DATA-WEEKLY-1G', 'Weekly 1GB', '1GB data valid for 7 days', 'Data Only', 1024, 75, 7, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
          VALUES ('DATA-WEEKLY-2G', 'Weekly 2GB', '2GB data valid for 7 days', 'Data Only', 2048, 135, 7, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional, promo_price, promo_start_date, promo_end_date)
          VALUES ('DATA-MONTHLY-1G', 'Monthly 1GB', '1GB data valid for 30 days', 'Data Only', 1024, 149, 30, 'Y', 99, DATE '2024-01-01', DATE '2024-12-31')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
          VALUES ('DATA-MONTHLY-2G', 'Monthly 2GB', '2GB data valid for 30 days', 'Data Only', 2048, 249, 30, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
          VALUES ('DATA-MONTHLY-5G', 'Monthly 5GB', '5GB data valid for 30 days', 'Data Only', 5120, 499, 30, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional)
          VALUES ('DATA-MONTHLY-10G', 'Monthly 10GB', '10GB data valid for 30 days', 'Data Only', 10240, 849, 30, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, price, validity_days, is_promotional, promo_price, promo_start_date, promo_end_date)
          VALUES ('DATA-MONTHLY-20G', 'Monthly 20GB', '20GB data valid for 30 days', 'Data Only', 20480, 1499, 30, 'Y', 1199, DATE '2024-01-01', DATE '2024-06-30')
          INTO vodacom_packages (package_code, package_name, description, package_type, voice_minutes, price, validity_days, is_promotional)
          VALUES ('VOICE-50MIN', '50 Minutes Anytime', '50 minutes to any network', 'Voice Only', 50, 50, 30, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, voice_minutes, price, validity_days, is_promotional)
          VALUES ('VOICE-100MIN', '100 Minutes Anytime', '100 minutes to any network', 'Voice Only', 100, 90, 30, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, voice_minutes, price, validity_days, is_promotional)
          VALUES ('VOICE-250MIN', '250 Minutes Anytime', '250 minutes to any network', 'Voice Only', 250, 200, 30, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, sms_count, price, validity_days, is_promotional)
          VALUES ('SMS-100', '100 SMS Bundle', '100 SMS to any network', 'SMS Only', 100, 25, 30, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, sms_count, price, validity_days, is_promotional)
          VALUES ('SMS-250', '250 SMS Bundle', '250 SMS to any network', 'SMS Only', 250, 50, 30, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, is_promotional)
          VALUES ('COMBO-SMART-S', 'Smart Combo S', '500MB + 50min + 50SMS', 'Combo', 500, 50, 50, 99, 30, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, is_promotional)
          VALUES ('COMBO-SMART-M', 'Smart Combo M', '2GB + 100min + 100SMS', 'Combo', 2048, 100, 100, 299, 30, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, is_promotional)
          VALUES ('COMBO-SMART-L', 'Smart Combo L', '5GB + 250min + 200SMS', 'Combo', 5120, 250, 200, 599, 30, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, validity_days, is_promotional, promo_price, promo_start_date, promo_end_date)
          VALUES ('COMBO-SMART-XL', 'Smart Combo XL', '10GB + 500min + 500SMS', 'Combo', 10240, 500, 500, 999, 30, 'Y', 799, DATE '2024-01-01', DATE '2024-12-31')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, is_promotional)
          VALUES ('CONTRACT-RED-1G', 'Red Contract 1GB', 'Monthly contract: 1GB + Unlimited calls + 200 SMS', 'Contract', 1024, 9999, 200, 299, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, is_promotional)
          VALUES ('CONTRACT-RED-2G', 'Red Contract 2GB', 'Monthly contract: 2GB + Unlimited calls + 500 SMS', 'Contract', 2048, 9999, 500, 399, 'N')
          INTO vodacom_packages (package_code, package_name, description, package_type, data_allocation_mb, voice_minutes, sms_count, price, is_promotional)
          VALUES ('CONTRACT-RED-5G', 'Red Contract 5GB', 'Monthly contract: 5GB + Unlimited calls + 1000 SMS', 'Contract', 5120, 9999, 1000, 599, 'N')
        SELECT * FROM dual;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Packages re-inserted: 21 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Packages already populated: ' || v_count || ' records');
    END IF;
    
    -- Check and re-insert Transactions
    SELECT COUNT(*) INTO v_count FROM vodacom_transactions;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Transactions...');
        INSERT ALL
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
          VALUES ('TXN-2024-00001', 1, '0821234567', 'Package Purchase', 999, 'Card', 18, TIMESTAMP '2024-01-05 10:15:30', 'Completed', 'App')
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, channel)
          VALUES ('TXN-2024-00002', 2, '0839876543', 'Airtime Purchase', 50, 'Cash', TIMESTAMP '2024-01-08 14:22:15', 'Completed', 'Store')
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
          VALUES ('TXN-2024-00003', 3, '0765432109', 'Data Purchase', 149, 'VodaPay', 5, TIMESTAMP '2024-01-10 09:45:00', 'Completed', 'USSD')
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, processed_by, channel)
          VALUES ('TXN-2024-00004', 4, '0734567890', 'Airtime Purchase', 20, 'Cash', TIMESTAMP '2024-01-12 16:30:45', 'Completed', 14, 'Store')
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
          VALUES ('TXN-2024-00005', 9, '0789012345', 'Data Purchase', 75, 'Card', 3, TIMESTAMP '2024-01-15 11:20:30', 'Completed', 'Web')
          INTO vodacom_transactions (transaction_ref, customer_id, transaction_type, amount, payment_method, transaction_date, status, channel)
          VALUES ('TXN-2024-00006', 1, 'VodaPay Transfer', 500, 'VodaPay', TIMESTAMP '2024-01-18 13:05:20', 'Completed', 'App')
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
          VALUES ('TXN-2024-00007', 10, '0736789012', 'Data Purchase', 249, 'VodaPay', 6, TIMESTAMP '2024-01-20 08:15:00', 'Completed', 'App')
          INTO vodacom_transactions (transaction_ref, customer_id, transaction_type, amount, payment_method, transaction_date, status, channel)
          VALUES ('TXN-2024-00008', 3, 'VodaPay Purchase', 350, 'VodaPay', TIMESTAMP '2024-01-22 17:40:15', 'Completed', 'App')
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, channel)
          VALUES ('TXN-2024-00009', 11, '0821231234', 'Airtime Purchase', 100, 'Card', TIMESTAMP '2024-01-25 12:30:00', 'Completed', 'Web')
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
          VALUES ('TXN-2024-00010', 13, '0756781234', 'Package Purchase', 599, 'Direct Debit', 17, TIMESTAMP '2024-01-28 10:00:00', 'Completed', 'App')
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, channel)
          VALUES ('TXN-2024-00011', 2, '0839876543', 'Airtime Purchase', 30, 'Voucher', TIMESTAMP '2024-02-01 15:45:30', 'Completed', 'USSD')
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
          VALUES ('TXN-2024-00012', 15, '0789011111', 'Data Purchase', 499, 'Card', 7, TIMESTAMP '2024-02-03 09:20:15', 'Completed', 'App')
          INTO vodacom_transactions (transaction_ref, customer_id, transaction_type, amount, payment_method, transaction_date, status, channel)
          VALUES ('TXN-2024-00013', 5, 'Bill Payment', 850, 'VodaPay', TIMESTAMP '2024-02-05 14:10:00', 'Completed', 'App')
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, package_id, transaction_date, status, channel)
          VALUES ('TXN-2024-00014', 16, '0821112222', 'Package Purchase', 999, 'Card', 18, TIMESTAMP '2024-02-08 11:35:45', 'Completed', 'Web')
          INTO vodacom_transactions (transaction_ref, customer_id, mobile_number, transaction_type, amount, payment_method, transaction_date, status, processed_by, channel)
          VALUES ('TXN-2024-00015', 19, '0733334444', 'Airtime Purchase', 15, 'Cash', TIMESTAMP '2024-02-10 16:50:20', 'Completed', 12, 'Store')
        SELECT * FROM dual;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Transactions re-inserted: 15 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Transactions already populated: ' || v_count || ' records');
    END IF;
    
    -- Check and re-insert Network Towers
    SELECT COUNT(*) INTO v_count FROM vodacom_network_towers;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Network Towers...');
        INSERT ALL
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('JHB-T001', 'Sandton City Tower', -26.107730, 28.056305, 'Gauteng', 'Johannesburg', '5G', 5000, DATE '2022-03-15', 85000, 'Vodacom')
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('JHB-T002', 'Rosebank Mall Tower', -26.147780, 28.040650, 'Gauteng', 'Johannesburg', 'Hybrid', 4500, DATE '2021-08-20', 75000, 'Vodacom')
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('CPT-T001', 'V&A Waterfront Tower', -33.904500, 18.419180, 'Western Cape', 'Cape Town', '5G', 5500, DATE '2022-06-10', 90000, 'Vodacom')
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('CPT-T002', 'Century City Tower', -33.892890, 18.508890, 'Western Cape', 'Cape Town', 'Hybrid', 4000, DATE '2021-05-15', 70000, 'Leased')
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('DBN-T001', 'Umhlanga Rocks Tower', -29.729550, 31.082300, 'KwaZulu-Natal', 'Durban', '5G', 4800, DATE '2022-09-05', 82000, 'Vodacom')
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('DBN-T002', 'Gateway Mall Tower', -29.763330, 31.048890, 'KwaZulu-Natal', 'Durban', 'Hybrid', 4200, DATE '2021-11-20', 72000, 'Shared')
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('PTA-T001', 'Menlyn Tower', -25.781670, 28.276390, 'Gauteng', 'Pretoria', '5G', 4600, DATE '2022-04-12', 80000, 'Vodacom')
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('PTA-T002', 'Hatfield Plaza Tower', -25.749170, 28.238610, 'Gauteng', 'Pretoria', 'Hybrid', 3800, DATE '2021-07-08', 68000, 'Leased')
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('BFN-T001', 'Bloemfontein Central', -29.121110, 26.214440, 'Free State', 'Bloemfontein', '4G', 3500, DATE '2020-10-15', 55000, 'Vodacom')
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('PLK-T001', 'Polokwane Mall Tower', -23.905000, 29.458330, 'Limpopo', 'Polokwane', '4G', 3200, DATE '2020-12-01', 52000, 'Shared')
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('ELS-T001', 'East London Beachfront', -33.015000, 27.911670, 'Eastern Cape', 'East London', '4G', 3000, DATE '2021-02-18', 50000, 'Leased')
          INTO vodacom_network_towers (tower_code, tower_name, latitude, longitude, province, city, tower_type, capacity, installation_date, monthly_cost, owner_type)
          VALUES ('NPT-T001', 'Nelspruit City Tower', -25.474440, 30.970000, 'Mpumalanga', 'Nelspruit', '4G', 2800, DATE '2021-04-22', 48000, 'Vodacom')
        SELECT * FROM dual;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Network Towers re-inserted: 12 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Network Towers already populated: ' || v_count || ' records');
    END IF;
    
    -- Check and re-insert Network Issues
    SELECT COUNT(*) INTO v_count FROM vodacom_network_issues;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Network Issues...');
        INSERT ALL
          INTO vodacom_network_issues (issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status)
          VALUES ('INC-2024-001', 1, 'Maintenance', 'Low', 'Scheduled upgrade to 5G equipment', 'Gauteng', 'Johannesburg', 0, TIMESTAMP '2024-02-15 02:00:00', 'Resolved')
          INTO vodacom_network_issues (issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to)
          VALUES ('INC-2024-002', 5, 'Outage', 'Critical', 'Complete tower failure - power supply issue', 'KwaZulu-Natal', 'Durban', 4800, TIMESTAMP '2024-02-10 14:30:00', 'Resolved', 7)
          INTO vodacom_network_issues (issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to)
          VALUES ('INC-2024-003', 3, 'Degraded Service', 'High', 'Intermittent connectivity - investigating hardware', 'Western Cape', 'Cape Town', 2500, TIMESTAMP '2024-02-18 09:15:00', 'In Progress', 8)
          INTO vodacom_network_issues (issue_ref, issue_type, severity, description, province, city, affected_customers, reported_date, status)
          VALUES ('INC-2024-004', 'Weather Damage', 'Medium', 'Lightning damage to fiber connection', 'Free State', 'Bloemfontein', 1200, TIMESTAMP '2024-02-12 18:45:00', 'Resolved')
          INTO vodacom_network_issues (issue_ref, tower_id, issue_type, severity, description, province, city, affected_customers, reported_date, status, assigned_to)
          VALUES ('INC-2024-005', 7, 'Vandalism', 'High', 'Cable theft affecting tower connectivity', 'Gauteng', 'Pretoria', 3200, TIMESTAMP '2024-02-20 06:30:00', 'Acknowledged', 6)
        SELECT * FROM dual;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Network Issues re-inserted: 5 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Network Issues already populated: ' || v_count || ' records');
    END IF;
    
    -- Check and re-insert Customer Support
    SELECT COUNT(*) INTO v_count FROM vodacom_customer_support;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Customer Support tickets...');
        INSERT ALL
          INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, channel, assigned_to)
          VALUES ('TKT-2024-00001', 1, '0821234567', 'Billing', 'Incorrect Charge', 'Charged twice for the same data bundle purchase', 'High', 'Call Center', 2)
          INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction)
          VALUES ('TKT-2024-00002', 2, '0839876543', 'Network', 'No Signal', 'No network coverage at home address', 'Urgent', 'Resolved', 'App', 3, TIMESTAMP '2024-01-10 16:30:00', 'Escalated to Network Operations. Tower maintenance completed.', 5)
          INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel)
          VALUES ('TKT-2024-00003', 4, '0734567890', 'Technical', 'Data Not Working', 'Purchased data but cannot browse internet', 'Normal', 'In Progress', 'Call Center', 4)
          INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction)
          VALUES ('TKT-2024-00004', 3, '0765432109', 'Account', 'Password Reset', 'Cannot access online account - forgot password', 'Low', 'Closed', 'Web', 5, TIMESTAMP '2024-01-15 10:20:00', 'Password reset link sent to registered email', 4)
          INTO vodacom_customer_support (ticket_number, customer_id, issue_category, issue_type, description, priority, channel, assigned_to)
          VALUES ('TKT-2024-00005', 1, 'VodaPay', 'Transaction Failed', 'VodaPay transfer failed but amount was deducted', 'Urgent', 'App', 28)
          INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to)
          VALUES ('TKT-2024-00006', 9, '0789012345', 'Billing', 'Invoice Query', 'Requesting breakdown of last month charges', 'Normal', 'Assigned', 'Email', 16)
          INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction)
          VALUES ('TKT-2024-00007', 11, '0821231234', 'Complaint', 'Poor Service', 'Multiple dropped calls in past week', 'High', 'Resolved', 'Call Center', 2, TIMESTAMP '2024-01-22 14:45:00', 'Network issue identified and fixed. Compensated with 1GB data', 3)
          INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, channel)
          VALUES ('TKT-2024-00008', 15, '0789011111', 'Query', 'Package Information', 'Want to know about available monthly packages', 'Low', 'Open', 'Social Media')
          INTO vodacom_customer_support (ticket_number, customer_id, mobile_number, issue_category, issue_type, description, priority, status, channel, assigned_to)
          VALUES ('TKT-2024-00009', 16, '0821112222', 'Technical', 'SIM Card Issue', 'SIM card not detected by phone', 'High', 'In Progress', 'Walk-in', 3)
          INTO vodacom_customer_support (ticket_number, customer_id, issue_category, issue_type, description, priority, status, channel, assigned_to, resolved_date, resolution, customer_satisfaction)
          VALUES ('TKT-2024-00010', 5, 'Request', 'Upgrade Package', 'Want to upgrade to higher data package', 'Normal', 'Closed', 'App', 11, TIMESTAMP '2024-02-05 11:15:00', 'Customer upgraded to Smart L package successfully', 5)
        SELECT * FROM dual;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Customer Support re-inserted: 10 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Customer Support already populated: ' || v_count || ' records');
    END IF;
    
    -- Check and re-insert Sales
    SELECT COUNT(*) INTO v_count FROM vodacom_sales;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Sales...');
        INSERT ALL
          INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
          VALUES ('SALE-2024-00001', 1, DATE '2024-01-10', 'New Contract', 'Red 5GB - 24 Month Contract', 1, 599, 0, 0, 599, 'Direct Debit', 11, 29.95, 'JHB-001')
          INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
          VALUES ('SALE-2024-00002', 9, DATE '2024-01-12', 'Device', 'Samsung Galaxy A34 5G', 1, 6999, 10, 700, 6299, 'Card', 12, 503.92, 'JHB-002')
          INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
          VALUES ('SALE-2024-00003', 4, DATE '2024-01-15', 'SIM Card', 'Prepaid SIM Starter Pack', 1, 5, 0, 0, 5, 'Cash', 14, 0.50, 'DBN-001')
          INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
          VALUES ('SALE-2024-00004', 3, DATE '2024-01-18', 'Upgrade', 'iPhone 15 Pro - Contract Upgrade', 1, 24999, 15, 3750, 21249, 'Card', 11, 1062.45, 'CPT-001')
          INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
          VALUES ('SALE-2024-00005', 11, DATE '2024-01-20', 'Accessory', 'Wireless Earbuds', 1, 1299, 0, 0, 1299, 'Card', 12, 103.92, 'JHB-001')
          INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
          VALUES ('SALE-2024-00006', 15, DATE '2024-01-25', 'Device', 'Huawei WiFi Router 5G', 1, 3999, 5, 200, 3799, 'VodaPay', 13, 303.92, 'DBN-001')
          INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
          VALUES ('SALE-2024-00007', 6, DATE '2024-01-28', 'Enterprise', 'Corporate Package - 50 Lines', 50, 399, 20, 3990, 15960, 'EFT', 11, 798.00, 'JHB-001')
          INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
          VALUES ('SALE-2024-00008', 16, DATE '2024-02-01', 'Device', 'Samsung Galaxy S24', 1, 17999, 0, 0, 17999, 'Card', 14, 1439.92, 'CPT-001')
          INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
          VALUES ('SALE-2024-00009', 19, DATE '2024-02-05', 'Accessory', 'Phone Case + Screen Protector', 1, 299, 0, 0, 299, 'Cash', 12, 23.92, 'JHB-002')
          INTO vodacom_sales (sale_ref, customer_id, sale_date, sale_type, product_name, quantity, unit_price, discount_percent, discount_amount, total_amount, payment_method, sales_agent_id, commission_amount, branch_code)
          VALUES ('SALE-2024-00010', 21, DATE '2024-02-08', 'New Contract', 'Red 2GB - 24 Month Contract', 1, 399, 0, 0, 399, 'Direct Debit', 13, 19.95, 'DBN-001')
        SELECT * FROM dual;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Sales re-inserted: 10 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Sales already populated: ' || v_count || ' records');
    END IF;
    
    -- Check and re-insert VodaPay Accounts
    SELECT COUNT(*) INTO v_count FROM vodacom_vodapay_accounts;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting VodaPay Accounts...');
        INSERT ALL
          INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
          VALUES (1, 'VP-821234567', '0821234567', 1250.50, 5000, 50000, 'Y', DATE '2022-06-15', 15680.00, 8950.50)
          INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
          VALUES (3, 'VP-765432109', '0765432109', 3420.75, 10000, 100000, 'Y', DATE '2021-03-20', 42350.00, 38770.75)
          INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
          VALUES (5, 'VP-827654321', '0827654321', 580.00, 5000, 50000, 'Y', DATE '2022-11-08', 8920.00, 6500.00)
          INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
          VALUES (10, 'VP-736789012', '0736789012', 2150.30, 5000, 50000, 'Y', DATE '2023-01-25', 12450.00, 10600.30)
          INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
          VALUES (13, 'VP-756781234', '0756781234', 4850.00, 10000, 100000, 'Y', DATE '2021-07-12', 65200.00, 58050.00)
          INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
          VALUES (15, 'VP-789011111', '0789011111', 620.45, 5000, 50000, 'Y', DATE '2023-02-18', 4380.00, 3000.45)
          INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
          VALUES (16, 'VP-821112222', '0821112222', 8920.80, 15000, 150000, 'Y', DATE '2022-01-05', 98450.00, 92370.80)
          INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
          VALUES (20, 'VP-765555666', '0765555666', 150.20, 5000, 50000, 'Y', DATE '2023-04-22', 2850.00, 1000.20)
          INTO vodacom_vodapay_accounts (customer_id, wallet_number, linked_mobile, balance, daily_limit, monthly_limit, kyc_verified, activation_date, total_spent, total_received)
          VALUES (21, 'VP-826667777', '0826667777', 1780.90, 5000, 50000, 'Y', DATE '2022-08-30', 18920.00, 14700.90)
        SELECT * FROM dual;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ VodaPay Accounts re-inserted: 9 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ VodaPay Accounts already populated: ' || v_count || ' records');
    END IF;
    
    -- Check and re-insert Invoices
    SELECT COUNT(*) INTO v_count FROM vodacom_invoices;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Invoices...');
        INSERT ALL
          INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by)
          VALUES ('INV-2024-01-001', 1, '0821234567', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 869.57, 130.43, 1000.00, 1000.00, 0, 'Paid', 16)
          INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by)
          VALUES ('INV-2024-01-002', 3, '0765432109', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 521.74, 78.26, 600.00, 600.00, 0, 'Paid', 16)
          INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, payment_date, generated_by)
          VALUES ('INV-2024-01-003', 11, '0821231234', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 695.65, 104.35, 800.00, 800.00, 0, 'Paid', DATE '2024-02-10', 16)
          INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by)
          VALUES ('INV-2024-01-004', 13, '0756781234', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 434.78, 65.22, 500.00, 0, 500.00, 'Issued', 16)
          INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by)
          VALUES ('INV-2024-01-005', 16, '0821112222', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 1043.48, 156.52, 1200.00, 0, 1200.00, 'Issued', 16)
          INTO vodacom_invoices (invoice_number, customer_id, mobile_number, invoice_date, due_date, billing_period, subtotal, vat_amount, total_amount, amount_paid, balance, status, generated_by)
          VALUES ('INV-2024-01-006', 21, '0826667777', DATE '2024-01-31', DATE '2024-02-15', 'January 2024', 782.61, 117.39, 900.00, 450.00, 450.00, 'Partially Paid', 16)
        SELECT * FROM dual;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Invoices re-inserted: 6 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Invoices already populated: ' || v_count || ' records');
    END IF;
    
    -- Check and re-insert Invoice Items
    SELECT COUNT(*) INTO v_count FROM vodacom_invoice_items;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Re-inserting Invoice Items...');
        INSERT ALL
          INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
          VALUES (1, 'Monthly Rental', 'Smart XL Package Monthly Fee', 1, 999, 999)
          INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
          VALUES (1, 'Voice Calls', 'Out-of-bundle calls', 1.00)
          INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
          VALUES (2, 'Monthly Rental', 'Red 1GB Contract Monthly Fee', 1, 299, 299)
          INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
          VALUES (2, 'Data Usage', 'Out-of-bundle data usage', 250, 0.99, 247.50)
          INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
          VALUES (2, 'SMS Charges', 'Additional SMS', 75.24)
          INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
          VALUES (3, 'Monthly Rental', 'Red 2GB Contract Monthly Fee', 1, 399, 399)
          INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
          VALUES (3, 'Data Usage', 'Out-of-bundle data usage', 400, 0.99, 396.00)
          INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
          VALUES (3, 'International Calls', 'International calls', 5.65)
          INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
          VALUES (4, 'Monthly Rental', 'Smart M Package Monthly Fee', 1, 299, 299)
          INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
          VALUES (4, 'Data Usage', 'Out-of-bundle data usage', 150, 0.99, 148.50)
          INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
          VALUES (4, 'Value Added Services', 'Music streaming service', 52.28)
          INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
          VALUES (5, 'Monthly Rental', 'Red 5GB Contract Monthly Fee', 1, 599, 599)
          INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
          VALUES (5, 'Device Installment', 'iPhone 15 Pro - Month 3 of 24', 1, 590, 590)
          INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
          VALUES (5, 'Data Usage', 'Out-of-bundle data', 54.48)
          INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
          VALUES (6, 'Monthly Rental', 'Smart L Package Monthly Fee', 1, 599, 599)
          INTO vodacom_invoice_items (invoice_id, item_type, description, quantity, unit_price, amount)
          VALUES (6, 'Data Usage', 'Out-of-bundle data usage', 180, 0.99, 178.20)
          INTO vodacom_invoice_items (invoice_id, item_type, description, amount)
          VALUES (6, 'Roaming', 'Data roaming charges', 105.41)
        SELECT * FROM dual;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('✓ Invoice Items re-inserted: 17 records');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ Invoice Items already populated: ' || v_count || ' records');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('✓ All data re-insertion checks completed successfully!');
    DBMS_OUTPUT.PUT_LINE('');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('❌ ERROR during data re-insertion: ' || SQLERRM);
        ROLLBACK;
        RAISE;
END;
/

COMMIT;

-- ============================================================================
-- DATA VALIDATION AND VERIFICATION
-- ============================================================================
-- This block validates that all tables have been populated with data
-- and provides detailed reporting on any missing data
-- ============================================================================

DECLARE
    v_table_count NUMBER;
    v_dept_count NUMBER;
    v_emp_count NUMBER;
    v_cust_count NUMBER;
    v_number_count NUMBER;
    v_pkg_count NUMBER;
    v_trans_count NUMBER;
    v_tower_count NUMBER;
    v_issue_count NUMBER;
    v_ticket_count NUMBER;
    v_sale_count NUMBER;
    v_vodapay_count NUMBER;
    v_invoice_count NUMBER;
    v_invoice_item_count NUMBER;
    v_errors NUMBER := 0;
    v_warnings NUMBER := 0;
    
    -- Expected minimum counts for each table
    v_expected_dept CONSTANT NUMBER := 8;
    v_expected_emp CONSTANT NUMBER := 29;
    v_expected_cust CONSTANT NUMBER := 22;
    v_expected_number CONSTANT NUMBER := 15;
    v_expected_pkg CONSTANT NUMBER := 21;
    v_expected_trans CONSTANT NUMBER := 15;
    v_expected_tower CONSTANT NUMBER := 12;
    v_expected_issue CONSTANT NUMBER := 5;
    v_expected_ticket CONSTANT NUMBER := 10;
    v_expected_sale CONSTANT NUMBER := 10;
    v_expected_vodapay CONSTANT NUMBER := 9;
    v_expected_invoice CONSTANT NUMBER := 6;
    v_expected_item CONSTANT NUMBER := 17;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('VODACOM DATABASE VALIDATION REPORT');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Generated: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'));
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Count tables
    SELECT COUNT(*) INTO v_table_count FROM user_tables WHERE table_name LIKE 'VODACOM_%';
    DBMS_OUTPUT.PUT_LINE('Tables created: ' || v_table_count || ' of 13');
    
    IF v_table_count < 13 THEN
        DBMS_OUTPUT.PUT_LINE('❌ ERROR: Missing tables! Expected 13, found ' || v_table_count);
        v_errors := v_errors + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ All tables created successfully');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('DATA POPULATION VALIDATION:');
    DBMS_OUTPUT.PUT_LINE('========================================');
    
    -- Check each table
    -- 1. Departments
    SELECT COUNT(*) INTO v_dept_count FROM vodacom_departments;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('1. vodacom_departments:');
    IF v_dept_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_dept || ' records');
        v_errors := v_errors + 1;
    ELSIF v_dept_count < v_expected_dept THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_dept_count || ' records. Expected ' || v_expected_dept);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_dept_count || ' records populated');
    END IF;
    
    -- 2. Employees
    SELECT COUNT(*) INTO v_emp_count FROM vodacom_employees;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('2. vodacom_employees:');
    IF v_emp_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_emp || ' records');
        v_errors := v_errors + 1;
    ELSIF v_emp_count < v_expected_emp THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_emp_count || ' records. Expected ' || v_expected_emp);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_emp_count || ' records populated');
    END IF;
    
    -- 3. Customers
    SELECT COUNT(*) INTO v_cust_count FROM vodacom_customers;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('3. vodacom_customers:');
    IF v_cust_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_cust || ' records');
        v_errors := v_errors + 1;
    ELSIF v_cust_count < v_expected_cust THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_cust_count || ' records. Expected ' || v_expected_cust);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_cust_count || ' records populated');
    END IF;
    
    -- 4. Mobile Numbers
    SELECT COUNT(*) INTO v_number_count FROM vodacom_mobile_numbers;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('4. vodacom_mobile_numbers:');
    IF v_number_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_number || ' records');
        v_errors := v_errors + 1;
    ELSIF v_number_count < v_expected_number THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_number_count || ' records. Expected ' || v_expected_number);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_number_count || ' records populated');
    END IF;
    
    -- 5. Packages
    SELECT COUNT(*) INTO v_pkg_count FROM vodacom_packages;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('5. vodacom_packages:');
    IF v_pkg_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_pkg || ' records');
        v_errors := v_errors + 1;
    ELSIF v_pkg_count < v_expected_pkg THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_pkg_count || ' records. Expected ' || v_expected_pkg);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_pkg_count || ' records populated');
    END IF;
    
    -- 6. Transactions
    SELECT COUNT(*) INTO v_trans_count FROM vodacom_transactions;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('6. vodacom_transactions:');
    IF v_trans_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_trans || ' records');
        v_errors := v_errors + 1;
    ELSIF v_trans_count < v_expected_trans THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_trans_count || ' records. Expected ' || v_expected_trans);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_trans_count || ' records populated');
    END IF;
    
    -- 7. Network Towers
    SELECT COUNT(*) INTO v_tower_count FROM vodacom_network_towers;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('7. vodacom_network_towers:');
    IF v_tower_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_tower || ' records');
        v_errors := v_errors + 1;
    ELSIF v_tower_count < v_expected_tower THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_tower_count || ' records. Expected ' || v_expected_tower);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_tower_count || ' records populated');
    END IF;
    
    -- 8. Network Issues
    SELECT COUNT(*) INTO v_issue_count FROM vodacom_network_issues;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('8. vodacom_network_issues:');
    IF v_issue_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_issue || ' records');
        v_errors := v_errors + 1;
    ELSIF v_issue_count < v_expected_issue THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_issue_count || ' records. Expected ' || v_expected_issue);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_issue_count || ' records populated');
    END IF;
    
    -- 9. Customer Support
    SELECT COUNT(*) INTO v_ticket_count FROM vodacom_customer_support;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('9. vodacom_customer_support:');
    IF v_ticket_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_ticket || ' records');
        v_errors := v_errors + 1;
    ELSIF v_ticket_count < v_expected_ticket THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_ticket_count || ' records. Expected ' || v_expected_ticket);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_ticket_count || ' records populated');
    END IF;
    
    -- 10. Sales
    SELECT COUNT(*) INTO v_sale_count FROM vodacom_sales;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('10. vodacom_sales:');
    IF v_sale_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_sale || ' records');
        v_errors := v_errors + 1;
    ELSIF v_sale_count < v_expected_sale THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_sale_count || ' records. Expected ' || v_expected_sale);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_sale_count || ' records populated');
    END IF;
    
    -- 11. VodaPay Accounts
    SELECT COUNT(*) INTO v_vodapay_count FROM vodacom_vodapay_accounts;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('11. vodacom_vodapay_accounts:');
    IF v_vodapay_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_vodapay || ' records');
        v_errors := v_errors + 1;
    ELSIF v_vodapay_count < v_expected_vodapay THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_vodapay_count || ' records. Expected ' || v_expected_vodapay);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_vodapay_count || ' records populated');
    END IF;
    
    -- 12. Invoices
    SELECT COUNT(*) INTO v_invoice_count FROM vodacom_invoices;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('12. vodacom_invoices:');
    IF v_invoice_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_invoice || ' records');
        v_errors := v_errors + 1;
    ELSIF v_invoice_count < v_expected_invoice THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_invoice_count || ' records. Expected ' || v_expected_invoice);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_invoice_count || ' records populated');
    END IF;
    
    -- 13. Invoice Items
    SELECT COUNT(*) INTO v_invoice_item_count FROM vodacom_invoice_items;
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('13. vodacom_invoice_items:');
    IF v_invoice_item_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('   ❌ CRITICAL: No data found! Expected ' || v_expected_item || ' records');
        v_errors := v_errors + 1;
    ELSIF v_invoice_item_count < v_expected_item THEN
        DBMS_OUTPUT.PUT_LINE('   ⚠ WARNING: Only ' || v_invoice_item_count || ' records. Expected ' || v_expected_item);
        v_warnings := v_warnings + 1;
    ELSE
        DBMS_OUTPUT.PUT_LINE('   ✓ ' || v_invoice_item_count || ' records populated');
    END IF;
    
    -- Summary report
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('VALIDATION SUMMARY:');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Total Tables: ' || v_table_count);
    DBMS_OUTPUT.PUT_LINE('Total Records: ' || (v_dept_count + v_emp_count + v_cust_count + 
                         v_number_count + v_pkg_count + v_trans_count + v_tower_count + 
                         v_issue_count + v_ticket_count + v_sale_count + v_vodapay_count + 
                         v_invoice_count + v_invoice_item_count));
    DBMS_OUTPUT.PUT_LINE('Errors: ' || v_errors);
    DBMS_OUTPUT.PUT_LINE('Warnings: ' || v_warnings);
    DBMS_OUTPUT.PUT_LINE('');
    
    -- Final status
    IF v_errors > 0 THEN
        DBMS_OUTPUT.PUT_LINE('❌ STATUS: FAILED - ' || v_errors || ' critical error(s) found');
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('TROUBLESHOOTING STEPS:');
        DBMS_OUTPUT.PUT_LINE('1. Check if you ran this script in SQL Scripts (not SQL Commands)');
        DBMS_OUTPUT.PUT_LINE('2. Review the script execution log for errors');
        DBMS_OUTPUT.PUT_LINE('3. Verify all INSERT statements completed successfully');
        DBMS_OUTPUT.PUT_LINE('4. Check for constraint violations or foreign key errors');
        DBMS_OUTPUT.PUT_LINE('5. Ensure COMMIT statements were executed');
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('To verify individual tables, run:');
        DBMS_OUTPUT.PUT_LINE('  SELECT COUNT(*) FROM vodacom_departments;');
        DBMS_OUTPUT.PUT_LINE('  SELECT COUNT(*) FROM vodacom_employees;');
        DBMS_OUTPUT.PUT_LINE('  (etc. for each table)');
        RAISE_APPLICATION_ERROR(-20001, 'Data validation failed! Check output above for details.');
    ELSIF v_warnings > 0 THEN
        DBMS_OUTPUT.PUT_LINE('⚠ STATUS: COMPLETED WITH WARNINGS - ' || v_warnings || ' warning(s)');
        DBMS_OUTPUT.PUT_LINE('Some tables have fewer records than expected.');
        DBMS_OUTPUT.PUT_LINE('The database is functional but may have incomplete data.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('✓ STATUS: SUCCESS - All tables populated correctly!');
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('You can now proceed with Lab exercises!');
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('Quick verification queries:');
        DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_departments;');
        DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_employees WHERE ROWNUM <= 10;');
        DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_customers WHERE ROWNUM <= 10;');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('========================================');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('❌ VALIDATION ERROR: ' || SQLERRM);
        DBMS_OUTPUT.PUT_LINE('Error Code: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE('This usually means one or more tables were not created properly.');
        DBMS_OUTPUT.PUT_LINE('Please re-run the entire script from the beginning.');
        RAISE;
END;
/
