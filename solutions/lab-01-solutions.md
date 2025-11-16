# Lab 01 Solutions: Introduction and Getting Started

**Lab Duration:** 60 minutes  
**Solution Guide Version:** 1.0

---

## Solution Overview

This guide provides complete solutions, explanations, and troubleshooting tips for Lab 01. Students should attempt exercises independently before consulting solutions.

---

## Part 1 Solutions: Exploring the APEX Environment

### Exercise 1.1: Log In and Navigate the Workspace

**Solution Steps:**

1. **Access APEX**: Navigate to `https://apex.oracle.com` or your instance URL

2. **Login Credentials:**
   - Workspace: `TECHNOVA_DEV`
   - Username: (assigned by instructor)
   - Password: (assigned by instructor)

3. **Expected Dashboard View:**
   - App Builder tile (blue)
   - SQL Workshop tile (orange)
   - Team Development tile (green)
   - Gallery tile (purple)

4. **Version Information (typical):**
   - APEX Version: 23.1 or 23.2
   - Database Version: Oracle Database 19c or 21c
   - Instance Type: Workspace-specific

**Verification:**
```sql
SELECT * FROM apex_release;
-- Should show APEX version information
```

**Common Issues & Solutions:**
- **Issue**: "Invalid workspace" error
  - **Solution**: Workspace name is case-sensitive, ensure `TECHNOVA_DEV` is exactly as typed
- **Issue**: "Invalid credentials"
  - **Solution**: Contact instructor for password reset; verify CapsLock is off

---

### Exercise 1.2: Navigate SQL Workshop

**Solution: Test Query**

```sql
SELECT SYSDATE AS current_date,
       USER AS current_user,
       TO_CHAR(SYSDATE, 'Day, DD Month YYYY HH24:MI:SS') AS formatted_date
FROM DUAL;
```

**Expected Output:**
| CURRENT_DATE | CURRENT_USER | FORMATTED_DATE |
|--------------|--------------|----------------|
| 09-NOV-2025 | TECHNOVA_DEV | Saturday , 09 November  2025 14:30:45 |

**Explanation:**
- `SYSDATE`: Oracle function returning current date/time
- `USER`: Returns current schema/workspace name
- `TO_CHAR()`: Formats date with custom pattern
- `DUAL`: Oracle dummy table with single row

---

## Part 2 Solutions: Creating Database Objects

### Exercise 2.1: Create the DEPARTMENTS Table

**Complete Solution:**

```sql
CREATE TABLE departments (
    department_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    department_name   VARCHAR2(100) NOT NULL UNIQUE,
    manager_id        NUMBER,
    budget            NUMBER(12,2),
    location          VARCHAR2(100),
    created_date      DATE DEFAULT SYSDATE,
    created_by        VARCHAR2(100) DEFAULT USER,
    modified_date     DATE,
    modified_by       VARCHAR2(100)
);
```

**Column-by-Column Explanation:**

| Column | Data Type | Constraints | Purpose |
|--------|-----------|-------------|---------|
| department_id | NUMBER | IDENTITY, PK | Auto-incrementing unique identifier |
| department_name | VARCHAR2(100) | NOT NULL, UNIQUE | Department name, cannot be blank or duplicate |
| manager_id | NUMBER | None | FK to employees table (added later) |
| budget | NUMBER(12,2) | None | Budget amount with 2 decimal places |
| location | VARCHAR2(100) | None | Office location (Cape Town, Johannesburg, etc.) |
| created_date | DATE | DEFAULT SYSDATE | Automatic timestamp of record creation |
| created_by | VARCHAR2(100) | DEFAULT USER | Username who created the record |
| modified_date | DATE | None | Timestamp of last modification |
| modified_by | VARCHAR2(100) | None | Username who last modified the record |

**Verification Query:**

```sql
-- Check table exists
SELECT table_name FROM user_tables WHERE table_name = 'DEPARTMENTS';

-- View table structure
DESC departments;

-- View constraints
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'DEPARTMENTS';
```

**Expected Constraints:**
- `SYS_C...`: PRIMARY KEY on department_id
- `SYS_C...`: NOT NULL on department_name
- `SYS_C...`: UNIQUE on department_name

---

### Exercise 2.2: Create the EMPLOYEES Table

**Complete Solution:**

