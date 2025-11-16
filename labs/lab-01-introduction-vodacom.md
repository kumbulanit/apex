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

You are a new developer at Vodacom, tasked with creating a modern customer management system to support the company's rapidly growing customer base. Your first assignment is to set up your development environment and create the foundational database structure for the Customer Service Portal.

**Business Context:**
- Vodacom serves over 45 million customers across South Africa
- Current legacy systems have scalability limitations
- Customer service reps need real-time access to customer information
- Support for multiple channels: stores, call centers, mobile app
- Integration needed for prepaid, postpaid, and VodaPay services
- Goal: Build a modern, web-based, scalable customer management system

---

## Part 1: Exploring the APEX Environment (15 minutes)

### Exercise 1.1: Log In and Navigate the Workspace

**Steps:**

1. **Access APEX Instance**
   
   📸 **Visual Guide:**
   - Open your web browser (Chrome, Firefox, or Edge recommended)
   - Navigate to: `https://apex.oracle.com` (or your local APEX instance URL)
   - You will see the Oracle APEX homepage
   
   **What You'll See:**
   ```
   ┌─────────────────────────────────────────────────────────┐
   │  Oracle APEX                      [Get Started] [Sign In]│
   │                                                          │
   │  Build Enterprise Apps                                  │
   │  ━━━━━━━━━━━━━━━━━                                      │
   │  Low-Code Development Platform                          │
   └─────────────────────────────────────────────────────────┘
   ```
   
   - Click the blue **"Sign In"** button in the top right corner
   
   🔗 **Reference Screenshot:** See [APEX Login Page](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/img/sign_in.png)

2. **Log In to Your Workspace**
   
   📸 **Visual Guide:**
   
   **What You'll See - Login Form:**
   ```
   ┌─────────────────────────────────────┐
   │   🔷 Oracle Application Express     │
   │                                     │
   │   Workspace: [____________]         │
   │   Username:  [____________]         │
   │   Password:  [____________]         │
   │   Remember workspace               │
   │                                     │
   │        [Sign In]                   │
   └─────────────────────────────────────┘
   ```
   
   **Step-by-Step:**
   - ① In the **Workspace** field, type: `VODACOM_DEV`
     - ⚠️ Note: This is case-sensitive!
   - ② In the **Username** field, type your assigned username (e.g., `developer01`)
   - ③ In the **Password** field, type your assigned password
   - ④ Optional: Check "Remember workspace" to save the workspace name
   - ⑤ Click the blue **"Sign In"** button
   
   🔗 **Reference Screenshot:** See [Workspace Sign In](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/img/workspace_signin.png)

