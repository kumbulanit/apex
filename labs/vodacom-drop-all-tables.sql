-- ============================================================================
-- DROP ALL TABLES SCRIPT
-- Oracle APEX Training Course
-- ============================================================================
-- This script drops ALL tables in the schema:
-- - Vodacom tables (13 tables)
-- - TechNova tables (13 tables)
-- - EBA tables (all tables starting with EBA)
-- Use this to completely clean your workspace
--
-- ⚠️ WARNING: This will permanently delete ALL tables and data!
-- ============================================================================
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('DROPPING ALL TABLES IN SCHEMA');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('⚠️  WARNING: This will delete ALL data!');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Tables to be dropped:');
    DBMS_OUTPUT.PUT_LINE('  - Vodacom tables (13)');
    DBMS_OUTPUT.PUT_LINE('  - TechNova tables (13)');
    DBMS_OUTPUT.PUT_LINE('  - EBA tables (all)');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- ============================================================================
-- Drop all EBA tables first (Sample Apps, Demo Apps, etc.)
-- ============================================================================
BEGIN
    FOR rec IN (SELECT table_name FROM user_tables WHERE table_name LIKE 'EBA%') LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS PURGE';
            DBMS_OUTPUT.PUT_LINE('✓ Dropped: ' || rec.table_name);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('✗ Error dropping ' || rec.table_name || ': ' || SQLERRM);
        END;
    END LOOP;
END;
/

-- ============================================================================
-- Drop tables in reverse dependency order (child tables first)
-- ============================================================================

-- Drop invoice_items first (depends on invoices)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_invoice_items CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_invoice_items');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_invoice_items does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_invoice_items: ' || SQLERRM);
        END IF;
END;
/

-- Drop invoices
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_invoices CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_invoices');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_invoices does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_invoices: ' || SQLERRM);
        END IF;
END;
/

-- Drop vodapay_accounts
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_vodapay_accounts CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_vodapay_accounts');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_vodapay_accounts does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_vodapay_accounts: ' || SQLERRM);
        END IF;
END;
/

-- Drop sales
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_sales CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_sales');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_sales does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_sales: ' || SQLERRM);
        END IF;
END;
/

-- Drop customer_support
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_customer_support CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_customer_support');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_customer_support does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_customer_support: ' || SQLERRM);
        END IF;
END;
/

-- Drop network_issues
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_network_issues CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_network_issues');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_network_issues does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_network_issues: ' || SQLERRM);
        END IF;
END;
/

-- Drop network_towers
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_network_towers CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_network_towers');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_network_towers does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_network_towers: ' || SQLERRM);
        END IF;
END;
/

-- Drop transactions
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_transactions CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_transactions');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_transactions does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_transactions: ' || SQLERRM);
        END IF;
END;
/

-- Drop packages
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_packages CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_packages');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_packages does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_packages: ' || SQLERRM);
        END IF;
END;
/

-- Drop mobile_numbers
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_mobile_numbers CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_mobile_numbers');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_mobile_numbers does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_mobile_numbers: ' || SQLERRM);
        END IF;
END;
/

-- Drop customers
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_customers CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_customers');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_customers does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_customers: ' || SQLERRM);
        END IF;
END;
/

-- Drop employees (has circular dependency with departments)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_employees CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_employees');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_employees does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_employees: ' || SQLERRM);
        END IF;
END;
/

-- Drop departments last
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_departments CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_departments');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_departments does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_departments: ' || SQLERRM);
        END IF;
END;
/

-- ============================================================================
-- Drop TechNova Tables (in reverse dependency order)
-- ============================================================================

-- Drop invoice_items (child of invoices)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE invoice_items CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: invoice_items');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table invoice_items does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping invoice_items: ' || SQLERRM);
        END IF;
END;
/

-- Drop invoices
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE invoices CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: invoices');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table invoices does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping invoices: ' || SQLERRM);
        END IF;
END;
/

-- Drop client_contacts
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE client_contacts CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: client_contacts');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table client_contacts does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping client_contacts: ' || SQLERRM);
        END IF;
END;
/

-- Drop audit_log
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE audit_log CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: audit_log');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table audit_log does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping audit_log: ' || SQLERRM);
        END IF;
END;
/

-- Drop expenses
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE expenses CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: expenses');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table expenses does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping expenses: ' || SQLERRM);
        END IF;
END;
/

-- Drop timesheets
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE timesheets CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: timesheets');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table timesheets does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping timesheets: ' || SQLERRM);
        END IF;
END;
/

-- Drop tasks
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE tasks CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: tasks');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table tasks does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping tasks: ' || SQLERRM);
        END IF;
END;
/

-- Drop project_assignments
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE project_assignments CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: project_assignments');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table project_assignments does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping project_assignments: ' || SQLERRM);
        END IF;
END;
/

-- Drop projects
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE projects CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: projects');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table projects does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping projects: ' || SQLERRM);
        END IF;
END;
/

-- Drop clients
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE clients CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: clients');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table clients does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping clients: ' || SQLERRM);
        END IF;
END;
/

-- Drop employees (has circular dependency with departments)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: employees');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table employees does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping employees: ' || SQLERRM);
        END IF;
END;
/

-- Drop roles
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE roles CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: roles');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table roles does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping roles: ' || SQLERRM);
        END IF;
END;
/

-- Drop departments
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: departments');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table departments does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping departments: ' || SQLERRM);
        END IF;
END;
/

-- ============================================================================
-- Final Summary
-- ============================================================================
BEGIN
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('✓ DROP OPERATION COMPLETE');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('All tables have been dropped:');
    DBMS_OUTPUT.PUT_LINE('  ✓ EBA tables (all)');
    DBMS_OUTPUT.PUT_LINE('  ✓ Vodacom tables (13)');
    DBMS_OUTPUT.PUT_LINE('  ✓ TechNova tables (13)');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Your workspace is now clean.');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('To recreate tables:');
    DBMS_OUTPUT.PUT_LINE('  Vodacom: Run setup-sample-data-vodacom.sql');
    DBMS_OUTPUT.PUT_LINE('  TechNova: Run setup-sample-data.sql');
    DBMS_OUTPUT.PUT_LINE('========================================');
END;
/
