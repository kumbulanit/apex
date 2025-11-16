# Lab 06: Security and Performance

**Duration:** 120 minutes  
**Difficulty:** Advanced  
**Prerequisites:** Completed Lab 05 (Navigation and Controls)

## Learning Objectives

By the end of this lab, you will be able to:
1. Configure authentication schemes
2. Implement authorization with role-based access
3. Secure session state and prevent SQL injection
4. Implement row-level security with VPD
5. Optimize SQL queries for performance
6. Use APEX Advisor for best practices
7. Debug and troubleshoot applications

---

## Lab Scenario

**🎯 Building the Enterprise Call Center Application - Lab 6 of 7**

You're implementing **Enterprise Security & Performance** for Vodacom's production call center application.

**What You're Building This Lab:**
- **Role-Based Security** - Agent, Supervisor, Manager, Admin access levels
- **POPIA Compliance** - South African data protection (customer privacy)
- **Row-Level Security** - Agents see only their assigned customers
- **SQL Injection Prevention** - Protect 45M customer records
- **Performance Optimization** - Fast queries on massive datasets
- **Audit Logging** - Track all package activations for compliance

**How This Fits the Complete Application:**
```
Vodacom Enterprise Call Center Application (PRODUCTION-READY)
├── Customer Management (Labs 1-2) ✅
├── Network Operations (Lab 3) ✅
├── Reporting & Forms (Lab 4) ✅
├── Navigation & UX (Lab 5) ✅
├── 🔐 Security & Performance (Lab 6) ← YOU ARE HERE
│   ├── Authentication (Vodacom AD/LDAP)
│   ├── Authorization Schemes (4 roles)
│   ├── POPIA Compliance (customer data protection)
│   ├── Audit Trails (regulatory requirements)
│   ├── Query Optimization (45M records)
│   └── SQL Injection Prevention
└── Production Deployment (Lab 7)
```

**Enterprise Requirements:**
- 5,000+ concurrent users (agents across SA)
- Regulatory compliance (POPIA, financial regulations)
- Sub-second response times on 45M customer database
- Complete audit trail for security incidents
- Prevent data breaches (customer privacy critical)

---

## Part 1: Authentication and Authorization (30 minutes)

**🔐 Security Fundamentals for Beginners**

**1. Authentication vs Authorization:**

```
🏛️ Think of a Building:

┌──────────────────────────────────────┐
│ AUTHENTICATION (Who are you?)         │
│ → Showing your ID badge at entrance   │
│ → Verifies your identity              │
│ → In APEX: Username + Password        │
├──────────────────────────────────────┤
│ AUTHORIZATION (What can you do?)      │
│ → Your badge has access levels        │
│ → Employee: 1st floor only            │
│ → Manager: 1st-3rd floors             │
│ → Admin: All floors + server room     │
└──────────────────────────────────────┘
```

**2. SQL Injection (Security Threat):**

```
⚠️ DANGER - Vulnerable Code:

User types in search box: ' OR '1'='1

Bad SQL: "SELECT * FROM customers WHERE name='" + userInput + "'"
Result:  "SELECT * FROM customers WHERE name='' OR '1'='1'"
         └──────────────────────────────────────┘
         '1'='1' is always TRUE → Returns ALL customers! 🚫

✅ SAFE - Using Bind Variables:

Good SQL: "SELECT * FROM customers WHERE name = :P10_SEARCH"
          └─────────────────────────────────┘
          :P10_SEARCH treated as DATA, not CODE ✅
```

**📚 Key Terms:**
- **Authentication**: Proving who you are (login)
- **Authorization**: Permissions for what you can access
- **SQL Injection**: Hacker technique to inject malicious SQL
- **Bind Variable**: Safe way to pass data (use :ITEM_NAME)
- **Session State**: Data stored during user session
- **Authorization Scheme**: Rules defining who can access features

## Part 1: Authentication and Authorization (30 minutes)

