# Assessment 06: Security and Performance

**Duration:** 50 minutes  
**Total Points:** 100 points  
**Passing Score:** 70%  
**Prerequisites:** Completed Lab 06 (Vodacom Security and Optimization)

---

## Part A: Multiple Choice Questions (40 points - 2 points each)

**1. Authentication in APEX determines:**
- [ ] A) What actions users can perform
- [ ] B) Who the user is (identity verification)
- [ ] C) Database query performance
- [ ] D) Application color scheme

**2. Authorization in APEX controls:**
- [ ] A) User login credentials
- [ ] B) What authenticated users can access/do
- [ ] C) Page loading speed
- [ ] D) Database backups

**3. The APEX_CUSTOM authentication scheme:**
- [ ] A) Requires no configuration
- [ ] B) Uses custom PL/SQL for login validation
- [ ] C) Is deprecated and cannot be used
- [ ] D) Only works on Tuesdays

**4. Session State Protection prevents:**
- [ ] A) Users from logging in
- [ ] B) Unauthorized page item manipulation
- [ ] C) Fast page loading
- [ ] D) Report generation

**5. What does SQL Injection attack attempt to do?**
- [ ] A) Speed up queries
- [ ] B) Insert malicious SQL code via input fields
- [ ] C) Improve performance
- [ ] D) Backup data

**6. Bind variables in SQL queries (:ITEM_NAME) help prevent:**
- [ ] A) Fast execution
- [ ] B) SQL Injection attacks
- [ ] C) User login
- [ ] D) Report display

**7. An index on a database column:**
- [ ] A) Slows down all queries
- [ ] B) Speeds up searches but adds overhead to INSERT/UPDATE
- [ ] C) Deletes data
- [ ] D) Creates users

**8. Caching in APEX stores:**
- [ ] A) User passwords
- [ ] B) Frequently accessed data in memory for faster retrieval
- [ ] C) Backup files
- [ ] D) Error logs only

**9. The APEX_UTIL.GET_SESSION_STATE function:**
- [ ] A) Deletes sessions
- [ ] B) Retrieves current page item value
- [ ] C) Creates new users
- [ ] D) Backs up database

**10. Authorization Schemes in APEX can be based on:**
- [ ] A) User roles/groups
- [ ] B) Custom SQL/PL/SQL logic
- [ ] C) Item values or conditions
- [ ] D) All of the above

**11. What is the purpose of the DBMS_SESSION.SET_IDENTIFIER procedure?**
- [ ] A) Delete sessions
- [ ] B) Track user actions for auditing
- [ ] C) Slow down queries
- [ ] D) Change passwords

**12. Page caching in APEX should be used when:**
- [ ] A) Data changes frequently
- [ ] B) Data is static or changes infrequently
- [ ] C) Users need real-time updates
- [ ] D) Never

**13. The V() function in APEX SQL is equivalent to:**
- [ ] A) DELETE
- [ ] B) :ITEM_NAME (bind variable reference)
- [ ] C) CREATE TABLE
- [ ] D) COMMIT

**14. Which authentication method is most secure for Vodacom enterprise applications?**
- [ ] A) No authentication
- [ ] B) LDAP/Active Directory or OAuth 2.0
- [ ] C) Hardcoded passwords in code
- [ ] D) Public access

**15. To prevent unauthorized access to sensitive pages, you should:**
- [ ] A) Hide the page link
- [ ] B) Apply authorization scheme to page
- [ ] C) Change page color
- [ ] D) Delete the page

**16. The apex_collection API is useful for:**
- [ ] A) Deleting users
- [ ] B) Temporary session-specific data storage
- [ ] C) Permanent table creation
- [ ] D) Server configuration

**17. Pagination in Interactive Reports improves performance by:**
- [ ] A) Loading all records at once
- [ ] B) Loading records in chunks (e.g., 15 at a time)
- [ ] C) Deleting old records
- [ ] D) Disabling search

**18. What does the APEX_UTIL.PREPARE_URL function do?**
- [ ] A) Deletes URLs
- [ ] B) Generates properly formatted APEX URLs with checksums
- [ ] C) Creates database links
- [ ] D) Backs up data