```sql
CREATE TABLE employees (
    employee_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name        VARCHAR2(50) NOT NULL,
    last_name         VARCHAR2(50) NOT NULL,
    email             VARCHAR2(100) NOT NULL UNIQUE,
    phone             VARCHAR2(20),
    hire_date         DATE NOT NULL,
    department_id     NUMBER,
    salary            NUMBER(10,2),
    status            VARCHAR2(20) DEFAULT 'Active' 
                      CHECK (status IN ('Active','Inactive','On Leave','Terminated')),
    created_date      DATE DEFAULT SYSDATE,
    created_by        VARCHAR2(100) DEFAULT USER,
    CONSTRAINT fk_emp_dept FOREIGN KEY (department_id) 
        REFERENCES departments(department_id)
);

-- Create indexes for performance
CREATE INDEX idx_emp_dept ON employees(department_id);
CREATE INDEX idx_emp_name ON employees(last_name, first_name);
CREATE INDEX idx_emp_status ON employees(status);
```

**Key Concepts:**

1. **Foreign Key Relationship:**
   ```
   employees.department_id → departments.department_id
   ```
   - Ensures every employee belongs to a valid department
   - Prevents assigning employee to non-existent department ID
   - Prevents deleting a department with employees (by default)

2. **CHECK Constraint:**
   ```sql
   CHECK (status IN ('Active','Inactive','On Leave','Terminated'))
   ```
   - Limits status values to only these 4 options
   - Any other value will be rejected
   - Ensures data integrity

3. **Index Strategy:**
   - `idx_emp_dept`: Fast lookup by department (used in JOINs)
   - `idx_emp_name`: Fast search by employee name
   - `idx_emp_status`: Fast filtering by status

**Verification:**

```sql
-- Verify foreign key exists
SELECT constraint_name, constraint_type, r_constraint_name
FROM user_constraints
WHERE table_name = 'EMPLOYEES' AND constraint_type = 'R';

-- Test foreign key (should fail with error)
INSERT INTO employees (first_name, last_name, email, hire_date, department_id, salary, status)
VALUES ('Test', 'User', 'test@test.com', SYSDATE, 9999, 50000, 'Active');
-- Expected Error: ORA-02291: integrity constraint violated - parent key not found

-- Verify indexes
SELECT index_name, column_name, column_position
FROM user_ind_columns
WHERE table_name = 'EMPLOYEES'
ORDER BY index_name, column_position;
```

---

### Exercise 2.3: Insert Sample Data

**Complete Solution:**

```sql
-- Insert Departments
INSERT INTO departments (department_name, budget, location) 
VALUES ('Software Development', 2500000, 'Cape Town');

INSERT INTO departments (department_name, budget, location) 
VALUES ('Project Management', 950000, 'Cape Town');

INSERT INTO departments (department_name, budget, location) 
VALUES ('IT Operations', 750000, 'Durban');

INSERT INTO departments (department_name, budget, location) 
VALUES ('Sales & Marketing', 650000, 'Johannesburg');

COMMIT;

-- Verify departments
SELECT department_id, department_name, budget, location, created_date
FROM departments
ORDER BY department_name;
```

**Expected Department Data:**

| DEPARTMENT_ID | DEPARTMENT_NAME | BUDGET | LOCATION |
|---------------|-----------------|--------|----------|
| 2 | IT Operations | 750000 | Durban |
| 1 | Software Development | 2500000 | Cape Town |
| 4 | Project Management | 950000 | Cape Town |
| 3 | Sales & Marketing | 650000 | Johannesburg |

**Insert Employees with PL/SQL:**

```sql
DECLARE
    v_dev_dept NUMBER;
    v_pm_dept NUMBER;
BEGIN
    -- Get department IDs
    SELECT department_id INTO v_dev_dept 
    FROM departments WHERE department_name = 'Software Development';
    
    SELECT department_id INTO v_pm_dept 
    FROM departments WHERE department_name = 'Project Management';
    
    -- Insert project manager
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, 
                           department_id, salary, status)
    VALUES ('Sarah', 'Johnson', 'sarah.johnson@technova.co.za', 
            '+27-21-555-0101', DATE '2015-03-15', v_pm_dept, 145000, 'Active');
    
    -- Insert developers
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, 
                           department_id, salary, status)
    VALUES ('John', 'Smith', 'john.smith@technova.co.za', 
            '+27-21-555-0104', DATE '2018-05-20', v_dev_dept, 95000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, 
                           department_id, salary, status)
    VALUES ('Maria', 'Garcia', 'maria.garcia@technova.co.za', 
            '+27-21-555-0105', DATE '2019-09-14', v_dev_dept, 92000, 'Active');
    
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('3 employees inserted successfully');
END;
/
```

**PL/SQL Explanation:**

