# Final Comprehensive Assessment: Oracle APEX for Vodacom

**Duration:** 90 minutes  
**Total Points:** 150 points  
**Passing Score:** 105 points (70%)  
**Prerequisites:** Completed all labs (Labs 01-07)

---

## 📋 Assessment Overview

This comprehensive final assessment evaluates your complete mastery of Oracle APEX through the lens of Vodacom's business requirements. You will demonstrate:

- Database design and SQL skills
- Application creation using multiple methods
- Page design and UI/UX implementation
- Security and authorization implementation
- Performance optimization
- Production deployment readiness

---

## Part A: Multiple Choice - Comprehensive Knowledge (40 points - 2 points each)

**1. Vodacom needs to scale from 250 employees to 45 million customers. Which APEX architecture component handles this load?**
- [ ] A) Browser tier only
- [ ] B) Database tier with Oracle RAC and APEX Engine with ORDS clustering
- [ ] C) Application tier only
- [ ] D) Desktop software

**2. When creating a Vodacom package management system, which method is fastest if data exists in Excel?**
- [ ] A) Manual table creation + wizard
- [ ] B) Create from File (CSV/XLSX import)
- [ ] C) Write all SQL manually
- [ ] D) Blueprint installation

**3. For Vodacom's Customer Portal dashboard showing real-time call statistics, which caching strategy is appropriate?**
- [ ] A) Cache for 24 hours
- [ ] B) No caching (real-time data)
- [ ] C) Cache for 1 year
- [ ] D) Cache indefinitely

**4. A Vodacom call center agent should see customer data but NOT financial reports. This requires:**
- [ ] A) Authentication only
- [ ] B) Authorization with role-based access control
- [ ] C) No security needed
- [ ] D) IP address blocking

**5. Which SQL join type shows ALL Vodacom customers even if they have zero mobile numbers?**
- [ ] A) INNER JOIN
- [ ] B) RIGHT JOIN
- [ ] C) LEFT JOIN (customers LEFT JOIN mobile_numbers)
- [ ] D) FULL OUTER JOIN

**6. To prevent SQL injection in customer search where user enters mobile number:**
- [ ] A) Use string concatenation
- [ ] B) Use bind variables (:P10_MOBILE_NUMBER)
- [ ] C) Disable search feature
- [ ] D) No special handling needed

**7. Vodacom deploys to Dev, UAT, and Prod. The billing API URL differs per environment. Best solution:**
- [ ] A) Hardcode URLs in application
- [ ] B) Use application substitution strings
- [ ] C) Create separate applications
- [ ] D) Manual code changes per environment

**8. An Interactive Report for call center agents to search 45M customers should:**
- [ ] A) Load all 45M records at once
- [ ] B) Use pagination and search filters
- [ ] C) Disable searching
- [ ] D) Export to Excel first

**9. Page Designer's three main panes are:**
- [ ] A) Top, Middle, Bottom
- [ ] B) Rendering Tree, Layout, Property Editor
- [ ] C) SQL, HTML, CSS
- [ ] D) Tables, Views, Sequences

**10. Master-Detail form showing customer with their mobile numbers requires:**
- [ ] A) Two separate applications
- [ ] B) Parent (customer) form region + child (numbers) Interactive Grid
- [ ] C) No relationship needed
- [ ] D) Only classic report

**11. Breadcrumb navigation "Home > Customers > Edit Customer #12345" shows:**
- [ ] A) Unrelated pages
- [ ] B) Hierarchical navigation path
- [ ] C) Error messages
- [ ] D) Database tables

**12. To audit all Vodacom package activations (who, when, what), you should:**
- [ ] A) Rely on memory
- [ ] B) Create audit table and log via trigger/process
- [ ] C) No auditing needed
- [ ] D) Send emails only

**13. Quick SQL is best used for:**
- [ ] A) Single table creation
- [ ] B) Designing complex schemas (10+ tables with relationships)
- [ ] C) Deleting data
- [ ] D) User authentication

**14. Authorization scheme SQL returning TRUE allows:**
- [ ] A) User to access protected component
- [ ] B) User is denied access
- [ ] C) Application to crash
- [ ] D) Database deletion

