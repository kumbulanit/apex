# Lesson 06: Application Security and Performance

## Theory

### Layman's Explanation

**Security** = Locks, keys, and security guards for your application (who gets in, what they can see/do)  
**Performance** = How fast everything works (nobody likes waiting)

Think of security and performance like a high-security building with express elevators:
- **Security**: Badge access (different levels: visitor, employee, manager, CEO)
- **Performance**: Fast elevators (nobody waits 5 minutes to reach their floor)

Both are critical but invisible when done right. Users only notice when they're done wrong (can't access what they need, or everything loads slowly).

**Real-World Analogy: Modern Office Building**

**Security Layers:**
1. **Outer Door**: Badge to enter building (Authentication - prove who you are)
2. **Floor Access**: Badge only works for your authorized floors (Authorization - what you can access)
3. **Room Locks**: Some doors need manager badge (Role-based access)
4. **Server Room**: Needs special keycard + PIN (Multi-factor)
5. **Security Cameras**: Track who went where, when (Audit trail)

**Performance Features:**
1. **Express Elevators**: Fast access to your floor (Optimized queries)
2. **Multiple Elevators**: Handle rush hour (Scalability)
3. **Smart Routing**: Elevators anticipate demand (Caching)
4. **No Waiting**: 10-second max wait time (Page load targets)

**Vodacom's Security & Performance Crisis: The Wake-Up Call**

Let's examine the critical incidents that forced Vodacom to take security and performance seriously.

**The Security Disaster (March 2023):**

**Incident 1: The Salary Leak**

Vodacom's Access database had ZERO security:
- **Problem**: Any employee could open the database and see the Employees table
- **Result**: Junior developer discovered everyone's salaries
- **Impact**: Morale crisis, HR nightmare, 3 people quit
- **Root cause**: No row-level security (everyone sees all data)

**Incident 2: The Client Data Breach**

- **Problem**: Sales intern accidentally emailed Access database file to wrong client
- **File contents**: ALL client contact info, contract values, confidential notes (180 clients × sensitive data)
- **Impact**: Legal threats, damaged reputation, emergency compliance audit
- **Root cause**: No file encryption, no access controls

**Incident 3: The Budget Disaster**

- **Problem**: Marketing coordinator changed project budget from $50,000 to $500,000 (extra zero)
- **Nobody noticed for 3 weeks** (no audit trail, no validation)
- **Impact**: CFO made decisions based on wrong budget, ordered premature staff hiring
- **Root cause**: No authorization (anyone could change anything), no validation, no audit log

**The Cost:**
- Legal fees: $35,000
- Compliance audit: $15,000
- Lost client: $120,000/year contract
- Emergency security consultant: $25,000
- **Total: $195,000 + reputation damage**

**CEO's Quote:** "We got lucky this wasn't worse. What if they'd seen our IP or strategic plans? We need real security, NOW."

**The Performance Nightmare (Daily Occurrence):**

**Problem: The 45-Second Dashboard**

```
User Experience:
9:00 AM - Maria opens Project Dashboard
9:00:05 - Stares at spinning loading icon
9:00:15 - Still loading...
9:00:30 - Still loading...
9:00:45 - Dashboard finally displays
9:00:47 - Client calls, Maria needs to switch to Client view
9:00:52 - Loading again...
9:01:27 - Client view loads (35 seconds)
9:01:28 - Client asks about specific project
9:01:30 - Maria clicks project detail
9:02:12 - Detail page loads (42 seconds)
9:02:13 - Client has already hung up, frustrated

Total time wasted: 2 minutes 12 seconds for 3 page loads
× 250 employees × 20 page loads/day = 18,333 minutes/day wasted
= 305 hours/day = **$30,500/day in lost productivity**
```

**Why So Slow?**

Database analysis revealed horrifying queries:

```sql
-- The nightmare query (8.3 seconds to run)
SELECT p.*,
       (SELECT company_name FROM clients WHERE client_id = p.client_id),
       (SELECT first_name || ' ' || last_name FROM employees WHERE emp_id = p.project_manager),
       (SELECT COUNT(*) FROM tasks WHERE project_id = p.project_id),
       (SELECT SUM(hours) FROM timesheets WHERE project_id = p.project_id),
       (SELECT MAX(invoice_date) FROM invoices WHERE project_id = p.project_id),
       (SELECT AVG(rating) FROM client_feedback WHERE project_id = p.project_id)
FROM projects p
WHERE is_active = 'Y';

-- Returns 5,300 rows
-- Executes 31,800 subqueries (5,300 × 6)
-- No indexes on foreign keys
-- No caching
```

