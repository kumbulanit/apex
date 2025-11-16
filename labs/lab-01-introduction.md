# Lab 01: Introduction and Getting Started

**Duration:** 60 minutes  
**Difficulty:** Beginner  
**Prerequisites:** None (fresh APEX installation)

## Learning Objectives

By the end of this lab, you will be able to:
1. Navigate the APEX development environment
2. Create and configure a workspace
3. Use SQL Workshop to create database objects
4. Run SQL queries and view data
5. Understand APEX application architecture

---

## Lab Scenario

**🎯 Your Mission:** Build Vodacom's Enterprise Call Center Management Application

You are a new APEX developer at Vodacom, tasked with building a modern **Enterprise Call Center Management System** to replace legacy systems. This is Lab 1 of 7, where you'll create the foundational database structure.

**What You're Building (Complete Application by Lab 7):**
- **Customer Management** - 45M+ customers across South Africa
- **Call Center Operations** - 5,000+ agents, real-time queue management
- **Package Activation** - Mobile data/voice packages
- **Network Operations** - Cell tower monitoring, incident tracking
- **VodaPay Integration** - Mobile money transactions
- **Reporting Dashboard** - Executive KPIs and analytics
- **Security & Compliance** - Role-based access, POPIA compliance

**Business Context:**
- Vodacom serves 45 million customers
- 5,000+ call center agents across multiple locations
- Legacy system can't scale to current demand
- Need web-based, multi-user, real-time system
- Must support mobile access for field technicians
- Goal: Enterprise-grade application for Africa's largest telecom

**This Lab's Focus:** Database foundation (customers, mobile numbers, packages)

---

## Part 1: Exploring the APEX Environment (15 minutes)

### Exercise 1.1: Log In and Navigate the Workspace

**Steps:**

1. **Access APEX Instance**
   - Open your web browser (Chrome, Firefox, or Edge recommended)
   - Navigate to: `https://apex.oracle.com` (or your local APEX instance URL)
   - **What you'll see:** The Oracle APEX home page with a blue "Sign In" button
   - Click "Sign In" in the top right corner

   ```
   📸 SCREENSHOT PLACEHOLDER: APEX login page with "Sign In" button highlighted
   ```

2. **Log In to Your Workspace**
   - **What you'll see:** A login form with three fields
   - Workspace: `TECHNOVA_DEV` ⚠️ **Case-sensitive!**
   - Username: Your assigned username (e.g., `developer01`)
   - Password: Your assigned password
   - Click "Sign In"

   ```
   📸 SCREENSHOT PLACEHOLDER: Login form showing three input fields
   ```

   **💡 Common Mistakes:**
   - ❌ Typing "technova_dev" (lowercase) → Use exact case: `TECHNOVA_DEV`
   - ❌ Forgetting workspace name → This is required, not optional
   - ❌ Using wrong browser → Use Chrome/Firefox/Edge (IE not supported)

3. **Explore the Home Dashboard**
   - **What you'll see:** A page with large, colorful tiles/cards
   - Observe the main sections:
     - **App Builder**: Create and manage applications (🏗️ blue icon)
     - **SQL Workshop**: Database development tools (⚙️ wrench icon)
     - **Team Development**: Project management (👥 people icon)
     - **Gallery**: Pre-built application templates (🎨 gallery icon)
   - **Where to look:** Workspace name appears in the TOP RIGHT corner
   - Click on your username dropdown to see profile options

   ```
   📸 SCREENSHOT PLACEHOLDER: APEX home dashboard with four main tiles labeled
   ```

   **🗺️ Visual Guide:**
   ```
   ┌─────────────────────────────────────┐
   │ APEX Logo    TECHNOVA_DEV [username]│ ← Top Bar
   ├─────────────────────────────────────┤
   │  ┌─────────┐  ┌─────────┐          │
   │  │  App    │  │  SQL    │          │ ← Main Section
   │  │ Builder │  │Workshop │  ...     │
   │  └─────────┘  └─────────┘          │
   └─────────────────────────────────────┘
   ```

4. **Check Workspace Information**
   - Click the **⚙️ icon** (Settings) in the top right
   - Select "About Application Express"
   - Record the following:
     - APEX Version: ____________________
     - Database Version: ____________________
     - Instance Type: ____________________