**19. In Vodacom's portal, why should call center agents NOT see manager reports?**
- [ ] A) To reduce server load
- [ ] B) Principle of least privilege (security)
- [ ] C) Agents dislike reports
- [ ] D) No technical reason

**20. Application-level session timeout should be set to:**
- [ ] A) Never expire (unlimited)
- [ ] B) Balance security and user convenience (e.g., 30-60 min)
- [ ] C) 1 second
- [ ] D) 1 year

---

## Part B: True/False Questions (20 points - 2 points each)

**21. Authentication and authorization are the same thing.**
- [ ] True
- [ ] False

**22. Session State Protection should be enabled on production applications.**
- [ ] True
- [ ] False

**23. Using SELECT * in queries is a performance best practice.**
- [ ] True
- [ ] False

**24. Bind variables prevent SQL Injection and improve query performance.**
- [ ] True
- [ ] False

**25. All database tables should have indexes on every column.**
- [ ] True
- [ ] False

**26. Authorization schemes can be reused across multiple pages and components.**
- [ ] True
- [ ] False

**27. Caching is always beneficial and should be enabled everywhere.**
- [ ] True
- [ ] False

**28. HTTPS encryption is optional for production APEX applications.**
- [ ] True
- [ ] False

**29. Auditing user actions helps with security compliance and troubleshooting.**
- [ ] True
- [ ] False

**30. Page-level authorization is sufficient; component-level authorization is unnecessary.**
- [ ] True
- [ ] False

---

## Part C: Security Scenario Analysis (15 points - 5 points each)

**31. SQL Injection Prevention**

A developer wrote this query for customer search:

```sql
-- VULNERABLE CODE
SELECT * FROM vodacom_customers
WHERE mobile_number = ''' || :P10_SEARCH || '''
```

**Questions:**
a) What security vulnerability exists? (2 points)
```
Your answer:
_____________________________________________________________________________
```

b) Provide the SECURE version of this query: (2 points)
```sql
-- Your secure SQL:


```

c) Explain why your version is secure: (1 point)
```
Your answer:
_____________________________________________________________________________
```

**32. Authorization Scheme Design**

Vodacom has three user roles:
- **Agent**: View customers, log calls
- **Manager**: Agent privileges + view reports, approve escalations
- **Admin**: Manager privileges + system configuration

**Questions:**
a) Write SQL for an authorization scheme "IS_MANAGER_OR_ABOVE": (3 points)
```sql
-- Your SQL that returns TRUE for Managers and Admins, FALSE for Agents:




```

b) List 3 pages/components where you'd apply this scheme: (2 points)
```
1. _________________________________________________________________________
2. _________________________________________________________________________
3. _________________________________________________________________________
```

**33. Performance Optimization**

This query runs slowly on Vodacom's customer portal (500ms for 100K customers):

```sql
SELECT c.first_name, c.last_name, c.mobile_number, c.province,
       (SELECT COUNT(*) FROM vodacom_calls WHERE customer_id = c.customer_id) AS call_count,
       (SELECT SUM(amount) FROM vodacom_payments WHERE customer_id = c.customer_id) AS total_paid
FROM vodacom_customers c
WHERE c.status = 'Active'
ORDER BY c.last_name;
```

**Questions:**
a) Identify TWO performance issues: (2 points)
```
Issue 1: ____________________________________________________________________
Issue 2: ____________________________________________________________________
```

b) Rewrite the query with optimizations: (3 points)
```sql
-- Your optimized SQL:








```

---

## Part D: Short Answer Questions (10 points)

**34. Explain the difference between page-level and component-level authorization. When would you use each in Vodacom's applications? (5 points)**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**35. What is the "Principle of Least Privilege" and how does it apply to Vodacom call center security? Provide two specific examples. (5 points)**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

---

## Part E: Practical Implementation (15 points)

**36. Secure Vodacom Package Activation Page**

Design security and performance features for a package activation page used by call center agents.

**Requirements:**
- Agents activate packages for customers
- Managers can override credit checks
- Admins can configure pricing
- Track all activation attempts for audit