**Impact:**
- Dashboard timeout: 45 seconds
- Server CPU: 95% constantly
- Frustrated users: 100%
- **Productivity loss: $7.6M/year** (305 hours/day × $100/hr × 250 workdays)

**CEO's Quote:** "We're paying $250,000/year for Oracle Database licenses and it's slower than Excel. This is unacceptable."

**The APEX Security Transformation:**

Vodacom implemented comprehensive security in APEX - took 3 days vs 3 months traditional development.

**Layer 1: Authentication (Who Are You?)**

**Old Access:** No login required, anyone with database file could open it

**New APEX:**
```
Login Page (HTTPS encrypted)
────────────────────────
Username: [____________]
Password: [************]
         [Sign In]
         
Options implemented:
✓ Active Directory integration (use corporate credentials)
✓ Password complexity requirements (8 chars, uppercase, number, symbol)
✓ Account lockout after 5 failed attempts
✓ Session timeout after 30 minutes idle
✓ Force password change every 90 days
✓ Two-factor authentication (optional, enabled for admins)
```

**Layer 2: Authorization (What Can You Do?)**

**Role-Based Access Control:**

```sql
-- Created authorization schemes

-- Scheme 1: Is Employee (Base Access)
SELECT COUNT(*) FROM vodacom_employees
WHERE email = :APP_USER
  AND is_active = 'Y'

-- Scheme 2: Is Manager
SELECT COUNT(*) FROM vodacom_employees
WHERE email = :APP_USER
  AND job_title LIKE '%Manager%'
  AND is_active = 'Y'

-- Scheme 3: Is Admin
SELECT COUNT(*) FROM vodacom_admins
WHERE email = :APP_USER
  AND is_active = 'Y'

-- Scheme 4: Is Finance Team
SELECT COUNT(*) FROM vodacom_employees
WHERE email = :APP_USER
  AND department = 'Finance'
  AND is_active = 'Y'
```

**Applied to Pages/Components:**

| Feature | Employee | Manager | Admin | Finance |
|---------|----------|---------|-------|---------|
| **View own projects** | ✅ | ✅ | ✅ | ✅ |
| **View all projects** | ❌ | ✅ | ✅ | ✅ |
| **Edit own timesheets** | ✅ | ✅ | ✅ | ✅ |
| **Approve timesheets** | ❌ | ✅ (team only) | ✅ (all) | ❌ |
| **View salaries** | ❌ (own only) | ❌ (own only) | ✅ | ✅ |
| **Edit budgets** | ❌ | ❌ | ✅ | ✅ |
| **Delete projects** | ❌ | ❌ | ✅ | ❌ |
| **Run financial reports** | ❌ | ❌ | ✅ | ✅ |
| **User administration** | ❌ | ❌ | ✅ | ❌ |

**Layer 3: Row-Level Security (Data Isolation)**

**The Salary Problem - SOLVED:**

```sql
-- View that employees use (secure)
CREATE OR REPLACE VIEW v_employee_secure AS
SELECT employee_id,
       first_name,
       last_name,
       email,
       phone,
       department,
       job_title,
       hire_date,
       -- Salary only visible if viewing own record or user is admin
       CASE 
         WHEN email = V('APP_USER') THEN salary
         WHEN V('APP_USER') IN (SELECT email FROM vodacom_admins) THEN salary
         ELSE NULL
       END AS salary,
       manager_id,
       is_active
FROM vodacom_employees;

-- Grant access to view, not base table
GRANT SELECT ON v_employee_secure TO vodacom_users;
REVOKE SELECT ON vodacom_employees FROM vodacom_users;
```

**Result:**
- Employees see only their own salary
- Admins see all salaries
- No way to bypass (database enforces it)

**Layer 4: Audit Trail (Who Did What, When?)**

