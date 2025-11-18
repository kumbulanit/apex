# Lab 02: Creating Applications

**Duration:** 90 minutes  
**Difficulty:** Beginner  
**Prerequisites:** Completed Lab 01 (Vodacom database tables created)

---

## 🎯 Lab Versions Available

### This Lab (Simplified - Wizard Only)
Covers the **Application Wizard** method for creating APEX applications from existing database tables.

### ⭐ **COMPLETE VERSION** (Recommended)
For comprehensive training covering **ALL 9 creation methods**, see:

**➡️ [Lab 02: Creating Applications - COMPLETE ALL METHODS](lab-02-creating-applications-COMPLETE-ALL-METHODS.md)**

**The complete version includes:**
- ✅ Method 1: Application Wizard (this lab)
- ✅ Method 2: CSV File Upload (vodacom-packages.csv)
- ✅ Method 3: Excel/XLSX Upload (vodacom-retail-stores.xlsx)
- ✅ Method 4: XML File Upload (vodacom-network-towers.xml)
- ✅ Method 5: JSON File Upload (vodacom-devices.json)
- ✅ Method 6: Copy/Paste Data (VodaPay transactions)
- ✅ Method 7: Quick SQL (generate complete schemas)
- ✅ Method 8: Oracle Fusion Starter Apps (ERP integration)
- ✅ Method 9: Application Blueprints (demo apps)

**Complete version benefits:**
- 9 different creation methods demonstrated
- 4 Vodacom sample data files included
- Import from CSV, Excel, XML, JSON formats
- Oracle Fusion Cloud integration guide
- Quick SQL for rapid schema design
- 120-minute comprehensive tutorial
- R550,000+ cost savings demonstrated

**👉 Use the complete version for full APEX training coverage!**

---

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

You're continuing the Vodacom Customer Service Portal project. Your team lead, Thabo Molefe (Customer Service Manager), has asked you to create the first APEX application - a Customer Management Portal. He wants to see three different approaches to application creation so the team can evaluate which methodology works best for Vodacom's needs.

**Business Requirements:**
- Manage customer information (45 million+ customers)
- Track mobile numbers and subscription details
- View customer lists with search capabilities
- Monitor VodaPay account status
- Support ticket tracking
- Mobile-friendly interface for field agents

---

## Part 1: Create Application Using Wizard (30 minutes)

### Exercise 1.1: Create Customer Portal from Scratch

**Steps:**

1. **Navigate to App Builder**
   - From the APEX home page, click **App Builder**
   - Click the **Create** button (blue button, top right)

2. **Choose Creation Method**
   - Select **New Application**
   - You'll see the Create Application wizard

3. **Name Your Application**
   - Name: `Vodacom Customer Portal`
   - Appearance: Keep default (Universal Theme - 42)
   - Click **Add Page** to add your first page

4. **Add a Dashboard Page**
   - Page Type: Select **Dashboard**
   - Page Name: `Operations Dashboard`
   - Chart 1 - Type: **Bar Chart**
     - Chart Name: `Customers by Province`
     - Table: `VODACOM_CUSTOMERS`
     - Label Column: `PROVINCE`
     - Value: **Count**
   - Chart 2 - Type: **Pie Chart**
     - Chart Name: `Customer Types`
     - Table: `VODACOM_CUSTOMERS`
     - Label Column: `CUSTOMER_TYPE`
     - Value: **Count**
   - Click **Add Page**

5. **Add an Interactive Report Page for Customers**
   - Click **Add Page** button
   - Page Type: Select **Interactive Report**
   - Page Name: `Customer Lookup`
   - Table: Select **VODACOM_CUSTOMERS**
   - Check: ✓ Include Form (this creates a linked form page)
   - Click **Add Page**

6. **Add a Form Page on Mobile Numbers**
   - Click **Add Page**
   - Page Type: **Form**
   - Page Name: `Mobile Number Management`
   - Table: **VODACOM_MOBILE_NUMBERS**
   - Click **Add Page**

7. **Add an Interactive Report for Support Tickets**
   - Click **Add Page**
   - Page Type: **Interactive Report**
   - Page Name: `Support Tickets`
   - Table: **VODACOM_CUSTOMER_SUPPORT**
   - Check: ✓ Include Form
   - Click **Add Page**