**15. Index on VODACOM_CUSTOMERS.MOBILE_NUMBER improves:**
- [ ] A) INSERT speed only
- [ ] B) Search/SELECT performance
- [ ] C) DELETE speed only
- [ ] D) Nothing

**16. Deployment rollback plan is needed when:**
- [ ] A) Everything works perfectly
- [ ] B) Production deployment fails or causes issues
- [ ] C) Never
- [ ] D) Only on Mondays

**17. Dynamic Action "On Change" of Province dropdown to filter Cities requires:**
- [ ] A) No configuration
- [ ] B) JavaScript and AJAX callback or refresh
- [ ] C) Manual page refresh
- [ ] D) Database restart

**18. LOV (List of Values) for Vodacom provinces should contain:**
- [ ] A) Random values
- [ ] B) Gauteng, Western Cape, KwaZulu-Natal, etc.
- [ ] C) International countries
- [ ] D) Numbers only

**19. Session State Protection prevents:**
- [ ] A) User login
- [ ] B) Unauthorized manipulation of page items
- [ ] C) Fast performance
- [ ] D) Report viewing

**20. Before production deployment, you should:**
- [ ] A) Deploy immediately without testing
- [ ] B) Test in UAT, backup production, create rollback plan
- [ ] C) Delete development
- [ ] D) Hope for the best

---

## Part B: Database Design - Vodacom Loyalty Program (25 points)

**Scenario:** Vodacom wants to launch "Vodacom Rewards" - a loyalty program where customers earn points on data usage, redeemable for packages or devices.

**Requirements:**
- Track customer points balance
- Log point transactions (earned, redeemed)
- Maintain rewards catalog (packages, devices, airtime)
- Record redemptions

**Task 1: Design the schema (10 points)**

Create table definitions for:

```sql
-- 1. VODACOM_LOYALTY_ACCOUNTS table
-- Stores customer points balance
CREATE TABLE vodacom_loyalty_accounts (
    -- Your columns here (account_id, customer_id, points_balance, tier, status)








);

-- 2. VODACOM_POINTS_TRANSACTIONS table
-- Logs all point movements (earn/redeem)
CREATE TABLE vodacom_points_transactions (
    -- Your columns here








);

-- 3. VODACOM_REWARDS_CATALOG table
-- Available rewards
CREATE TABLE vodacom_rewards_catalog (
    -- Your columns here








);

-- 4. VODACOM_REDEMPTIONS table
-- Track reward redemptions
CREATE TABLE vodacom_redemptions (
    -- Your columns here








);
```

**Task 2: Create indexes for performance (3 points)**

```sql
-- Create 3 appropriate indexes





```

**Task 3: Write business queries (12 points - 4 points each)**

**Query 1:** Top 10 customers by loyalty points
```sql
-- Show: customer name, mobile number, points balance, tier
-- Order by points descending






```

**Query 2:** Customer's loyalty transaction history
```sql
-- For customer_id = 100, show:
-- Transaction date, type (Earned/Redeemed), points, description, running balance
-- Order by date descending






```

**Query 3:** Rewards redemption report
```sql
-- Show: reward name, category, points cost, times redeemed, total points redeemed
-- Include only rewards redeemed at least once
-- Order by total points DESC






```

---

## Part C: Application Design - Call Center Agent Desktop (30 points)

**Scenario:** Design a comprehensive Call Center Agent Desktop application.

**Requirements:**
- Agent views their call queue
- Search customers by mobile/account number
- View customer 360° view (details, packages, loyalty, calls)
- Log new calls
- Activate packages
- Real-time statistics dashboard

**Task 1: Application Structure (10 points)**

Design the application pages:

| Page# | Page Name | Page Type | Purpose | Key Regions/Items |
|-------|-----------|-----------|---------|-------------------|
| 1 | __________ | Dashboard | ________ | _________________ |
| 2 | __________ | ___________ | ________ | _________________ |
| 3 | __________ | ___________ | ________ | _________________ |
| 4 | __________ | ___________ | ________ | _________________ |
| 5 | __________ | ___________ | ________ | _________________ |
| 6 | __________ | ___________ | ________ | _________________ |

**Task 2: Navigation Menu Design (5 points)**

