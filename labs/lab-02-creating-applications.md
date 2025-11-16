# Lab 02: Creating Applications

**Duration:** 90 minutes  
**Difficulty:** Beginner  
**Prerequisites:** Completed Lab 01 (database tables created)

## Learning Objectives

By the end of this lab, you will be able to:
1. Create an APEX application using the Create Application Wizard
2. Build an application from a spreadsheet file
3. Use application blueprints for rapid prototyping
4. Create an application from an SQL query
5. Customize application properties and settings
6. Understand application structure and navigation

---

## Lab Scenario

**🎯 Building the Enterprise Call Center Application - Lab 2 of 7**

You're continuing the Vodacom Enterprise Call Center project. Your manager wants to see different approaches to application creation before building the complete system.

**What You're Building This Lab:**
- **Customer Management Module** - Search, view, edit 45M customers
- **Package Activation Interface** - Quick package activation for agents
- **Call Queue Dashboard** - Real-time agent workload
- **Network Operations Center** - Infrastructure monitoring

**Complete Application (By Lab 7):**
- Customer 360° View (all services, history, payments)
- Agent Desktop (call handling, CRM integration)
- Supervisor Dashboard (team performance, SLAs)
- Network Operations (cell towers, incidents, outages)
- Package Management (activations, billing, upgrades)
- VodaPay Transactions (mobile money)
- Executive Reporting (KPIs, trends, forecasting)

**This Lab's Focus:** Learn 9 different methods to create applications, then choose the best approach for enterprise development

---

## Part 1: Create Application Using Wizard (30 minutes)

### Exercise 1.1: Create Application from Scratch

**Steps:**

1. **Navigate to App Builder**
   - **Where to start:** From the APEX home page (dashboard)
   - **What to click:** The **App Builder** tile (🏗️ blue icon)
   - **What you'll see:** A page that says "No applications found" (if this is your first time)
   - **Next step:** Click the **Create** button (blue button, top right corner)

   ```
   📸 SCREENSHOT PLACEHOLDER: App Builder page with "Create" button highlighted
   ```

2. **Choose Creation Method**
   - **What you'll see:** A dialog with several options for creating applications
   - **What to click:** Select **New Application**
   - **What happens next:** The Create Application wizard opens
   - **What you'll see:** A page titled "Create Application" with "Add Page" button

   ```
   📸 SCREENSHOT PLACEHOLDER: "New Application" option highlighted in creation dialog
   ```

   **🗺️ Visual Guide - Creation Options:**
   ```
   ┌─────────────────────────────────────┐
   │   How do you want to create?       │
   ├─────────────────────────────────────┤
   │ [New Application]   ← Choose this  │
   │ [From a File]                      │
   │ [Use Create App Wizard]            │
   │ [From Blueprint]                   │
   └─────────────────────────────────────┘
   ```

3. **Name Your Application**
   - **Where to look:** Top of the page, you'll see a text field labeled "Name"
   - **What to type:** `Employee Management System`
   - **Appearance section:** 
     - Theme: Keep default **(Universal Theme - 42)** ✅
     - Color Scheme: Keep default (usually "Blue")
   - **What to click next:** The blue **Add Page** button (middle of screen)

   ```
   📸 SCREENSHOT PLACEHOLDER: Application name field and Add Page button
   ```

   **💡 What's a Theme?**
   - A theme controls how your application looks (colors, fonts, layout)
   - Universal Theme 42 is modern, responsive, and recommended for beginners
   - You can change themes later without losing functionality