**Expected Results:**
- ✅ Successfully logged into TECHNOVA_DEV workspace
- ✅ Can see App Builder, SQL Workshop, and other main sections
- ✅ APEX version 23.1 or higher displayed

**Common Issues:**
- If login fails, verify workspace name is correct (case-sensitive)
- If "workspace not found", contact your instructor for workspace creation

---

### Exercise 1.2: Navigate SQL Workshop

**Steps:**

1. **Open SQL Workshop**
   - From the home page, click **SQL Workshop**
   - **What you'll see:** A new page with 5-6 menu options across the top
   - Observe the submenu options:
     - **Object Browser** - View/edit database tables
     - **SQL Commands** - Run SQL queries
     - **SQL Scripts** - Upload/run SQL files
     - **Utilities** - Import data, generate DDL
     - **RESTful Services** - API configuration

   ```
   📸 SCREENSHOT PLACEHOLDER: SQL Workshop main page with top navigation menu
   ```

2. **Explore Object Browser**
   - Click **Object Browser** in the top navigation
   - **What you'll see:** A two-panel layout
     - **LEFT PANEL:** List of object types (like a folder tree)
     - **RIGHT PANEL:** Details of selected object
   - In the left sidebar, you'll see object types:
     - **Tables** - Store data in rows and columns
     - **Views** - Virtual tables based on queries
     - **Indexes** - Speed up searches
     - **Sequences** - Generate unique numbers
     - And more...
   - Since this is a new workspace, it should be mostly empty
   - Click **Tables** - note there may be some APEX system tables (starting with APEX$)

   ```
   📸 SCREENSHOT PLACEHOLDER: Object Browser with left panel showing object types
   ```

   **📚 Glossary:**
   - **Object Browser**: A tool to view/edit database objects (tables, views, etc.)
   - **Table**: A database structure that stores data in rows and columns (like an Excel sheet)
   - **Schema**: A container for database objects (your workspace name is your schema)

3. **Open SQL Commands**
   - Click **SQL Commands** in the top navigation
   - **What you'll see:** A page divided into three horizontal sections
   - This is your SQL query interface (like a mini SQL editor)
   - Note the three sections:
     - **SQL Editor** (top): Where you write queries (text box)
     - **Query Results** (middle): Output appears here (grid/table)
     - **Query History** (bottom): Previously run queries (reference list)

   ```
   📸 SCREENSHOT PLACEHOLDER: SQL Commands interface with three sections labeled
   ```

4. **Test SQL Commands**
   - **What to do:** Click in the SQL Editor text box (top section)
   - **Type EXACTLY as shown** (or copy/paste):
     ```sql
     SELECT SYSDATE AS current_date,
            USER AS current_user,
            TO_CHAR(SYSDATE, 'Day, DD Month YYYY HH24:MI:SS') AS formatted_date
     FROM DUAL;
     ```
   - **How to run:** Click the **Run** button (▶️ icon) OR press **Ctrl+Enter** (Cmd+Enter on Mac)
   - **What you'll see:** A table with 3 columns showing date and username
   - Observe the results displaying current date and your username

   ```
   📸 SCREENSHOT PLACEHOLDER: SQL Commands with query results showing
   ```

   **🔍 Understanding This Query:**
   ```
   SELECT        ← "Give me these columns:"
     SYSDATE,    ← Current date/time from database
     USER        ← Your username
   FROM DUAL     ← Special 1-row table for testing
   ```

**Expected Results:**
- ✅ Can navigate between Object Browser and SQL Commands
- ✅ SQL query executes successfully
- ✅ Results show current date and your username
- ✅ No error messages appear

**💡 Common Errors:**
- ❌ "ORA-00933: SQL command not properly ended" → Missing semicolon at end
- ❌ "ORA-00942: table or view does not exist" → Typo in table name
- ❌ Nothing happens when clicking Run → Make sure cursor is in SQL Editor

**📚 Glossary:**
- **SQL (Structured Query Language)**: Language for talking to databases
- **SELECT**: Command to retrieve data
- **DUAL**: A special Oracle table with 1 row, used for calculations/testing
- **SYSDATE**: Oracle function that returns current date and time

---

## Part 2: Creating Database Objects (25 minutes)

### Exercise 2.1: Create the DEPARTMENTS Table

**Scenario:** You need to create the first table in the TechNova database - the DEPARTMENTS table that will store information about the company's 7 departments.