```
Main Menu:
├── _____________________
├── _____________________
│   ├── _________________
│   └── _________________
├── _____________________
└── _____________________

Navigation Bar (global):
├── _____________________
├── _____________________
└── _____________________
```

**Task 3: Customer 360° View Page Design (10 points)**

Design Page 4: Customer 360° View (comprehensive customer information)

**Regions:**

| Region Name | Type | SQL Source (if applicable) | Conditional Display |
|-------------|------|---------------------------|-------------------|
| 1. _________ | ____ | ________________________ | _________________ |
| 2. _________ | ____ | ________________________ | _________________ |
| 3. _________ | ____ | ________________________ | _________________ |
| 4. _________ | ____ | ________________________ | _________________ |
| 5. _________ | ____ | ________________________ | _________________ |

**Tabs organization:**
```
Tab 1: ________________ (show: ___________________________)
Tab 2: ________________ (show: ___________________________)
Tab 3: ________________ (show: ___________________________)
Tab 4: ________________ (show: ___________________________)
```

**Task 4: Package Activation Form Logic (5 points)**

Describe the workflow when agent activates a package:

```
1. Agent action: __________________________________________________________

2. Validation 1: __________________________________________________________

3. Validation 2: __________________________________________________________

4. Process 1 (Background): ________________________________________________

5. Process 2 (Notification): ______________________________________________

6. Success message: _______________________________________________________
```

---

## Part D: Security Implementation (20 points)

**Scenario:** Implement comprehensive security for Vodacom applications.

**Task 1: Authorization Schemes (8 points)**

Create authorization schemes for three roles:

**Scheme 1: IS_CALL_CENTER_AGENT**
```sql
-- SQL that returns TRUE for agents







```

**Scheme 2: IS_SUPERVISOR**
```sql
-- SQL that returns TRUE for supervisors and managers (hierarchy)







```

**Scheme 3: HAS_ADMIN_PRIVILEGE**
```sql
-- SQL that returns TRUE for admins







```

**Apply schemes:**
```
Page "Agent Performance Reports" → Authorization: _________________________
Button "Override Credit Check" → Authorization: ___________________________
Region "System Configuration" → Authorization: ____________________________
```

**Task 2: Prevent SQL Injection (6 points)**

Fix these vulnerable code snippets:

**Vulnerable Code 1:**
```sql
-- VULNERABLE
SELECT * FROM vodacom_customers
WHERE account_number = ''' || :P10_SEARCH || '''
```

**Your secure version:**
```sql
-- SECURE VERSION





```

**Vulnerable Code 2:**
```plsql
-- VULNERABLE
v_sql := 'DELETE FROM vodacom_calls WHERE call_id = ' || :P20_CALL_ID;
EXECUTE IMMEDIATE v_sql;
```

**Your secure version:**
```plsql
-- SECURE VERSION




```

**Task 3: Audit Implementation (6 points)**

Design audit logging for sensitive operations:

**Audit trigger for package activations:**
```sql
-- Log: who activated what package for which customer, when, from which IP
CREATE OR REPLACE TRIGGER vodacom_activation_audit_trg
AFTER INSERT ON vodacom_package_activations
FOR EACH ROW
BEGIN
    -- Your audit code










END;
/
```

---

## Part E: Performance Optimization (15 points)

**Scenario:** Vodacom's Customer Search page is slow (5+ seconds) with 45M customers.

**Task 1: Analyze Slow Query (5 points)**

This query is slow:

```sql
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS full_name,
       c.mobile_number,
       c.province,
       (SELECT COUNT(*) FROM vodacom_calls WHERE customer_id = c.customer_id) AS call_count,
       (SELECT MAX(call_date) FROM vodacom_calls WHERE customer_id = c.customer_id) AS last_call,
       (SELECT SUM(amount_rand) FROM vodacom_payments WHERE customer_id = c.customer_id) AS total_paid,
       (SELECT package_name FROM vodacom_packages WHERE package_id = c.active_package_id) AS package
FROM vodacom_customers c
WHERE c.status = 'Active'
ORDER BY c.last_name, c.first_name;
```