3. **Explore the Home Dashboard**
   
   📸 **Visual Guide - APEX Home Page:**
   
   **What You'll See After Login:**
   ```
   ┌─────────────────────────────────────────────────────────────────┐
   │ 🔷 Oracle APEX    VODACOM_DEV                    developer01 ▾  │
   ├─────────────────────────────────────────────────────────────────┤
   │                                                                  │
   │  Welcome to Application Express                                 │
   │                                                                  │
   │  ┌───────────────┐  ┌───────────────┐  ┌──────────────────┐   │
   │  │ 📱 App Builder│  │ 🔧 SQL Workshop│  │ 👥 Team Development│  │
   │  │               │  │                │  │                  │   │
   │  │ Create and    │  │ Database       │  │ Track projects   │   │
   │  │ manage apps   │  │ development    │  │ and milestones  │   │
   │  └───────────────┘  └───────────────┘  └──────────────────┘   │
   │                                                                  │
   │  ┌───────────────┐  ┌───────────────┐  ┌──────────────────┐   │
   │  │ 🎨 Gallery    │  │ 📦 Packaged   │  │ 📚 Documentation│   │
   │  │               │  │    Apps        │  │                  │   │
   │  │ Sample apps   │  │ Ready-to-use  │  │ Help & guides   │   │
   │  │ and templates │  │ applications   │  │                  │   │
   │  └───────────────┘  └───────────────┘  └──────────────────┘   │
   └─────────────────────────────────────────────────────────────────┘
   ```
   
   **Step-by-Step Exploration:**
   
   - ① **Observe the top navigation bar:**
     - Left side: Oracle APEX logo (click to return home)
     - Center: Workspace name `VODACOM_DEV` (you're in the right place!)
     - Right side: Your username `developer01` with dropdown arrow ▾
   
   - ② **Identify the six main sections** (tiles/cards):
     
     📱 **App Builder** (Top Left)
     - Purpose: Create and manage applications
     - Color: Blue icon
     - This is where you'll build your apps!
     
     🔧 **SQL Workshop** (Top Center)
     - Purpose: Database development tools
     - Color: Orange/Red icon
     - This is where you'll create tables and run SQL
     
     👥 **Team Development** (Top Right)
     - Purpose: Project management and tracking
     - Color: Purple icon
     - Track bugs, features, and milestones
     
     🎨 **Gallery** (Bottom Left)
     - Purpose: Pre-built sample applications
     - Color: Green icon
     - Learn from example apps
     
     📦 **Packaged Apps** (Bottom Center)
     - Purpose: Production-ready applications
     - Color: Blue icon
     - Install complete applications
     
     📚 **Documentation** (Bottom Right)
     - Purpose: Help and learning resources
     - Access guides and tutorials
   
   - ③ **Check your workspace indicator:**
     - Look at the top center of the page
     - You should see: `VODACOM_DEV`
     - ✅ This confirms you're in the correct workspace
   
   - ④ **Explore your user menu:**
     - Click on your username (`developer01 ▾`) in the top right
     - You'll see a dropdown with options:
       - Set Preferences
       - Edit My Profile
       - Feedback
       - Sign Out
     - Click elsewhere to close the dropdown
   
   🔗 **Reference Screenshots:** 
   - [APEX Home Page](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/img/apex_home.png)
   - [Navigation Overview](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/understanding-app-builder.html)

4. **Check Workspace Information**
   
   📸 **Visual Guide:**
   
   **Step-by-Step:**
   
   - ① **Locate the Settings icon:**
     - Look at the top-right corner of the page
     - You'll see: `[VODACOM_DEV] [developer01 ▾] [⚙️ Settings]`
     - The ⚙️ is a gear/cog icon
   
   - ② **Open Settings menu:**
     - Click the **⚙️ icon** (gear icon)
     - A dropdown menu appears with options:
       ```
       ┌─────────────────────────────┐
       │ ⚙️ Settings               │
       ├─────────────────────────────┤
       │ Manage Workspace         │
       │ SQL Workshop Preferences │
       │ About Application Express│  ← Click this
       └─────────────────────────────┘
       ```
   
   - ③ **Click "About Application Express":**
     - A modal dialog will appear
   
   - ④ **View and Record Version Information:**
     ```
     ┌──────────────────────────────────────────┐
     │ About Oracle Application Express         │
     ├──────────────────────────────────────────┤
     │                                          │
     │ Version: 23.1.0                          │
     │ Database: Oracle Database 19c            │
     │ Instance: apex.oracle.com                │
     │                                          │
     │           [Close]                        │
     └──────────────────────────────────────────┘
     ```
   
   - ⑤ **Record the following information in your lab notes:**
     - APEX Version: ___23.1.0___ (or your version)
     - Database Version: ___Oracle Database 19c___ (or your version)
     - Instance Type: ___apex.oracle.com___ (or your instance)
   
   - ⑥ **Close the dialog:**
     - Click the **"Close"** button or click outside the dialog
   
   🔗 **Reference:** [About APEX Dialog](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/getting-started.html)

**Expected Results:**
- ✅ Successfully logged into VODACOM_DEV workspace
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
   - Observe the submenu options:
     - Object Browser
     - SQL Commands
     - SQL Scripts
     - Utilities
     - RESTful Services

2. **Explore Object Browser**
   - Click **Object Browser**
   - In the left sidebar, you'll see object types:
     - Tables
     - Views
     - Indexes
     - Sequences
     - etc.
   - Since this is a new workspace, it should be mostly empty
   - Click **Tables** - note there may be some APEX system tables

3. **Open SQL Commands**
   - Click **SQL Commands** in the top navigation
   - This is your SQL query interface
   - Note the three sections:
     - **SQL Editor** (top): Where you write queries
     - **Query Results** (middle): Output appears here
     - **Query History** (bottom): Previously run queries

4. **Test SQL Commands**
   - In the SQL Editor, type:
     ```sql
     SELECT SYSDATE AS current_date,
            USER AS current_user,
            TO_CHAR(SYSDATE, 'Day, DD Month YYYY HH24:MI:SS') AS formatted_date
     FROM DUAL;
     ```
   - Click **Run** (or press Ctrl+Enter)
   - Observe the results displaying current date and your username

**Expected Results:**
- ✅ Can navigate between Object Browser and SQL Commands
- ✅ SQL query executes successfully
- ✅ Results show current date and your username

**Knowledge Check:**
- **Q:** What is the DUAL table?
- **A:** DUAL is a special one-row, one-column table in Oracle used for selecting expressions or testing functions

---

## Part 2: Creating Database Objects (25 minutes)

### Exercise 2.1: Create the VODACOM_DEPARTMENTS Table

**Scenario:** You need to create the first table in the Vodacom database - the DEPARTMENTS table that will store information about Vodacom's operational departments (Customer Service, Network Operations, Sales, VodaPay, etc.).

**Steps:**

1. **Write the CREATE TABLE Statement**
   - In SQL Commands, enter the following SQL:
   
   ```sql
   CREATE TABLE vodacom_departments (
       dept_id           NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
       dept_name         VARCHAR2(100) NOT NULL UNIQUE,
       dept_code         VARCHAR2(20) NOT NULL UNIQUE,
       manager_id        NUMBER,
       budget            NUMBER(14,2),
       location          VARCHAR2(100),
       cost_center       VARCHAR2(50),
       is_active         VARCHAR2(1) DEFAULT 'Y' CHECK (is_active IN ('Y','N')),
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
   - You should see **VODACOM_DEPARTMENTS** in the list
   - Click on **VODACOM_DEPARTMENTS** to view its structure

4. **Examine Table Details**
   - In Object Browser, with VODACOM_DEPARTMENTS selected, observe the tabs:
     - **Columns**: Shows all columns with data types
     - **Data**: View table data (currently empty)
     - **Constraints**: Primary key, unique constraints
     - **Indexes**: Automatically created indexes
     - **SQL**: Shows the CREATE TABLE DDL

**Expected Results:**
- ✅ VODACOM_DEPARTMENTS table created successfully
- ✅ Table visible in Object Browser
- ✅ DEPT_ID is a primary key with identity column
- ✅ DEPT_NAME and DEPT_CODE have UNIQUE constraints

**Understanding the Code:**
- `GENERATED ALWAYS AS IDENTITY`: Auto-incrementing number for unique department IDs
- `PRIMARY KEY`: Ensures each row is uniquely identifiable
- `NOT NULL`: Field cannot be left empty
- `UNIQUE`: No two departments can have the same name or code
- `DEFAULT SYSDATE`: Automatically sets creation date
- `DEFAULT USER`: Automatically sets username
- `CHECK (is_active IN ('Y','N'))`: Ensures only valid values

---

### Exercise 2.2: Create the VODACOM_CUSTOMERS Table

**Steps:**

1. **Create the VODACOM_CUSTOMERS Table**
   - In SQL Commands, enter:
   
   ```sql
   CREATE TABLE vodacom_customers (
       customer_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
       account_number    VARCHAR2(20) NOT NULL UNIQUE,
       first_name        VARCHAR2(50) NOT NULL,
       last_name         VARCHAR2(50) NOT NULL,
       id_number         VARCHAR2(20) NOT NULL UNIQUE,
       email             VARCHAR2(100),
       phone             VARCHAR2(20) NOT NULL,
       alternate_phone   VARCHAR2(20),
       address_line1     VARCHAR2(200),
       address_line2     VARCHAR2(200),
       city              VARCHAR2(100),
       province          VARCHAR2(50),
       postal_code       VARCHAR2(10),
       customer_type     VARCHAR2(20) DEFAULT 'Individual' 
                         CHECK (customer_type IN ('Individual','Business','Corporate','Government')),
       account_status    VARCHAR2(20) DEFAULT 'Active' 
                         CHECK (account_status IN ('Active','Suspended','Closed','Blacklisted')),
       credit_limit      NUMBER(10,2) DEFAULT 0,
       registration_date DATE DEFAULT SYSDATE,
       last_updated      DATE,
       vodapay_active    VARCHAR2(1) DEFAULT 'N' CHECK (vodapay_active IN ('Y','N')),
       created_date      DATE DEFAULT SYSDATE,
       created_by        VARCHAR2(100) DEFAULT USER
   );
   ```

2. **Execute and Verify**
   - Click **Run**
   - Verify "Table created." message
   - Go to Object Browser > Tables > VODACOM_CUSTOMERS

3. **Understand the Table Structure**
   - Click the **Columns** tab
   - Note the CHECK constraints on customer_type and account_status
   - These ensure data quality by restricting values to valid options
   - ACCOUNT_NUMBER and ID_NUMBER have UNIQUE constraints

4. **Create Indexes for Performance**
   - Return to SQL Commands
   - Execute:
   ```sql
   CREATE INDEX idx_cust_status ON vodacom_customers(account_status);
   CREATE INDEX idx_cust_type ON vodacom_customers(customer_type);
   CREATE INDEX idx_cust_name ON vodacom_customers(last_name, first_name);
   CREATE INDEX idx_cust_idnum ON vodacom_customers(id_number);
   ```
   - Indexes speed up searches on frequently queried columns

**Expected Results:**
- ✅ VODACOM_CUSTOMERS table created successfully
- ✅ Four indexes created for optimal query performance
- ✅ CHECK constraints ensure valid customer types and account statuses

**Real-World Impact:**
This table will store millions of customer records. The indexes are critical for fast customer lookups when service representatives need to quickly access customer information during calls or at retail locations.

---

### Exercise 2.3: Insert Sample Data

**Steps:**

1. **Insert Departments**
   ```sql
   INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) 
   VALUES ('Customer Service', 'CS', 15000000, 'Midrand', 'CC-CS-001');
   
   INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) 
   VALUES ('Network Operations', 'NO', 50000000, 'Midrand', 'CC-NO-001');
   
   INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) 
   VALUES ('Sales and Distribution', 'SD', 25000000, 'Johannesburg', 'CC-SD-001');
   
   INSERT INTO vodacom_departments (dept_name, dept_code, budget, location, cost_center) 
   VALUES ('VodaPay Division', 'VP', 30000000, 'Cape Town', 'CC-VP-001');
   
   COMMIT;
   ```

2. **Verify Department Data**
   ```sql
   SELECT dept_id, dept_name, dept_code, budget, location, created_date
   FROM vodacom_departments
   ORDER BY dept_name;
   ```
   - You should see 4 departments
   - Note the DEPT_ID values (1, 2, 3, 4)
   - Observe budget amounts in Rands (ZAR)

3. **Insert Customers**
   ```sql
   -- Insert individual prepaid customer
   INSERT INTO vodacom_customers 
       (account_number, first_name, last_name, id_number, email, phone, 
        address_line1, city, province, postal_code, customer_type, 
        account_status, vodapay_active)
   VALUES 
       ('VDC-ACC-100001', 'Palesa', 'Mokoena', '9901010000088', 
        'palesa.mokoena@email.com', '0821110001', '45 Oxford Road', 
        'Johannesburg', 'Gauteng', '2196', 'Individual', 'Active', 'Y');
   
   -- Insert individual postpaid customer
   INSERT INTO vodacom_customers 
       (account_number, first_name, last_name, id_number, email, phone, 
        address_line1, city, province, postal_code, customer_type, 
        account_status, credit_limit, vodapay_active)
   VALUES 
       ('VDC-ACC-100002', 'Thulani', 'Ngubane', '9902020000089', 
        'thulani.ngubane@email.com', '0831110002', '12 Smith Street', 
        'Durban', 'KwaZulu-Natal', '4001', 'Individual', 'Active', 3000, 'Y');
   
   -- Insert business customer
   INSERT INTO vodacom_customers 
       (account_number, first_name, last_name, id_number, email, phone, 
        address_line1, city, province, postal_code, customer_type, 
        account_status, credit_limit, vodapay_active)
   VALUES 
       ('VDC-ACC-200001', 'ABC Trading PTY LTD', '', '2015/123456/07', 
        'accounts@abctrading.co.za', '0115551234', '100 Rivonia Road', 
        'Sandton', 'Gauteng', '2196', 'Business', 'Active', 50000, 'Y');
   
   -- Insert another individual customer
   INSERT INTO vodacom_customers 
       (account_number, first_name, last_name, id_number, email, phone, 
        address_line1, city, province, postal_code, customer_type, 
        account_status, credit_limit, vodapay_active)
   VALUES 
       ('VDC-ACC-100003', 'Mbali', 'Dlamini', '9903030000083', 
        'mbali.dlamini@email.com', '0761110003', '78 Long Street', 
        'Cape Town', 'Western Cape', '8001', 'Individual', 'Active', 8000, 'Y');
   
   COMMIT;
   ```

4. **Query Customer Data with Enhanced Information**
   ```sql
   SELECT customer_id,
          account_number,
          first_name || ' ' || last_name AS customer_name,
          phone,
          city,
          province,
          customer_type,
          account_status,
          CASE WHEN vodapay_active = 'Y' THEN 'Yes' ELSE 'No' END AS vodapay_user,
          credit_limit,
          registration_date
   FROM vodacom_customers
   ORDER BY registration_date DESC;
   ```

**Expected Results:**
- ✅ 4 departments inserted (Customer Service, Network Ops, Sales, VodaPay)
- ✅ 4 customers inserted (3 individuals, 1 business)
- ✅ Query shows customers with formatted information
- ✅ VodaPay activation status clearly displayed

**Key Learning:**
The South African ID numbers (13 digits) and company registration numbers have specific formats that help verify customer authenticity. In a production system, these would be validated against Home Affairs or CIPC databases.

---

## Part 3: SQL Workshop Exploration (15 minutes)

### Exercise 3.1: Use the Data Workshop

**Steps:**

1. **Navigate to Object Browser**
   - Click SQL Workshop > Object Browser
   - Click on the **VODACOM_CUSTOMERS** table

2. **View and Edit Data Graphically**
   - Click the **Data** tab
   - You should see your 4 customers
   - Click the **Edit** icon (pencil) next to Palesa Mokoena
   - Change her phone number to: `0821110099`
   - Click **Apply Changes**
   - Observe the data is updated

3. **Add Data Directly**
   - Click the **Insert Row** button
   - Enter a new customer:
     - Account Number: `VDC-ACC-100004`
     - First Name: `Sipho`
     - Last Name: `Khumalo`
     - ID Number: `9904040000084`
     - Email: `sipho.khumalo@email.com`
     - Phone: `0731110004`
     - Address Line 1: `23 Church Street`
     - City: `Pretoria`
     - Province: `Gauteng`
     - Postal Code: `0002`
     - Customer Type: `Individual`
     - Account Status: `Active`
     - Credit Limit: `4000`
     - VodaPay Active: `N`
   - Click **Create**

4. **Verify with SQL**
   ```sql
   SELECT * FROM vodacom_customers WHERE last_name = 'Khumalo';
   ```

**Expected Results:**
- ✅ Successfully edited Palesa's phone number
- ✅ Added Sipho Khumalo as a new customer
- ✅ Changes reflected in SQL query
- ✅ All constraints enforced (unique account number, valid status, etc.)

---

### Exercise 3.2: Create a View for Customer Service Reps

**Scenario:** Create a view that shows essential customer information in a format optimized for customer service representatives who need quick access to customer details.

**Steps:**

1. **Create the View**
   ```sql
   CREATE OR REPLACE VIEW v_customer_service_view AS
   SELECT c.customer_id,
          c.account_number,
          c.first_name,
          c.last_name,
          c.first_name || ' ' || c.last_name AS full_name,
          c.id_number,
          c.email,
          c.phone,
          c.alternate_phone,
          c.address_line1 || ', ' || c.city || ', ' || c.province || ' ' || c.postal_code AS full_address,
          c.city,
          c.province,
          c.customer_type,
          c.account_status,
          CASE c.account_status
              WHEN 'Active' THEN '✓ Active'
              WHEN 'Suspended' THEN '⚠ Suspended'
              WHEN 'Closed' THEN '✗ Closed'
              WHEN 'Blacklisted' THEN '⛔ Blacklisted'
          END AS status_display,
          c.credit_limit,
          CASE WHEN c.vodapay_active = 'Y' THEN 'Yes' ELSE 'No' END AS vodapay_enabled,
          c.registration_date,
          TRUNC(SYSDATE - c.registration_date) AS days_as_customer,
          TRUNC((SYSDATE - c.registration_date) / 365.25, 1) AS years_as_customer
   FROM vodacom_customers c;
   ```

2. **Test the View**
   ```sql
   SELECT full_name, 
          phone, 
          city,
          customer_type,
          status_display,
          vodapay_enabled,
          years_as_customer
   FROM v_customer_service_view
   WHERE account_status = 'Active'
   ORDER BY years_as_customer DESC;
   ```

3. **Advanced Query: Find VodaPay Users in Gauteng**
   ```sql
   SELECT full_name,
          phone,
          city,
          vodapay_enabled,
          credit_limit
   FROM v_customer_service_view
   WHERE province = 'Gauteng'
     AND vodapay_enabled = 'Yes'
   ORDER BY credit_limit DESC;
   ```

4. **Verify in Object Browser**
   - Go to Object Browser
   - Click **Views** in the left sidebar
   - You should see **V_CUSTOMER_SERVICE_VIEW**
   - Click on it to see its definition

**Expected Results:**
- ✅ View created successfully
- ✅ Query returns customer data with calculated fields
- ✅ Status display shows user-friendly symbols
- ✅ View visible in Object Browser

**Why This View is Important:**
Customer service representatives answer hundreds of calls per day. This view provides all essential information in one query, reducing the time needed to help customers. The calculated fields (years as customer, formatted address) eliminate repetitive formatting in application code.

---

### Exercise 3.3: Create a Mobile Numbers Table (Advanced)

**Scenario:** Customers can have multiple mobile numbers (personal, business, IoT devices). Create a child table to track all mobile numbers associated with a customer.

**Steps:**

1. **Create the Mobile Numbers Table**
   ```sql
   CREATE TABLE vodacom_mobile_numbers (
       number_id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
       mobile_number     VARCHAR2(20) NOT NULL UNIQUE,
       customer_id       NUMBER NOT NULL,
       number_type       VARCHAR2(20) DEFAULT 'Prepaid' 
                         CHECK (number_type IN ('Prepaid','Postpaid','Contract')),
       sim_card_number   VARCHAR2(50) UNIQUE,
       activation_date   DATE NOT NULL,
       status            VARCHAR2(20) DEFAULT 'Active' 
                         CHECK (status IN ('Active','Suspended','Deactivated','Ported Out')),
       data_balance_mb   NUMBER(10,2) DEFAULT 0,
       airtime_balance   NUMBER(8,2) DEFAULT 0,
       sms_balance       NUMBER(6,0) DEFAULT 0,
       created_date      DATE DEFAULT SYSDATE,
       CONSTRAINT fk_num_customer FOREIGN KEY (customer_id) 
           REFERENCES vodacom_customers(customer_id)
   );
   
   CREATE INDEX idx_num_customer ON vodacom_mobile_numbers(customer_id);
   CREATE INDEX idx_num_status ON vodacom_mobile_numbers(status);
   ```

2. **Insert Sample Mobile Numbers**
   ```sql
   -- Palesa's prepaid number
   INSERT INTO vodacom_mobile_numbers 
       (mobile_number, customer_id, number_type, sim_card_number, 
        activation_date, data_balance_mb, airtime_balance, sms_balance)
   VALUES ('0821110001', 1, 'Prepaid', 'SIM-8927100000000000001', 
           DATE '2022-01-15', 850, 45.50, 25);
   
   -- Thulani's postpaid number
   INSERT INTO vodacom_mobile_numbers 
       (mobile_number, customer_id, number_type, sim_card_number, 
        activation_date, data_balance_mb, airtime_balance, sms_balance)
   VALUES ('0831110002', 2, 'Postpaid', 'SIM-8927100000000000002', 
           DATE '2021-06-20', 2048, 0, 0);
   
   -- Mbali's contract number
   INSERT INTO vodacom_mobile_numbers 
       (mobile_number, customer_id, number_type, sim_card_number, 
        activation_date, data_balance_mb, airtime_balance, sms_balance)
   VALUES ('0761110003', 4, 'Contract', 'SIM-8927100000000000003', 
           DATE '2020-11-10', 5120, 0, 0);
   
   COMMIT;
   ```

3. **Query Customers with Their Mobile Numbers**
   ```sql
   SELECT c.account_number,
          c.first_name || ' ' || c.last_name AS customer_name,
          m.mobile_number,
          m.number_type,
          m.status,
          m.data_balance_mb || ' MB' AS data_balance,
          'R' || TO_CHAR(m.airtime_balance, '999.99') AS airtime_balance,
          m.sms_balance || ' SMS' AS sms_remaining
   FROM vodacom_customers c
   LEFT JOIN vodacom_mobile_numbers m ON c.customer_id = m.customer_id
   ORDER BY c.last_name, m.mobile_number;
   ```

**Expected Results:**
- ✅ VODACOM_MOBILE_NUMBERS table created with foreign key
- ✅ 3 mobile numbers linked to customers
- ✅ Query shows customers with their balances
- ✅ Foreign key prevents orphaned mobile numbers

**Real-World Scenario:**
A customer calls: "My data is finished, can you check my balance?"  
The service rep queries this table to instantly see: 850 MB data, R45.50 airtime, 25 SMS remaining.

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
     - **Pages**: The screens users see (customer lookup, add customer, reports)
     - **Shared Components**: Reusable elements (navigation, security, LOVs)
     - **Supporting Objects**: Database tables, views, packages

3. **Review Workspace Utilities**
   - Click your workspace name dropdown (top right)
   - Select "Manage Workspaces and Users"
   - Observe workspace properties:
     - Workspace name: VODACOM_DEV
     - Database schema: Same as workspace name
     - All your tables are stored here

**Understanding:**
- Your workspace is isolated from other workspaces (security)
- All database objects (tables, views) belong to your workspace schema
- Multiple developers can work in the same workspace simultaneously
- In production, Vodacom would have separate workspaces for DEV, TEST, and PROD

---

## Lab Summary and Validation

### What You Accomplished

✅ **Environment Setup**
- Logged into APEX workspace (VODACOM_DEV)
- Navigated SQL Workshop and App Builder
- Understood workspace architecture

✅ **Database Development**
- Created VODACOM_DEPARTMENTS table with identity column
- Created VODACOM_CUSTOMERS table with business rules (check constraints)
- Created VODACOM_MOBILE_NUMBERS table with foreign key relationship
- Created indexes for performance optimization
- Inserted sample data for departments, customers, and mobile numbers
- Created a view for customer service operations

✅ **Skills Developed**
- SQL DDL (CREATE TABLE, CREATE INDEX, CREATE VIEW)
- SQL DML (INSERT, SELECT with JOIN)
- Understanding of referential integrity (foreign keys)
- Business rules implementation (check constraints)
- Object Browser navigation and data editing
- Performance optimization with indexes

### Validation Checklist

Run this validation query to confirm your work:

```sql
SELECT 'Departments Table' AS object_type, COUNT(*) AS count 
FROM vodacom_departments
UNION ALL
SELECT 'Customers Table', COUNT(*) FROM vodacom_customers
UNION ALL
SELECT 'Mobile Numbers Table', COUNT(*) FROM vodacom_mobile_numbers
UNION ALL
SELECT 'Indexes on CUSTOMERS', COUNT(*) 
FROM user_indexes WHERE table_name = 'VODACOM_CUSTOMERS'
UNION ALL
SELECT 'Views Created', COUNT(*) 
FROM user_views WHERE view_name = 'V_CUSTOMER_SERVICE_VIEW';
```

**Expected Results:**
- Departments Table: 4
- Customers Table: 5
- Mobile Numbers Table: 3
- Indexes on CUSTOMERS: 5 (4 manual + 1 PK index)
- Views Created: 1

---

## Challenge Exercises (Optional - 15 minutes)

### Challenge 1: Create a DATA_PACKAGES Table

Create a DATA_PACKAGES table to store Vodacom's data bundle offerings:
- PACKAGE_ID (identity primary key)
- PACKAGE_CODE (required, unique, max 20 characters) - e.g., 'DATA-DAILY-250'
- PACKAGE_NAME (required, max 100 characters) - e.g., 'Daily 250MB'
- DATA_ALLOCATION_MB (number with 2 decimals) - e.g., 250.00
- PRICE (number with 2 decimals) - e.g., 25.00
- VALIDITY_DAYS (number) - e.g., 1 for daily, 30 for monthly
- IS_ACTIVE (Y/N check constraint)
- Default created_date and created_by fields

**Hint:** Use CHECK constraint for is_active, similar to other tables.

**Sample Data to Insert:**
```sql
INSERT INTO data_packages (package_code, package_name, data_allocation_mb, price, validity_days)
VALUES ('DATA-DAILY-250', 'Daily 250MB', 250, 25, 1);