### Exercise 1.1: Create Custom Authorization Schemes

1. **Access Security Settings**
   - App Builder → Your Application
   - Shared Components → Security → **Authorization Schemes**

2. **Create Admin Authorization**
   - Click **Create**
   - Name: `Administration Rights`
   - Scheme Type: `Exists SQL Query`
   - SQL Query:
     ```sql
     SELECT 1
     FROM technova_employees
     WHERE email = :APP_USER
       AND job_title IN ('CEO', 'CTO', 'CFO', 'Managing Director')
       AND is_active = 'Y'
     ```
   - Error Message: `You do not have administrative privileges to access this feature.`
   - Validate Authorization: `Once per Session`
   - Click **Create Authorization Scheme**

3. **Create Manager Authorization**
   - Name: `Manager Rights`
   - SQL Query:
     ```sql
     SELECT 1
     FROM technova_employees
     WHERE email = :APP_USER
       AND (job_title LIKE '%Manager%' 
            OR job_title LIKE '%Director%'
            OR job_title IN ('CEO', 'CTO', 'CFO'))
       AND is_active = 'Y'
     ```
   - Error Message: `This feature requires manager-level access.`

4. **Create Employee (Self) Authorization**
   - Name: `Employee Self Access`
   - Scheme Type: `PL/SQL Function Returning Boolean`
   - PL/SQL Function:
     ```sql
     DECLARE
       v_emp_id NUMBER;
     BEGIN
       SELECT emp_id
       INTO v_emp_id
       FROM technova_employees
       WHERE email = :APP_USER;
       
       RETURN (v_emp_id = :P_EMP_ID OR v_emp_id IS NULL);
     EXCEPTION
       WHEN NO_DATA_FOUND THEN
         RETURN FALSE;
     END;
     ```
   - Error Message: `You can only view your own employee record.`

### Exercise 1.2: Apply Authorization to Pages

1. **Protect Admin Pages**
   - Navigate to Page 1 (Dashboard)
   - Page Properties → Security:
     - Authorization Scheme: `Administration Rights`
   
   - Navigate to Page 20 (Client Analysis)
   - Authorization Scheme: `Manager Rights`

2. **Protect Navigation Menu Items**
   - Shared Components → Navigation → **Navigation Menu**
   - Edit **Reports** menu entry:
     - Authorization Scheme: `Manager Rights`

3. **Test Authorization**
   - Save and Run Application
   - Try accessing protected pages
   - Expected: Authorization error if not authorized

### Exercise 1.3: Configure Session State Protection

1. **Enable Session State Protection (Application-Level)**
   - Edit Application Definition
   - Security → Session Management:
     - Session State Protection: `Enabled`
   - Save Changes

2. **Protect Specific Pages**
   - Open Page 30 (Invoice Details)
   - Page Properties → Security:
     - Page Access Protection: `Arguments Must Have Checksum`
   
   - Open Page 3 (Projects)
   - Page Access Protection: `Unrestricted`

3. **Protect Items from URL Manipulation**
   - Page 30 → Select item `P30_INVOICE_ID`
   - Security:
     - Session State Protection: `Checksum Required - Application Level`
     - Store Value: `Encrypted in Session State`

---

## Part 2: Row-Level Security (25 minutes)

### Exercise 2.1: Create VPD Context

1. **Create Security Context Package**
   - SQL Workshop → SQL Commands
   - Execute:

```sql
-- Create context
CREATE OR REPLACE CONTEXT technova_ctx USING technova_security_pkg;

-- Create security package
CREATE OR REPLACE PACKAGE technova_security_pkg AS
  PROCEDURE set_emp_id(p_emp_id IN NUMBER);
  FUNCTION get_emp_id RETURN NUMBER;
END technova_security_pkg;
/

CREATE OR REPLACE PACKAGE BODY technova_security_pkg AS
  PROCEDURE set_emp_id(p_emp_id IN NUMBER) IS
  BEGIN
    DBMS_SESSION.SET_CONTEXT('technova_ctx', 'emp_id', p_emp_id);
  END set_emp_id;
  
  FUNCTION get_emp_id RETURN NUMBER IS
  BEGIN
    RETURN SYS_CONTEXT('technova_ctx', 'emp_id');
  END get_emp_id;
END technova_security_pkg;
/
```