```sql
-- Created audit table
CREATE TABLE vodacom_audit_log (
    audit_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    table_name      VARCHAR2(100),
    record_id       NUMBER,
    action_type     VARCHAR2(20),  -- INSERT, UPDATE, DELETE
    old_values      CLOB,          -- JSON of old values
    new_values      CLOB,          -- JSON of new values
    changed_by      VARCHAR2(100),
    changed_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    ip_address      VARCHAR2(50),
    session_id      NUMBER
);

-- Trigger on projects table
CREATE OR REPLACE TRIGGER trg_projects_audit
AFTER INSERT OR UPDATE OR DELETE ON vodacom_projects
FOR EACH ROW
DECLARE
    v_action VARCHAR2(20);
    v_old JSON_OBJECT_T;
    v_new JSON_OBJECT_T;
BEGIN
    v_action := CASE
                  WHEN INSERTING THEN 'INSERT'
                  WHEN UPDATING THEN 'UPDATE'
                  WHEN DELETING THEN 'DELETE'
                END;
    
    IF UPDATING OR DELETING THEN
        v_old := JSON_OBJECT_T;
        v_old.put('project_id', :OLD.project_id);
        v_old.put('project_name', :OLD.project_name);
        v_old.put('budget', :OLD.budget);
        v_old.put('status', :OLD.status);
    END IF;
    
    IF INSERTING OR UPDATING THEN
        v_new := JSON_OBJECT_T;
        v_new.put('project_id', :NEW.project_id);
        v_new.put('project_name', :NEW.project_name);
        v_new.put('budget', :NEW.budget);
        v_new.put('status', :NEW.status);
    END IF;
    
    INSERT INTO vodacom_audit_log (
        table_name, record_id, action_type, old_values, new_values,
        changed_by, ip_address, session_id
    ) VALUES (
        'PROJECTS', 
        NVL(:NEW.project_id, :OLD.project_id), 
        v_action,
        v_old.to_string,
        v_new.to_string,
        NVL(V('APP_USER'), USER),
        V('APP_REMOTE_ADDR'),
        V('APP_SESSION')
    );
END;
/
```

**Now When Budget Changes:**
```
Audit Log Entry:
─────────────────────────────────────────────────
Date: 2024-01-15 14:23:47
User: marketing@vodacom.com
IP: 192.168.1.105
Action: UPDATE
Table: PROJECTS
Record ID: 1234
Changed Fields:
  • budget: $50,000 → $500,000
Session: 1847293847
─────────────────────────────────────────────────
```

**Result:**
- Every change tracked forever
- Compliance audit: PASSED
- Budget disaster: IMPOSSIBLE (caught immediately)

**Layer 5: Input Validation & SQL Injection Prevention**

**APEX Built-in Protection:**
- All user input automatically escaped (SQL injection impossible)
- Bind variables used throughout (`:P1_PROJECT_ID`, not string concatenation)
- Cross-site scripting (XSS) protection automatic
- HTTPS enforced (no plain-text passwords)

**Example of Protection:**

**Malicious User Tries:**
```
Username: admin' OR '1'='1
Password: anything

Old vulnerable code would generate:
SELECT * FROM users WHERE username='admin' OR '1'='1' AND password='anything'
(Would return all users, bypass authentication)

APEX Protection:
SELECT * FROM users WHERE username=:P1_USERNAME AND password=:P1_PASSWORD
Bind variable :P1_USERNAME = "admin' OR '1'='1" (treated as literal text)
Result: Login fails (no such username)
```

**Security Results:**

| Metric | Before (Access) | After (APEX) | Improvement |
|--------|----------------|--------------|-------------|
| **Authentication** | None | Active Directory SSO | ∞ better |
| **Authorization** | None | Role-based (3 levels) | ∞ better |
| **Row-level security** | None | Enforced by database | ∞ better |
| **Audit trail** | None | Complete history | ∞ better |
| **SQL injection risk** | High | Zero | 100% eliminated |
| **Salary visibility** | Everyone | Own only | 100% resolved |
| **Security incidents** | 3 in 6 months | 0 in 18 months | 100% eliminated |
| **Compliance audit** | Failed | Passed | Pass |

**Estimated risk reduction: $500,000+ (cost of potential breach prevented)**

**The APEX Performance Transformation:**

**Problem: The 45-Second Dashboard**
**Solution: 0.4-Second Dashboard** (112x faster!)

**Step 1: Query Optimization**