**Steps:**

1. **Write the CREATE TABLE Statement**
   - In SQL Commands, enter the following SQL:
   
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

2. **Execute the Statement**
   - Click **Run** (or Ctrl+Enter)
   - Look for the success message: "Table created."
   - If you see an error, read it carefully and correct any syntax issues

3. **Verify Table Creation**
   - Click **Object Browser** in the top navigation
   - Click **Tables** in the left sidebar
   - You should see **DEPARTMENTS** in the list
   - Click on **DEPARTMENTS** to view its structure

4. **Examine Table Details**
   - In Object Browser, with DEPARTMENTS selected, observe the tabs:
     - **Columns**: Shows all columns with data types
     - **Data**: View table data (currently empty)
     - **Constraints**: Primary key, unique constraints
     - **Indexes**: Automatically created indexes
     - **SQL**: Shows the CREATE TABLE DDL

**Expected Results:**
- ✅ DEPARTMENTS table created successfully
- ✅ Table visible in Object Browser
- ✅ DEPARTMENT_ID is a primary key with identity column
- ✅ DEPARTMENT_NAME has UNIQUE constraint

**Understanding the Code:**
- `GENERATED ALWAYS AS IDENTITY`: Auto-incrementing number (like AutoNumber in Access)
- `PRIMARY KEY`: Ensures each row is uniquely identifiable
- `NOT NULL`: Field cannot be left empty
- `UNIQUE`: No two departments can have the same name
- `DEFAULT SYSDATE`: Automatically sets creation date
- `DEFAULT USER`: Automatically sets username

---

### Exercise 2.2: Create the EMPLOYEES Table

**Steps:**

1. **Create the EMPLOYEES Table**
   - In SQL Commands, enter:
   
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
   ```

2. **Execute and Verify**
   - Click **Run**
   - Verify "Table created." message
   - Go to Object Browser > Tables > EMPLOYEES

3. **Examine the Foreign Key**
   - Click the **Constraints** tab
   - Find the **FK_EMP_DEPT** constraint
   - Note it references DEPARTMENTS(DEPARTMENT_ID)
   - This creates a relationship: Each employee belongs to one department

4. **Create an Index for Performance**
   - Return to SQL Commands
   - Execute:
   ```sql
   CREATE INDEX idx_emp_dept ON employees(department_id);
   CREATE INDEX idx_emp_name ON employees(last_name, first_name);
   CREATE INDEX idx_emp_status ON employees(status);
   ```
   - Indexes speed up queries on these columns

**Expected Results:**
- ✅ EMPLOYEES table created with foreign key to DEPARTMENTS
- ✅ Three indexes created successfully
- ✅ CHECK constraint ensures status values are valid

**Real-World Impact:**
In the old Access database, there was no referential integrity - employees could reference non-existent departments, causing data quality issues. The foreign key constraint prevents this.

---

### Exercise 2.3: Insert Sample Data

**Steps:**

1. **Insert Departments**
   ```sql
   INSERT INTO departments (department_name, budget, location) 
   VALUES ('Software Development', 2500000, 'Cape Town');
   
   INSERT INTO departments (department_name, budget, location) 
   VALUES ('Project Management', 950000, 'Cape Town');
   
   INSERT INTO departments (department_name, budget, location) 
   VALUES ('IT Operations', 750000, 'Durban');
   
   INSERT INTO departments (department_name, budget, location) 
   VALUES ('Sales & Marketing', 650000, 'Johannesburg');
   
   COMMIT;
   ```

2. **Verify Department Data**
   ```sql
   SELECT department_id, department_name, budget, location, created_date
   FROM departments
   ORDER BY department_name;
   ```
   - You should see 4 departments
   - Note the DEPARTMENT_ID values (1, 2, 3, 4)

3. **Insert Employees**
   ```sql
   -- Get department IDs first
   DECLARE
       v_dev_dept NUMBER;
       v_pm_dept NUMBER;
   BEGIN
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
   END;
   /
   ```

4. **Query Employee Data with Department Names**
   ```sql
   SELECT e.employee_id,
          e.first_name || ' ' || e.last_name AS employee_name,
          e.email,
          d.department_name,
          e.hire_date,
          e.salary,
          e.status
   FROM employees e
   LEFT JOIN departments d ON e.department_id = d.department_id
   ORDER BY e.last_name, e.first_name;
   ```

**Expected Results:**
- ✅ 4 departments inserted
- ✅ 3 employees inserted
- ✅ Query shows employees with their department names (using JOIN)

**Key Learning:**
The JOIN operation combines data from two tables. This replaces the "lookup" queries you may have used in Access.

---

## Part 3: SQL Workshop Exploration (15 minutes)

### Exercise 3.1: Use the Data Workshop

**Steps:**

1. **Navigate to Object Browser**
   - Click SQL Workshop > Object Browser
   - Click on the **EMPLOYEES** table

2. **View and Edit Data Graphically**
   - Click the **Data** tab
   - You should see your 3 employees
   - Click the **Edit** icon (pencil) next to Sarah Johnson
   - Change her phone number to: `+27-21-555-9999`
   - Click **Apply Changes**
   - Observe the data is updated

3. **Add Data Directly**
   - Click the **Insert Row** button
   - Enter a new employee:
     - First Name: `David`
     - Last Name: `Brown`
     - Email: `david.brown@technova.co.za`
     - Phone: `+27-21-555-0106`
     - Hire Date: `01-FEB-2020`
     - Department ID: `1` (Software Development)
     - Salary: `88000`
     - Status: `Active`
   - Click **Create**

4. **Verify with SQL**
   ```sql
   SELECT * FROM employees WHERE last_name = 'Brown';
   ```

**Expected Results:**
- ✅ Successfully edited Sarah's phone number
- ✅ Added David Brown as a new employee
- ✅ Changes reflected in SQL query

---

### Exercise 3.2: Create a View

**Scenario:** Create a view that shows employee information along with department names, making queries easier.

**Steps:**

1. **Create the View**
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
          d.location
   FROM employees e
   LEFT JOIN departments d ON e.department_id = d.department_id;
   ```