**Identify 3 performance problems:**
```
1. _________________________________________________________________________
2. _________________________________________________________________________
3. _________________________________________________________________________
```

**Task 2: Optimize the Query (10 points)**

Rewrite the query with optimizations:

```sql
-- Your optimized query (use JOINs, eliminate correlated subqueries)














```

**Additional optimizations (describe):**
```
1. Index on: ________________________________________________________________
2. Index on: ________________________________________________________________
3. Index on: ________________________________________________________________
4. Consider: ________________________________________________________________
```

---

## Part F: Deployment Plan (20 points)

**Scenario:** Deploy Vodacom Customer Portal v2.0 to production.

**Changes in v2.0:**
- New Loyalty Program features (4 tables)
- Enhanced Customer 360° view
- Performance improvements
- Security enhancements
- New REST API integration

**Task 1: Deployment Checklist (10 points)**

Create comprehensive pre-deployment checklist:

**Development Environment:**
```
□ _________________________________________________________________________
□ _________________________________________________________________________
□ _________________________________________________________________________
```

**UAT Testing:**
```
□ _________________________________________________________________________
□ _________________________________________________________________________
□ _________________________________________________________________________
```

**Production Preparation:**
```
□ _________________________________________________________________________
□ _________________________________________________________________________
□ _________________________________________________________________________
□ _________________________________________________________________________
```

**Task 2: Rollback Plan (5 points)**

**If deployment fails at 3:00 AM, describe rollback steps:**

```
Time 3:00 AM - Deployment fails with error: "ORA-00942: table does not exist"

Step 1 (Immediate): ________________________________________________________
Step 2 (Within 5 min): ______________________________________________________
Step 3 (Within 15 min): _____________________________________________________
Step 4 (Within 30 min): _____________________________________________________
Step 5 (Next day): __________________________________________________________
```

**Task 3: Substitution Strings (5 points)**

**Define environment-specific values:**

| Substitution String | Dev | UAT | Production |
|---------------------|-----|-----|------------|
| LOYALTY_API_URL | ________ | ________ | ________ |
| NOTIFICATION_EMAIL | ________ | ________ | ________ |
| _______________ | ________ | ________ | ________ |
| _______________ | ________ | ________ | ________ |

---

## Answer Key (For Instructor Use Only)

### Part A: Multiple Choice
1. B  2. B  3. B  4. B  5. C  6. B  7. B  8. B  9. B  10. B
11. B  12. B  13. B  14. A  15. B  16. B  17. B  18. B  19. B  20. B

### Part B: Database Design (Sample Solution)

**Task 1: Schema Design**

```sql
CREATE TABLE vodacom_loyalty_accounts (
    account_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    customer_id      NUMBER NOT NULL REFERENCES vodacom_customers(customer_id),
    points_balance   NUMBER DEFAULT 0 NOT NULL,
    tier_level       VARCHAR2(20) DEFAULT 'Bronze' CHECK (tier_level IN ('Bronze','Silver','Gold','Platinum')),
    status           VARCHAR2(20) DEFAULT 'Active' CHECK (status IN ('Active','Suspended','Closed')),
    joined_date      DATE DEFAULT SYSDATE NOT NULL,
    last_activity    DATE
);

CREATE TABLE vodacom_points_transactions (
    transaction_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_id       NUMBER NOT NULL REFERENCES vodacom_loyalty_accounts(account_id),
    transaction_date DATE DEFAULT SYSDATE NOT NULL,
    transaction_type VARCHAR2(20) NOT NULL CHECK (transaction_type IN ('Earned','Redeemed','Adjusted','Expired')),
    points_amount    NUMBER NOT NULL,
    description      VARCHAR2(500),
    reference_id     VARCHAR2(100),
    created_by       VARCHAR2(100) DEFAULT USER
);

CREATE TABLE vodacom_rewards_catalog (
    reward_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    reward_name      VARCHAR2(200) NOT NULL,
    reward_category  VARCHAR2(50) CHECK (reward_category IN ('Data Package','Device','Airtime','Voucher')),
    points_cost      NUMBER NOT NULL,
    description      VARCHAR2(1000),
    image_url        VARCHAR2(500),
    stock_available  NUMBER DEFAULT 0,
    active           VARCHAR2(1) DEFAULT 'Y' CHECK (active IN ('Y','N'))
);

CREATE TABLE vodacom_redemptions (
    redemption_id    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_id       NUMBER NOT NULL REFERENCES vodacom_loyalty_accounts(account_id),
    reward_id        NUMBER NOT NULL REFERENCES vodacom_rewards_catalog(reward_id),
    redemption_date  DATE DEFAULT SYSDATE NOT NULL,
    points_redeemed  NUMBER NOT NULL,
    status           VARCHAR2(20) DEFAULT 'Pending' CHECK (status IN ('Pending','Fulfilled','Cancelled')),
    fulfillment_date DATE,
    created_by       VARCHAR2(100) DEFAULT USER
);
```