8. **Add a Calendar Page**
   - Click **Add Page**
   - Page Type: **Calendar**
   - Page Name: `Customer Registrations`
   - Table: **VODACOM_CUSTOMERS**
   - Display Column: **ACCOUNT_NUMBER** (select from dropdown)
   - Start Date Column: **REGISTRATION_DATE**
   - End Date Column: **REGISTRATION_DATE**
   - Click **Add Page**

9. **Review Pages Summary**
   - You should now see 7 pages listed:
     1. Home (Operations Dashboard)
     2. Customer Lookup
     3. Customer Form (auto-created with report)
     4. Mobile Number Management
     5. Support Tickets
     6. Support Ticket Form (auto-created)
     7. Customer Registrations
   - Review the Features section:
     - ✓ Add Navigation Menu
     - ✓ Add Session State Protection
   - Click **Create Application**

10. **Application Created!**
    - APEX will create your application
    - You'll see: "Application created successfully"
    - Click **Run Application** (play button icon, top right)

11. **Log In and Explore**
    - Username: Your APEX username
    - Password: Your APEX password
    - Click **Sign In**
    - **Explore the Application:**
      - Dashboard shows charts (customer distribution)
      - Navigation menu on left shows all pages
      - Click **Customer Lookup** to see customer records
      - Click on a customer to view/edit details
      - Explore Support Tickets page

**Expected Results:**
- ✅ Application created with 7 pages
- ✅ Can run and log into the application
- ✅ Navigation menu displays all pages
- ✅ Pages are functional with Vodacom customer data
- ✅ Charts show customer distribution

**What Just Happened?**
In about 5-10 minutes, you created a complete multi-page customer service application that would have taken weeks to build in traditional development. The wizard:
- Generated all SQL queries
- Created page layouts optimized for customer service
- Built navigation menu
- Added session security
- Configured mobile responsiveness for field agents

---

### Exercise 1.2: Customize the Operations Dashboard

Let's improve the dashboard with Vodacom-specific metrics.

**Steps:**

1. **Return to App Builder**
   - Click the **Application ID** link in the developer toolbar (bottom of screen)
   - Or click **Edit Page 1** from the developer toolbar

2. **Edit the Dashboard Page**
   - You're now in Page Designer
   - In the **Rendering tree** (left panel), find the two chart regions
   - Click on **Customers by Province** chart

3. **Improve "Customers by Province" Chart**
   - In the **Property Editor** (right panel), scroll to **Source**
   - Replace the SQL Query with:
   
   ```sql
   SELECT province AS label,
          COUNT(customer_id) AS value
   FROM vodacom_customers
   WHERE account_status = 'Active'
   GROUP BY province
   ORDER BY value DESC;
   ```
   
   - This shows only active customers by province

4. **Update "Customer Types" Chart**
   - Click on the **Customer Types** chart region
   - Update SQL Query:
   
   ```sql
   SELECT customer_type AS label,
          COUNT(*) AS value,
          CASE customer_type
              WHEN 'Individual' THEN '#1f77b4'
              WHEN 'Business' THEN '#ff7f0e'
              WHEN 'Corporate' THEN '#2ca02c'
              WHEN 'Government' THEN '#d62728'
          END AS color
   FROM vodacom_customers
   WHERE account_status = 'Active'
   GROUP BY customer_type
   ORDER BY value DESC;
   ```

5. **Save and Run**
   - Click **Save** (top right)
   - Click **Run** (play icon)
   - Charts now show meaningful Vodacom data
   - Much more informative!

6. **Add Vodacom KPI Cards**
   - Return to Page Designer
   - Right-click on **Body** in the Rendering tree
   - Select **Create Region**
   - Name: `Key Performance Indicators`
   - Type: **Cards**
   - Template: **Standard**
   - Under **Source**, set SQL Query:
   
   ```sql
   SELECT 'Total Active Customers' AS title,
          TO_CHAR(COUNT(*), '999,999,999') AS value,
          'fa-users' AS icon,
          '#0091ea' AS color
   FROM vodacom_customers
   WHERE account_status = 'Active'
   
   UNION ALL
   
   SELECT 'Active Mobile Numbers' AS title,
          TO_CHAR(COUNT(*), '999,999,999') AS value,
          'fa-mobile' AS icon,
          '#00c853' AS color
   FROM vodacom_mobile_numbers
   WHERE status = 'Active'
   
   UNION ALL
   
   SELECT 'VodaPay Users' AS title,
          TO_CHAR(COUNT(*), '999,999,999') AS value,
          'fa-credit-card' AS icon,
          '#ff6d00' AS color
   FROM vodacom_customers
   WHERE vodapay_active = 'Y'
   
   UNION ALL
   
   SELECT 'Open Support Tickets' AS title,
          TO_CHAR(COUNT(*), '999,999') AS value,
          'fa-ticket-alt' AS icon,
          '#d50000' AS color
   FROM vodacom_customer_support
   WHERE status IN ('Open', 'Assigned', 'In Progress');
   ```

