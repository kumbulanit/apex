-- ============================================================================
-- VODACOM SIMPLE DATABASE SETUP
-- Oracle APEX Training Course
-- ============================================================================
-- Simple Vodacom mobile network database with sample data
-- 
-- TABLES CREATED:
-- 1. Customers - Mobile customers
-- 2. Packages - Data/voice/SMS packages
-- 3. Subscriptions - Customer package subscriptions
-- 4. Transactions - Customer transactions
-- 5. Support_Tickets - Customer support issues
-- 6. Contract_Types - Different contract types and terms
-- 7. Customer_Contracts - Active customer contracts
-- 8. Contract_Renewals - Contract renewal history
-- 9. Contract_Penalties - Early termination penalties
-- 10. Contract_Benefits - Contract loyalty benefits and rewards
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
        'VODACOM_CONTRACT_PENALTIES', 'VODACOM_CONTRACT_BENEFITS'
    )) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS PURGE';
    END LOOP;
END;
/

-- ============================================================================
-- CUSTOMERS TABLE
-- ============================================================================
CREATE TABLE vodacom_customers (
    customer_id       NUMBER PRIMARY KEY,
    first_name        VARCHAR2(50) NOT NULL,
    last_name         VARCHAR2(50) NOT NULL,
    mobile_number     VARCHAR2(15) NOT NULL UNIQUE,
    email             VARCHAR2(100),
    id_number         VARCHAR2(13),
    registration_date DATE DEFAULT SYSDATE,
    status            VARCHAR2(20) DEFAULT 'Active'
);

CREATE SEQUENCE vodacom_customers_seq START WITH 1;

-- Insert 10 customers
INSERT INTO vodacom_customers VALUES (1, 'Thabo', 'Sithole', '0821234567', 'thabo.sithole@email.com', '8501015800081', DATE '2023-01-15', 'Active');
INSERT INTO vodacom_customers VALUES (2, 'Zanele', 'Dlamini', '0832345678', 'zanele.dlamini@email.com', '9203256789012', DATE '2023-02-20', 'Active');
INSERT INTO vodacom_customers VALUES (3, 'Sipho', 'Nkosi', '0843456789', 'sipho.nkosi@email.com', '7812121234567', DATE '2023-03-10', 'Active');
INSERT INTO vodacom_customers VALUES (4, 'Nomsa', 'Khumalo', '0794567890', 'nomsa.khumalo@email.com', '8906155678901', DATE '2023-04-05', 'Active');
INSERT INTO vodacom_customers VALUES (5, 'Mandla', 'Mthembu', '0725678901', 'mandla.mthembu@email.com', '7509305432109', DATE '2023-05-12', 'Active');
INSERT INTO vodacom_customers VALUES (6, 'Thembi', 'Zulu', '0836789012', 'thembi.zulu@email.com', '9105128901234', DATE '2023-06-18', 'Active');
INSERT INTO vodacom_customers VALUES (7, 'Bongani', 'Mkhize', '0847890123', 'bongani.mkhize@email.com', '8208097654321', DATE '2023-07-22', 'Active');
INSERT INTO vodacom_customers VALUES (8, 'Thandi', 'Ndlovu', '0798901234', 'thandi.ndlovu@email.com', '9401204567890', DATE '2023-08-30', 'Active');
INSERT INTO vodacom_customers VALUES (9, 'Lungile', 'Radebe', '0729012345', 'lungile.radebe@email.com', '8607193210987', DATE '2023-09-14', 'Active');
INSERT INTO vodacom_customers VALUES (10, 'Zinhle', 'Cele', '0830123456', 'zinhle.cele@email.com', '9308247890123', DATE '2023-10-08', 'Active');

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
-- SUBSCRIPTIONS TABLE
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
-- TRANSACTIONS TABLE
-- ============================================================================
CREATE TABLE vodacom_transactions (
    transaction_id    NUMBER PRIMARY KEY,
    customer_id       NUMBER NOT NULL,
    transaction_date  DATE DEFAULT SYSDATE,
    transaction_type  VARCHAR2(50),
    amount            NUMBER(10,2) NOT NULL,
    description       VARCHAR2(200),
    CONSTRAINT fk_trans_customer FOREIGN KEY (customer_id) REFERENCES vodacom_customers(customer_id)
);