**Task 2: Indexes**
```sql
CREATE INDEX idx_loyalty_customer ON vodacom_loyalty_accounts(customer_id);
CREATE INDEX idx_trans_account ON vodacom_points_transactions(account_id);
CREATE INDEX idx_redemption_account ON vodacom_redemptions(account_id);
```

**Task 3: Queries**

**Query 1:**
```sql
SELECT c.first_name || ' ' || c.last_name AS customer_name,
       m.mobile_number,
       la.points_balance,
       la.tier_level
FROM vodacom_loyalty_accounts la
JOIN vodacom_customers c ON la.customer_id = c.customer_id
LEFT JOIN (SELECT customer_id, MIN(mobile_number) AS mobile_number 
           FROM vodacom_mobile_numbers 
           WHERE status='Active' 
           GROUP BY customer_id) m ON c.customer_id = m.customer_id
WHERE la.status = 'Active'
ORDER BY la.points_balance DESC
FETCH FIRST 10 ROWS ONLY;
```

**Query 2:**
```sql
SELECT transaction_date,
       transaction_type,
       points_amount,
       description,
       SUM(points_amount) OVER (ORDER BY transaction_date, transaction_id) AS running_balance
FROM vodacom_points_transactions
WHERE account_id = (SELECT account_id FROM vodacom_loyalty_accounts WHERE customer_id = 100)
ORDER BY transaction_date DESC;
```

**Query 3:**
```sql
SELECT rc.reward_name,
       rc.reward_category,
       rc.points_cost,
       COUNT(r.redemption_id) AS times_redeemed,
       SUM(r.points_redeemed) AS total_points_redeemed
FROM vodacom_rewards_catalog rc
JOIN vodacom_redemptions r ON rc.reward_id = r.reward_id
GROUP BY rc.reward_id, rc.reward_name, rc.reward_category, rc.points_cost
HAVING COUNT(r.redemption_id) > 0
ORDER BY total_points_redeemed DESC;
```

### Part C: Application Design (Sample Solution)

**Task 1: Application Structure**

| Page# | Page Name | Page Type | Purpose | Key Regions |
|-------|-----------|-----------|---------|-------------|
| 1 | Agent Dashboard | Dashboard | Real-time stats | Charts: calls handled, avg duration, resolution rate |
| 2 | My Call Queue | Interactive Report | Agent's assigned calls | Filterable list, priority badges |
| 3 | Customer Search | Faceted Search | Find customers | Search by mobile/account/name |
| 4 | Customer 360° View | Master Detail + Tabs | Complete customer info | Details, packages, loyalty, calls |
| 5 | Log Call | Form | Record call details | Call form with validations |
| 6 | Package Activation | Wizard | Activate packages | Multi-step wizard |

**Task 2: Navigation**
```
Main Menu:
├── Dashboard
├── Customers
│   ├── Search Customers
│   └── Add New Customer
├── My Calls
│   ├── My Queue
│   └── Log New Call
├── Packages
│   ├── View Packages
│   └── Activate Package
└── Reports (if supervisor)

Navigation Bar:
├── Notifications (badge count)
├── My Profile
└── Logout
```

**Task 3: Customer 360° View**

