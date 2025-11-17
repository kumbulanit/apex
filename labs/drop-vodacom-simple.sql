-- ============================================================================
-- DROP VODACOM SIMPLE TABLES SCRIPT
-- Oracle APEX Training Course
-- ============================================================================
-- This script drops all tables created by vodacom-simple-setup.sql
-- 
-- TABLES TO BE DROPPED:
-- 1. vodacom_customers
-- 2. vodacom_packages
-- 3. vodacom_subscriptions
-- 4. vodacom_transactions
-- 5. vodacom_support_tickets
-- 6. vodacom_contract_types
-- 7. vodacom_customer_contracts
-- 8. vodacom_contract_renewals
-- 9. vodacom_contract_penalties
-- 10. vodacom_contract_benefits
--
-- ⚠️ WARNING: This will permanently delete all tables and data!
-- ============================================================================

BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('DROPPING VODACOM SIMPLE TABLES');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('⚠️  WARNING: This will delete ALL data!');
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- ============================================================================
-- Drop tables in reverse dependency order (child tables first)
-- ============================================================================

-- Drop contract benefits (depends on customer_contracts)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_contract_benefits CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_contract_benefits');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_contract_benefits does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_contract_benefits: ' || SQLERRM);
        END IF;
END;
/

-- Drop contract penalties (depends on customer_contracts)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_contract_penalties CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_contract_penalties');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_contract_penalties does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_contract_penalties: ' || SQLERRM);
        END IF;
END;
/

-- Drop contract renewals (depends on customer_contracts and contract_types)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_contract_renewals CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_contract_renewals');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_contract_renewals does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_contract_renewals: ' || SQLERRM);
        END IF;
END;
/

-- Drop customer contracts (depends on customers, contract_types, and packages)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_customer_contracts CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_customer_contracts');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_customer_contracts does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_customer_contracts: ' || SQLERRM);
        END IF;
END;
/

-- Drop contract types
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_contract_types CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_contract_types');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_contract_types does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_contract_types: ' || SQLERRM);
        END IF;
END;
/

-- Drop support tickets (depends on customers)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_support_tickets CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_support_tickets');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_support_tickets does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_support_tickets: ' || SQLERRM);
        END IF;
END;
/

-- Drop transactions (depends on customers)
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

-- Drop subscriptions (depends on customers and packages)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE vodacom_subscriptions CASCADE CONSTRAINTS PURGE';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_subscriptions');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -942 THEN
            DBMS_OUTPUT.PUT_LINE('  (Table vodacom_subscriptions does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_subscriptions: ' || SQLERRM);
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

-- ============================================================================
-- Drop sequences
-- ============================================================================

-- Drop sequences in any order
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_customers_seq';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_customers_seq');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('  (Sequence vodacom_customers_seq does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_customers_seq: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_packages_seq';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_packages_seq');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('  (Sequence vodacom_packages_seq does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_packages_seq: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_subscriptions_seq';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_subscriptions_seq');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('  (Sequence vodacom_subscriptions_seq does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_subscriptions_seq: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_transactions_seq';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_transactions_seq');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('  (Sequence vodacom_transactions_seq does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_transactions_seq: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_support_tickets_seq';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_support_tickets_seq');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('  (Sequence vodacom_support_tickets_seq does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_support_tickets_seq: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_contract_types_seq';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_contract_types_seq');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('  (Sequence vodacom_contract_types_seq does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_contract_types_seq: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_customer_contracts_seq';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_customer_contracts_seq');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('  (Sequence vodacom_customer_contracts_seq does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_customer_contracts_seq: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_contract_renewals_seq';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_contract_renewals_seq');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('  (Sequence vodacom_contract_renewals_seq does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_contract_renewals_seq: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_contract_penalties_seq';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_contract_penalties_seq');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('  (Sequence vodacom_contract_penalties_seq does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_contract_penalties_seq: ' || SQLERRM);
        END IF;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE vodacom_contract_benefits_seq';
    DBMS_OUTPUT.PUT_LINE('✓ Dropped: vodacom_contract_benefits_seq');
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2289 THEN
            DBMS_OUTPUT.PUT_LINE('  (Sequence vodacom_contract_benefits_seq does not exist)');
        ELSE
            DBMS_OUTPUT.PUT_LINE('✗ Error dropping vodacom_contract_benefits_seq: ' || SQLERRM);
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
    DBMS_OUTPUT.PUT_LINE('All Vodacom Simple tables dropped:');
    DBMS_OUTPUT.PUT_LINE('  ✓ 10 Tables');
    DBMS_OUTPUT.PUT_LINE('  ✓ 10 Sequences');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Your workspace is now clean.');
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('To recreate tables:');
    DBMS_OUTPUT.PUT_LINE('  Run vodacom-simple-setup.sql');
    DBMS_OUTPUT.PUT_LINE('========================================');
END;
/