1. **DECLARE Section**: Define variables
2. **SELECT INTO**: Retrieve department IDs into variables
3. **INSERT Statements**: Use variables instead of hard-coded IDs
4. **COMMIT**: Make changes permanent
5. **Error Handling**: If department not found, PL/SQL raises NO_DATA_FOUND exception

**Query with JOIN:**

```sql
SELECT e.employee_id,
       e.first_name || ' ' || e.last_name AS employee_name,
       e.email,
       d.department_name,
       e.hire_date,
       TRUNC(MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12, 1) AS years_of_service,
       e.salary,
       TO_CHAR(e.salary, '$999,999.00') AS formatted_salary,
       e.status
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
ORDER BY e.last_name, e.first_name;
```

**Expected Output:**

| EMPLOYEE_NAME | EMAIL | DEPARTMENT_NAME | HIRE_DATE | YEARS_OF_SERVICE | FORMATTED_SALARY | STATUS |
|---------------|-------|-----------------|-----------|------------------|------------------|--------|
| Maria Garcia | maria.garcia@technova.co.za | Software Development | 14-SEP-2019 | 5.2 | $92,000.00 | Active |
| Sarah Johnson | sarah.johnson@technova.co.za | Project Management | 15-MAR-2015 | 9.7 | $145,000.00 | Active |
| John Smith | john.smith@technova.co.za | Software Development | 20-MAY-2018 | 6.5 | $95,000.00 | Active |

---

## Part 3 Solutions: SQL Workshop Exploration

### Exercise 3.1: Use the Data Workshop

**Solution Steps:**

1. **Navigate**: Object Browser > EMPLOYEES table > Data tab

2. **Edit Sarah Johnson's Phone:**
   - Click Edit icon (pencil)
   - Change phone to: `+27-21-555-9999`
   - Click Apply Changes

3. **Insert David Brown:**
   - Click Insert Row
   - Fill in values:
     - First Name: `David`
     - Last Name: `Brown`
     - Email: `david.brown@technova.co.za`
     - Phone: `+27-21-555-0106`
     - Hire Date: `01-FEB-2020`
     - Department ID: `1`
     - Salary: `88000`
     - Status: `Active`
   - Click Create

4. **Verification Query:**
   ```sql
   SELECT * FROM employees WHERE last_name = 'Brown';
   ```

**Note**: Object Browser is convenient for quick edits but SQL is preferred for bulk operations and automation.

---

### Exercise 3.2: Create a View

**Complete Solution:**

```sql
CREATE OR REPLACE VIEW v_employee_details AS
SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.first_name || ' ' || e.last_name AS full_name,
       e.email,
       e.phone,
       e.hire_date,
       TRUNC(MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12, 1) AS years_of_service,
       e.salary,
       e.status,
       d.department_id,
       d.department_name,
       d.location,
       d.budget AS department_budget
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;
```

**Test Queries:**

```sql
-- Simple query - no JOIN needed
SELECT full_name, department_name, years_of_service, salary
FROM v_employee_details
WHERE status = 'Active'
ORDER BY years_of_service DESC;

-- Find employees hired in last 5 years
SELECT full_name, hire_date, years_of_service
FROM v_employee_details
WHERE hire_date >= ADD_MONTHS(SYSDATE, -60)
ORDER BY hire_date DESC;

-- Department summary using view
SELECT department_name,
       COUNT(*) AS employee_count,
       AVG(salary) AS avg_salary,
       SUM(salary) AS total_payroll
FROM v_employee_details
GROUP BY department_name
ORDER BY employee_count DESC;
```

**Why Views Are Powerful:**

1. **Simplification**: Complex JOINs written once, used many times
2. **Security**: Hide sensitive columns (like salary) from certain users
3. **Consistency**: Everyone uses same logic for calculations
4. **Performance**: Database can optimize view queries
5. **Maintainability**: Change view definition, all dependent queries updated

---

## Challenge Exercise Solutions

### Challenge 1: Create a PROJECTS Table

**Solution:**

```sql
CREATE TABLE projects (
    project_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_name      VARCHAR2(200) NOT NULL,
    client_name       VARCHAR2(200),
    start_date        DATE,
    end_date          DATE,
    budget            NUMBER(15,2),
    status            VARCHAR2(20) DEFAULT 'Planning'
                      CHECK (status IN ('Planning','In Progress','Completed','On Hold','Cancelled')),
    created_date      DATE DEFAULT SYSDATE,
    created_by        VARCHAR2(100) DEFAULT USER
);

-- Verify
DESC projects;

-- Test with sample data
INSERT INTO projects (project_name, client_name, start_date, end_date, budget, status)
VALUES ('CRM System', 'TechStart Inc', DATE '2024-11-01', DATE '2025-03-31', 425000, 'Planning');

COMMIT;

SELECT * FROM projects;
```