2. **Test the View**
   ```sql
   SELECT full_name, 
          department_name, 
          years_of_service,
          salary
   FROM v_employee_details
   WHERE status = 'Active'
   ORDER BY years_of_service DESC;
   ```

3. **Verify in Object Browser**
   - Go to Object Browser
   - Click **Views** in the left sidebar
   - You should see **V_EMPLOYEE_DETAILS**
   - Click on it to see its definition

**Expected Results:**
- ✅ View created successfully
- ✅ Query returns employee data with calculated years of service
- ✅ View visible in Object Browser

**Why Use Views?**
Views simplify complex queries and provide a consistent way to access commonly needed data combinations. In APEX applications, you'll often build reports and forms on views rather than directly on tables.

---

## Part 4: Understanding APEX Architecture (5 minutes)

### Exercise 4.1: Explore Application Builder

**Steps:**

1. **Navigate to App Builder**
   - Click the **APEX** logo (top left) to return to home
   - Click **App Builder**
   - Currently, you have no applications (we'll create one in Lab 2)

2. **Understand the Application Structure**
   - An APEX application consists of:
     - **Pages**: The screens users see
     - **Shared Components**: Reusable elements (navigation, security, etc.)
     - **Supporting Objects**: Database tables, views, packages

3. **Review Workspace Utilities**
   - Click your workspace name dropdown (top right)
   - Select "Manage Workspaces and Users"
   - Observe workspace properties:
     - Workspace name: TECHNOVA_DEV
     - Database schema: Same as workspace name
     - All your tables are stored here

**Understanding:**
- Your workspace is isolated from other workspaces
- All database objects (tables, views) belong to your workspace schema
- Multiple developers can work in the same workspace simultaneously

---

## Lab Summary and Validation

### What You Accomplished

✅ **Environment Setup**
- Logged into APEX workspace
- Navigated SQL Workshop and App Builder
- Understood workspace architecture

✅ **Database Development**
- Created DEPARTMENTS table with identity column
- Created EMPLOYEES table with foreign key relationship
- Created indexes for performance
- Inserted sample data using SQL and PL/SQL
- Created a view for simplified queries

✅ **Skills Developed**
- SQL DDL (CREATE TABLE, CREATE INDEX, CREATE VIEW)
- SQL DML (INSERT, SELECT with JOIN)
- PL/SQL anonymous blocks
- Object Browser navigation
- Understanding of referential integrity

### Validation Checklist

Run this validation query to confirm your work:

```sql
SELECT 'Departments Table' AS object_type, COUNT(*) AS count FROM departments
UNION ALL
SELECT 'Employees Table', COUNT(*) FROM employees
UNION ALL
SELECT 'Indexes on EMPLOYEES', COUNT(*) FROM user_indexes WHERE table_name = 'EMPLOYEES'
UNION ALL
SELECT 'Views Created', COUNT(*) FROM user_views WHERE view_name = 'V_EMPLOYEE_DETAILS';
```

**Expected Results:**
- Departments Table: 4
- Employees Table: 4
- Indexes on EMPLOYEES: 4 (3 manual + 1 PK index)
- Views Created: 1

---

## Challenge Exercises (Optional - 15 minutes)

### Challenge 1: Create a PROJECTS Table

Create a PROJECTS table with the following requirements:
- PROJECT_ID (identity primary key)
- PROJECT_NAME (required, max 200 characters)
- CLIENT_NAME (max 200 characters)
- START_DATE (date)
- END_DATE (date)
- BUDGET (number with 2 decimal places)
- STATUS (must be one of: 'Planning', 'In Progress', 'Completed', 'On Hold')
- Default created_date and created_by fields

**Hint:** Use CHECK constraint for status values, similar to EMPLOYEES table.

### Challenge 2: Write Complex Queries

1. **Find the highest paid employee in each department:**
   ```sql
   -- Your query here
   ```

2. **Calculate average salary by department:**
   ```sql
   -- Your query here
   ```

3. **Find employees hired in the last 5 years:**
   ```sql
   -- Your query here
   ```

### Challenge 3: Create a Stored Procedure

Create a procedure to insert a new employee:

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
BEGIN
    -- Your code here
END;
/
```

Test it:
```sql
BEGIN
    add_employee('Lisa', 'Anderson', 'lisa.anderson@technova.co.za', 
                 '+27-21-555-0107', SYSDATE, 1, 85000);
    COMMIT;
END;
/
```

---

## Troubleshooting Guide

### Issue 1: "Table Already Exists" Error

**Problem:** When running CREATE TABLE, you get "ORA-00955: name is already used by an existing object"

**Solution:**
```sql
-- Drop the table and try again
DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE departments CASCADE CONSTRAINTS;
-- Then re-run CREATE TABLE statements
```

### Issue 2: Foreign Key Violation

**Problem:** When inserting employee, you get "ORA-02291: integrity constraint violated - parent key not found"

**Solution:**
- Ensure the department_id you're using exists in the DEPARTMENTS table
- Query departments first:
  ```sql
  SELECT department_id, department_name FROM departments;
  ```

### Issue 3: Cannot See Tables in Object Browser

**Problem:** Tables don't appear in Object Browser after creation

**Solution:**
- Click the **Refresh** button (circular arrow icon)
- Verify you're looking at "Tables" not "Views"
- Check if there were any errors during CREATE TABLE

### Issue 4: Query Returns No Rows

**Problem:** SELECT returns no data after INSERT

**Solution:**
- You may have forgotten to COMMIT
- Run: `COMMIT;`
- Then re-run your SELECT query

---

## Next Steps

In **Lab 02: Creating Applications**, you will:
- Create your first APEX application using the Create Application Wizard
- Build an application from a spreadsheet
- Use application blueprints
- Understand application structure and pages

**Preparation:**
- Keep your database objects (they'll be used in Lab 02)
- Review the concepts: primary keys, foreign keys, views
- Think about what kind of application would benefit TechNova's employees

---

## Additional Resources

**SQL Reference:**
- Oracle SQL Language Reference: https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/
- SQL Workshop Documentation: Access via Help menu in APEX

**Practice Queries:**
Try these to deepen your SQL skills:
```sql
-- Count employees by department
SELECT d.department_name, COUNT(e.employee_id) AS emp_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Find departments with no employees
SELECT d.department_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
WHERE e.employee_id IS NULL;

-- Calculate total payroll by department
SELECT d.department_name, 
       SUM(e.salary) AS total_payroll,
       AVG(e.salary) AS avg_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY total_payroll DESC;
```

---

**End of Lab 01**

**Time to Complete:** 60 minutes  
**Files Created:** 2 tables, 3 indexes, 1 view  
**Records Inserted:** 4 departments, 4 employees

**Instructor Sign-off:** ________________  Date: ________