### Exercise 2.2: Implement VPD Policy

1. **Create VPD Policy Function**

```sql
-- Policy function for timesheets
CREATE OR REPLACE FUNCTION timesheet_security_policy(
  p_schema VARCHAR2,
  p_object VARCHAR2
) RETURN VARCHAR2 IS
  v_emp_id NUMBER;
  v_predicate VARCHAR2(1000);
BEGIN
  -- Get current user's employee ID
  SELECT emp_id
  INTO v_emp_id
  FROM technova_employees
  WHERE email = SYS_CONTEXT('APEX$SESSION', 'APP_USER');
  
  -- Check if user is manager
  IF v_emp_id IN (
    SELECT emp_id 
    FROM technova_employees 
    WHERE job_title LIKE '%Manager%' OR job_title LIKE '%Director%'
  ) THEN
    -- Managers see all timesheets for their projects
    v_predicate := 'project_id IN (
      SELECT project_id 
      FROM technova_projects 
      WHERE pm_emp_id = ' || v_emp_id || '
    )';
  ELSE
    -- Regular employees see only their own timesheets
    v_predicate := 'emp_id = ' || v_emp_id;
  END IF;
  
  RETURN v_predicate;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN '1=0'; -- No access
END timesheet_security_policy;
/

-- Apply policy to timesheets table
BEGIN
  DBMS_RLS.ADD_POLICY(
    object_schema   => USER,
    object_name     => 'TECHNOVA_TIMESHEETS',
    policy_name     => 'timesheet_emp_access',
    function_schema => USER,
    policy_function => 'timesheet_security_policy',
    statement_types => 'SELECT, INSERT, UPDATE, DELETE'
  );
END;
/
```

2. **Test Row-Level Security**
   - Run Page 25 (Timesheet Entry)
   - Verify: Users see only their own timesheets
   - Verify: Managers see their team's timesheets

### Exercise 2.3: Add Audit Trail

1. **Create Audit Table**

```sql
CREATE TABLE technova_audit_log (
    audit_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    table_name VARCHAR2(100) NOT NULL,
    action_type VARCHAR2(10) NOT NULL, -- INSERT, UPDATE, DELETE
    record_id NUMBER,
    old_values CLOB,
    new_values CLOB,
    changed_by VARCHAR2(100) NOT NULL,
    changed_date TIMESTAMP DEFAULT SYSTIMESTAMP,
    ip_address VARCHAR2(50),
    apex_session_id NUMBER
);
```

2. **Create Audit Trigger**

```sql
CREATE OR REPLACE TRIGGER trg_invoice_audit
AFTER INSERT OR UPDATE OR DELETE ON technova_invoices
FOR EACH ROW
DECLARE
  v_action VARCHAR2(10);
  v_old CLOB;
  v_new CLOB;
BEGIN
  IF INSERTING THEN
    v_action := 'INSERT';
    v_new := 'invoice_id=' || :NEW.invoice_id || 
             ',client_id=' || :NEW.client_id ||
             ',total_amount=' || :NEW.total_amount ||
             ',status=' || :NEW.status;
  ELSIF UPDATING THEN
    v_action := 'UPDATE';
    v_old := 'total_amount=' || :OLD.total_amount || ',status=' || :OLD.status;
    v_new := 'total_amount=' || :NEW.total_amount || ',status=' || :NEW.status;
  ELSIF DELETING THEN
    v_action := 'DELETE';
    v_old := 'invoice_id=' || :OLD.invoice_id || ',total_amount=' || :OLD.total_amount;
  END IF;
  
  INSERT INTO technova_audit_log (
    table_name, action_type, record_id,
    old_values, new_values, changed_by,
    ip_address, apex_session_id
  ) VALUES (
    'TECHNOVA_INVOICES', v_action, COALESCE(:NEW.invoice_id, :OLD.invoice_id),
    v_old, v_new, NVL(V('APP_USER'), USER),
    V('APP_REQUEST_IP_ADDRESS'), V('APP_SESSION')
  );
END;
/
```

