-- ============================================================================
-- Vodacom Lab Setup - SUPPLEMENTAL Script
-- Oracle APEX Training Course
-- ============================================================================
--
-- PURPOSE:
-- This script runs AFTER setup-sample-data-vodacom.sql to add missing tables,
-- columns, sequences, and data that the hands-on labs reference but that do
-- not exist in the main setup script.
--
-- PREREQUISITE: Run setup-sample-data-vodacom.sql FIRST.
--
-- WHAT THIS SCRIPT FIXES:
--
-- GAP 1: vodacom_customer_assignments table (Lab 06 - VPD Policy)
--   Lab 06's VPD policy function vodacom_customer_policy queries this table
--   to determine which customers an agent can see. The table is populated
--   from vodacom_customers.assigned_agent_id.
--
-- GAP 2: SA Province/City/Suburb lookup tables (Lab 05 - Cascading LOVs)
--   Lab 05 builds cascading select lists for Province > City > Suburb.
--   These three reference tables must exist with sample South African data.
--
-- GAP 3: assigned_tech column on vodacom_network_towers (Lab 06 - VPD Policy)
--   Lab 06's tower-level VPD policy references this column to restrict
--   network technicians to only seeing their assigned towers.
--
-- GAP 4: category column on vodacom_packages (Index reference)
--   The main setup script creates idx_pkg_category on vodacom_packages(category)
--   but the category column does not exist on the table. This adds it.
--
-- GAP 5: vodacom_issue_seq sequence (Lab 03 - Page Designer)
--   Lab 03 uses vodacom_issue_seq.NEXTVAL to generate issue reference numbers
--   in a PL/SQL computation.
--
-- GAP 6: Compatibility views for column name differences (Lab 04, Lab 05/06)
--   Lab 04 originally referenced li.line_item_id but the actual column is item_id.
--   Lab 05/06 originally referenced mn.mobile_number_id but the actual column is number_id.
--   Views are created as a safety net, but the labs have been UPDATED to use
--   the correct column names (item_id and number_id) directly.
--
-- COLUMN NAME MISMATCHES (RESOLVED in lab files):
-- +--------------------------+-------------------+---------------------+-------+
-- | Table                    | Actual Column     | Old Lab References  | Lab   |
-- +--------------------------+-------------------+---------------------+-------+
-- | vodacom_invoice_items    | item_id           | line_item_id (FIXED)| 04    |
-- | vodacom_mobile_numbers   | number_id         | mobile_number_id (FIXED)| 05,06 |
-- +--------------------------+-------------------+---------------------+-------+
-- The compatibility views below are kept as a safety net but should no longer
-- be needed since the lab instructions now use the correct column names.
--
-- RUN METHOD: SQL Workshop > SQL Scripts > Upload > Run
-- ESTIMATED TIME: Under 1 minute
-- ============================================================================


-- ============================================================================
-- GAP 1: vodacom_customer_assignments table (Lab 06 - VPD Policy)
-- ============================================================================
-- The VPD policy function vodacom_customer_policy does:
--   SELECT customer_id FROM vodacom_customer_assignments
--   WHERE agent_emp_id = v_emp_id AND assignment_status = 'Active'
-- This table must exist and be populated from vodacom_customers.assigned_agent_id.
-- ============================================================================

-- Drop existing table if re-running
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_customer_assignments CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            DBMS_OUTPUT.PUT_LINE('Warning dropping vodacom_customer_assignments: ' || SQLERRM);
        END IF;
END;
/

CREATE TABLE vodacom_customer_assignments (
    assignment_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id       NUMBER NOT NULL,
    agent_emp_id      NUMBER NOT NULL,
    assignment_date   DATE DEFAULT SYSDATE,
    assignment_status VARCHAR2(20) DEFAULT 'Active'
                      CHECK (assignment_status IN ('Active','Inactive','Transferred')),
    created_date      DATE DEFAULT SYSDATE,
    CONSTRAINT fk_assign_customer FOREIGN KEY (customer_id)
        REFERENCES vodacom_customers(customer_id),
    CONSTRAINT fk_assign_agent FOREIGN KEY (agent_emp_id)
        REFERENCES vodacom_employees(emp_id)
);

-- Populate from existing customer-agent relationships
INSERT INTO vodacom_customer_assignments (customer_id, agent_emp_id, assignment_date)
SELECT customer_id, assigned_agent_id, SYSDATE
FROM vodacom_customers
WHERE assigned_agent_id IS NOT NULL;