INSERT INTO data_packages (package_code, package_name, data_allocation_mb, price, validity_days)
VALUES ('DATA-WEEKLY-1G', 'Weekly 1GB', 1024, 75, 7);

INSERT INTO data_packages (package_code, package_name, data_allocation_mb, price, validity_days)
VALUES ('DATA-MONTHLY-5G', 'Monthly 5GB', 5120, 499, 30);
```

### Challenge 2: Write Business Intelligence Queries

1. **Find customers with VodaPay active in each province:**
   ```sql
   -- Your query here
   -- Should show province name and count of VodaPay users
   ```

2. **Calculate total data balance and airtime across all customers:**
   ```sql
   -- Your query here
   -- Should show sum of data_balance_mb and airtime_balance
   ```

3. **Find customers with multiple mobile numbers:**
   ```sql
   -- Your query here
   -- Should show customer name and count of numbers
   ```

### Challenge 3: Create a Stored Function

Create a function to check if a customer is eligible for a postpaid upgrade (requires 6+ months as customer and Active status):

```sql
CREATE OR REPLACE FUNCTION is_upgrade_eligible (
    p_customer_id NUMBER
) RETURN VARCHAR2
AS
    v_status VARCHAR2(20);
    v_reg_date DATE;
    v_months_active NUMBER;