3. **Create Audit Log Page**
   - Create Page → Report → Interactive Report
   - Page Number: `40`
   - Page Name: `Audit Log`
   - Authorization: `Administration Rights`
   - SQL Query:
     ```sql
     SELECT audit_id,
            table_name,
            action_type,
            record_id,
            changed_by,
            changed_date,
            ip_address,
            apex_session_id,
            SUBSTR(old_values, 1, 100) AS old_values_preview,
            SUBSTR(new_values, 1, 100) AS new_values_preview
     FROM technova_audit_log
     ORDER BY changed_date DESC
     ```

---

## Part 3: Input Validation and Security (20 minutes)

### Exercise 3.1: Prevent SQL Injection

1. **Review Vulnerable Code (DO NOT USE)**
   ```sql
   -- VULNERABLE - DO NOT USE!
   DECLARE
     v_sql VARCHAR2(4000);
   BEGIN
     v_sql := 'SELECT * FROM technova_clients WHERE company_name = ''' || :P20_SEARCH || '''';
     EXECUTE IMMEDIATE v_sql;
   END;
   ```

2. **Use Bind Variables Instead**
   ```sql
   -- SECURE - Use bind variables
   DECLARE
     v_result NUMBER;
   BEGIN
     SELECT COUNT(*)
     INTO v_result
     FROM technova_clients
     WHERE company_name = :P20_SEARCH; -- Bind variable
   END;
   ```

3. **Add Input Validation**
   - Page 20 → Select item `P20_SEARCH_COMPANY`
   - Create Validation:
     - Name: `Valid Company Name`
     - Type: `Regular Expression (does not match)`
     - Regular Expression: `[<>\"'%;()&+]`
     - Error Message: `Company name contains invalid characters.`

### Exercise 3.2: Protect Against XSS

1. **Use APEX_ESCAPE**
   - Instead of: `<p>#COMPANY_NAME#</p>`
   - Use: `<p>&COMPANY_NAME.</p>` (automatic escaping)
   - Or explicit: `APEX_ESCAPE.HTML(company_name)`

2. **Create Safe Display Column**
   - Page 20 → Client Analysis report
   - Edit `COMPANY_NAME` column:
     - Type: `Plain Text` (automatically escaped)
   - Instead of `HTML Expression` (requires manual escaping)

### Exercise 3.3: Configure Password Policies

1. **Access Authentication Scheme**
   - Shared Components → Security → **Authentication Schemes**
   - Edit **Application Express Authentication**

2. **Set Password Requirements**
   - Settings:
     - Minimum Password Length: `10`
     - Require Mixed Case: `Yes`
     - Require Numeric Characters: `Yes`
     - Require Special Characters: `Yes`
     - Require Non-Alphanumeric: `1`

---

## Part 4: Performance Optimization (35 minutes)

### Exercise 4.1: Identify Slow Queries

1. **Enable Debug Mode**
   - Run Application
   - Bottom of page → Developer Toolbar
   - Click **Debug**
   - Navigate to slow pages

2. **View Page Processing Time**
   - Navigate to Page 20 (Client Analysis)
   - Developer Toolbar → **View Debug**
   - Look for:
     - `...Execute Statement (Query)` - SQL execution time
     - `...Region: Client Analysis` - Region rendering time