7. **Configure Card Display**
   - In the KPI region properties, find **Attributes**
   - Card Layout: **Grid**
   - Columns: **4**
   - Primary Key Column: **TITLE**

8. **Add Revenue Summary Region**
   - Create another region
   - Name: `Today's Activity`
   - Type: **Classic Report**
   - Template: **Standard**
   - Under **Source**:
     - Type: **PL/SQL Function Body**
     - PL/SQL Function Body:
   
   ```sql
   BEGIN
       RETURN 'SELECT 
           TO_CHAR(COUNT(*), ''999,999'') || '' transactions'' AS transactions_today,
           ''R'' || TO_CHAR(SUM(amount), ''999,999,999.99'') AS revenue_today,
           TO_CHAR(COUNT(DISTINCT customer_id), ''999,999'') || '' customers served'' AS customers_today
       FROM vodacom_transactions
       WHERE TRUNC(transaction_date) = TRUNC(SYSDATE)
         AND status = ''Completed''';
   END;
   ```

9. **Save and Run**
   - Click **Save** and **Run**
   - Now the dashboard shows:
     - Active customers, mobile numbers, VodaPay users
     - Open support tickets
     - Today's transaction activity
     - Customer distribution by province
     - Customer type breakdown

**Expected Results:**
- ✅ Dashboard displays Vodacom-specific KPIs
- ✅ Charts show active customers only
- ✅ Color-coded customer types
- ✅ Today's activity metrics
- ✅ Professional operations dashboard for management

**Real-World Impact:**
This dashboard gives Vodacom managers instant visibility into:
- Customer base size and distribution
- VodaPay adoption rates
- Support workload
- Daily transaction activity
- Critical metrics at a glance

---

## Part 2: Create Application from Spreadsheet (25 minutes)

### Exercise 2.1: Prepare Data Package Spreadsheet

**Scenario:** Vodacom's marketing team has a list of promotional data packages in an Excel spreadsheet. Let's import this data and create a package management application.

**Steps:**

1. **Create Sample Spreadsheet**
   - Open Excel, Google Sheets, or similar
   - Create headers:
     - PACKAGE_CODE
     - PACKAGE_NAME
     - DATA_MB
     - VOICE_MINUTES
     - SMS_COUNT
     - PRICE
     - VALIDITY_DAYS
     - IS_PROMOTIONAL
     - DESCRIPTION

2. **Add Sample Data** (at least 10 rows):
   
   | PACKAGE_CODE | PACKAGE_NAME | DATA_MB | VOICE_MINUTES | SMS_COUNT | PRICE | VALIDITY_DAYS | IS_PROMOTIONAL | DESCRIPTION |
   |--------------|--------------|---------|---------------|-----------|-------|---------------|----------------|-------------|
   | PROMO-DAILY-1GB | Daily 1GB Promo | 1024 | 0 | 0 | 15 | 1 | Y | Special daily data offer |
   | PROMO-WEEK-3GB | Weekly 3GB Promo | 3072 | 0 | 0 | 99 | 7 | Y | Week-long data bundle |
   | COMBO-BASIC | Basic Combo | 500 | 50 | 50 | 79 | 30 | N | Entry level package |
   | COMBO-STANDARD | Standard Combo | 2048 | 100 | 100 | 249 | 30 | N | Most popular package |
   | COMBO-PREMIUM | Premium Combo | 5120 | 250 | 200 | 499 | 30 | N | High usage package |
   | DATA-NIGHT-2GB | Night Owl 2GB | 2048 | 0 | 0 | 49 | 30 | N | Night-time data 12am-5am |
   | SOCIAL-MEDIA | Social Connect | 1024 | 0 | 0 | 29 | 7 | N | WhatsApp, Facebook, Twitter only |
   | STUDENT-BUNDLE | Student Special | 3072 | 100 | 50 | 149 | 30 | Y | Verified students only |
   | BUSINESS-PRO | Business Pro | 10240 | 500 | 1000 | 799 | 30 | N | Business customer package |
   | ENTERPRISE-UNLIMITED | Enterprise Unlimited | 51200 | 9999 | 5000 | 1999 | 30 | N | Corporate unlimited plan |