---

### Challenge 2: Write Complex Queries

**Solution 1: Highest paid employee in each department:**

```sql
SELECT d.department_name,
       e.first_name || ' ' || e.last_name AS employee_name,
       e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary = (
    SELECT MAX(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
)
ORDER BY e.salary DESC;
```

**Alternative using ROW_NUMBER:**

```sql
WITH ranked_employees AS (
    SELECT e.first_name || ' ' || e.last_name AS employee_name,
           d.department_name,
           e.salary,
           ROW_NUMBER() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS rank
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id
)
SELECT department_name, employee_name, salary
FROM ranked_employees
WHERE rank = 1
ORDER BY salary DESC;
```

**Solution 2: Average salary by department:**

```sql
SELECT d.department_name,
       COUNT(e.employee_id) AS employee_count,
       AVG(e.salary) AS avg_salary,
       MIN(e.salary) AS min_salary,
       MAX(e.salary) AS max_salary,
       SUM(e.salary) AS total_payroll
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC NULLS LAST;
```

**Solution 3: Employees hired in last 5 years:**

```sql
SELECT e.first_name || ' ' || e.last_name AS employee_name,
       e.hire_date,
       d.department_name,
       TRUNC(MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12, 1) AS years_of_service,
       e.salary
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE e.hire_date >= ADD_MONTHS(SYSDATE, -60)
ORDER BY e.hire_date DESC;
```

---

### Challenge 3: Create a Stored Procedure

**Solution:**

```sql
CREATE OR REPLACE PROCEDURE add_employee (
    p_first_name    VARCHAR2,
    p_last_name     VARCHAR2,
    p_email         VARCHAR2,
    p_phone         VARCHAR2,
    p_hire_date     DATE,
    p_department_id NUMBER,
    p_salary        NUMBER
) AS
    v_count NUMBER;
BEGIN
    -- Validate department exists
    SELECT COUNT(*) INTO v_count
    FROM departments
    WHERE department_id = p_department_id;
    
    IF v_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid department ID: ' || p_department_id);
    END IF;
    
    -- Insert employee
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, salary, status)
    VALUES (p_first_name, p_last_name, p_email, p_phone, p_hire_date, p_department_id, p_salary, 'Active');
    
    DBMS_OUTPUT.PUT_LINE('Employee ' || p_first_name || ' ' || p_last_name || ' added successfully');
    
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        RAISE_APPLICATION_ERROR(-20002, 'Email already exists: ' || p_email);
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'Error adding employee: ' || SQLERRM);
END;
/

-- Test the procedure
BEGIN
    add_employee('Lisa', 'Anderson', 'lisa.anderson@technova.co.za', 
                 '+27-21-555-0107', SYSDATE, 1, 85000);
    COMMIT;
END;
/

-- Verify
SELECT * FROM employees WHERE last_name = 'Anderson';
```

**Procedure Features:**
- Input parameter validation
- Department existence check
- Error handling for duplicate emails
- Descriptive error messages
- Transaction control with COMMIT in caller

---

## Lab Validation Query

```sql
-- Run this to validate all work is complete
SELECT 'Departments Table' AS object_type, COUNT(*) AS count FROM departments
UNION ALL
SELECT 'Employees Table', COUNT(*) FROM employees
UNION ALL
SELECT 'Indexes on EMPLOYEES', COUNT(*) FROM user_indexes WHERE table_name = 'EMPLOYEES'
UNION ALL
SELECT 'Views Created', COUNT(*) FROM user_views WHERE view_name = 'V_EMPLOYEE_DETAILS';
```

**Expected Results:**
| OBJECT_TYPE | COUNT |
|-------------|-------|
| Departments Table | 4 |
| Employees Table | 4 |
| Indexes on EMPLOYEES | 4 |
| Views Created | 1 |

---

## Key Takeaways

1. **APEX Workspace**: Isolated development environment with dedicated schema
2. **Primary Keys**: IDENTITY columns provide auto-incrementing values
3. **Foreign Keys**: Enforce referential integrity between tables
4. **Indexes**: Improve query performance on frequently searched columns
5. **Views**: Simplify complex queries and provide data security
6. **PL/SQL**: Procedural logic for complex operations
7. **Object Browser**: Quick way to view and edit data graphically
8. **SQL Commands**: Powerful tool for running queries and scripts

---

**End of Lab 01 Solutions**