| Region Name | Type | SQL Source | Conditional Display |
|-------------|------|------------|-------------------|
| 1. Customer Info | Display Only | vodacom_customers | Always |
| 2. Account Summary | Cards | Package, balance, loyalty info | Always |
| 3. Mobile Numbers | Interactive Grid | vodacom_mobile_numbers | Always |
| 4. Package History | Classic Report | vodacom_package_activations | Always |
| 5. Call History | Interactive Report | vodacom_calls | Always |
| 6. Loyalty Transactions | Classic Report | vodacom_points_transactions | If loyalty account exists |

**Tabs:**
```
Tab 1: Overview (customer info, account summary)
Tab 2: Mobile Numbers & Packages (numbers grid, package history)
Tab 3: Loyalty (points balance, transactions, redemptions)
Tab 4: Call History (all calls, timeline)
```

**Task 4: Activation Workflow**
```
1. Agent selects package from dropdown (LOV filtered by customer type)
2. Validation 1: Customer credit check passed OR supervisor override
3. Validation 2: Package available for customer's current contract/prepaid type
4. Process 1: Insert into VODACOM_PACKAGE_ACTIVATIONS, update customer active_package_id
5. Process 2: Send SMS confirmation to customer, email notification to billing
6. Success message: "Package [name] activated for [customer]. SMS sent."
```

### Part D: Security (Sample Solution)

**Task 1: Authorization Schemes**

```sql
-- IS_CALL_CENTER_AGENT
SELECT 1 FROM vodacom_users
WHERE username = :APP_USER
  AND user_role IN ('Agent','Supervisor','Manager','Admin')
  AND status = 'Active';

-- IS_SUPERVISOR  
SELECT 1 FROM vodacom_users
WHERE username = :APP_USER
  AND user_role IN ('Supervisor','Manager','Admin')
  AND status = 'Active';

-- HAS_ADMIN_PRIVILEGE
SELECT 1 FROM vodacom_users
WHERE username = :APP_USER
  AND user_role = 'Admin'
  AND status = 'Active';
```

**Apply:**
- Page "Agent Performance Reports" → IS_SUPERVISOR
- Button "Override Credit Check" → IS_SUPERVISOR
- Region "System Configuration" → HAS_ADMIN_PRIVILEGE

**Task 2: Secure Code**

```sql
-- SECURE VERSION 1
SELECT * FROM vodacom_customers
WHERE account_number = :P10_SEARCH;

-- SECURE VERSION 2
DELETE FROM vodacom_calls 
WHERE call_id = :P20_CALL_ID;
-- Or using bind:
EXECUTE IMMEDIATE 'DELETE FROM vodacom_calls WHERE call_id = :1' USING :P20_CALL_ID;
```

**Task 3: Audit Trigger**

```sql
CREATE OR REPLACE TRIGGER vodacom_activation_audit_trg
AFTER INSERT ON vodacom_package_activations
FOR EACH ROW
BEGIN
    INSERT INTO vodacom_audit_log (
        audit_id,
        table_name,
        operation,
        record_id,
        customer_id,
        package_id,
        user_id,
        ip_address,
        timestamp
    ) VALUES (
        vodacom_audit_seq.NEXTVAL,
        'VODACOM_PACKAGE_ACTIVATIONS',
        'INSERT',
        :NEW.activation_id,
        :NEW.customer_id,
        :NEW.package_id,
        NVL(V('APP_USER'), USER),
        SYS_CONTEXT('USERENV','IP_ADDRESS'),
        SYSDATE
    );
END;
/
```

### Part E: Performance (Sample Solution)

**Task 1: Problems**
1. Correlated subqueries execute once per row (inefficient for 45M rows)
2. No indexes on foreign keys (customer_id in calls/payments)
3. No filtering - returns ALL active customers (millions)

**Task 2: Optimized Query**