BEGIN
    -- Your code here
    -- Return 'ELIGIBLE' or 'NOT ELIGIBLE'
END;
/
```

Test it:
```sql
SELECT account_number,
       first_name || ' ' || last_name AS customer_name,
       is_upgrade_eligible(customer_id) AS upgrade_status
FROM vodacom_customers;
```

---

## Troubleshooting Guide

### Issue 1: "Table Already Exists" Error

**Problem:** When running CREATE TABLE, you get "ORA-00955: name is already used by an existing object"

**Solution:**
```sql
-- Drop the tables in correct order (child tables first)
DROP TABLE vodacom_mobile_numbers CASCADE CONSTRAINTS;
DROP TABLE vodacom_customers CASCADE CONSTRAINTS;
DROP TABLE vodacom_departments CASCADE CONSTRAINTS;
-- Then re-run CREATE TABLE statements
```

### Issue 2: Foreign Key Violation

**Problem:** When inserting mobile number, you get "ORA-02291: integrity constraint violated - parent key not found"

**Solution:**
- Ensure the customer_id you're using exists in VODACOM_CUSTOMERS table
- Query customers first:
  ```sql
  SELECT customer_id, account_number, first_name, last_name 
  FROM vodacom_customers;
  ```

### Issue 3: Check Constraint Violation

**Problem:** "ORA-02290: check constraint violated" when inserting customer

**Solution:**
- Verify account_status is one of: 'Active', 'Suspended', 'Closed', 'Blacklisted'
- Verify customer_type is one of: 'Individual', 'Business', 'Corporate', 'Government'
- Check that vodapay_active is 'Y' or 'N' (not 'Yes' or 'No')

### Issue 4: Cannot See Tables in Object Browser

**Problem:** Tables don't appear in Object Browser after creation

**Solution:**
- Click the **Refresh** button (circular arrow icon)
- Verify you're looking at "Tables" not "Views"
- Check if there were any errors during CREATE TABLE

### Issue 5: South African ID Number Format

**Problem:** Confused about ID number format

**Solution:**
- South African ID numbers are 13 digits: YYMMDD SSSS C A Z
  - YYMMDD: Date of birth
  - SSSS: Sequence number
  - C: Citizenship (0=SA, 1=non-SA)
  - A: Gender (0-4=female, 5-9=male)
  - Z: Checksum digit
- Example: 9901010000088 = Dummy ID (format: YYMMDDSSSSCAN)

---

## Next Steps

In **Lab 02: Creating Applications**, you will:
- Create your first APEX application using the Create Application Wizard
- Build a Customer Management Portal
- Create interactive reports for customer lookup
- Build forms for adding and editing customers
- Implement search functionality for service reps

**Preparation:**
- Keep your database objects (they'll be used in Lab 02)
- Review the concepts: primary keys, foreign keys, views, constraints
- Think about what features would help Vodacom customer service reps work more efficiently

---

## Additional Resources

**Vodacom Context:**
- Customer Types: Individual (prepaid/postpaid), Business (SME), Corporate (enterprise), Government
- Mobile Number Format: South African numbers start with 0 (e.g., 082, 083, 071, 072, 073, etc.)
- SIM Card Number: 19-20 digit ICCID (Integrated Circuit Card Identifier)
- VodaPay: Mobile payment system similar to M-Pesa or e-wallet

**SQL Reference:**
- Oracle SQL Language Reference: https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/
- SQL Workshop Documentation: Access via Help menu in APEX

**Practice Queries:**
Try these to deepen your SQL skills:
```sql
-- Count customers by province
SELECT province, COUNT(*) AS customer_count
FROM vodacom_customers
GROUP BY province
ORDER BY customer_count DESC;