3. **Save the File**
   - Save as: `vodacom_promo_packages.xlsx` or `.csv`
   - Remember the file location

---

### Exercise 2.2: Import Spreadsheet and Create Package Manager

**Steps:**

1. **Start Import Process**
   - Go to App Builder home
   - Click **Create** button
   - Select **From a File**

2. **Upload Your File**
   - Click **Choose File**
   - Select your `vodacom_promo_packages.xlsx`
   - Click **Next**

3. **Configure Import**
   - Table Name: `PROMO_PACKAGES`
   - First line contains headers: **Yes**
   - Preview shows your data columns
   - Click **Next**

4. **Review Column Definitions**
   - APEX auto-detects data types
   - Verify:
     - PACKAGE_CODE: VARCHAR2(50)
     - PACKAGE_NAME: VARCHAR2(100)
     - DATA_MB: NUMBER
     - PRICE: NUMBER
     - IS_PROMOTIONAL: VARCHAR2(1)
   - Adjust if needed
   - Click **Load Data**

5. **Data Loaded Successfully**
   - You'll see: "10 rows loaded"
   - Click **Create Application**

6. **Configure Application**
   - Application Name: `Package Management`
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
   - View the Package report
   - Click **Edit** on a row
   - Modify package details and save
   - Add a new promotional package using **Create** button
   - Search for packages by name or code

9. **Enhance the Package Report**
   - Edit the Interactive Report page
   - Click on the report region
   - Add computed columns:
     - Total Value: `DATA_MB + (VOICE_MINUTES * 2) + SMS_COUNT` AS total_value
     - Price per MB: `ROUND(PRICE / NULLIF(DATA_MB, 0), 2)` AS price_per_mb
   - Add conditional formatting:
     - IS_PROMOTIONAL = 'Y': Highlight in orange
     - PRICE < 100: Green background
     - PRICE > 500: Blue background (premium)

**Expected Results:**
- ✅ Spreadsheet data imported into PROMO_PACKAGES table
- ✅ Application created automatically
- ✅ Can view, edit, and add package records
- ✅ Application is fully functional immediately
- ✅ Marketing team can manage promotional offers

**Time Savings:**
- Manual approach: 2-3 days to build package management system
- Spreadsheet import: 10 minutes
- **Time saved: 99%+**

**Business Value:**
Marketing teams can now:
- Quickly launch promotional campaigns
- Manage package pricing
- Track promotional vs. regular packages
- Analyze package performance
- Update offers without IT involvement

---

## Part 3: Create Application from SQL Query (20 minutes)

### Exercise 3.1: Build Network Operations Dashboard

**Scenario:** Network Operations needs a dashboard to track tower status, customer complaints, and service quality. This requires data from multiple joined tables.

**Steps:**

1. **Create Application from Custom SQL**
   - Go to App Builder
   - Click **Create** > **New Application**
   - Name: `Network Operations Dashboard`
   - Click **Add Page**

2. **Add Interactive Report with Network Issues**
   - Page Type: **Interactive Report**
   - Page Name: `Network Issues`
   - Instead of selecting a table, click **SQL Query**
   - Enter this SQL:
   
   ```sql
   SELECT ni.issue_ref,
          ni.issue_type,
          ni.severity,
          CASE ni.severity
              WHEN 'Critical' THEN '<span style="color:red;">●</span> Critical'
              WHEN 'High' THEN '<span style="color:orange;">●</span> High'
              WHEN 'Medium' THEN '<span style="color:blue;">●</span> Medium'
              WHEN 'Low' THEN '<span style="color:green;">●</span> Low'
          END AS severity_display,
          nt.tower_code,
          nt.tower_name,
          nt.province,
          nt.city,
          ni.affected_customers,
          ni.reported_date,
          CASE 
              WHEN ni.status = 'Resolved' THEN ni.resolved_date
              ELSE NULL
          END AS resolved_date,
          CASE 
              WHEN ni.status = 'Resolved' THEN 
                  ROUND((ni.resolved_date - ni.reported_date) * 24, 1)
              ELSE
                  ROUND((SYSTIMESTAMP - ni.reported_date) * 24, 1)
          END AS hours_to_resolve,
          ni.status,
          CASE ni.status
              WHEN 'Open' THEN '<span class="badge badge-danger">Open</span>'
              WHEN 'Acknowledged' THEN '<span class="badge badge-warning">Acknowledged</span>'
              WHEN 'In Progress' THEN '<span class="badge badge-info">In Progress</span>'
              WHEN 'Resolved' THEN '<span class="badge badge-success">Resolved</span>'
          END AS status_badge,
          e.first_name || ' ' || e.last_name AS assigned_technician,
          ni.description
   FROM vodacom_network_issues ni
   LEFT JOIN vodacom_network_towers nt ON ni.tower_id = nt.tower_id
   LEFT JOIN vodacom_employees e ON ni.assigned_to = e.emp_id
   ORDER BY 
       CASE ni.status 
           WHEN 'Open' THEN 1
           WHEN 'Acknowledged' THEN 2
           WHEN 'In Progress' THEN 3
           WHEN 'Resolved' THEN 4
       END,
       ni.severity DESC,
       ni.reported_date DESC;
   ```
   
   - ✓ Include Form
   - Click **Add Page**