4. **Add a Dashboard Page**
   - **What you'll see:** A dialog titled "Add Page" with page type options
   - **Step 4a - Choose Page Type:**
     - **What to click:** Select **Dashboard** (📊 icon)
     - **What happens:** More fields appear below
   
   - **Step 4b - Name the Page:**
     - Page Name: `Dashboard` (this appears in navigation menu)
   
   - **Step 4c - Configure Chart 1:**
     - Chart Type: Click dropdown → Select **Bar Chart**
     - Chart Name: `Employees by Department`
     - Table: Click dropdown → Select **EMPLOYEES** from list
     - Label Column: Click dropdown → Select **DEPARTMENT_ID**
     - Value: Click dropdown → Select **Count**
   
   - **Step 4d - Configure Chart 2:**
     - Chart Type: Click dropdown → Select **Pie Chart**
     - Chart Name: `Employee Status`
     - Table: **EMPLOYEES** (same table)
     - Label Column: **STATUS**
     - Value: **Count**
   
   - **What to click:** Blue **Add Page** button at bottom

   ```
   📸 SCREENSHOT PLACEHOLDER: Dashboard page configuration dialog
   ```

   **🗺️ What You're Building:**
   ```
   Dashboard Page
   ├── Bar Chart: Employees by Department
   │   └── Shows: How many employees in each dept
   └── Pie Chart: Employee Status  
       └── Shows: Active vs Inactive employees
   ```

   **⚠️ Common Mistakes:**
   - ❌ Can't find EMPLOYEES table → Make sure you completed Lab 01
   - ❌ Wrong table selected → Use dropdown, don't type manually
   - ❌ Missing charts → Each chart needs all 4 fields filled