-- Find customers without mobile numbers
SELECT c.account_number, c.first_name, c.last_name
FROM vodacom_customers c
LEFT JOIN vodacom_mobile_numbers m ON c.customer_id = m.customer_id
WHERE m.number_id IS NULL;

-- Calculate total credit exposure by customer type
SELECT customer_type,
       COUNT(*) AS customer_count,
       SUM(credit_limit) AS total_credit_limit,
       AVG(credit_limit) AS avg_credit_limit
FROM vodacom_customers
WHERE account_status = 'Active'
GROUP BY customer_type
ORDER BY total_credit_limit DESC;

-- Analyze data usage patterns
SELECT number_type,
       COUNT(*) AS number_count,
       SUM(data_balance_mb) AS total_data_mb,
       AVG(data_balance_mb) AS avg_data_mb,
       SUM(airtime_balance) AS total_airtime
FROM vodacom_mobile_numbers
WHERE status = 'Active'
GROUP BY number_type
ORDER BY number_type;
```

---

**End of Lab 01**

**Time to Complete:** 60 minutes  
**Tables Created:** 3 (departments, customers, mobile_numbers)  
**Indexes Created:** 7  
**Views Created:** 1  
**Records Inserted:** 4 departments, 5 customers, 3 mobile numbers

**Instructor Sign-off:** ________________  Date: ________

**Notes:** This lab establishes the foundation for the Vodacom Customer Management Portal. In subsequent labs, you'll build upon these tables to create a full-featured application for customer service representatives.