3. **Add Tower Status Chart**
   - Click **Add Page**
   - Page Type: **Chart**
   - Chart Type: **Bar**
   - Page Name: `Towers by Type`
   - SQL Query:
   
   ```sql
   SELECT tower_type || ' (' || status || ')' AS label,
          COUNT(*) AS value,
          CASE tower_type
              WHEN '5G' THEN '#ff0000'
              WHEN '4G' THEN '#ff9800'
              WHEN '3G' THEN '#4caf50'
              ELSE '#9e9e9e'
          END AS color
   FROM vodacom_network_towers
   GROUP BY tower_type, status
   ORDER BY tower_type DESC, status;
   ```
   
   - Click **Add Page**

4. **Add Support Tickets Overview**
   - Click **Add Page**
   - Page Type: **Interactive Report**
   - Page Name: `Active Support Tickets`
   - SQL Query:
   
   ```sql
   SELECT cs.ticket_number,
          c.account_number,
          c.first_name || ' ' || c.last_name AS customer_name,
          c.phone,
          cs.issue_category,
          cs.issue_type,
          cs.priority,
          cs.status,
          cs.created_date,
          ROUND(SYSDATE - cs.created_date, 1) AS days_open,
          CASE 
              WHEN cs.priority = 'Urgent' AND SYSDATE - cs.created_date > 1 THEN 'SLA BREACH'
              WHEN cs.priority = 'High' AND SYSDATE - cs.created_date > 2 THEN 'SLA BREACH'
              WHEN cs.priority = 'Normal' AND SYSDATE - cs.created_date > 5 THEN 'SLA BREACH'
              ELSE 'Within SLA'
          END AS sla_status,
          e.first_name || ' ' || e.last_name AS assigned_agent,
          cs.description
   FROM vodacom_customer_support cs
   JOIN vodacom_customers c ON cs.customer_id = c.customer_id
   LEFT JOIN vodacom_employees e ON cs.assigned_to = e.emp_id
   WHERE cs.status NOT IN ('Resolved', 'Closed')
   ORDER BY 
       CASE cs.priority
           WHEN 'Urgent' THEN 1
           WHEN 'High' THEN 2
           WHEN 'Normal' THEN 3
           ELSE 4
       END,
       cs.created_date;
   ```
   
   - ✓ Include Form
   - Click **Add Page**

5. **Add Customer Activity Dashboard**
   - Click **Add Page**
   - Page Type: **Dashboard**
   - Page Name: `Transaction Overview`
   - Chart 1 - Type: **Line Chart**
     - SQL Query:
     ```sql
     SELECT TRUNC(transaction_date) AS label,
            COUNT(*) AS value
     FROM vodacom_transactions
     WHERE transaction_date >= SYSDATE - 30
       AND status = 'Completed'
     GROUP BY TRUNC(transaction_date)
     ORDER BY label;
     ```
   - Chart 2 - Type: **Pie Chart**
     - SQL Query:
     ```sql
     SELECT transaction_type AS label,
            COUNT(*) AS value
     FROM vodacom_transactions
     WHERE transaction_date >= SYSDATE - 7
     GROUP BY transaction_type
     ORDER BY value DESC;
     ```
   - Click **Add Page**

6. **Create Application**
   - Review pages (should have 6-7 pages)
   - Click **Create Application**

