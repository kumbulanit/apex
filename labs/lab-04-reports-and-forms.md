# Lab 04: Reports and Forms

**Duration:** 90 minutes  
**Difficulty:** Intermediate  
**Prerequisites:** Completed Lab 03 (Project Dashboard created)

## Learning Objectives

By the end of this lab, you will be able to:
1. Create and customize Interactive Reports
2. Build Interactive Grids with inline editing
3. Create master-detail forms
4. Add conditional formatting and highlighting
5. Configure report download options
6. Implement search and filter functionality

---

## Lab Scenario

**🎯 Building the Enterprise Call Center Application - Lab 4 of 7**

You're building the **Reporting & Forms** modules for Vodacom's call center application.

**What You're Building This Lab:**
- **Customer Analysis Report** - 45M customers, revenue analytics, export to Excel
- **Call Logging System** - Agent call entry with inline editing
- **Invoice Management** - Master-detail for billing (R2B+ monthly revenue)
- **Package Performance Dashboard** - Activation trends, popular packages

**How This Fits the Complete Application:**
```
Vodacom Enterprise Call Center Application
├── Customer Management (Labs 1-2) ✅
├── Network Operations (Lab 3) ✅
├── 📊 Reporting & Forms (Lab 4) ← YOU ARE HERE
│   ├── Customer 360° Reports
│   ├── Call Center Analytics
│   └── Billing & Invoicing
├── Controls & Navigation (Lab 5)
├── Security & Performance (Lab 6)
└── Production Deployment (Lab 7)
```

**Enterprise Features:**
- Handle 45M customer records efficiently
- Export reports for executive presentations
- Bulk editing for call center productivity
- Conditional formatting for urgent issues

---

## Part 1: Advanced Interactive Report (30 minutes)

### Exercise 1.1: Create Client Analysis Report

1. **Create New Page**
   - App Builder → Your Application
   - Create Page → Report → **Interactive Report**
   - Page Number: `20`
   - Page Name: `Client Analysis`
   - Breadcrumb: Yes → `Client Analysis`
   - **SQL Query** (copy this EXACTLY):
     ```sql
     SELECT c.client_id,
            c.company_name,
            c.industry,
            c.contact_person,
            c.email,
            c.phone,
            COUNT(DISTINCT p.project_id) AS total_projects,
            COUNT(CASE WHEN p.status = 'Active' THEN 1 END) AS active_projects,
            SUM(p.budget) AS total_budget,
            SUM(CASE WHEN p.status = 'Completed' THEN p.budget ELSE 0 END) AS completed_budget,
            MAX(p.end_date) AS last_project_date
     FROM technova_clients c
     LEFT JOIN technova_projects p ON c.client_id = p.client_id
     GROUP BY c.client_id, c.company_name, c.industry, 
              c.contact_person, c.email, c.phone
     ORDER BY total_budget DESC NULLS LAST
     ```
   - Click **Create Page**

   **🔍 Understanding This SQL Query:**
   
   This query combines data from two tables and calculates statistics:
   
   ```
   SELECT           ← "Give me these columns:"
     c.client_id,   ← Client ID
     c.company_name,← Company name
     ...            ← More client info
     COUNT(...)     ← Count projects (AGGREGATION)
     SUM(...)       ← Add up budgets (AGGREGATION)
   
   FROM technova_clients c              ← Main table (alias 'c')
   LEFT JOIN technova_projects p        ← Joining projects table (alias 'p')
   ON c.client_id = p.client_id         ← Match by client_id
   
   GROUP BY c.client_id, ...            ← Group results by client
   ORDER BY total_budget DESC           ← Highest budget first
   ```

   **💡 Key SQL Concepts:**
   
   1. **LEFT JOIN** - Show ALL clients, even if they have zero projects
      ```
      Clients Table    Projects Table
      ┌────────┐    ┌──────────┐
      │ ID | Name│────│ ClientID|...│
      ├────────┤    ├──────────┤
      │ 1  | ACME│────│    1   |...│
      │ 2  | XYZ │    │    1   |...│
      │ 3  | ABC │    │    2   |...│ 
      └────────┘    └──────────┘
                      ↑
           LEFT JOIN shows ABC even with no projects!
      ```
   
   2. **COUNT(DISTINCT ...)** - Count unique projects (prevents duplicates)
   
   3. **COUNT(CASE WHEN ...)** - Conditional counting
      ```sql
      COUNT(CASE WHEN p.status = 'Active' THEN 1 END)
            └──────────────────────────────┘
            Only count projects where status = 'Active'
      ```
   
   4. **GROUP BY** - Collapse rows by client (one row per client)
      ```
      Before GROUP BY:        After GROUP BY:
      ACME | Project A         ACME | 3 projects
      ACME | Project B    →    XYZ  | 1 project
      ACME | Project C         ABC  | 0 projects
      XYZ  | Project D
      ```

   **📚 Glossary:**
   - **LEFT JOIN**: Keep all rows from left table, match right table where possible
   - **COUNT()**: Count rows
   - **SUM()**: Add up numbers
   - **GROUP BY**: Combine rows with same values
   - **CASE WHEN**: If-then logic in SQL
   - **Alias (c, p)**: Short names for tables ("c" for clients, "p" for projects)