**Part 1: Authentication & Authorization (6 points)**

**Authentication Scheme:**
```
Scheme Name: _________________________
Type: _______________________________
Configuration: _______________________________________________________
```

**Authorization Schemes (Create 3):**

| Scheme Name | SQL/Logic | Applied To |
|-------------|-----------|------------|
| IS_AGENT | _______________ | _____________ |
| IS_MANAGER | _______________ | _____________ |
| IS_ADMIN | _______________ | _____________ |

**Part 2: Security Features (5 points)**

**Input Validation (List 3 validations):**
```
1. _________________________________________________________________________
2. _________________________________________________________________________
3. _________________________________________________________________________
```

**Session State Protection:**
```
Items to protect: _________________________________________________________
Protection Level: _________________________________________________________
```

**Part 3: Audit Implementation (4 points)**

Write PL/SQL to log activation attempts:

```sql
-- Create audit log entry after activation attempt
-- Log: user, customer, package, timestamp, success/failure, IP address








```

**Audit Table Design:**
```sql
-- Design VODACOM_ACTIVATION_AUDIT table
-- Include: audit_id, user_id, customer_id, package_id, activation_date,
--          success_flag, failure_reason, ip_address, created_date

CREATE TABLE vodacom_activation_audit (




);
```

---

## Answer Key (For Instructor Use Only)

### Part A: Multiple Choice
1. B  2. B  3. B  4. B  5. B  6. B  7. B  8. B  9. B  10. D
11. B  12. B  13. B  14. B  15. B  16. B  17. B  18. B  19. B  20. B

### Part B: True/False
21. False  22. True  23. False  24. True  25. False
26. True  27. False  28. False  29. True  30. False

### Part C: Security Scenarios

**31. SQL Injection Prevention:**

a) **Vulnerability**: String concatenation allows user to inject SQL code (e.g., `' OR '1'='1`)

b) **Secure version**:
```sql
SELECT * FROM vodacom_customers
WHERE mobile_number = :P10_SEARCH
```

c) **Why secure**: Bind variable (:P10_SEARCH) treats input as data, not executable SQL code. APEX automatically escapes special characters.

**32. Authorization Scheme:**

a) **SQL for IS_MANAGER_OR_ABOVE**:
```sql
SELECT 1
FROM vodacom_users
WHERE username = :APP_USER
  AND user_role IN ('Manager', 'Admin')
```

b) **Apply to**:
1. Reports page (only managers/admins view reports)
2. Agent Performance region (manager-only visibility)
3. Approve Escalation button (managers approve escalations)

**33. Performance Optimization:**

a) **Issues**:
- Issue 1: Correlated subqueries (run once per customer) - inefficient
- Issue 2: No indexes on customer_id foreign keys in calls/payments tables

b) **Optimized query**:
```sql
SELECT c.first_name, c.last_name, c.mobile_number, c.province,
       NVL(cl.call_count, 0) AS call_count,
       NVL(p.total_paid, 0) AS total_paid
FROM vodacom_customers c
LEFT JOIN (SELECT customer_id, COUNT(*) AS call_count 
           FROM vodacom_calls 
           GROUP BY customer_id) cl ON c.customer_id = cl.customer_id
LEFT JOIN (SELECT customer_id, SUM(amount) AS total_paid 
           FROM vodacom_payments 
           GROUP BY customer_id) p ON c.customer_id = p.customer_id
WHERE c.status = 'Active'
ORDER BY c.last_name;

-- Also: CREATE INDEX idx_calls_cust ON vodacom_calls(customer_id);
-- CREATE INDEX idx_payments_cust ON vodacom_payments(customer_id);
```

### Part D: Short Answer

**34. Page vs Component Authorization:**

**Page-level**: Controls access to entire page. If user fails, redirected to access denied page.
- **Use when**: Entire page is role-specific (e.g., Admin Settings page - only admins)

**Component-level**: Controls visibility/access to specific regions, buttons, items within page.
- **Use when**: Page has mixed-role features (e.g., Customer Details page - all see info, only managers see "Override Credit Check" button)