7. **Run and Test**
   - Click **Run Application**
   - Explore the **Network Issues** report
   - Notice the calculated columns:
     - Severity Display (color-coded)
     - Hours to Resolve
     - Status Badge (HTML badges)
     - SLA Status
   - View the **Tower Status** chart
   - Check **Active Support Tickets**
   - Examine **Transaction Overview**

8. **Add Conditional Highlighting**
   - Edit the Network Issues page
   - Click on the report region
   - For HOURS_TO_RESOLVE column:
     - Highlight if > 24: Red background
     - Highlight if > 12: Orange background
   - For SLA_STATUS:
     - 'SLA BREACH': Red, bold text
     - 'Within SLA': Green text
   - Save and run

**Expected Results:**
- ✅ Network Operations Dashboard created
- ✅ Report shows critical network issues with technician assignments
- ✅ SLA breach warnings highlighted
- ✅ Tower infrastructure visualized by type
- ✅ Support tickets prioritized correctly
- ✅ Transaction trends displayed
- ✅ Real-time operational visibility

**Business Value:**
Network Operations can now:
- Monitor critical infrastructure issues in real-time
- Track SLA compliance for customer support
- Identify at-risk towers and areas
- Prioritize technician assignments
- Respond faster to customer-impacting outages
- Analyze transaction patterns for capacity planning

---

## Part 4: Using Application Blueprints (15 minutes)

### Exercise 4.1: Install and Customize a Blueprint

**Scenario:** APEX blueprints are pre-built application templates that you can customize for Vodacom's needs.

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
   - Application Name: `Vodacom Retail Sales`
   - Click **Create Application**

5. **Adapt Blueprint for Vodacom Context**
   - The blueprint has "Customers" - perfect for Vodacom
   - "Products" can become "Devices" (phones, tablets, routers)
   - "Orders" can become "Sales Transactions"

6. **Customize the Blueprint**
   - Click **Edit Application**
   - Go to **Shared Components**
   - Click **Navigation Menu**
   - Click **Navigation Menu**
   - Rename menu entries:
     - "Customers" → "Vodacom Customers"
     - "Products" → "Devices Catalog"
     - "Orders" → "Sales Transactions"
   - Save changes

7. **Link to Your Vodacom Data**
   - Edit the Customers page
   - Change the report source to use VODACOM_CUSTOMERS:
   ```sql
   SELECT customer_id,
          account_number,
          first_name || ' ' || last_name AS customer_name,
          phone,
          email,
          city,
          province,
          customer_type,
          account_status,
          CASE WHEN vodapay_active = 'Y' THEN 'Yes' ELSE 'No' END AS vodapay_user,
          registration_date
   FROM vodacom_customers
   WHERE account_status = 'Active'
   ORDER BY registration_date DESC;
   ```

8. **Test Customizations**
   - Save and run the application
   - Navigate through renamed menu items
   - Verify customer data displays correctly
   - Test creating/editing records

**Expected Results:**
- ✅ Sample Database Application installed
- ✅ Customized for Vodacom branding
- ✅ Menu items renamed appropriately
- ✅ Linked to Vodacom customer data
- ✅ Understand how to leverage blueprints quickly

**Use Cases for Blueprints:**
- **Prototyping**: Quickly demonstrate concepts to Vodacom stakeholders
- **Learning**: Study well-structured applications
- **Starting Point**: Use as foundation for device sales tracking
- **Best Practices**: See how experts structure telecom applications

---

## Lab Summary and Key Takeaways

### What You Built

✅ **4 Complete Applications:**
1. **Vodacom Customer Portal** - Built from wizard with dashboard, customer lookup, support tickets, mobile number management
2. **Package Management** - Created from Excel spreadsheet import (promotional packages)
3. **Network Operations Dashboard** - Built with complex SQL queries for infrastructure monitoring
4. **Retail Sales** - Adapted blueprint for Vodacom device sales

✅ **Application Features Implemented:**
- Interactive Reports with search and filtering
- Forms for customer and ticket management
- Operations dashboards with Vodacom KPIs
- Calendar views for customer registrations
- Navigation menus
- Conditional formatting for SLA monitoring
- Real-time network status tracking
- Transaction trend analysis

### Time Comparison