3. **Find Expensive Queries**
   - Look for SQL taking > 1 second
   - Note the line numbers

### Exercise 4.2: Optimize SQL Queries

1. **Analyze Query Performance**
   - SQL Workshop → SQL Commands
   - Execute with EXPLAIN PLAN:
   ```sql
   EXPLAIN PLAN FOR
   SELECT c.client_id,
          c.company_name,
          c.industry,
          COUNT(DISTINCT p.project_id) AS total_projects,
          SUM(p.budget) AS total_budget
   FROM technova_clients c
   LEFT JOIN technova_projects p ON c.client_id = p.client_id
   GROUP BY c.client_id, c.company_name, c.industry;
   
   -- View execution plan
   SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
   ```

2. **Add Missing Indexes**
   ```sql
   -- Index on foreign keys
   CREATE INDEX idx_projects_client_id ON technova_projects(client_id);
   CREATE INDEX idx_timesheets_emp_id ON technova_timesheets(emp_id);
   CREATE INDEX idx_timesheets_project_id ON technova_timesheets(project_id);
   
   -- Index for frequently filtered columns
   CREATE INDEX idx_projects_status ON technova_projects(status);
   CREATE INDEX idx_employees_is_active ON technova_employees(is_active);
   
   -- Composite index for common WHERE conditions
   CREATE INDEX idx_timesheets_date_emp ON technova_timesheets(work_date, emp_id);
   ```

3. **Rewrite Inefficient Query**
   - **Before (Slow):**
     ```sql
     SELECT e.emp_id,
            e.first_name || ' ' || e.last_name AS full_name,
            (SELECT COUNT(*) 
             FROM technova_timesheets t 
             WHERE t.emp_id = e.emp_id) AS timesheet_count,
            (SELECT SUM(hours_logged) 
             FROM technova_timesheets t 
             WHERE t.emp_id = e.emp_id) AS total_hours
     FROM technova_employees e;
     ```
   
   - **After (Fast):**
     ```sql
     SELECT e.emp_id,
            e.first_name || ' ' || e.last_name AS full_name,
            COUNT(t.timesheet_id) AS timesheet_count,
            SUM(t.hours_logged) AS total_hours
     FROM technova_employees e
     LEFT JOIN technova_timesheets t ON e.emp_id = t.emp_id
     GROUP BY e.emp_id, e.first_name, e.last_name;
     ```

### Exercise 4.3: Enable Report Caching

1. **Configure Region Caching**
   - Page 20 → Select **Client Analysis** region
   - Attributes → Caching:
     - Cache: `Cached`
     - Cache Timeout: `300` seconds (5 minutes)
     - Cache By User: `Yes`

2. **Clear Cache on Data Changes**
   - Page 21 (Client Form)
   - After Processing → Create Branch:
     - Branch Point: `After Processing`
     - Type: `Page or URL (Redirect)`
     - Target: Page `20`
     - **Clear Cache**: `20` (clears page 20 cache)

### Exercise 4.4: Use APEX Advisor

1. **Run APEX Advisor**
   - App Builder → Your Application
   - Utilities → **Advisor**
   - Click **Run Advisor**

2. **Review Findings**
   - **Performance Issues:**
     - Large queries without pagination
     - Missing indexes on LOV queries
     - Items not used (increase page load)
   
   - **Security Issues:**
     - Pages without authorization
     - Session state not protected
     - Items accepting dangerous characters

3. **Fix High-Priority Issues**
   - Click each finding
   - Review recommendation
   - Implement fix
   - Re-run Advisor to verify

### Exercise 4.5: Optimize Page Load

1. **Minimize Items**
   - Review Page 20
   - Hidden items still load data
   - Delete unused items: `P20_TEMP_1`, `P20_TEMP_2`

2. **Use Conditional Loading**
   - Page 30 → Select **Invoice Line Items** region
   - Server-side Condition:
     - Type: `Item is NOT NULL`
     - Item: `P30_INVOICE_ID`
   - Result: Region loads only when editing existing invoice