-- Create indexes for VPD policy query performance
CREATE INDEX idx_assign_customer ON vodacom_customer_assignments(customer_id);
CREATE INDEX idx_assign_agent ON vodacom_customer_assignments(agent_emp_id);
CREATE INDEX idx_assign_status ON vodacom_customer_assignments(assignment_status);

COMMENT ON TABLE vodacom_customer_assignments IS 'Customer-to-agent assignment mapping for VPD row-level security (Lab 06)';
COMMENT ON COLUMN vodacom_customer_assignments.agent_emp_id IS 'Employee ID of the assigned customer service agent';
COMMENT ON COLUMN vodacom_customer_assignments.assignment_status IS 'Active, Inactive, or Transferred';

COMMIT;

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM vodacom_customer_assignments;
    DBMS_OUTPUT.PUT_LINE('GAP 1 COMPLETE: vodacom_customer_assignments created with ' || v_count || ' rows');
END;
/


-- ============================================================================
-- GAP 2: South African Province/City/Suburb lookup tables (Lab 05)
-- ============================================================================
-- Lab 05 builds cascading LOVs: Province > City > Suburb
-- These three normalized reference tables provide the lookup data.
-- ============================================================================

-- Drop existing tables in reverse dependency order if re-running
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_sa_suburbs CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            DBMS_OUTPUT.PUT_LINE('Warning dropping vodacom_sa_suburbs: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_sa_cities CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            DBMS_OUTPUT.PUT_LINE('Warning dropping vodacom_sa_cities: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_sa_provinces CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            DBMS_OUTPUT.PUT_LINE('Warning dropping vodacom_sa_provinces: ' || SQLERRM);
        END IF;
END;
/

-- Create Province table (all 9 SA provinces)
CREATE TABLE vodacom_sa_provinces (
    province_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    province_code VARCHAR2(5)   NOT NULL UNIQUE,
    province_name VARCHAR2(100) NOT NULL
);

-- Create City table (linked to province)
CREATE TABLE vodacom_sa_cities (
    city_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    city_name   VARCHAR2(100) NOT NULL,
    province_id NUMBER        NOT NULL,
    CONSTRAINT fk_city_province FOREIGN KEY (province_id)
        REFERENCES vodacom_sa_provinces(province_id)
);

-- Create Suburb table (linked to city)
CREATE TABLE vodacom_sa_suburbs (
    suburb_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    suburb_name VARCHAR2(100) NOT NULL,
    postal_code VARCHAR2(10),
    city_id     NUMBER        NOT NULL,
    CONSTRAINT fk_suburb_city FOREIGN KEY (city_id)
        REFERENCES vodacom_sa_cities(city_id)
);

-- -------------------------------------------------------
-- Insert all 9 South African provinces
-- -------------------------------------------------------
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('GP',  'Gauteng');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('WC',  'Western Cape');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('KZN', 'KwaZulu-Natal');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('EC',  'Eastern Cape');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('FS',  'Free State');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('LP',  'Limpopo');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('MP',  'Mpumalanga');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('NC',  'Northern Cape');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('NW',  'North West');

COMMIT;

-- -------------------------------------------------------
-- Insert cities linked to their provinces
-- Uses subqueries to resolve province_id from province_code
-- -------------------------------------------------------

-- Gauteng cities
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Johannesburg', province_id FROM vodacom_sa_provinces WHERE province_code = 'GP';

INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Pretoria', province_id FROM vodacom_sa_provinces WHERE province_code = 'GP';

INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Sandton', province_id FROM vodacom_sa_provinces WHERE province_code = 'GP';

INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Midrand', province_id FROM vodacom_sa_provinces WHERE province_code = 'GP';

-- Western Cape cities
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Cape Town', province_id FROM vodacom_sa_provinces WHERE province_code = 'WC';

INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Stellenbosch', province_id FROM vodacom_sa_provinces WHERE province_code = 'WC';

INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Paarl', province_id FROM vodacom_sa_provinces WHERE province_code = 'WC';

-- KwaZulu-Natal cities
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Durban', province_id FROM vodacom_sa_provinces WHERE province_code = 'KZN';

INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Pietermaritzburg', province_id FROM vodacom_sa_provinces WHERE province_code = 'KZN';

-- Eastern Cape city
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Port Elizabeth', province_id FROM vodacom_sa_provinces WHERE province_code = 'EC';

-- Free State city
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Bloemfontein', province_id FROM vodacom_sa_provinces WHERE province_code = 'FS';

-- Limpopo city
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Polokwane', province_id FROM vodacom_sa_provinces WHERE province_code = 'LP';

-- Mpumalanga city
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Nelspruit', province_id FROM vodacom_sa_provinces WHERE province_code = 'MP';

-- Northern Cape city
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Kimberley', province_id FROM vodacom_sa_provinces WHERE province_code = 'NC';

-- North West city
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Rustenburg', province_id FROM vodacom_sa_provinces WHERE province_code = 'NW';

COMMIT;

-- -------------------------------------------------------
-- Insert suburbs linked to their cities
-- Uses subqueries to resolve city_id from city_name
-- -------------------------------------------------------

-- Johannesburg suburbs
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Sandton', '2196', city_id FROM vodacom_sa_cities WHERE city_name = 'Johannesburg';

INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Rosebank', '2196', city_id FROM vodacom_sa_cities WHERE city_name = 'Johannesburg';

INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Fourways', '2055', city_id FROM vodacom_sa_cities WHERE city_name = 'Johannesburg';

INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Bryanston', '2021', city_id FROM vodacom_sa_cities WHERE city_name = 'Johannesburg';

-- Cape Town suburbs
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Sea Point', '8005', city_id FROM vodacom_sa_cities WHERE city_name = 'Cape Town';

INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Camps Bay', '8040', city_id FROM vodacom_sa_cities WHERE city_name = 'Cape Town';

INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Century City', '7441', city_id FROM vodacom_sa_cities WHERE city_name = 'Cape Town';

-- Durban suburbs
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Umhlanga', '4319', city_id FROM vodacom_sa_cities WHERE city_name = 'Durban';

INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Morningside', '4001', city_id FROM vodacom_sa_cities WHERE city_name = 'Durban';

-- Pretoria suburbs
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Hatfield', '0028', city_id FROM vodacom_sa_cities WHERE city_name = 'Pretoria';

INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Brooklyn', '0181', city_id FROM vodacom_sa_cities WHERE city_name = 'Pretoria';

COMMIT;

-- Create indexes for cascading LOV query performance
CREATE INDEX idx_city_province ON vodacom_sa_cities(province_id);
CREATE INDEX idx_suburb_city ON vodacom_sa_suburbs(city_id);

COMMENT ON TABLE vodacom_sa_provinces IS 'South African provinces for cascading LOV lookups (Lab 05)';
COMMENT ON TABLE vodacom_sa_cities IS 'SA cities linked to provinces for cascading LOVs (Lab 05)';
COMMENT ON TABLE vodacom_sa_suburbs IS 'SA suburbs linked to cities for cascading LOVs (Lab 05)';

DECLARE
    v_prov   NUMBER;
    v_city   NUMBER;
    v_suburb NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_prov   FROM vodacom_sa_provinces;
    SELECT COUNT(*) INTO v_city   FROM vodacom_sa_cities;
    SELECT COUNT(*) INTO v_suburb FROM vodacom_sa_suburbs;
    DBMS_OUTPUT.PUT_LINE('GAP 2 COMPLETE: vodacom_sa_provinces=' || v_prov
        || ', vodacom_sa_cities=' || v_city
        || ', vodacom_sa_suburbs=' || v_suburb);
END;
/


-- ============================================================================
-- GAP 3: assigned_tech column on vodacom_network_towers (Lab 06 - VPD Policy)
-- ============================================================================
-- Lab 06's tower VPD policy restricts network technicians to their assigned
-- towers. The policy function references vodacom_network_towers.assigned_tech.
--
-- Network Operations employees (dept_id = 2):
--   emp_id 6 = Mandla Zulu     (Network Operations Director)
--   emp_id 7 = Thandi Ngwenya  (Senior Network Engineer)
--   emp_id 8 = Bongani Mthembu (Network Technician)
--   emp_id 9 = Nonhlanhla Sithole (Network Support Specialist)
--
-- Tower assignment mapping:
--   JHB towers (JHB-T001, JHB-T002) -> emp_id 7 (Thandi Ngwenya)
--   CPT towers (CPT-T001, CPT-T002) -> emp_id 8 (Bongani Mthembu)
--   DBN towers (DBN-T001, DBN-T002) -> emp_id 7 (Thandi Ngwenya)
--   PTA towers (PTA-T001, PTA-T002) -> emp_id 9 (Nonhlanhla Sithole)
--   Other towers (BFN, PLK, ELS, NPT) -> emp_id 8 (Bongani Mthembu)
-- ============================================================================

-- Add the column (safe: ignores error if column already exists)
BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE vodacom_network_towers ADD (assigned_tech NUMBER)';
    DBMS_OUTPUT.PUT_LINE('Added assigned_tech column to vodacom_network_towers');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1430 THEN -- ORA-01430: column already exists
            DBMS_OUTPUT.PUT_LINE('Column assigned_tech already exists on vodacom_network_towers - skipping');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Warning adding assigned_tech: ' || SQLERRM);
        END IF;
END;
/

-- Add foreign key constraint (safe: ignores error if constraint already exists)
BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE vodacom_network_towers ADD CONSTRAINT fk_tower_tech
        FOREIGN KEY (assigned_tech) REFERENCES vodacom_employees(emp_id)';
    DBMS_OUTPUT.PUT_LINE('Added FK constraint fk_tower_tech');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2275 THEN -- ORA-02275: constraint already exists
            DBMS_OUTPUT.PUT_LINE('Constraint fk_tower_tech already exists - skipping');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Warning adding fk_tower_tech: ' || SQLERRM);
        END IF;
END;
/

-- Assign technicians to towers based on tower_code prefix (city)
-- JHB towers -> emp_id 7 (Thandi Ngwenya, Senior Network Engineer)
UPDATE vodacom_network_towers
SET assigned_tech = 7
WHERE tower_code LIKE 'JHB%';

-- CPT towers -> emp_id 8 (Bongani Mthembu, Network Technician)
UPDATE vodacom_network_towers
SET assigned_tech = 8
WHERE tower_code LIKE 'CPT%';

-- DBN towers -> emp_id 7 (Thandi Ngwenya, Senior Network Engineer)
UPDATE vodacom_network_towers
SET assigned_tech = 7
WHERE tower_code LIKE 'DBN%';

-- PTA towers -> emp_id 9 (Nonhlanhla Sithole, Network Support Specialist)
UPDATE vodacom_network_towers
SET assigned_tech = 9
WHERE tower_code LIKE 'PTA%';

-- All other towers -> emp_id 8 (Bongani Mthembu, Network Technician)
UPDATE vodacom_network_towers
SET assigned_tech = 8
WHERE assigned_tech IS NULL;

COMMIT;

-- Create index for VPD policy query performance
BEGIN
    EXECUTE IMMEDIATE 'CREATE INDEX idx_tower_tech ON vodacom_network_towers(assigned_tech)';
    DBMS_OUTPUT.PUT_LINE('Created index idx_tower_tech');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN -- ORA-00955: name already used
            DBMS_OUTPUT.PUT_LINE('Index idx_tower_tech already exists - skipping');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Warning creating idx_tower_tech: ' || SQLERRM);
        END IF;
END;
/

COMMENT ON COLUMN vodacom_network_towers.assigned_tech IS 'Employee ID of assigned network technician for VPD policy (Lab 06)';

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM vodacom_network_towers WHERE assigned_tech IS NOT NULL;
    DBMS_OUTPUT.PUT_LINE('GAP 3 COMPLETE: ' || v_count || ' towers assigned to technicians');
END;
/


-- ============================================================================
-- GAP 4: category column on vodacom_packages (Index reference fix)
-- ============================================================================
-- The main setup script creates:
--   CREATE INDEX idx_pkg_category ON vodacom_packages(category)
-- but the vodacom_packages table has no category column.
-- This adds the column and populates it based on package_type.
-- ============================================================================

-- Add the column (safe: ignores error if column already exists)
BEGIN
    EXECUTE IMMEDIATE 'ALTER TABLE vodacom_packages ADD (category VARCHAR2(50))';
    DBMS_OUTPUT.PUT_LINE('Added category column to vodacom_packages');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -1430 THEN -- ORA-01430: column already exists
            DBMS_OUTPUT.PUT_LINE('Column category already exists on vodacom_packages - skipping');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Warning adding category: ' || SQLERRM);
        END IF;
END;
/

-- Populate category based on package_type
UPDATE vodacom_packages SET category =
    CASE
        WHEN package_type = 'Data Only'                    THEN 'Data'
        WHEN package_type = 'Voice Only'                   THEN 'Voice'
        WHEN package_type = 'SMS Only'                     THEN 'SMS'
        WHEN package_type = 'Combo'                        THEN 'Bundle'
        WHEN package_type IN ('Contract', 'Postpaid Plan') THEN 'Contract'
        ELSE 'Other'
    END;

COMMIT;

COMMENT ON COLUMN vodacom_packages.category IS 'Package category derived from package_type for reporting and indexing';

-- Recreate the index now that the column exists
-- (The main script may have failed to create it; safe to retry)
BEGIN
    EXECUTE IMMEDIATE 'CREATE INDEX idx_pkg_category ON vodacom_packages(category)';
    DBMS_OUTPUT.PUT_LINE('Created index idx_pkg_category');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -955 THEN -- ORA-00955: name already used
            DBMS_OUTPUT.PUT_LINE('Index idx_pkg_category already exists - skipping');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Warning creating idx_pkg_category: ' || SQLERRM);
        END IF;
END;
/

DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM vodacom_packages WHERE category IS NOT NULL;
    DBMS_OUTPUT.PUT_LINE('GAP 4 COMPLETE: ' || v_count || ' packages updated with category');
END;
/


-- ============================================================================
-- GAP 5: vodacom_issue_seq sequence (Lab 03 - Page Designer)
-- ============================================================================
-- Lab 03 uses vodacom_issue_seq.NEXTVAL in a PL/SQL computation to generate
-- unique issue reference numbers in the format: NI-YYYYMMDD-001
--
-- PL/SQL from Lab 03:
--   SELECT 'NI-' || TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' ||
--          LPAD(vodacom_issue_seq.NEXTVAL, 3, '0')
--   INTO v_issue_ref FROM dual;
-- ============================================================================

-- Drop existing sequence if re-running (safe)
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_issue_seq';
    DBMS_OUTPUT.PUT_LINE('Dropped existing vodacom_issue_seq');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN -- ORA-02289: sequence does not exist
            DBMS_OUTPUT.PUT_LINE('Warning dropping vodacom_issue_seq: ' || SQLERRM);
        END IF;
END;
/

CREATE SEQUENCE vodacom_issue_seq
    START WITH 100
    INCREMENT BY 1
    NOCACHE
    NOCYCLE;

BEGIN
    DBMS_OUTPUT.PUT_LINE('GAP 5 COMPLETE: vodacom_issue_seq created (START WITH 100)');
END;
/


-- ============================================================================
-- GAP 6: Compatibility views for column name mismatches
-- ============================================================================
-- Some labs reference column names that differ from the actual table schema.
-- These views expose the actual columns under both names so labs work as-is.
--
-- Mismatch 1: vodacom_invoice_items.item_id referenced as line_item_id (Lab 04)
-- Mismatch 2: vodacom_mobile_numbers.number_id referenced as mobile_number_id (Lab 05/06)
--
-- NOTE FOR INSTRUCTORS:
-- These views are a convenience bridge. You can alternatively update the lab
-- instructions to use the correct column names (item_id and number_id).
-- ============================================================================

-- View for Lab 04: exposes item_id as both item_id and line_item_id
CREATE OR REPLACE VIEW v_vodacom_invoice_items AS
SELECT
    item_id          AS line_item_id,
    item_id,
    invoice_id,
    item_type,
    description,
    quantity,
    unit_price,
    amount,
    created_date
FROM vodacom_invoice_items;

COMMENT ON TABLE v_vodacom_invoice_items IS 'Compatibility view: exposes item_id as line_item_id for Lab 04';

-- View for Lab 05/06: exposes number_id as both number_id and mobile_number_id
CREATE OR REPLACE VIEW v_vodacom_mobile_numbers AS
SELECT
    number_id        AS mobile_number_id,
    number_id,
    mobile_number,
    customer_id,
    number_type,
    sim_card_number,
    activation_date,
    expiry_date,
    status,
    current_package,
    monthly_fee,
    data_balance_mb,
    airtime_balance,
    sms_balance,
    last_recharge_date,
    last_usage_date,
    created_date
FROM vodacom_mobile_numbers;

COMMENT ON TABLE v_vodacom_mobile_numbers IS 'Compatibility view: exposes number_id as mobile_number_id for Lab 05/06';

BEGIN
    DBMS_OUTPUT.PUT_LINE('GAP 6 COMPLETE: Compatibility views created');
    DBMS_OUTPUT.PUT_LINE('  - v_vodacom_invoice_items  (line_item_id alias for item_id)');
    DBMS_OUTPUT.PUT_LINE('  - v_vodacom_mobile_numbers (mobile_number_id alias for number_id)');
END;
/


-- ============================================================================
-- VERIFICATION: Display all Vodacom objects and row counts
-- ============================================================================
-- This block runs a comprehensive check to confirm everything was created
-- correctly and all tables have the expected data.
-- ============================================================================

DECLARE
    v_count NUMBER;

    -- Helper procedure to check a table and print its row count
    PROCEDURE check_table(p_table_name VARCHAR2) IS
        v_rows NUMBER;
    BEGIN
        EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || p_table_name INTO v_rows;
        DBMS_OUTPUT.PUT_LINE('  ' || RPAD(p_table_name, 40) || v_rows || ' rows');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('  ' || RPAD(p_table_name, 40) || 'ERROR: ' || SQLERRM);
    END;

    -- Helper procedure to check a view exists
    PROCEDURE check_view(p_view_name VARCHAR2) IS
        v_rows NUMBER;
    BEGIN
        EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM ' || p_view_name INTO v_rows;
        DBMS_OUTPUT.PUT_LINE('  ' || RPAD(p_view_name, 40) || v_rows || ' rows (view)');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('  ' || RPAD(p_view_name, 40) || 'ERROR: ' || SQLERRM);
    END;

    -- Helper procedure to check a sequence exists
    PROCEDURE check_sequence(p_seq_name VARCHAR2) IS
        v_dummy NUMBER;
    BEGIN
        EXECUTE IMMEDIATE 'SELECT ' || p_seq_name || '.NEXTVAL FROM dual' INTO v_dummy;
        DBMS_OUTPUT.PUT_LINE('  ' || RPAD(p_seq_name, 40) || 'EXISTS (current value: ' || v_dummy || ')');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('  ' || RPAD(p_seq_name, 40) || 'ERROR: ' || SQLERRM);
    END;

BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('============================================================');
    DBMS_OUTPUT.PUT_LINE('VERIFICATION REPORT: Vodacom Supplemental Lab Setup');
    DBMS_OUTPUT.PUT_LINE('============================================================');
    DBMS_OUTPUT.PUT_LINE('');

    -- Original tables from setup-sample-data-vodacom.sql
    DBMS_OUTPUT.PUT_LINE('--- ORIGINAL TABLES (from setup-sample-data-vodacom.sql) ---');
    check_table('vodacom_departments');
    check_table('vodacom_employees');
    check_table('vodacom_customers');
    check_table('vodacom_mobile_numbers');
    check_table('vodacom_packages');
    check_table('vodacom_transactions');
    check_table('vodacom_network_towers');
    check_table('vodacom_network_issues');
    check_table('vodacom_customer_support');
    check_table('vodacom_sales');
    check_table('vodacom_vodapay_accounts');
    check_table('vodacom_invoices');
    check_table('vodacom_invoice_items');

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('--- NEW TABLES (from this supplemental script) -----------');
    check_table('vodacom_customer_assignments');
    check_table('vodacom_sa_provinces');
    check_table('vodacom_sa_cities');
    check_table('vodacom_sa_suburbs');

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('--- COMPATIBILITY VIEWS -----------------------------------');
    check_view('v_vodacom_invoice_items');
    check_view('v_vodacom_mobile_numbers');

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('--- SEQUENCES ---------------------------------------------');
    check_sequence('vodacom_issue_seq');

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('--- COLUMN ADDITIONS --------------------------------------');

    -- Check assigned_tech column on vodacom_network_towers
    BEGIN
        EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM vodacom_network_towers WHERE assigned_tech IS NOT NULL' INTO v_count;
        DBMS_OUTPUT.PUT_LINE('  vodacom_network_towers.assigned_tech    ' || v_count || ' towers assigned');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('  vodacom_network_towers.assigned_tech    ERROR: ' || SQLERRM);
    END;

    -- Check category column on vodacom_packages
    BEGIN
        EXECUTE IMMEDIATE 'SELECT COUNT(*) FROM vodacom_packages WHERE category IS NOT NULL' INTO v_count;
        DBMS_OUTPUT.PUT_LINE('  vodacom_packages.category                ' || v_count || ' packages categorized');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('  vodacom_packages.category                ERROR: ' || SQLERRM);
    END;

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('============================================================');
    DBMS_OUTPUT.PUT_LINE('Supplemental setup complete. All labs should now work.');
    DBMS_OUTPUT.PUT_LINE('============================================================');
END;
/