CREATE SEQUENCE vodacom_transactions_seq START WITH 1;

-- Insert 10 transactions
INSERT INTO vodacom_transactions VALUES (1, 1, DATE '2024-01-01', 'Recharge', 99.00, 'Smart S package purchase');
INSERT INTO vodacom_transactions VALUES (2, 2, DATE '2024-01-01', 'Subscription', 199.00, 'Red Plan 199 monthly payment');
INSERT INTO vodacom_transactions VALUES (3, 3, DATE '2024-01-05', 'Recharge', 299.00, 'Smart L package purchase');
INSERT INTO vodacom_transactions VALUES (4, 4, DATE '2024-01-10', 'Subscription', 299.00, 'Red Plan 299 monthly payment');
INSERT INTO vodacom_transactions VALUES (5, 5, DATE '2024-01-15', 'Recharge', 149.00, 'Smart M package purchase');
INSERT INTO vodacom_transactions VALUES (6, 6, DATE '2024-01-20', 'Subscription', 499.00, 'Red Plan 499 monthly payment');
INSERT INTO vodacom_transactions VALUES (7, 7, DATE '2024-01-25', 'Recharge', 499.00, 'Smart XL package purchase');
INSERT INTO vodacom_transactions VALUES (8, 8, DATE '2024-02-01', 'Data Bundle', 199.00, 'Data Only 5GB purchase');
INSERT INTO vodacom_transactions VALUES (9, 9, DATE '2024-02-05', 'Data Bundle', 49.00, 'Data Only 1GB purchase');
INSERT INTO vodacom_transactions VALUES (10, 10, DATE '2024-02-10', 'Data Bundle', 99.00, 'Night Owl 10GB purchase');

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
    DBMS_OUTPUT.PUT_LINE('Tables created with 10 records each:');
    DBMS_OUTPUT.PUT_LINE('  ✓ VODACOM_CUSTOMERS');
    DBMS_OUTPUT.PUT_LINE('  ✓ VODACOM_PACKAGES');
    DBMS_OUTPUT.PUT_LINE('  ✓ VODACOM_SUBSCRIPTIONS');
    DBMS_OUTPUT.PUT_LINE('  ✓ VODACOM_TRANSACTIONS');
    DBMS_OUTPUT.PUT_LINE('  ✓ VODACOM_SUPPORT_TICKETS');
    DBMS_OUTPUT.PUT_LINE('  ✓ VODACOM_CONTRACT_TYPES');
    DBMS_OUTPUT.PUT_LINE('  ✓ VODACOM_CUSTOMER_CONTRACTS');
    DBMS_OUTPUT.PUT_LINE('  ✓ VODACOM_CONTRACT_RENEWALS');
    DBMS_OUTPUT.PUT_LINE('  ✓ VODACOM_CONTRACT_PENALTIES');
    DBMS_OUTPUT.PUT_LINE('  ✓ VODACOM_CONTRACT_BENEFITS');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('CONTRACT DEPARTMENT TABLES:');
    DBMS_OUTPUT.PUT_LINE('  - Contract Types (12-36 month plans)');
    DBMS_OUTPUT.PUT_LINE('  - Customer Contracts (with devices)');
    DBMS_OUTPUT.PUT_LINE('  - Contract Renewals (upgrade history)');
    DBMS_OUTPUT.PUT_LINE('  - Contract Penalties (fees & charges)');
    DBMS_OUTPUT.PUT_LINE('  - Contract Benefits (loyalty rewards)');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Quick test queries:');
    DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_customer_contracts;');
    DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_contract_types;');
    DBMS_OUTPUT.PUT_LINE('  SELECT * FROM vodacom_contract_renewals;');
    DBMS_OUTPUT.PUT_LINE('========================================');
END;
/