```sql
-- BEFORE: 8.3 seconds (nightmare)
SELECT p.*,
       (SELECT company_name FROM clients WHERE client_id = p.client_id),
       (SELECT first_name || ' ' || last_name FROM employees WHERE emp_id = p.project_manager),
       ...
FROM projects p;

-- AFTER: 0.07 seconds (optimized with JOINs)
SELECT p.project_id,
       p.project_name,
       p.status,
       p.start_date,
       p.budget,
       c.company_name,
       e.first_name || ' ' || e.last_name AS project_manager,
       task_stats.task_count,
       task_stats.completed_count,
       time_stats.total_hours
FROM vodacom_projects p
LEFT JOIN vodacom_clients c ON p.client_id = c.client_id
LEFT JOIN vodacom_employees e ON p.project_manager = e.employee_id
LEFT JOIN (
    SELECT project_id,
           COUNT(*) AS task_count,
           SUM(CASE WHEN status = 'Complete' THEN 1 ELSE 0 END) AS completed_count
    FROM vodacom_tasks
    GROUP BY project_id
) task_stats ON p.project_id = task_stats.project_id
LEFT JOIN (
    SELECT project_id,
           SUM(hours_logged) AS total_hours
    FROM vodacom_timesheets
    GROUP BY project_id
) time_stats ON p.project_id = time_stats.project_id
WHERE p.is_active = 'Y';

-- Performance: 8.3s → 0.07s (99.2% faster)
```

**Step 2: Indexes**

```sql
-- Created strategic indexes
CREATE INDEX idx_projects_active ON vodacom_projects(is_active, start_date);
CREATE INDEX idx_projects_client ON vodacom_projects(client_id);
CREATE INDEX idx_projects_manager ON vodacom_projects(project_manager);
CREATE INDEX idx_tasks_project ON vodacom_tasks(project_id, status);
CREATE INDEX idx_timesheets_project ON vodacom_timesheets(project_id);
CREATE INDEX idx_employees_email ON vodacom_employees(email);

-- Result: Query plan uses indexes, avoids full table scans
```

**Step 3: Materialized View for Dashboard**

```sql
-- Heavy aggregation pre-computed, refreshes every 15 minutes
CREATE MATERIALIZED VIEW mv_project_dashboard
REFRESH FAST ON COMMIT
AS
SELECT p.project_id,
       p.project_name,
       p.status,
       c.company_name,
       e.first_name || ' ' || e.last_name AS manager_name,
       COUNT(DISTINCT t.task_id) AS task_count,
       SUM(CASE WHEN t.status = 'Complete' THEN 1 ELSE 0 END) AS completed_tasks,
       SUM(ts.hours_logged) AS total_hours,
       p.budget,
       SUM(i.amount) AS invoiced_amount
FROM vodacom_projects p
LEFT JOIN vodacom_clients c ON p.client_id = c.client_id
LEFT JOIN vodacom_employees e ON p.project_manager = e.employee_id
LEFT JOIN vodacom_tasks t ON p.project_id = t.project_id
LEFT JOIN vodacom_timesheets ts ON p.project_id = ts.project_id
LEFT JOIN vodacom_invoices i ON p.project_id = i.project_id
GROUP BY p.project_id, p.project_name, p.status, c.company_name,
         e.first_name, e.last_name, p.budget;

-- Dashboard query becomes:
SELECT * FROM mv_project_dashboard WHERE status = 'Active';

-- Performance: 0.07s → 0.003s (96% faster than optimized query)
```

**Step 4: APEX Region Caching**

```apex
Region: Project Dashboard
Settings:
  ✓ Enable Caching
  Cache Timeout: 10 minutes
  Cache By User: No (same for all users)
  Cache Conditions: None

Result: First load = 0.3s, subsequent loads = 0.01s (from cache)
```

**Step 5: Lazy Loading for Details**

```
Dashboard loads immediately (0.3s)
─────────────────────────────────
Project List: [Loaded - shows 50 projects]
Charts: [Loading...] ← Loads in background
Activity Feed: [Loading...] ← Loads after charts

User sees data instantly, details fill in progressively
Total perceived load time: 0.3s (vs 45s before)
Actual complete load: 1.2s (but user already interacting)
```

**Performance Results:**

| Metric | Before (Access) | After (APEX) | Improvement |
|--------|----------------|--------------|-------------|
| **Dashboard load** | 45 seconds | 0.4 seconds | 112x faster |
| **Report query** | 8.3 seconds | 0.07 seconds | 118x faster |
| **Form save** | 3-5 seconds | 0.2 seconds | 20x faster |
| **Search** | 12 seconds | 0.1 seconds | 120x faster |
| **Server CPU** | 95% constant | 12% average | 87% reduction |
| **Database load** | 500 queries/sec | 45 queries/sec | 91% reduction |
| **User complaints** | 40/week | 0/month | 100% eliminated |
| **Productivity loss** | $7.6M/year | $380K/year | 95% reduction |