3. **Lazy Load Regions**
   - Select **Invoice Line Items** region
   - Advanced → Static ID: `line-items-region`
   - Create Dynamic Action on page load:
     - Event: `Page Load`
     - Condition: `Item is NOT NULL` → `P30_INVOICE_ID`
     - Action: `Refresh`
     - Region: `Invoice Line Items`

---

## Part 5: Debugging and Troubleshooting (10 minutes)

### Exercise 5.1: Use Console Logging

1. **Add JavaScript Debugging**
   - Page 30 → JavaScript → Execute when Page Loads:
     ```javascript
     // Log page load
     console.log('Page 30 loaded. Invoice ID:', apex.item('P30_INVOICE_ID').getValue());
     
     // Log button clicks
     $('#CALCULATE_TOTAL').on('click', function() {
       console.log('Calculate Total clicked');
       console.log('Invoice ID:', apex.item('P30_INVOICE_ID').getValue());
     });
     
     // Log Dynamic Action execution
     apex.debug.info('Invoice Details page initialized');
     ```

2. **Add PL/SQL Debugging**
   - Page 30 → Process: `Calculate Total`
   - Add debug statements:
     ```sql
     BEGIN
       apex_debug.message('Calculate Total process started');
       apex_debug.message('Invoice ID: ' || :P30_INVOICE_ID);
       
       DECLARE
         v_total NUMBER;
       BEGIN
         SELECT SUM(quantity * unit_price)
         INTO v_total
         FROM technova_invoice_line_items
         WHERE invoice_id = :P30_INVOICE_ID;
         
         apex_debug.message('Calculated total: ' || v_total);
         
         :P30_TOTAL_AMOUNT := NVL(v_total, 0);
       END;
       
       apex_debug.message('Calculate Total process completed');
     END;
     ```

3. **View Debug Output**
   - Enable Debug mode
   - Click **Calculate Total**
   - View Debug → Search for your messages

---

## Challenge Exercises

### Challenge 1: Implement Two-Factor Authentication
- Add table for OTP codes
- Send code via email on login
- Verify code before granting access

### Challenge 2: Create Performance Dashboard
- Track page load times
- Show slowest queries
- Display cache hit rates
- Monitor concurrent sessions

### Challenge 3: Implement Data Masking
- Hide sensitive data (salaries, SSN)
- Show full data only to authorized users
- Create masking function: `123-45-6789` → `XXX-XX-6789`

---

## Verification Checklist

- [ ] Authorization schemes created and tested
- [ ] Protected pages deny unauthorized access
- [ ] Navigation menu respects authorization
- [ ] Row-level security works (VPD)
- [ ] Audit log captures changes
- [ ] Input validation prevents invalid data
- [ ] Indexes created on foreign keys
- [ ] Slow queries identified and optimized
- [ ] APEX Advisor run with no critical issues
- [ ] Caching configured for reports
- [ ] Debug logging works correctly

---

## Key Takeaways

1. **Security is multi-layered**: Authentication → Authorization → Row-level security
2. **Never trust user input**: Always validate and escape
3. **Use bind variables**: Prevents SQL injection
4. **Audit everything**: Track who changed what and when
5. **Index foreign keys**: Dramatically improves JOIN performance
6. **Cache read-only data**: Reduces database load
7. **APEX Advisor is your friend**: Run it regularly
8. **Debug mode reveals issues**: Use it to find bottlenecks
9. **Optimize SQL first**: Database is usually the bottleneck
10. **Test with production-like data**: Small datasets hide performance issues

---

## Next Steps

Lab 07 will cover Deploying Applications:
- Export/Import applications
- Managing environments (DEV, TEST, PROD)
- CI/CD with SQLcl
- Version control with Git
- Rollback procedures

**Estimated Time for Lab 07:** 90 minutes