| Task | Traditional Development | APEX Wizard | Time Saved |
|------|------------------------|-------------|------------|
| Customer Portal (7 pages) | 60-80 hours | 15 minutes | 99.7% |
| Package Management (Spreadsheet) | 25-35 hours | 10 minutes | 99.5% |
| Network Ops Dashboard (Custom SQL) | 50-70 hours | 25 minutes | 99.4% |
| Retail Sales (Blueprint) | 40-60 hours | 15 minutes | 99.6% |
| **TOTAL** | **175-245 hours** | **65 minutes** | **99.5%+** |

**Cost Savings for Vodacom:**
- Developer time saved: ~200 hours per application set
- At R1,500/hour: **R300,000+ saved**
- Time to market: **Weeks reduced to 1 day**

### Skills Developed

- Using Create Application Wizard for telecom applications
- Adding pages for customer service operations
- Importing promotional data from spreadsheets
- Writing complex SQL for operational dashboards
- Adding calculated columns for SLA monitoring
- Customizing dashboards with Vodacom KPIs
- Using application blueprints
- Conditional formatting for priority alerts
- Joining multiple tables for operational insights

---

## Challenge Exercises (Optional - 20 minutes)

### Challenge 1: Enhance the Customer Portal

Add a new page to the Vodacom Customer Portal:
- **Page Type**: Classic Report
- **Page Name**: VodaPay Statistics by Province
- **SQL Query**: Calculate VodaPay adoption and wallet balances by province
- **Requirements**:
  - Show province name
  - Show total customers
  - Show VodaPay users count
  - Show adoption percentage
  - Show total wallet balance
  - Sort by adoption rate descending

**Hint:**
```sql
SELECT c.province,
       COUNT(c.customer_id) AS total_customers,
       SUM(CASE WHEN c.vodapay_active = 'Y' THEN 1 ELSE 0 END) AS vodapay_users,
       ROUND(SUM(CASE WHEN c.vodapay_active = 'Y' THEN 1 ELSE 0 END) / 
             NULLIF(COUNT(c.customer_id), 0) * 100, 1) AS adoption_pct,
       SUM(NVL(vp.balance, 0)) AS total_wallet_balance
FROM vodacom_customers c
LEFT JOIN vodacom_vodapay_accounts vp ON c.customer_id = vp.customer_id
WHERE c.account_status = 'Active'
GROUP BY c.province
ORDER BY adoption_pct DESC NULLS LAST;
```

### Challenge 2: Create a Data Usage Analytics Application

Create a new application for analyzing customer data usage:
1. Create an analytics view:
   ```sql
   CREATE OR REPLACE VIEW v_data_usage_analysis AS
   SELECT mn.mobile_number,
          c.account_number,
          c.first_name || ' ' || c.last_name AS customer_name,
          c.province,
          mn.number_type,
          mn.data_balance_mb,
          t.package_id,
          p.package_name,
          p.data_allocation_mb,
          p.price,
          t.transaction_date,
          CASE 
              WHEN mn.data_balance_mb = 0 THEN 'Depleted'
              WHEN mn.data_balance_mb < 100 THEN 'Low'
              WHEN mn.data_balance_mb < 500 THEN 'Medium'
              ELSE 'Healthy'
          END AS data_status
   FROM vodacom_mobile_numbers mn
   JOIN vodacom_customers c ON mn.customer_id = c.customer_id
   LEFT JOIN vodacom_transactions t ON c.customer_id = t.customer_id
       AND t.transaction_type = 'Data Purchase'
   LEFT JOIN vodacom_packages p ON t.package_id = p.package_id
   WHERE mn.status = 'Active';
   ```

2. Create application with:
   - Dashboard showing data usage by province
   - Report of customers with depleted data (upsell opportunity)
   - Chart showing popular data packages
   - Analysis of prepaid vs postpaid usage patterns

### Challenge 3: Implement Real-Time Tower Monitoring

In the Network Operations Dashboard:
- Add a region showing towers with status 'Offline' or 'Maintenance'
- Create a map visualization (if available) showing tower locations
- Add filters for:
  - Province dropdown
  - Tower type (2G/3G/4G/5G)
  - Status (Operational, Offline, Maintenance)
- Calculate affected customers by offline towers
- Add email alerts for critical tower outages

---

## Validation Quiz

Test your understanding:

1. **What are the 4 main ways to create an APEX application?**
   - [x] Create from wizard
   - [x] Import from spreadsheet
   - [x] From SQL query/existing tables
   - [x] Use a blueprint/template

2. **True or False: When you add an Interactive Report with "Include Form" checked, APEX creates two pages.**
   - [x] True
   - [ ] False