**Annual Savings from Performance: $7.2M**

**Total Security + Performance Savings: $7.7M/year**

**The Bottom Line**

Security and performance are not optional extras - they're fundamental requirements:

**Security Protects:**
- Sensitive data (salaries, client info, IP)
- Company reputation
- Legal compliance
- Customer trust

**Performance Enables:**
- User productivity (no waiting)
- User satisfaction (positive experience)
- Scalability (more users, same speed)
- Competitive advantage (faster = better)

**Vodacom's Transformation:**
- **Security incidents**: 3 in 6 months → 0 in 18 months
- **Page load time**: 45 seconds → 0.4 seconds
- **Total savings**: $7.9M/year (security risk avoided + productivity gained)

**CEO's final quote:** "We went from security nightmares and performance disasters to enterprise-grade security and sub-second page loads. APEX didn't just solve our problems - it transformed our business capabilities."

In the next sections, we'll learn exactly how to implement authentication schemes, create authorization rules, optimize SQL queries, and monitor performance.

### Intermediate Explanation

**Security Layers:**
- Authentication: Who you are
- Authorization: What you can access
- Session State Protection: Prevent tampering
- SQL Injection Prevention: Automatic (built-in)
- Audit Trail: Track all changes

**APEX Security Layers Diagram:**

```
┌──────────────────────────────────────────────────────────┐
│                APEX SECURITY LAYERS                      │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  Layer 1: NETWORK SECURITY                               │
│  ┌────────────────────────────────────────────────┐     │
│  │ • HTTPS Encryption (SSL/TLS)                   │     │
│  │ • Firewall rules                               │     │
│  │ • IP whitelisting                              │     │
│  │ • DDoS protection                              │     │
│  └────────────────────────────────────────────────┘     │
│                      ↓                                   │
│  Layer 2: AUTHENTICATION (Who are you?)                  │
│  ┌────────────────────────────────────────────────┐     │
│  │ • Database accounts                            │     │
│  │ • LDAP/Active Directory                        │     │
│  │ • OAuth2 (Google, Microsoft)                   │     │
│  │ • SAML (Enterprise SSO)                        │     │
│  │ • Social Sign-in                               │     │
│  │ • Two-factor authentication                    │     │
│  └────────────────────────────────────────────────┘     │
│                      ↓                                   │
│  Layer 3: AUTHORIZATION (What can you access?)           │
│  ┌────────────────────────────────────────────────┐     │
│  │ • Page-level access control                    │     │
│  │ • Region-level security                        │     │
│  │ • Button authorization schemes                 │     │
│  │ • Item-level authorization                     │     │
│  │ • Role-based access (RBAC)                     │     │
│  └────────────────────────────────────────────────┘     │
│                      ↓                                   │
│  Layer 4: DATA SECURITY (Row-level)                      │
│  ┌────────────────────────────────────────────────┐     │
│  │ • VPD (Virtual Private Database)               │     │
│  │ • Secure views (WHERE user = APP_USER)         │     │
│  │ • Column-level encryption                      │     │
│  │ • Data masking                                 │     │
│  └────────────────────────────────────────────────┘     │
│                      ↓                                   │
│  Layer 5: SESSION SECURITY                               │
│  ┌────────────────────────────────────────────────┐     │
│  │ • Session State Protection (checksums)         │     │
│  │ • Session timeout (auto logout)                │     │
│  │ • Deep linking control                         │     │
│  │ • CSRF token validation                        │     │
│  └────────────────────────────────────────────────┘     │
│                      ↓                                   │
│  Layer 6: INPUT VALIDATION                               │
│  ┌────────────────────────────────────────────────┐     │
│  │ • SQL injection prevention (bind variables)    │     │
│  │ • XSS prevention (output escaping)             │     │
│  │ • Input sanitization                           │     │
│  │ • Data type validation                         │     │
│  └────────────────────────────────────────────────┘     │
│                      ↓                                   │
│  Layer 7: AUDIT & MONITORING                             │
│  ┌────────────────────────────────────────────────┐     │
│  │ • Login tracking                               │     │
│  │ • Page view logging                            │     │
│  │ • Data change audit trail                      │     │
│  │ • Error logging                                │     │
│  └────────────────────────────────────────────────┘     │
│                                                          │
│  Defense in Depth: Multiple layers protect your app     │
└──────────────────────────────────────────────────────────┘
```