```sql
SELECT c.customer_id,
       c.first_name || ' ' || c.last_name AS full_name,
       c.mobile_number,
       c.province,
       NVL(cl.call_count, 0) AS call_count,
       cl.last_call,
       NVL(p.total_paid, 0) AS total_paid,
       pkg.package_name
FROM vodacom_customers c
LEFT JOIN (SELECT customer_id, 
                  COUNT(*) AS call_count,
                  MAX(call_date) AS last_call
           FROM vodacom_calls
           GROUP BY customer_id) cl ON c.customer_id = cl.customer_id
LEFT JOIN (SELECT customer_id, 
                  SUM(amount_rand) AS total_paid
           FROM vodacom_payments
           GROUP BY customer_id) p ON c.customer_id = p.customer_id
LEFT JOIN vodacom_packages pkg ON c.active_package_id = pkg.package_id
WHERE c.status = 'Active'
  AND (:P10_SEARCH IS NULL OR c.mobile_number LIKE '%'||:P10_SEARCH||'%')
ORDER BY c.last_name, c.first_name
FETCH FIRST 50 ROWS ONLY;

-- Indexes needed:
CREATE INDEX idx_cust_status ON vodacom_customers(status);
CREATE INDEX idx_cust_mobile ON vodacom_customers(mobile_number);
CREATE INDEX idx_calls_cust ON vodacom_calls(customer_id);
CREATE INDEX idx_payments_cust ON vodacom_payments(customer_id);
```

### Part F: Deployment (Sample Solution)

**Task 1: Checklist**

**Development:**
```
□ Code complete, unit tested
□ Export application with supporting objects
□ Document changes in CHANGELOG.md
```

**UAT Testing:**
```
□ Import to UAT successfully
□ Functional testing complete (all 6 pages)
□ Performance test: 500 concurrent users passed
□ Security review completed
□ Business sign-off obtained
```

**Production Preparation:**
```
□ Schedule deployment window (Saturday 2-6 AM)
□ Notify stakeholders (email sent to all agents/managers)
□ Backup production database (RMAN full backup)
□ Export current prod application (v1.0 backup)
□ Test rollback procedure in UAT
□ DBA and APEX admin on standby
```

**Task 2: Rollback**
```
Step 1: Stop deployment, assess damage (tables created? data inserted?)
Step 2: Import backed-up application v1.0
Step 3: Rollback database changes (RMAN restore if needed, or drop new tables)
Step 4: Verify application functional (test login, customer search)
Step 5: Post-mortem meeting, fix issues in Dev, reschedule deployment
```

**Task 3: Substitution Strings**

| String | Dev | UAT | Production |
|--------|-----|-----|------------|
| LOYALTY_API_URL | http://dev-loyalty.local | http://uat-loyalty.local | https://loyalty.vodacom.co.za |
| NOTIFICATION_EMAIL | apex-dev@vodacom.co.za | apex-uat@vodacom.co.za | notifications@vodacom.co.za |
| ENVIRONMENT_NAME | DEVELOPMENT | UAT | PRODUCTION |
| SUPPORT_PHONE | 082-TEST-001 | 082-TEST-UAT | 082-135-0000 |

---

## Grading Rubric

| Section | Points | Criteria |
|---------|--------|----------|
| Part A (MC) | 40 | 2 points per correct answer |
| Part B (Database Design) | 25 | Schema (10), Indexes (3), Queries (12) |
| Part C (Application Design) | 30 | Structure (10), Navigation (5), 360° View (10), Workflow (5) |
| Part D (Security) | 20 | Auth schemes (8), SQL Injection (6), Audit (6) |
| Part E (Performance) | 15 | Analysis (5), Optimization (10) |
| Part F (Deployment) | 20 | Checklist (10), Rollback (5), Substitution (5) |
| **TOTAL** | **150** | Pass = 105+ points (70%) |

---

## Grade Ranges

| Grade | Points | Percentage | Level |
|-------|--------|------------|-------|
| **A (Distinction)** | 135-150 | 90-100% | Expert |
| **B (Very Good)** | 120-134 | 80-89% | Advanced |
| **C (Good)** | 105-119 | 70-79% | Competent |
| **D (Fail)** | < 105 | < 70% | Needs Improvement |

---

**Student Name:** ______________________________  
**Date:** ______________  
**Score:** ______ / 150  
**Grade:** __________  
**Pass/Fail:** __________

---

## Instructor Feedback

**Strengths:**
_____________________________________________________________________________
_____________________________________________________________________________

**Areas for Improvement:**
_____________________________________________________________________________
_____________________________________________________________________________

**Recommendations:**
_____________________________________________________________________________
_____________________________________________________________________________

---

**Congratulations on completing the Vodacom Oracle APEX training program!** 🎉