5. **Add an Interactive Report Page**
   - **What to click:** The blue **Add Page** button (you're back on the main wizard page)
   - **What you'll see:** The "Add Page" dialog again
   
   - **Step 5a - Choose Page Type:**
     - Page Type: Select **Interactive Report** (📋 icon with rows)
   
   - **Step 5b - Configure Report:**
     - Page Name: `Employees Report`
     - Table: Select **EMPLOYEES** from dropdown
     - **Important checkbox:** ✓ Check **Include Form**
       - **What this does:** Creates TWO pages:
         1. Report page (view all employees)
         2. Form page (edit one employee)
       - **Why it's useful:** Click a row → opens edit form automatically
   
   - Click **Add Page**

   ```
   📸 SCREENSHOT PLACEHOLDER: Interactive Report dialog with "Include Form" checkbox
   ```

   **💡 What's an Interactive Report?**
   - Users can search, filter, sort, and customize the view
   - Like Excel, but web-based and multi-user
   - Includes toolbar with actions (Search, Filter, Download)

   **🎯 Expected Result:**
   - You'll see TWO pages added to your list:
     - Page 2: Employees Report (Interactive Report)
     - Page 3: Employee Form (Form) ← Auto-created!

6. **Add a Form Page on DEPARTMENTS**
   - Click **Add Page**
   - Page Type: **Form**
   - Page Name: `Department Form`
   - Table: **DEPARTMENTS**
   - Click **Add Page**

7. **Add a Calendar Page**
   - Click **Add Page**
   - Page Type: **Calendar**
   - Page Name: `Employee Hire Dates`
   - Table: **EMPLOYEES**
   - Display Column: **FIRST_NAME** (select from dropdown)
   - Start Date Column: **HIRE_DATE**
   - End Date Column: **HIRE_DATE**
   - Click **Add Page**

8. **Review Pages Summary**
   - You should now see 5 pages listed:
     1. Home (Dashboard)
     2. Employees Report
     3. Employee Form (auto-created with report)
     4. Department Form
     5. Employee Hire Dates
   - Review the Features section:
     - ✓ Add Navigation Menu
     - ✓ Add Session State Protection
   - Click **Create Application**

9. **Application Created!**
   - APEX will create your application
   - You'll see: "Application created successfully"
   - Click **Run Application** (play button icon, top right)

10. **Log In and Explore**
    - Username: Your APEX username
    - Password: Your APEX password
    - Click **Sign In**
    - **Explore the Application:**
      - Dashboard shows charts (currently empty data)
      - Navigation menu on left shows all pages
      - Click through each page to see what was created
      - Note: Charts will be empty because we have limited sample data

**Expected Results:**
- ✅ Application created with 5 pages
- ✅ Can run and log into the application
- ✅ Navigation menu displays all pages
- ✅ Pages are functional (though data may be limited)

**What Just Happened?**
In about 5 minutes, you created a complete multi-page application that would have taken days to build in traditional development. The wizard:
- Generated all SQL queries
- Created page layouts
- Built navigation menu
- Added session security
- Configured mobile responsiveness

---

### Exercise 1.2: Customize the Dashboard

Let's improve the dashboard with actual useful data.

**Steps:**

1. **Return to App Builder**
   - Click the **Application ID** link in the developer toolbar (bottom of screen)
   - Or click **Edit Page 1** from the developer toolbar

2. **Edit the Dashboard Page**
   - You're now in Page Designer
   - In the **Rendering tree** (left panel), find the two chart regions
   - Click on **Employees by Department** chart

3. **Improve "Employees by Department" Chart**
   - In the **Property Editor** (right panel), scroll to **Source**
   - Replace the SQL Query with:
   
   ```sql
   SELECT d.department_name AS label,
          COUNT(e.employee_id) AS value
   FROM departments d
   LEFT JOIN employees e ON d.department_id = e.department_id
   GROUP BY d.department_name
   ORDER BY value DESC
   ```
   
   - This uses department names instead of IDs

4. **Save and Run**
   - Click **Save** (top right)
   - Click **Run** (play icon)
   - The chart now shows department names
   - Much more readable!

5. **Add More Dashboard Content**
   - Return to Page Designer
   - Right-click on **Body** in the Rendering tree
   - Select **Create Region**
   - Name: `Quick Stats`
   - Type: **Static Content**
   - Template: **Hero**
   - Add HTML:
   
   ```html
   <div class="dashboard-stats">
       <div class="stat-box">
           <h3>&TOTAL_EMPLOYEES.</h3>
           <p>Total Employees</p>
       </div>
       <div class="stat-box">
           <h3>&ACTIVE_EMPLOYEES.</h3>
           <p>Active Employees</p>
       </div>
       <div class="stat-box">
           <h3>&TOTAL_DEPARTMENTS.</h3>
           <p>Departments</p>
       </div>
   </div>
   ```

6. **Create Page Items for Stats**
   - Right-click on **Quick Stats** region
   - Select **Create Page Item**
   - Name: `P1_TOTAL_EMPLOYEES`
   - Type: **Hidden**
   - Under **Source**:
     - Type: **SQL Query (return single value)**
     - SQL Query: `SELECT COUNT(*) FROM employees`
   - Repeat for:
     - `P1_ACTIVE_EMPLOYEES`: `SELECT COUNT(*) FROM employees WHERE status = 'Active'`
     - `P1_TOTAL_DEPARTMENTS`: `SELECT COUNT(*) FROM departments`

7. **Save and Run**
   - Now the dashboard shows real statistics
   - This gives users immediate insight into the data

**Expected Results:**
- ✅ Dashboard chart shows department names
- ✅ Quick stats display actual counts
- ✅ Page is more informative and useful

---

## Part 2: Create Application from Spreadsheet (25 minutes)

### Exercise 2.1: Prepare Spreadsheet Data

**Scenario:** TechNova has a list of clients in an Excel spreadsheet. Let's import this data and create an application.

**Steps:**

1. **Create Sample Spreadsheet**
   - Open Excel, Google Sheets, or similar
   - Create headers:
     - CLIENT_NAME
     - INDUSTRY
     - CONTACT_PERSON
     - EMAIL
     - PHONE
     - CITY
     - CONTRACT_VALUE
     - STATUS

2. **Add Sample Data** (at least 10 rows):
   
   | CLIENT_NAME | INDUSTRY | CONTACT_PERSON | EMAIL | PHONE | CITY | CONTRACT_VALUE | STATUS |
   |------------|----------|----------------|-------|-------|------|----------------|--------|
   | FirstBank Holdings | Banking | Peter Davies | peter@firstbank.co.za | +27-11-234-5678 | Johannesburg | 4500000 | Active |
   | RetailCorp SA | Retail | Susan Miller | susan@retailcorp.co.za | +27-21-345-6789 | Cape Town | 2800000 | Active |
   | MedHealth Systems | Healthcare | Dr. James Wilson | james@medhealth.co.za | +27-31-456-7890 | Durban | 1950000 | Active |
   | Manufacturing Solutions | Manufacturing | Karen Robinson | karen@mansol.co.za | +27-11-567-8901 | Johannesburg | 3200000 | Active |
   | LogiTrans Africa | Logistics | Mark Thompson | mark@logitrans.co.za | +27-21-678-9012 | Cape Town | 1650000 | Active |
   | TechStart Innovations | Technology | Linda Martinez | linda@techstart.co.za | +27-21-789-0123 | Cape Town | 850000 | Prospect |
   | EduLearn Academy | Education | Robert Green | robert@edulearn.co.za | +27-11-890-1234 | Johannesburg | 675000 | Active |
   | Property Masters | Real Estate | Nicole Adams | nicole@propmasters.co.za | +27-21-901-2345 | Cape Town | 1250000 | Active |
   | Global Traders | Import/Export | Michael Lee | michael@globaltraders.co.za | +27-31-012-3456 | Durban | 980000 | Active |
   | Insurance Plus | Insurance | Sarah White | sarah@insuranceplus.co.za | +27-11-123-4567 | Johannesburg | 1450000 | Active |

3. **Save the File**
   - Save as: `technova_clients.xlsx` or `.csv`
   - Remember the file location

---

### Exercise 2.2: Import Spreadsheet and Create Application

**Steps:**

1. **Start Import Process**
   - Go to App Builder home
   - Click **Create** button
   - Select **From a File**

2. **Upload Your File**
   - Click **Choose File**
   - Select your `technova_clients.xlsx`
   - Click **Next**

3. **Configure Import**
   - Table Name: `CLIENTS_IMPORT`
   - First line contains headers: **Yes**
   - Preview shows your data columns
   - Click **Next**

4. **Review Column Definitions**
   - APEX auto-detects data types
   - Verify:
     - CLIENT_NAME: VARCHAR2(200)
     - CONTRACT_VALUE: NUMBER
     - EMAIL: VARCHAR2(100)
   - Adjust if needed
   - Click **Load Data**

5. **Data Loaded Successfully**
   - You'll see: "10 rows loaded"
   - Click **Create Application**

6. **Configure Application**
   - Application Name: `Client Management`
   - Click **Create Application**

7. **Explore the Auto-Created App**
   - APEX creates:
     - Dashboard page with chart
     - Interactive Report page
     - Form page for editing
     - Calendar page
   - Click **Run Application**

8. **Test the Application**
   - Log in with your credentials
   - View the Client report
   - Click **Edit** on a row
   - Modify data and save
   - Add a new client using the **Create** button

**Expected Results:**
- ✅ Spreadsheet data imported into CLIENTS_IMPORT table
- ✅ Application created automatically
- ✅ Can view, edit, and add client records
- ✅ Application is fully functional immediately

**Time Savings:**
- Manual approach: 2-3 hours to build this from scratch
- Spreadsheet import: 10 minutes
- **Time saved: 90-95%**

---

## Part 3: Create Application from SQL Query (20 minutes)

### Exercise 3.1: Build Application Using Custom SQL

**Scenario:** You want to create a Project Tracking application, but you need data from multiple joined tables.

**Steps:**

1. **First, Create Projects Table**
   - Go to SQL Workshop > SQL Commands
   - Execute:
   
   ```sql
   CREATE TABLE projects (
       project_id        NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
       project_name      VARCHAR2(200) NOT NULL,
       client_name       VARCHAR2(200),
       start_date        DATE,
       end_date          DATE,
       budget            NUMBER(15,2),
       actual_cost       NUMBER(15,2),
       status            VARCHAR2(20) DEFAULT 'Planning',
       priority          VARCHAR2(20) DEFAULT 'Medium',
       created_date      DATE DEFAULT SYSDATE
   );
   
   -- Insert sample projects
   INSERT INTO projects (project_name, client_name, start_date, end_date, budget, status, priority)
   VALUES ('Online Banking Portal', 'FirstBank Holdings', DATE '2024-01-15', DATE '2024-09-30', 1850000, 'In Progress', 'High');
   
   INSERT INTO projects (project_name, client_name, start_date, end_date, budget, status, priority)
   VALUES ('Inventory System', 'RetailCorp SA', DATE '2024-02-01', DATE '2024-10-31', 980000, 'In Progress', 'High');
   
   INSERT INTO projects (project_name, client_name, start_date, end_date, budget, status, priority)
   VALUES ('Patient Records', 'MedHealth Systems', DATE '2024-03-01', DATE '2024-12-31', 1250000, 'Planning', 'Critical');
   
   INSERT INTO projects (project_name, client_name, start_date, end_date, budget, actual_cost, status, priority)
   VALUES ('CRM System', 'TechStart Innovations', DATE '2023-09-01', DATE '2024-03-31', 425000, 398000, 'Completed', 'Medium');
   
   COMMIT;
   ```

2. **Create Application from Report and Form**
   - Go to App Builder
   - Click **Create** > **New Application**
   - Name: `Project Tracker`
   - Click **Add Page**

3. **Add Interactive Report with Custom SQL**
   - Page Type: **Interactive Report**
   - Page Name: `Active Projects`
   - Instead of selecting a table, click **SQL Query**
   - Enter this SQL:
   
   ```sql
   SELECT project_id,
          project_name,
          client_name,
          start_date,
          end_date,
          CASE 
              WHEN end_date < SYSDATE AND status != 'Completed' THEN 'Overdue'
              WHEN end_date < SYSDATE + 30 AND status != 'Completed' THEN 'Due Soon'
              ELSE 'On Track'
          END AS timeline_status,
          budget,
          actual_cost,
          budget - NVL(actual_cost, 0) AS remaining_budget,
          ROUND((NVL(actual_cost, 0) / NULLIF(budget, 0)) * 100, 1) AS budget_used_pct,
          status,
          priority,
          TRUNC(end_date - start_date) AS duration_days
   FROM projects
   ORDER BY 
       CASE status 
           WHEN 'In Progress' THEN 1
           WHEN 'Planning' THEN 2
           WHEN 'Completed' THEN 3
           ELSE 4
       END,
       priority DESC;
   ```
   
   - ✓ Include Form
   - Click **Add Page**

4. **Add a Chart Page**
   - Click **Add Page**
   - Page Type: **Chart**
   - Chart Type: **Bar**
   - Page Name: `Projects by Status`
   - SQL Query:
   
   ```sql
   SELECT status AS label,
          COUNT(*) AS value
   FROM projects
   GROUP BY status
   ORDER BY value DESC;
   ```
   
   - Click **Add Page**

5. **Create Application**
   - Review pages (should have 3-4 pages)
   - Click **Create Application**

6. **Run and Test**
   - Click **Run Application**
   - Explore the **Active Projects** report
   - Notice the calculated columns:
     - Timeline Status (Overdue/Due Soon/On Track)
     - Remaining Budget
     - Budget Used Percentage
     - Duration in Days
   - These provide instant business insights!

7. **Add Conditional Formatting**
   - Edit Page (click Edit Page 2 from developer toolbar)
   - Click on the **Active Projects** region
   - In the right panel, find **TIMELINE_STATUS** column
   - Add Conditional Formatting:
     - Condition: **Value = 'Overdue'**
     - Background Color: `#ff0000` (red)
     - Text Color: `#ffffff` (white)
   - Add another condition:
     - Condition: **Value = 'Due Soon'**
     - Background Color: `#ffcc00` (yellow)
   - Save and run

**Expected Results:**
- ✅ Project Tracker application created
- ✅ Report shows calculated business metrics
- ✅ Overdue projects highlighted in red
- ✅ Chart visualizes project status distribution

**Business Value:**
This application provides instant visibility into:
- Project health (overdue vs. on track)
- Budget utilization
- Project pipeline status
- At-risk projects requiring attention

---

## Part 4: Using Application Blueprints (15 minutes)

### Exercise 4.1: Install and Use a Blueprint

**Scenario:** APEX blueprints are pre-built application templates that you can customize.

**Steps:**

1. **Access Gallery**
   - From App Builder home, click **Create**
   - Select **Use a Blueprint**
   - You'll see the Gallery with blueprint categories

2. **Browse Available Blueprints**
   - Categories:
     - Starter Apps
     - Sample Apps
     - Productivity Apps
     - Demo Apps
   - Click on **Sample Database Application**

3. **Preview the Blueprint**
   - Read the description
   - Click **View Screenshots** to see what it includes
   - Note the features:
     - Customers management
     - Products catalog
     - Orders tracking
     - Interactive reports and forms
     - Dashboard with charts

4. **Install the Blueprint**
   - Click **Create App from Blueprint**
   - Application Name: `Sample Database App`
   - Click **Create Application**

5. **Explore the Installed Application**
   - Click **Run Application**
   - Log in
   - Explore pages:
     - Dashboard with KPIs
     - Customer list and forms
     - Product catalog
     - Order management
   - Examine the navigation structure
   - Test creating a new customer

6. **Customize the Blueprint**
   - Return to App Builder
   - Click **Edit Application**
   - Explore **Shared Components**:
     - Navigation Menu (change menu structure)
     - Lists (modify navigation lists)
     - Breadcrumbs
     - Authentication Schemes
   - Make a simple change:
     - Go to **Shared Components** > **Navigation Menu**
     - Click **Navigation Menu**
     - Edit an entry or add a new one
     - Save and run to see your change

**Expected Results:**
- ✅ Sample Database Application installed
- ✅ Fully functional application with multiple features
- ✅ Can customize navigation and structure
- ✅ Understand how to leverage blueprints for rapid development

**Use Cases for Blueprints:**
- **Prototyping**: Quickly demonstrate concepts to stakeholders
- **Learning**: Study well-structured applications
- **Starting Point**: Use as foundation, then customize
- **Best Practices**: See how experts structure applications

---

## Lab Summary and Key Takeaways

### What You Built

✅ **3 Complete Applications:**
1. **Employee Management System** - Built from wizard with dashboard, reports, forms, calendar
2. **Client Management** - Created from Excel spreadsheet import (10 minutes)
3. **Project Tracker** - Built with custom SQL queries and calculated columns

✅ **Application Features Implemented:**
- Interactive Reports with search and filtering
- Forms for data entry and editing
- Dashboards with charts and KPIs
- Calendar views
- Navigation menus
- Conditional formatting

### Time Comparison

| Task | Traditional Development | APEX Wizard | Time Saved |
|------|------------------------|-------------|------------|
| Employee Management System | 40-60 hours | 15 minutes | 99.6% |
| Client Management (Spreadsheet) | 20-30 hours | 10 minutes | 99.2% |
| Project Tracker (Custom SQL) | 30-40 hours | 25 minutes | 99.0% |
| **TOTAL** | **90-130 hours** | **50 minutes** | **99%+** |

### Skills Developed

- Using Create Application Wizard
- Adding pages of different types (reports, forms, charts, calendars)
- Importing data from spreadsheets
- Writing custom SQL for reports
- Adding calculated columns for business insights
- Customizing dashboards
- Using application blueprints
- Conditional formatting

---

## Challenge Exercises (Optional - 20 minutes)

### Challenge 1: Enhance the Employee Management System

Add a new page to the Employee Management System:
- **Page Type**: Classic Report
- **Page Name**: Salary Report by Department
- **SQL Query**: Calculate average, minimum, and maximum salary by department
- **Requirements**:
  - Show department name
  - Show count of employees
  - Show average, min, max salary
  - Sort by average salary descending

**Hint:**
```sql
SELECT d.department_name,
       COUNT(e.employee_id) AS emp_count,
       AVG(e.salary) AS avg_salary,
       MIN(e.salary) AS min_salary,
       MAX(e.salary) AS max_salary
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC NULLS LAST;
```

### Challenge 2: Create a Task Management Application

Create a new application for task tracking:
1. First create TASKS table:
   ```sql
   CREATE TABLE tasks (
       task_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
       task_name VARCHAR2(200) NOT NULL,
       description VARCHAR2(2000),
       assigned_to VARCHAR2(100),
       due_date DATE,
       status VARCHAR2(20) DEFAULT 'Not Started',
       priority VARCHAR2(20) DEFAULT 'Medium',
       created_date DATE DEFAULT SYSDATE
   );
   ```

2. Create application with:
   - Dashboard showing tasks by status
   - Interactive Report with all tasks
   - Form for adding/editing tasks
   - Calendar showing tasks by due date

### Challenge 3: Implement Advanced Filtering

In the Project Tracker application:
- Add a filter region with:
  - Status dropdown (Planning, In Progress, Completed)
  - Priority dropdown (Low, Medium, High, Critical)
  - Date range picker (Start Date from/to)
- Make the report respond to filter selections

---

## Validation Quiz

Test your understanding:

1. **What are the 4 main ways to create an APEX application?**
   - [ ] Create from wizard
   - [ ] Import from spreadsheet
   - [ ] From SQL query/existing tables
   - [ ] Use a blueprint/template

2. **True or False: When you add an Interactive Report with "Include Form" checked, APEX creates two pages.**
   - [ ] True
   - [ ] False

3. **What file formats can you import for "Create from File"?**
   - [ ] Excel (.xlsx)
   - [ ] CSV (.csv)
   - [ ] XML (.xml)
   - [ ] JSON (.json)

4. **What does a calculated column in a report require?**
   - [ ] Custom SQL expression
   - [ ] Special table structure
   - [ ] Additional licensing
   - [ ] Manual computation

5. **Application blueprints are useful for:**
   - [ ] Learning best practices
   - [ ] Rapid prototyping
   - [ ] Starting point for customization
   - [ ] All of the above

**Answers:** 1. All four; 2. True; 3. Excel and CSV primarily; 4. Custom SQL expression; 5. All of the above

---

## Troubleshooting Guide

### Issue 1: "No Data Found" in Dashboard Charts

**Problem:** Charts display "No Data Found" message

**Solution:**
- Ensure you have data in the underlying tables
- Check the SQL query returns rows:
  ```sql
  SELECT * FROM employees; -- Should return rows
  ```
- Verify foreign key relationships are correct
- Add sample data if tables are empty

### Issue 2: Application Won't Run

**Problem:** Click "Run" but application doesn't load

**Solution:**
- Check browser console for errors (F12 > Console)
- Verify ORDS (Oracle REST Data Services) is running
- Clear browser cache (Ctrl+Shift+Delete)
- Try a different browser

### Issue 3: Form Page Shows Error on Save

**Problem:** "Unable to process row update" error

**Solution:**
- Verify table has a primary key
- Check all NOT NULL columns have values
- Ensure foreign key references are valid
- Look at the error details in the notification

### Issue 4: Spreadsheet Import Fails

**Problem:** "Unable to load data from file"

**Solution:**
- Ensure first row contains column headers
- Check for special characters in headers
- Verify file is not corrupted
- Save as CSV and try again
- Make sure file size is under 50MB

---

## Next Steps

In **Lab 03: Pages and Page Designer**, you will:
- Master the three-panel Page Designer interface
- Add and configure page components
- Work with regions, items, and buttons
- Understand the rendering tree and execution order
- Build responsive layouts
- Add dynamic actions for interactivity

**Preparation:**
- Keep all applications you created in this lab
- Review the structure of your Employee Management System
- Think about what additional features would benefit users

---

## Additional Resources

**APEX Create Application Documentation:**
- https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/creating-database-applications.html

**Sample Applications Gallery:**
- From APEX home page: **Gallery** > **Sample Apps**
- Install sample apps to see advanced features

**Practice Exercise:**
Create a simple inventory tracking application:
- Products table (product_id, product_name, quantity, price)
- Insert 20 sample products
- Create app with report and form
- Add a chart showing products by category
- Calculate total inventory value

---

**End of Lab 02**

**Time to Complete:** 90 minutes  
**Applications Created:** 3-4 complete applications  
**Pages Built:** 15+ pages across all apps

**Instructor Sign-off:** ________________  Date: ________