**🎓 Learn More:**
- **Documentation**: [APEX Security Guide](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/providing-security-through-authorization.html)
- **Documentation**: [Session State Protection](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/managing-session-state.html)
- **Best Practices**: [APEX Security Best Practices](https://apex.oracle.com/en/learn/documentation/)

**Performance Optimization:**
- SQL query tuning
- Pagination (limit result sets)
- Caching (region, SQL)
- Lazy loading (regions load on demand)
- Indexing (database optimization)

**Performance Optimization Decision Tree:**

```
┌──────────────────────────────────────────────────────────┐
│        PERFORMANCE OPTIMIZATION DECISION TREE            │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  Is your page slow (>2 seconds)?                         │
│              │                                            │
│              ├─ YES → Continue below                      │
│              └─ NO → You're done! ✓                       │
│                                                          │
│  Step 1: IDENTIFY THE BOTTLENECK                         │
│  ┌────────────────────────────────────────────────┐     │
│  │ Enable Debug mode → View timing                │     │
│  │                                                 │     │
│  │ Check timing breakdown:                        │     │
│  │ • SQL queries: > 80% → Slow SQL               │     │
│  │ • Rendering: > 15% → Too many regions         │     │
│  │ • Processing: > 10% → Heavy computation       │     │
│  └────────────────────────────────────────────────┘     │
│              │                                            │
│              ↓                                            │
│  Problem: SLOW SQL QUERIES?                              │
│  ┌────────────────────────────────────────────────┐     │
│  │ ✓ Replace subqueries with JOINs               │     │
│  │ ✓ Add indexes on foreign keys                 │     │
│  │ ✓ Use EXISTS instead of IN for subqueries     │     │
│  │ ✓ Avoid SELECT * (specify columns)            │     │
│  │ ✓ Use EXPLAIN PLAN to analyze query           │     │
│  │ ✓ Consider materialized views                 │     │
│  └────────────────────────────────────────────────┘     │
│              │                                            │
│              ↓                                            │
│  Problem: TOO MANY REGIONS?                              │
│  ┌────────────────────────────────────────────────┐     │
│  │ ✓ Enable lazy loading (load on scroll)        │     │
│  │ ✓ Use AJAX partial refresh                    │     │
│  │ ✓ Combine regions where possible              │     │
│  │ ✓ Hide regions until needed (conditional)     │     │
│  └────────────────────────────────────────────────┘     │
│              │                                            │
│              ↓                                            │
│  Problem: LARGE RESULT SETS?                             │
│  ┌────────────────────────────────────────────────┐     │
│  │ ✓ Enable pagination (50 rows per page)        │     │
│  │ ✓ Use search/filter to reduce dataset         │     │
│  │ ✓ Add indexes on filter columns               │     │
│  │ ✓ Consider pagination type (row ranges)       │     │
│  └────────────────────────────────────────────────┘     │
│              │                                            │
│              ↓                                            │
│  Problem: REPEATED QUERIES?                              │
│  ┌────────────────────────────────────────────────┐     │
│  │ ✓ Enable region caching (10-minute timeout)   │     │
│  │ ✓ Use APEX_UTIL.GET_SESSION_STATE for items   │     │
│  │ ✓ Cache SQL query results                     │     │
│  └────────────────────────────────────────────────┘     │
│              │                                            │
│              ↓                                            │
│  Test Again → Did it improve?                            │
│  ├─ YES → Great! Monitor and iterate                     │
│  └─ NO → Consider ORDS tuning, database resources        │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

**🎓 Deep Dive:**
- **Documentation**: [Performance Tuning Guide](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/managing-application-performance.html)
- **Tool**: [APEX Advisor](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/using-advisor.html) - Automated performance recommendations
- **Best Practices**: Enable Debug mode to see exact SQL execution times

### Advanced Explanation

**Authentication Schemes:**
- Database Accounts
- LDAP/Active Directory
- OAuth2 (Google, Microsoft)
- SAML (Enterprise SSO)
- Custom (PL/SQL function)

**Authorization Schemes:**
- SQL query returning true/false
- PL/SQL function
- Applied to pages, regions, buttons, items

**Session State Protection:**
- Checksum validation on page items
- Prevents URL tampering
- Deep linking controls

**Performance Monitoring:**
- APEX Advisor (identifies issues)
- Debug mode (page rendering timeline)
- Database AWR reports
- ORDS connection pool tuning

---

## Labs / Practicals

### Lab 1: Simple - Implement Authentication

**Objective:** Set up LDAP authentication for Vodacom.

**Steps:**
1. Shared Components → Authentication Schemes
2. Create: LDAP Directory
3. Configure:
```
Name: Vodacom Active Directory
Scheme Type: LDAP Directory
Host: ldap.vodacom.com:389
DN String: cn=%LDAP_USER%,ou=employees,dc=vodacom,dc=com
```
4. Set as current scheme
5. Test login with AD credentials

---

### Lab 2: Intermediate - Create Authorization Schemes

**Objective:** Restrict manager functions to managers only.

**Step 1: Create Authorization Scheme**
```sql
Name: Is Manager
Scheme Type: PL/SQL Function Returning Boolean
PL/SQL Code:
  DECLARE
    v_is_manager NUMBER;
  BEGIN
    SELECT COUNT(*)
    INTO v_is_manager
    FROM vodacom_employees
    WHERE email = :APP_USER
      AND job_title LIKE '%Manager%';
    
    RETURN v_is_manager > 0;
  END;
Error Message: You must be a manager to access this feature.
```

**Step 2: Apply to Components**
- Page 15 (Approve Budget): Authorization = Is Manager
- Button "Approve": Authorization = Is Manager
- Region "Financial Summary": Authorization = Is Manager

**Test:** Log in as non-manager, features hidden

---

### Lab 3: Advanced - Performance Tuning

**Objective:** Optimize slow-running Vodacom project dashboard.

**Step 1: Enable Debug**
1. Run page
2. Developer toolbar → Debug
3. View timing in debug output

**Step 2: Identify Slow Query**
```sql
-- Original slow query (4.2 seconds)
SELECT p.*,
       (SELECT company_name FROM tn_clients WHERE client_id = p.client_id) AS client,
       (SELECT first_name || ' ' || last_name FROM tn_employees WHERE emp_id = p.project_manager) AS manager,
       (SELECT COUNT(*) FROM tn_tasks WHERE project_id = p.project_id) AS task_count
FROM vodacom_projects p;
```

**Step 3: Optimize with Joins**
```sql
-- Optimized query (0.3 seconds)
SELECT p.project_id,
       p.project_name,
       p.status,
       c.company_name AS client,
       e.first_name || ' ' || e.last_name AS manager,
       COUNT(t.task_id) AS task_count
FROM vodacom_projects p
LEFT JOIN tn_clients c ON p.client_id = c.client_id
LEFT JOIN tn_employees e ON p.project_manager = e.emp_id
LEFT JOIN tn_tasks t ON p.project_id = t.project_id
GROUP BY p.project_id, p.project_name, p.status, 
         c.company_name, e.first_name, e.last_name;
```

**Step 4: Add Indexes**
```sql
CREATE INDEX idx_tasks_project ON tn_tasks(project_id);
CREATE INDEX idx_projects_client ON vodacom_projects(client_id);
CREATE INDEX idx_projects_manager ON vodacom_projects(project_manager);
```

**Step 5: Enable Region Caching**
```
Region: Project Dashboard
Caching: Enabled
Cache Timeout: 10 minutes
Cache By User: No
```

**Result:** Page load reduced from 4.2s to 0.3s

---

## Real-World Practical

### Vodacom Security Audit & Performance Review

**Scenario:** Vodacom's CFO demands:
1. SOC 2 compliance (audit trail, access controls)
2. Sub-2-second page loads
3. Mobile performance optimization
4. Penetration test readiness

**Tasks:**
- Implement audit logging (who changed what, when)
- Add role-based access control (Employee, Manager, Admin)
- Enable HTTPS only
- Optimize top 5 slowest pages
- Add session timeout (30 minutes)
- Implement SQL injection prevention
- Enable XSS protection

**Deliverables:**
- Security configuration document
- Performance benchmark report
- Authorization scheme matrix
- Optimized SQL queries

---

## Assessment

### MCQs

**Q1:** What is the difference between authentication and authorization?

A) No difference  
B) Authentication is who you are, authorization is what you can do  
C) Authorization is faster than authentication  
D) Authentication requires database, authorization doesn't  

**Answer: B**

**Q2:** Which technique provides the biggest performance improvement for slow queries?

A) Increasing session timeout  
B) Adding indexes and optimizing SQL joins  
C) Changing page template  
D) Using more regions  

**Answer: B**

**Q3:** What does session state protection prevent?

A) Slow page loads  
B) URL tampering and unauthorized parameter changes  
C) Database crashes  
D) Network failures  

**Answer: B**

### Short Answer

**Q1:** Vodacom wants to ensure only project managers can approve their own project budgets (not other managers' projects). How would you implement this security?

**Answer:** Create authorization scheme:
```sql
SELECT COUNT(*)
FROM vodacom_projects
WHERE project_id = :P5_PROJECT_ID
  AND project_manager = (
    SELECT emp_id 
    FROM vodacom_employees 
    WHERE email = :APP_USER
  );
-- Returns 1 if current user is project's manager
```
Apply to "Approve Budget" button. Checks both manager role AND project ownership.

**Q2:** Explain three ways to improve APEX application performance.

**Answer:**
1. **SQL Optimization**: Use joins instead of subqueries, add indexes on foreign keys, avoid SELECT * 
2. **Page Caching**: Cache regions that rarely change (10-minute timeout), reduces database queries
3. **AJAX Partial Refresh**: Refresh only changed regions instead of full page reload, reduces network traffic and render time

### Practical Challenge

**Project:** Vodacom Security & Performance Overhaul

**Requirements:**

**Security (50 points):**
1. Implement 3-tier access (Employee, Manager, Admin)
2. Create authorization schemes for each tier
3. Apply to appropriate pages/components
4. Add audit logging table tracking all data changes
5. Enable session state protection
6. Configure HTTPS-only mode

**Performance (50 points):**
1. Identify 3 slow-running pages (>2 seconds)
2. Optimize SQL queries
3. Add database indexes
4. Enable region caching where appropriate
5. Document before/after timings
6. Run APEX Advisor and fix issues

**Deliverables:**
- Authorization scheme documentation
- Audit log implementation
- Performance benchmark spreadsheet
- Optimized SQL queries
- APEX Advisor report (before/after)

---

## PowerPoint Slides

### Slide 1: Security and Performance
**Vodacom Training - Lesson 06**

### Slide 2: Security Layers
1. **Authentication** - Who are you?
2. **Authorization** - What can you access?
3. **Session Management** - Stay logged in securely
4. **Input Validation** - Prevent bad data
5. **Output Encoding** - Prevent XSS

**Defense in depth!**

### Slide 3: Authentication Methods
- Database Accounts (simple)
- LDAP/Active Directory (enterprise)
- OAuth2 (Google, Microsoft, GitHub)
- SAML (SSO)
- Custom PL/SQL function

**Vodacom:** Uses Active Directory

### Slide 4: Authorization Schemes
**SQL Query:**
```sql
SELECT COUNT(*) 
FROM user_roles 
WHERE username = :APP_USER 
  AND role = 'MANAGER'
```

**Apply to:**
- Pages
- Regions
- Buttons
- Items

### Slide 5: Vodacom Access Control
**Employee:** View own timesheets, projects  
**Manager:** Approve team timesheets, budgets  
**Admin:** Full access, user management  

**Implementation:** 3 authorization schemes

### Slide 6: Performance Bottlenecks
🐌 **Slow SQL queries** (subqueries, missing indexes)  
🐌 **Too many regions** (lazy load instead)  
🐌 **Full page refresh** (use AJAX)  
🐌 **Large result sets** (pagination)  
🐌 **Unoptimized images** (compress, CDN)  

### Slide 7: Performance Optimization
✅ **Optimize SQL** - Joins, indexes, query plans  
✅ **Enable Caching** - Regions, SQL results  
✅ **AJAX Refresh** - Partial page updates  
✅ **Lazy Loading** - Load on-demand  
✅ **Connection Pooling** - ORDS configuration  

**Goal:** <2 second page loads

### Slide 8: Debug Mode
**Enable:** Developer Toolbar → Debug

**Shows:**
- Page rendering timeline
- SQL execution time
- Region load times
- Session state

**Find bottlenecks fast!**

### Slide 9: Security Best Practices
✅ Use HTTPS only  
✅ Enable session state protection  
✅ Set session timeout (30 min)  
✅ Implement role-based access  
✅ Audit sensitive operations  
✅ Validate all inputs  
✅ Escape all outputs  
✅ Keep APEX/ORDS updated  

### Slide 10: Vodacom Results
**Before:**
- No access controls (anyone sees everything)
- Slow dashboard (4.2 seconds)
- No audit trail

**After:**
- 3-tier role-based access
- Dashboard loads in 0.3 seconds
- Complete audit logging
- SOC 2 compliant

**Business Impact:** $50K cost savings, passed audit