**Vodacom examples**:
- **Page-level**: "System Configuration" page (admin-only)
- **Component-level**: "Approve Escalation" button on Call Details page (manager-only, but agents view page)

**35. Principle of Least Privilege:**

**Definition**: Users granted minimum permissions necessary for their job function. Reduces security risk by limiting potential damage from compromised accounts or human error.

**Vodacom examples**:
1. **Call center agents**: Can view/edit customer data and log calls, but CANNOT view financial reports or modify system settings. Prevents data leakage and accidental system changes.

2. **Managers**: Can view team performance reports and approve escalations, but CANNOT delete customer records or modify pricing tables. Prevents accidental data loss while enabling oversight duties.

### Part E: Practical Implementation (Sample Solution)

**Part 1: Authentication & Authorization**

**Authentication Scheme:**
```
Scheme Name: VODACOM_LDAP_AUTH
Type: LDAP Directory
Configuration: Connect to Vodacom Active Directory, map AD groups to APEX roles
```

**Authorization Schemes:**

| Scheme Name | SQL/Logic | Applied To |
|-------------|-----------|------------|
| IS_AGENT | `SELECT 1 FROM vodacom_users WHERE username=:APP_USER AND user_role IN ('Agent','Manager','Admin')` | Package activation form, customer search |
| IS_MANAGER | `SELECT 1 FROM vodacom_users WHERE username=:APP_USER AND user_role IN ('Manager','Admin')` | Override Credit Check button, Manager reports |
| IS_ADMIN | `SELECT 1 FROM vodacom_users WHERE username=:APP_USER AND user_role='Admin'` | Pricing configuration, user management |

**Part 2: Security Features**

**Input Validation:**
1. **Customer exists**: `Mobile number must belong to active customer`
2. **Package available**: `Package must be active and available for customer type`
3. **Credit check**: `Customer credit score >= minimum (unless manager override)`

**Session State Protection:**
```
Items to protect: P20_CUSTOMER_ID, P20_PACKAGE_ID, P20_OVERRIDE_FLAG
Protection Level: Checksum Required - Session Level
```

**Part 3: Audit Implementation**

```sql
-- Audit log entry
INSERT INTO vodacom_activation_audit (
    audit_id,
    user_id,
    customer_id,
    package_id,
    activation_date,
    success_flag,
    failure_reason,
    ip_address,
    created_date
) VALUES (
    vodacom_audit_seq.NEXTVAL,
    :APP_USER,
    :P20_CUSTOMER_ID,
    :P20_PACKAGE_ID,
    SYSDATE,
    :P20_SUCCESS,
    :P20_FAILURE_REASON,
    :APP_REMOTE_ADDR,
    SYSDATE
);
COMMIT;
```

**Audit Table:**
```sql
CREATE TABLE vodacom_activation_audit (
    audit_id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id           VARCHAR2(100) NOT NULL,
    customer_id       NUMBER NOT NULL,
    package_id        NUMBER NOT NULL,
    activation_date   DATE NOT NULL,
    success_flag      VARCHAR2(1) DEFAULT 'N' CHECK (success_flag IN ('Y','N')),
    failure_reason    VARCHAR2(500),
    ip_address        VARCHAR2(50),
    created_date      DATE DEFAULT SYSDATE NOT NULL
);

CREATE INDEX idx_audit_user ON vodacom_activation_audit(user_id);
CREATE INDEX idx_audit_date ON vodacom_activation_audit(activation_date);
```

---

## Grading Rubric

| Section | Points | Criteria |
|---------|--------|----------|
| Part A (MC) | 40 | 2 points per correct answer |
| Part B (T/F) | 20 | 2 points per correct answer |
| Part C (Scenarios) | 15 | SQL Injection (5), Authorization (5), Performance (5) |
| Part D (Short Answer) | 10 | Page/Component auth (5), Least privilege (5) |
| Part E (Implementation) | 15 | Auth schemes (6), Security features (5), Audit (4) |
| **TOTAL** | **100** | Pass = 70+ points |

---

**Student Name:** ______________________________  
**Date:** ______________  
**Score:** ______ / 100  
**Pass/Fail:** __________

**Instructor Notes:**