2. **Customize Report Columns**
   - Open Page 20 in Page Designer
   - Select the **Client Analysis** region
   - Expand **Columns** in left panel
   
   - **COMPANY_NAME**:
     - Heading: `Client Company`
     - Type: `Link`
     - Target:
       - Page: `21` (we'll create this)
       - Set Items: `P21_CLIENT_ID` → `#CLIENT_ID#`
       - Link Text: `#COMPANY_NAME#`
   
   - **TOTAL_BUDGET** and **COMPLETED_BUDGET**:
     - Type: `Plain Text`
     - Format Mask: `FML999G999G999G999G990D00`
     - Alignment: `Right`
   
   - **LAST_PROJECT_DATE**:
     - Type: `Plain Text`
     - Format Mask: `DD-MON-YYYY`

3. **Add Conditional Highlighting**
   - Select **Client Analysis** region
   - Right Panel → **Attributes** → Scroll to **Highlighting**
   - Click **Add Highlighting** (+ button)
   
   - **Highlight 1: High Value Clients**
     - Name: `High Value Clients`
     - Sequence: `10`
     - Condition Type: `Column Value`
     - Column: `TOTAL_BUDGET`
     - Operator: `>`
     - Expression 1: `1000000`
     - Background Color: `#E8F5E9` (light green)
     - Text Color: `#2E7D32` (dark green)
   
   - **Highlight 2: Inactive Clients**
     - Name: `No Active Projects`
     - Sequence: `20`
     - Column: `ACTIVE_PROJECTS`
     - Operator: `=`
     - Expression 1: `0`
     - Background Color: `#FFEBEE` (light red)
     - Text Color: `#C62828` (dark red)

4. **Configure Download Options**
   - Select **Client Analysis** region
   - Right Panel → **Attributes**
   - Download:
     - Formats Available: `CSV, HTML, Excel, PDF`
     - Filename: `client_analysis`
     - CSV Export Enabled: `Yes`
     - PDF Export Enabled: `Yes`

5. **Add Computed Column**
   - In **Columns**, click **Add Column** (+ button)
   - Column Type: `Link Column`
   - Heading: `Actions`
   - HTML Expression:
     ```html
     <button type="button" class="t-Button t-Button--simple t-Button--hot" 
             onclick="apex.navigation.redirect('f?p=&APP_ID.:21:&SESSION.::NO::P21_CLIENT_ID:#CLIENT_ID#');">
       <span class="fa fa-edit"></span> Edit
     </button>
     <button type="button" class="t-Button t-Button--simple" 
             onclick="apex.navigation.redirect('f?p=&APP_ID.:22:&SESSION.::NO::P22_CLIENT_ID:#CLIENT_ID#');">
       <span class="fa fa-file"></span> Projects
     </button>
     ```

### Exercise 1.2: Add Search Region

1. **Create Search Region**
   - Right-click **Content Body**
   - Create Region
   - Title: `Search Filters`
   - Type: `Static Content`
   - Template: `Collapsible`
   - Sequence: `5` (appears above report)

2. **Add Search Items**
   - Create Item: `P20_SEARCH_COMPANY`
     - Type: `Text Field`
     - Label: `Company Name`
     - Placeholder: `Enter company name...`
   
   - Create Item: `P20_SEARCH_INDUSTRY`
     - Type: `Select List`
     - Label: `Industry`
     - List of Values:
       - Type: `SQL Query`
       - SQL:
         ```sql
         SELECT DISTINCT industry AS d, industry AS r
         FROM technova_clients
         ORDER BY industry
         ```
     - Display Null Value: `Yes`
     - Null Display Value: `- All Industries -`
   
   - Create Item: `P20_MIN_BUDGET`
     - Type: `Number Field`
     - Label: `Minimum Budget`
     - Format Mask: `FML999G999G999`

3. **Add Apply Filter Button**
   - Create Button: `APPLY_FILTER`
   - Label: `Apply Filters`
   - Position: `Next`
   - Hot: `Yes`

4. **Update Report Query**
   - Select **Client Analysis** region
   - Modify SQL Query:
     ```sql
     SELECT c.client_id,
            c.company_name,
            c.industry,
            c.contact_person,
            c.email,
            c.phone,
            COUNT(DISTINCT p.project_id) AS total_projects,
            COUNT(CASE WHEN p.status = 'Active' THEN 1 END) AS active_projects,
            SUM(p.budget) AS total_budget,
            SUM(CASE WHEN p.status = 'Completed' THEN p.budget ELSE 0 END) AS completed_budget,
            MAX(p.end_date) AS last_project_date
     FROM technova_clients c
     LEFT JOIN technova_projects p ON c.client_id = p.client_id
     WHERE (:P20_SEARCH_COMPANY IS NULL OR 
            UPPER(c.company_name) LIKE '%' || UPPER(:P20_SEARCH_COMPANY) || '%')
       AND (:P20_SEARCH_INDUSTRY IS NULL OR c.industry = :P20_SEARCH_INDUSTRY)
     GROUP BY c.client_id, c.company_name, c.industry, 
              c.contact_person, c.email, c.phone
     HAVING (:P20_MIN_BUDGET IS NULL OR SUM(p.budget) >= :P20_MIN_BUDGET)
     ORDER BY total_budget DESC NULLS LAST
     ```
   - Page Items to Submit: `P20_SEARCH_COMPANY,P20_SEARCH_INDUSTRY,P20_MIN_BUDGET`

---

## Part 2: Interactive Grid with Bulk Editing (25 minutes)

### Exercise 2.1: Create Timesheet Entry Grid

1. **Create New Page**
   - Create Page → Report → **Interactive Grid**
   - Page Number: `25`
   - Page Name: `Timesheet Entry`
   - Include Form Page: `No`
   - SQL Query:
     ```sql
     SELECT t.timesheet_id,
            e.first_name || ' ' || e.last_name AS employee_name,
            p.project_name,
            t.work_date,
            t.hours_logged,
            t.description,
            t.is_billable,
            e.emp_id,
            p.project_id
     FROM technova_timesheets t
     JOIN technova_employees e ON t.emp_id = e.emp_id
     JOIN technova_projects p ON t.project_id = p.project_id
     WHERE t.work_date >= TRUNC(SYSDATE) - 30
     ORDER BY t.work_date DESC, e.last_name
     ```

2. **Configure Grid for Editing**
   - Select **Timesheet Entry** region
   - Attributes:
     - Editable: `Yes`
     - Edit → Enabled: `Yes`
     - Edit → Mode: `Row`
     - Add Row: `Yes`
     - Delete Row: `Yes`
     - Pagination → Type: `Page`
     - Pagination → Rows per Page: `50`

3. **Configure Columns**
   - **TIMESHEET_ID**:
     - Type: `Hidden`
     - Primary Key: `Yes`
   
   - **EMP_ID**:
     - Type: `Select List`
     - Heading: `Employee`
     - Required: `Yes`
     - List of Values:
       - Type: `SQL Query`
       - SQL:
         ```sql
         SELECT first_name || ' ' || last_name AS d,
                emp_id AS r
         FROM technova_employees
         WHERE is_active = 'Y'
         ORDER BY last_name, first_name
         ```
     - Default:
       - Type: `SQL Query`
       - SQL: `SELECT emp_id FROM technova_employees WHERE email = :APP_USER`
   
   - **PROJECT_ID**:
     - Type: `Popup LOV`
     - Heading: `Project`
     - Required: `Yes`
     - List of Values:
       - SQL:
         ```sql
         SELECT project_name AS d,
                project_id AS r
         FROM technova_projects
         WHERE status IN ('Active', 'In Progress')
         ORDER BY project_name
         ```
   
   - **WORK_DATE**:
     - Type: `Date Picker`
     - Required: `Yes`
     - Default:
       - Type: `Expression`
       - PL/SQL Expression: `TRUNC(SYSDATE)`
   
   - **HOURS_LOGGED**:
     - Type: `Number Field`
     - Heading: `Hours`
     - Required: `Yes`
     - Validation:
       - Type: `Item is a number`
       - Item is greater than or equal to: `0.25`
       - Item is less than or equal to: `24`
   
   - **IS_BILLABLE**:
     - Type: `Switch`
     - Heading: `Billable`
     - Default: `Y`

4. **Add Save Button**
   - Create Button: `SAVE_TIMESHEETS`
   - Label: `Save All Changes`
   - Position: `Right of Interactive Grid Search Bar`
   - Hot: `Yes`

5. **Add Process**
   - Create Process:
     - Name: `Process Timesheet Grid`
     - Type: `Interactive Grid - Automatic Row Processing (DML)`
     - Editable Region: `Timesheet Entry`
     - When Button Pressed: `SAVE_TIMESHEETS`

---

## Part 3: Master-Detail Form (35 minutes)

### Exercise 3.1: Create Invoice Master-Detail

1. **Create Master Page (Invoice Header)**
   - Create Page → Form → **Form**
   - Page Number: `30`
   - Page Name: `Invoice Details`
   - Table Name: `TECHNOVA_INVOICES`
   - Primary Key Column: `INVOICE_ID`
   - Click **Create Page**

2. **Enhance Master Form**
   - Open Page 30 in Page Designer
   - Modify Items:
   
   - **P30_CLIENT_ID**:
     - Type: `Popup LOV`
     - List of Values:
       - SQL:
         ```sql
         SELECT company_name AS d,
                client_id AS r
         FROM technova_clients
         ORDER BY company_name
         ```
   
   - **P30_INVOICE_DATE**:
     - Default Type: `Expression`
     - PL/SQL Expression: `TRUNC(SYSDATE)`
   
   - **P30_DUE_DATE**:
     - Default Type: `Expression`
     - PL/SQL Expression: `TRUNC(SYSDATE) + 30`
   
   - **P30_STATUS**:
     - Type: `Select List`
     - List of Values:
       - Static: `Draft,Draft,Sent,Sent,Paid,Paid,Overdue,Overdue,Cancelled,Cancelled`
     - Default: `Draft`
   
   - **P30_TOTAL_AMOUNT**:
     - Type: `Display Only`
     - Format Mask: `FML999G999G999G990D00`
     - Appearance → CSS Classes: `apex-item-display-only u-bold`

3. **Create Detail Region (Invoice Line Items)**
   - Right-click **Content Body**
   - Create Region
   - Title: `Invoice Line Items`
   - Type: `Interactive Grid`
   - Sequence: `20` (after form items)
   - SQL Query:
     ```sql
     SELECT li.line_item_id,
            li.invoice_id,
            li.description,
            li.quantity,
            li.unit_price,
            li.quantity * li.unit_price AS line_total
     FROM technova_invoice_line_items li
     WHERE li.invoice_id = :P30_INVOICE_ID
     ORDER BY li.line_item_id
     ```
   - Page Items to Submit: `P30_INVOICE_ID`

4. **Configure Detail Grid**
   - Attributes:
     - Editable: `Yes`
     - Add Row: `Yes`
     - Delete Row: `Yes`
   
   - **LINE_ITEM_ID**:
     - Type: `Hidden`
     - Primary Key: `Yes`
   
   - **INVOICE_ID**:
     - Type: `Hidden`
     - Default:
       - Type: `Item`
       - Item: `P30_INVOICE_ID`
   
   - **DESCRIPTION**:
     - Required: `Yes`
     - Width: `250`
   
   - **QUANTITY**:
     - Type: `Number Field`
     - Required: `Yes`
     - Default: `1`
     - Format Mask: `999G999G999G999`
   
   - **UNIT_PRICE**:
     - Type: `Number Field`
     - Required: `Yes`
     - Format Mask: `FML999G999G999G990D00`
   
   - **LINE_TOTAL**:
     - Type: `Display Only`
     - Format Mask: `FML999G999G999G990D00`
     - Server-side Condition:
       - Type: `Item is NOT NULL`
       - Item: `P30_INVOICE_ID`

5. **Add Calculate Total Button**
   - Create Button: `CALCULATE_TOTAL`
   - Label: `Calculate Total`
   - Position: `Below Region`

6. **Add Dynamic Action to Calculate**
   - Create Dynamic Action on `CALCULATE_TOTAL` button
   - Event: `Click`
   - True Action:
     - Action: `Execute Server-side Code`
     - PL/SQL:
       ```sql
       DECLARE
         v_total NUMBER;
       BEGIN
         SELECT SUM(quantity * unit_price)
         INTO v_total
         FROM technova_invoice_line_items
         WHERE invoice_id = :P30_INVOICE_ID;
         
         :P30_TOTAL_AMOUNT := NVL(v_total, 0);
         
         UPDATE technova_invoices
         SET total_amount = NVL(v_total, 0)
         WHERE invoice_id = :P30_INVOICE_ID;
       END;
       ```
     - Items to Submit: `P30_INVOICE_ID`
     - Items to Return: `P30_TOTAL_AMOUNT`
   - Add Success Message:
     - Action: `Show`
     - Message: `Total calculated: R &P30_TOTAL_AMOUNT.`

7. **Add Process for Line Items**
   - Create Process:
     - Name: `Save Line Items`
     - Type: `Interactive Grid - Automatic Row Processing (DML)`
     - Editable Region: `Invoice Line Items`
     - Success Message: `Invoice line items saved successfully!`

8. **Create Invoice List Page**
   - Create Page → Report → Interactive Report
   - Page Number: `29`
   - Page Name: `Invoices`
   - SQL Query:
     ```sql
     SELECT i.invoice_id,
            i.invoice_number,
            c.company_name AS client,
            i.invoice_date,
            i.due_date,
            i.status,
            i.total_amount,
            CASE
              WHEN i.status = 'Paid' THEN 'u-success'
              WHEN i.status = 'Overdue' THEN 'u-danger'
              WHEN i.status = 'Sent' THEN 'u-warning'
              ELSE 'u-normal'
            END AS status_class
     FROM technova_invoices i
     JOIN technova_clients c ON i.client_id = c.client_id
     ORDER BY i.invoice_date DESC
     ```
   - Link Column: `INVOICE_NUMBER`
   - Target Page: `30`
   - Set Item: `P30_INVOICE_ID` → `#INVOICE_ID#`

---

## Challenge Exercises

### Challenge 1: Add Aggregations to Interactive Report
- Add control break on `INDUSTRY`
- Show sum of `TOTAL_BUDGET` per industry
- Add grand total at bottom

### Challenge 2: Create Email Invoice Functionality
- Add "Send Invoice" button on page 30
- Create process to generate PDF
- Send email with PDF attachment using APEX_MAIL

### Challenge 3: Implement Timesheet Approval Workflow
- Add "Submit for Approval" button
- Create approval page for managers
- Update status column (Draft → Submitted → Approved)

---

## Verification Checklist

- [ ] Page 20 (Client Analysis) displays with filters
- [ ] Highlighting works (green for high-value, red for inactive)
- [ ] Download buttons work (CSV, PDF, Excel)
- [ ] Search filters update the report
- [ ] Page 25 (Timesheet Entry) allows inline editing
- [ ] Timesheet grid saves bulk changes
- [ ] Page 30 (Invoice Details) shows master form
- [ ] Line items grid allows adding/editing rows
- [ ] Calculate Total button updates total amount
- [ ] Page 29 (Invoice List) links to detail page

---

## Key Takeaways

1. **Interactive Reports are for display**: Read-only, powerful search/filter
2. **Interactive Grids are for editing**: Spreadsheet-like data entry
3. **Master-Detail keeps data together**: One form, related records below
4. **Conditional highlighting draws attention**: Color-code important data
5. **LOVs prevent data entry errors**: Dropdowns ensure valid values
6. **Automatic DML processing simplifies saves**: No manual INSERT/UPDATE needed
7. **Dynamic Actions calculate on-the-fly**: Real-time updates without page refresh

---

## Next Steps

Lab 05 will cover Controls and Navigation:
- Navigation menus and breadcrumbs
- Cascading LOVs
- Dynamic item behavior
- Custom buttons and actions

**Estimated Time for Lab 05:** 60 minutes