3. **For Vodacom's Customer Portal, which table contains mobile number balances?**
   - [ ] VODACOM_CUSTOMERS
   - [x] VODACOM_MOBILE_NUMBERS
   - [ ] VODACOM_TRANSACTIONS
   - [ ] VODACOM_PACKAGES

4. **What does a calculated column like "Hours to Resolve" require?**
   - [x] Custom SQL expression
   - [ ] Special table structure
   - [ ] Additional licensing
   - [ ] Manual computation

5. **Application blueprints are useful for:**
   - [ ] Learning best practices
   - [ ] Rapid prototyping
   - [ ] Starting point for customization
   - [x] All of the above

**Answers:** 1. All four; 2. True; 3. VODACOM_MOBILE_NUMBERS; 4. Custom SQL expression; 5. All of the above

---

## Troubleshooting Guide

### Issue 1: "No Data Found" in Dashboard Charts

**Problem:** Charts display "No Data Found" message

**Solution:**
- Ensure you ran the Vodacom database setup script (Lab 01)
- Check the SQL query returns rows:
  ```sql
  SELECT * FROM vodacom_customers; -- Should return 20+ rows
  SELECT * FROM vodacom_mobile_numbers; -- Should return 15+ rows
  ```
- Verify foreign key relationships are correct
- Re-run setup-sample-data-vodacom.sql if needed

### Issue 2: Application Won't Run

**Problem:** Click "Run" but application doesn't load

**Solution:**
- Check browser console for errors (F12 > Console)
- Verify ORDS (Oracle REST Data Services) is running
- Clear browser cache (Ctrl+Shift+Delete)
- Try a different browser (Chrome or Firefox recommended)
- Check workspace quota limits

### Issue 3: Form Page Shows Error on Save

**Problem:** "Unable to process row update" error

**Solution:**
- Verify table has a primary key
- Check all NOT NULL columns have values
- Ensure foreign key references are valid (e.g., customer_id exists)
- Look at the error details in the notification
- For VODACOM_CUSTOMERS: Ensure account_number is unique

### Issue 4: Spreadsheet Import Fails

**Problem:** "Unable to load data from file"

**Solution:**
- Ensure first row contains column headers
- Check for special characters in headers (use underscores)
- Verify file is not corrupted
- Save as CSV and try again
- Make sure file size is under 50MB
- Remove any blank rows at the bottom

### Issue 5: Charts Don't Show Province Names

**Problem:** Charts show blank or wrong labels

**Solution:**
- Check SQL query uses correct column names:
  ```sql
  SELECT province AS label, COUNT(*) AS value
  FROM vodacom_customers
  GROUP BY province;
  ```
- Verify data exists in the province column
- Use UPPER() or INITCAP() for consistent formatting

---

## Next Steps

In **Lab 03: Pages and Page Designer**, you will:
- Master the three-panel Page Designer interface
- Add and configure page components for customer service
- Work with regions, items, and buttons
- Understand the rendering tree and execution order
- Build responsive layouts for field agents
- Add dynamic actions for real-time customer lookups
- Implement LOVs for package selection

**Preparation:**
- Keep all Vodacom applications you created in this lab
- Review the structure of your Customer Portal
- Think about additional features customer service reps would need
- Consider how mobile agents could use these applications in the field

---

## Additional Resources

**APEX Create Application Documentation:**
- https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/creating-database-applications.html

**Sample Applications Gallery:**
- From APEX home page: **Gallery** > **Sample Apps**
- Install sample apps to see telecom-relevant patterns

**Vodacom Use Cases:**
- Customer service portals for call centers
- Field agent applications for sales teams
- Network monitoring dashboards for operations
- VodaPay transaction management
- Device inventory and sales tracking

**Practice Exercise:**
Create a simple SIM card management application:
- SIM_CARDS table (sim_number, status, customer_id, activation_date)
- Insert 50 sample SIM cards
- Create app with report and form
- Add chart showing SIM status distribution (Active, Suspended, Available)
- Calculate SIM inventory metrics

---

**End of Lab 02**

**Time to Complete:** 90 minutes  
**Applications Created:** 4 complete Vodacom applications  
**Pages Built:** 20+ pages across all apps  
**Business Value:** R300,000+ in development cost savings

**Instructor Sign-off:** ________________  Date: ________

**Next Lab:** Lab 03 - Pages and Page Designer (Deep dive into customizing Vodacom applications)
