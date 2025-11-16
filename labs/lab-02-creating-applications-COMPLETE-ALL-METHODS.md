# Lab 02: Creating Applications - Complete Methods Guide

**Duration:** 120 minutes (Extended)  
**Difficulty:** Beginner to Intermediate  
**Prerequisites:** Completed Lab 01 (Vodacom database tables created)

## Learning Objectives

By the end of this lab, you will be able to:
1. Create APEX applications using **6 different methods**
2. Build applications from the Create Application Wizard
3. Upload and import data from **CSV, XLSX, XML, and JSON** files
4. Use **copy/paste data** to create tables and applications
5. Generate applications using **Quick SQL**
6. Create **Starter Applications** with Oracle Fusion Cloud integrations
7. Use **Application Blueprints** for rapid prototyping
8. Customize application properties and settings

---

## Lab Scenario

You're leading the Vodacom Customer Service Portal project. Your manager, Thabo Molefe, wants to evaluate **ALL possible methods** of creating APEX applications to determine the best approach for different use cases across Vodacom's 45 million customer base.

**Business Requirements:**
- Customer management for 45M+ customers
- Mobile package catalog management
- Retail store network monitoring
- Network tower infrastructure tracking
- Device inventory management
- VodaPay integration readiness
- Oracle Fusion Cloud ERP integration

**Today's Goal:** Create **6 different applications** using all available APEX creation methods.

---

## 📁 Sample Data Files Provided

Before starting, verify you have these Vodacom sample files in `/labs/sample-data/`:

| File | Format | Size | Use Case |
|------|--------|------|----------|
| `vodacom-packages.csv` | CSV | 25 rows | Data packages (CSV import) |
| `vodacom-retail-stores.xlsx` | Excel | 15 stores | Retail locations (Excel import) |
| `vodacom-network-towers.xml` | XML | 10 towers | Network infrastructure (XML import) |
| `vodacom-devices.json` | JSON | 15 devices | Device catalog (JSON import) |

**Note:** If files are missing, see **Appendix A** at the end of this lab for copy/paste data.

---

## METHOD 1: Create Application Wizard (30 minutes)

### Exercise 1.1: Create Customer Portal from Database Tables

**Use Case:** Build a full-featured application from existing database tables (created in Lab 01).

**Steps:**

1. **Navigate to App Builder**
   - From APEX home page → **App Builder**
   - Click **Create** button (top right)

2. **Choose Creation Method**
   - Select **New Application**

3. **Configure Application Properties**
   ```
   Name: Vodacom Customer Portal
   Appearance: Universal Theme - 42
   Icon: fa-users (customer icon)
   Icon Background Color: #E60000 (Vodacom red)
   ```

4. **Add Page 1: Dashboard**
   - Click **Add Page**
   - Page Type: **Dashboard**
   - Page Name: `Operations Dashboard`
   
   **Chart 1 - Customers by Province:**
   ```
   Chart Type: Bar Chart
   Chart Name: Customers by Province
   Table or View: VODACOM_CUSTOMERS
   Label Column: PROVINCE
   Type: Count
   ```
   
   **Chart 2 - Customer Types:**
   ```
   Chart Type: Donut Chart
   Chart Name: Customer Type Distribution
   Table or View: VODACOM_CUSTOMERS
   Label Column: CUSTOMER_TYPE
   Type: Count
   ```
   
   **Chart 3 - VodaPay Users:**
   ```
   Chart Type: Pie Chart
   Chart Name: VodaPay Adoption
   Table or View: VODACOM_CUSTOMERS
   Label Column: VODAPAY_ACTIVE
   Type: Count
   ```
   
   Click **Add Page**

5. **Add Page 2: Interactive Report with Form**
   - Click **Add Page**
   - Page Type: **Interactive Report**
   ```
   Page Name: Customer Lookup
   Table or View: VODACOM_CUSTOMERS
   ✓ Include Form
   Form Page Name: Customer Details
   ```
   Click **Add Page**

6. **Add Page 3: Mobile Numbers Management**
   - Click **Add Page**
   - Page Type: **Interactive Report**
   ```
   Page Name: Mobile Numbers
   Table or View: VODACOM_MOBILE_NUMBERS
   ✓ Include Form
   ```
   Click **Add Page**

7. **Add Page 4: Calendar**
   - Click **Add Page**
   - Page Type: **Calendar**
   ```
   Page Name: Customer Registrations
   Table or View: VODACOM_CUSTOMERS
   Display Column: ACCOUNT_NUMBER
   Start Date Column: REGISTRATION_DATE
   End Date Column: REGISTRATION_DATE
   ```
   Click **Add Page**

8. **Add Page 5: Faceted Search**
   - Click **Add Page**
   - Page Type: **Faceted Search**
   ```
   Page Name: Advanced Customer Search
   Table or View: VODACOM_CUSTOMERS
   ```
   Click **Add Page**

9. **Add Features**
   - Scroll down to **Features** section
   - Check: ✓ **Access Control**
   - Check: ✓ **Activity Reporting**
   - Check: ✓ **Feedback**
   - Check: ✓ **About Page**
   - Check: ✓ **Configuration Options**

10. **Add Settings**
    ```
    Application Settings:
    - Authentication: Application Express Accounts
    - Language: English (en)
    - User Interface: Desktop
    ```

11. **Create Application**
    - Review all pages (should show 6+ pages)
    - Click **Create Application** button
    - Wait for confirmation message

12. **Run Application**
    - Click **Run Application** button
    - Log in with your workspace credentials
    - Test the Operations Dashboard
    - Test Customer Lookup page
    - Verify all charts display data

**✅ Verification Checklist:**
- [ ] Application created with 6+ pages
- [ ] Dashboard shows 3 charts with Vodacom data
- [ ] Customer Lookup displays all customers
- [ ] Form allows editing customer records
- [ ] Mobile Numbers page shows phone numbers
- [ ] Calendar displays registration dates
- [ ] Faceted Search works with filters

---

## METHOD 2: Create from CSV File Upload (20 minutes)

### Exercise 2.1: Import Vodacom Package Catalog

**Use Case:** Sales team has a CSV file with all data packages. Import and create an application instantly.

**Steps:**

1. **Prepare CSV File**
   - Navigate to `/labs/sample-data/`
   - Open `vodacom-packages.csv` (25 data packages)
   - Verify columns: PACKAGE_ID, PACKAGE_NAME, PACKAGE_TYPE, DATA_MB, VOICE_MINUTES, SMS_COUNT, PRICE_RAND, VALIDITY_DAYS, DESCRIPTION, ACTIVE

2. **Start Import Process**
   - App Builder → **Create**
   - Select **Create Application from a File**

3. **Upload CSV File**
   - Click **Choose File**
   - Select `vodacom-packages.csv`
   - Click **Next**

4. **Configure Import**
   ```
   Load To: New Table
   Table Name: VODACOM_PACKAGES_CATALOG
   Error Handling: Terminate if errors found
   File Encoding: Unicode UTF-8
   ```
   - Click **Next**

5. **Map Columns**
   - APEX auto-detects columns
   - Verify data types:
     ```
     PACKAGE_ID → NUMBER (Primary Key)
     PACKAGE_NAME → VARCHAR2(200)
     PACKAGE_TYPE → VARCHAR2(50)
     DATA_MB → NUMBER
     VOICE_MINUTES → NUMBER
     SMS_COUNT → NUMBER
     PRICE_RAND → NUMBER
     VALIDITY_DAYS → NUMBER
     DESCRIPTION → VARCHAR2(500)
     ACTIVE → VARCHAR2(1)
     ```
   - Set **PACKAGE_ID** as Primary Key
   - Click **Load Data**

6. **Create Application**
   - After successful load, click **Create Application**
   - APEX shows preview:
     ```
     Application Name: Vodacom Packages Catalog
     Pages: 
       - Interactive Report
       - Form
       - Dashboard
     ```
   - Click **Create Application**

7. **Customize Application**
   - Edit Application Properties:
     ```
     Name: Vodacom Package Management
     Icon: fa-database
     Icon Color: #E60000
     ```
   - Click **Save**

8. **Run and Test**
   - Click **Run Application**
   - View Interactive Report with all 25 packages
   - Test searching: "Monthly"
   - Test filtering by PACKAGE_TYPE: "Data Only"
   - Open a package form and verify all fields
   - Try creating a new package:
     ```
     Package Name: Student Special 2GB
     Package Type: Data Only
     Data MB: 2048
     Price Rand: 99
     Validity Days: 30
     Description: Student discount package
     Active: Y
     ```

**✅ Verification Checklist:**
- [ ] CSV file imported successfully (25 rows)
- [ ] Application created automatically
- [ ] Interactive Report shows all packages
- [ ] Form allows editing packages
- [ ] Search and filters work correctly
- [ ] Can add new package records

**💡 Pro Tip:** CSV import is the **fastest method** for creating applications when you have tabular data in Excel or Google Sheets (export as CSV first).

---

## METHOD 3: Create from Excel/XLSX File (20 minutes)

### Exercise 3.1: Import Vodacom Retail Store Network

**Use Case:** Retail Operations has an Excel spreadsheet with all 15 Vodacom store locations. Create an application to manage store network.

**Note:** APEX supports both **XLS** (Excel 97-2003) and **XLSX** (Excel 2007+) formats.

**Steps:**

1. **Prepare Excel File**
   - File: `vodacom-retail-stores.xlsx` (15 stores)
   - Contains: STORE_ID, STORE_NAME, PROVINCE, CITY, ADDRESS, POSTAL_CODE, MANAGER_NAME, PHONE, EMAIL, OPENING_DATE, STATUS

2. **Upload Excel File**
   - App Builder → **Create**
   - Select **Create Application from a File**
   - Click **Choose File**
   - Select `vodacom-retail-stores.xlsx`
   - Click **Next**

3. **Configure Excel Import**
   ```
   Load To: New Table
   Table Name: VODACOM_RETAIL_STORES
   First Line Contains Headers: Yes (checked)
   Sheet: Sheet1
   ```
   - Click **Next**

4. **Map Excel Columns to Database**
   ```
   STORE_ID → NUMBER (Primary Key)
   STORE_NAME → VARCHAR2(200)
   PROVINCE → VARCHAR2(100)
   CITY → VARCHAR2(100)
   ADDRESS → VARCHAR2(300)
   POSTAL_CODE → VARCHAR2(10)
   MANAGER_NAME → VARCHAR2(100)
   PHONE → VARCHAR2(20)
   EMAIL → VARCHAR2(100)
   OPENING_DATE → DATE
   STATUS → VARCHAR2(20)
   ```
   - Set **STORE_ID** as Primary Key
   - Click **Load Data**

5. **Create Store Management Application**
   - After import success → **Create Application**
   - Application Name: `Vodacom Retail Store Network`
   - Icon: `fa-store`
   - Icon Color: `#E60000`
   - Click **Create Application**

6. **Enhance the Application**
   - Go to **Page 2** (Interactive Report)
   - Add **Region Title**: "Vodacom Store Locations"
   - Run the application

7. **Add Custom Features**
   - Edit the Interactive Report
   - Add a **Cards Region** (optional):
     ```
     Template: Standard Cards
     Title: &STORE_NAME.
     Subtitle: &CITY., &PROVINCE.
     Body: Manager: &MANAGER_NAME.
     Secondary Body: Phone: &PHONE.
     Icon: fa-map-marker
     ```

8. **Test Features**
   - Search for "Sandton"
   - Filter by Province: "Gauteng"
   - Download report as **Excel** (Actions menu)
   - Open a store form and edit manager details
   - Add a new store:
     ```
     Store Name: Vodacom Fourways
     Province: Gauteng
     City: Fourways
     Address: Fourways Mall
     Postal Code: 2055
     Manager: John Doe
     Phone: 0821110099
     Email: fourways@vodacom.co.za
     Status: Active
     ```

**✅ Verification Checklist:**
- [ ] Excel file imported (15 stores)
- [ ] All columns mapped correctly
- [ ] OPENING_DATE stored as DATE type
- [ ] Interactive Report displays all stores
- [ ] Can search by store name
- [ ] Can filter by province
- [ ] Can export back to Excel
- [ ] Form allows editing

**💡 Pro Tip:** Excel import preserves **data types** (dates, numbers) better than CSV. Use Excel when you have mixed data types.

---

## METHOD 4: Create from XML File (20 minutes)

### Exercise 4.1: Import Network Tower Infrastructure

**Use Case:** Network Operations exports cell tower data as XML from their monitoring system. Import and create a network infrastructure dashboard.

**Steps:**

1. **Review XML File Structure**
   - File: `vodacom-network-towers.xml`
   - Contains: 10 cell towers with GPS coordinates
   - Structure:
     ```xml
     <vodacom_network_towers>
       <tower>
         <tower_id>1</tower_id>
         <tower_name>Sandton City Tower</tower_name>
         <province>Gauteng</province>
         <technology>5G</technology>
         ...
       </tower>
     </vodacom_network_towers>
     ```

2. **Upload XML File**
   - App Builder → **Create**
   - **Create Application from a File**
   - Choose File: `vodacom-network-towers.xml`
   - Click **Next**

3. **Configure XML Import**
   ```
   Load To: New Table
   Table Name: VODACOM_TOWER_INFRASTRUCTURE
   File Type: XML
   Root Element: vodacom_network_towers
   Row Element: tower
   ```
   - Click **Next**

4. **Map XML Elements**
   APEX detects XML structure:
   ```
   tower_id → NUMBER (Primary Key)
   tower_name → VARCHAR2(200)
   province → VARCHAR2(100)
   city → VARCHAR2(100)
   latitude → NUMBER
   longitude → NUMBER
   technology → VARCHAR2(20)
   status → VARCHAR2(50)
   capacity_users → NUMBER
   installed_date → DATE
   monthly_cost_rand → NUMBER
   ownership → VARCHAR2(50)
   ```
   - Set **tower_id** as Primary Key
   - Click **Load Data**

5. **Create Network Infrastructure Application**
   - Click **Create Application**
   - Name: `Vodacom Network Infrastructure`
   - Icon: `fa-broadcast-tower`
   - Icon Color: `#E60000`
   - Pages to add:
     - Interactive Report (Tower List)
     - Form (Tower Details)
     - Map Region (GPS coordinates)
     - Dashboard (Technology distribution)
   - Click **Create Application**

6. **Add Map Visualization**
   - Edit Page 1 (Dashboard)
   - Add new **Region**:
     ```
     Type: Map
     Name: Tower Locations
     Source: VODACOM_TOWER_INFRASTRUCTURE
     Latitude Column: LATITUDE
     Longitude Column: LONGITUDE
     Tooltip: &TOWER_NAME. - &TECHNOLOGY.
     ```

7. **Add Technology Chart**
   - Add **Chart Region**:
     ```
     Type: Donut Chart
     Name: Technology Distribution
     SQL: 
     SELECT technology, COUNT(*) as tower_count
     FROM vodacom_tower_infrastructure
     GROUP BY technology
     ```

8. **Test Application**
   - Run application
   - Verify 10 towers displayed
   - Check map shows correct locations:
     - Sandton City: -26.107730, 28.056305
     - V&A Waterfront: -33.904500, 18.419180
   - Test filtering by technology: "5G"
   - Test filtering by province: "Gauteng"
   - Verify monthly costs sum correctly

**✅ Verification Checklist:**
- [ ] XML file imported (10 towers)
- [ ] GPS coordinates stored as NUMBER
- [ ] Dates parsed correctly
- [ ] Map displays tower locations
- [ ] Technology chart shows distribution
- [ ] Can filter by 5G, 4G, Hybrid
- [ ] Form shows all XML fields

**💡 Pro Tip:** XML import is ideal for integrations with external systems that export structured data (SAP, Oracle ERP, monitoring tools).

---

## METHOD 5: Create from JSON File (20 minutes)

### Exercise 5.1: Import Device Catalog

**Use Case:** Device procurement team maintains device inventory as JSON (from API). Import 15 smartphones, tablets, and routers.

**Steps:**

1. **Review JSON File Structure**
   - File: `vodacom-devices.json`
   - Contains: Array of 15 devices
   - Structure:
     ```json
     {
       "vodacom_devices": [
         {
           "device_id": 1,
           "brand": "Samsung",
           "model": "Galaxy S24",
           "price_rand": 18999,
           "5g_supported": "Y"
         }
       ]
     }
     ```

2. **Upload JSON File**
   - App Builder → **Create**
   - **Create Application from a File**
   - Choose File: `vodacom-devices.json`
   - Click **Next**

3. **Configure JSON Import**
   ```
   Load To: New Table
   Table Name: VODACOM_DEVICE_CATALOG
   File Type: JSON
   Root Path: vodacom_devices
   Error Handling: Terminate on error
   ```
   - Click **Next**

4. **Map JSON Properties**
   ```
   device_id → NUMBER (Primary Key)
   brand → VARCHAR2(100)
   model → VARCHAR2(100)
   device_type → VARCHAR2(50)
   operating_system → VARCHAR2(50)
   screen_size_inches → NUMBER
   storage_gb → NUMBER
   ram_gb → NUMBER
   price_rand → NUMBER
   stock_quantity → NUMBER
   supplier → VARCHAR2(200)
   release_date → DATE
   vodacom_compatible → VARCHAR2(1)
   esim_supported → VARCHAR2(1)
   5g_supported → VARCHAR2(1)
   ```
   - Set **device_id** as Primary Key
   - Click **Load Data**

5. **Create Device Catalog Application**
   - Click **Create Application**
   - Name: `Vodacom Device Catalog`
   - Icon: `fa-mobile-alt`
   - Icon Color: `#E60000`
   - Add pages:
     - Dashboard (device distribution)
     - Interactive Report (searchable catalog)
     - Form (device details)
     - Cards view (visual catalog)
   - Click **Create Application**

6. **Customize Device Catalog**
   - Add **Cards Region** on Page 2:
     ```
     Type: Cards
     Title: &BRAND. &MODEL.
     Subtitle: R &PRICE_RAND.
     Body: &DEVICE_TYPE. | &STORAGE_GB. GB
     Secondary: 5G: &5G_SUPPORTED. | eSIM: &ESIM_SUPPORTED.
     Icon: fa-mobile-alt
     Badge: &STOCK_QUANTITY. in stock
     ```

7. **Add Filters**
   - Add **Faceted Search** filters:
     ```
     - Brand (Samsung, Apple, Huawei, Xiaomi)
     - Device Type (Smartphone, Tablet, Router, Smartwatch)
     - 5G Supported (Y/N)
     - eSIM Supported (Y/N)
     - Price Range (slider: 0 - 30000)
     ```

8. **Test Features**
   - Run application
   - View cards layout (visual catalog)
   - Filter by Brand: "Samsung"
   - Filter by Device Type: "Smartphone"
   - Filter by 5G: "Y"
   - Sort by Price (low to high)
   - Open Samsung Galaxy S24 details
   - Verify: 256 GB storage, R18,999, 5G supported

**✅ Verification Checklist:**
- [ ] JSON imported (15 devices)
- [ ] Nested JSON properties parsed
- [ ] Boolean fields (5G, eSIM) stored correctly
- [ ] Cards display device images/icons
- [ ] Filters work (brand, type, 5G)
- [ ] Price sorting works
- [ ] Stock quantity displayed
- [ ] Can edit device details

**💡 Pro Tip:** JSON import is perfect for REST API integrations. You can schedule automatic imports from external APIs.

---

## METHOD 6: Copy/Paste Data (15 minutes)

### Exercise 6.1: Create VodaPay Transaction Table from Copy/Paste

**Use Case:** Quick prototype needed! Finance team emails you 10 sample VodaPay transactions. Use copy/paste to instantly create table and app.

**Steps:**

1. **Copy Sample Data**
   
   Copy this tab-delimited data (Ctrl+C):
   ```
   TRANSACTION_ID	CUSTOMER_ID	TRANSACTION_DATE	TRANSACTION_TYPE	AMOUNT_RAND	MERCHANT_NAME	STATUS	REFERENCE
   1	1	2024-11-01	Payment	-250.00	Checkers	Completed	PAY-001
   2	1	2024-11-02	Top-up	500.00	Vodacom	Completed	TOP-001
   3	3	2024-11-03	Transfer	-1000.00	FNB	Completed	TRF-001
   4	5	2024-11-04	Payment	-125.50	Woolworths	Completed	PAY-002
   5	7	2024-11-05	Top-up	200.00	Vodacom	Completed	TOP-002
   6	3	2024-11-06	Payment	-350.00	Pick n Pay	Completed	PAY-003
   7	9	2024-11-07	Transfer	-500.00	Standard Bank	Failed	TRF-002
   8	11	2024-11-08	Payment	-89.99	Netflix	Completed	PAY-004
   9	13	2024-11-09	Top-up	100.00	Vodacom	Completed	TOP-003
   10	15	2024-11-10	Payment	-450.00	Uber	Completed	PAY-005
   ```

2. **Start Copy/Paste Wizard**
   - App Builder → **Create**
   - Select **Create Application from a File**
   - Click **Copy and Paste**

3. **Paste Data**
   - Paste the copied data (Ctrl+V)
   - APEX auto-detects columns and data
   - Click **Next**

4. **Configure Table**
   ```
   Load To: New Table
   Table Name: VODACOM_VODAPAY_TRANSACTIONS
   Separator: Tab-delimited (auto-detected)
   First Row Contains Headers: Yes
   ```
   - Click **Next**

5. **Map Columns**
   ```
   TRANSACTION_ID → NUMBER (Primary Key)
   CUSTOMER_ID → NUMBER
   TRANSACTION_DATE → DATE
   TRANSACTION_TYPE → VARCHAR2(50)
   AMOUNT_RAND → NUMBER
   MERCHANT_NAME → VARCHAR2(200)
   STATUS → VARCHAR2(50)
   REFERENCE → VARCHAR2(100)
   ```
   - Set **TRANSACTION_ID** as Primary Key
   - Add **Foreign Key**: CUSTOMER_ID → VODACOM_CUSTOMERS(CUSTOMER_ID)
   - Click **Load Data**

6. **Create VodaPay Application**
   - Click **Create Application**
   - Name: `VodaPay Transaction Monitor`
   - Icon: `fa-credit-card`
   - Icon Color: `#E60000`
   - Click **Create Application**

7. **Enhance Application**
   - Add **Dashboard** page:
     ```
     Chart 1: Transaction Types (Pie)
     Chart 2: Transaction Status (Donut)
     Chart 3: Daily Transaction Volume (Line)
     Chart 4: Top Merchants (Bar)
     ```

8. **Add Conditional Formatting**
   - Edit Interactive Report
   - Add **Highlight**:
     ```
     Name: Failed Transactions
     Condition: STATUS = 'Failed'
     Background Color: #ff0000
     Text Color: #ffffff
     ```

9. **Test Application**
   - Run application
   - Verify 10 transactions loaded
   - Filter by Status: "Completed"
   - Filter by Transaction Type: "Payment"
   - Check total amount calculations
   - Sort by AMOUNT_RAND (highest first)
   - Verify failed transaction highlighted red

**✅ Verification Checklist:**
- [ ] Data pasted successfully (10 rows)
- [ ] Columns auto-detected correctly
- [ ] Dates parsed as DATE type
- [ ] Negative amounts stored correctly
- [ ] Interactive Report displays all transactions
- [ ] Failed transaction highlighted
- [ ] Can filter by status
- [ ] Can add new transactions

**💡 Pro Tip:** Copy/paste is the **fastest method** for quick prototypes. Copy from Excel, Google Sheets, or even email tables!

---

## METHOD 7: Quick SQL (25 minutes)

### Exercise 7.1: Generate Complete VodaPay Schema with Quick SQL

**Use Case:** Design a complete VodaPay database schema using shorthand notation. Quick SQL generates tables, relationships, sample data, and application in seconds.

**What is Quick SQL?**
Quick SQL lets you design databases using simple indented text (like YAML). APEX generates:
- CREATE TABLE statements
- Primary keys, foreign keys, check constraints
- Indexes
- Sample data
- Complete APEX application

**Steps:**

1. **Open Quick SQL**
   - APEX home → **SQL Workshop**
   - Click **Utilities**
   - Select **Quick SQL**

2. **Write Quick SQL Script**
   
   Paste this VodaPay schema definition:
   ```
   # VodaPay Wallet System Schema
   # Generated for Vodacom
   
   vodapay_wallets
     wallet_number /unique
     customer_id /references vodacom_customers
     wallet_status
     balance_rand num
     daily_limit_rand num
     kyc_verified
     created_date
     last_transaction_date
   
   vodapay_transactions
     transaction_id
     wallet_id /references vodapay_wallets
     transaction_type
     amount_rand num
     merchant_name
     merchant_id
     transaction_date
     status
     reference_number /unique
     description
   
   vodapay_merchants
     merchant_id
     merchant_name /unique
     merchant_type
     registration_number
     contact_person
     phone
     email
     bank_account
     commission_rate num
     status
     registered_date
   
   vodapay_cashbacks
     cashback_id
     transaction_id /references vodapay_transactions
     cashback_amount_rand num
     cashback_percentage num
     cashback_date
     status
   
   vodapay_limits
     limit_id
     limit_type
     daily_limit_rand num
     monthly_limit_rand num
     per_transaction_limit num
     effective_date
   ```

3. **Preview Generated SQL**
   - Click **Generate SQL** button
   - APEX generates ~200+ lines of SQL:
     - CREATE TABLE statements (5 tables)
     - Primary key constraints
     - Foreign key relationships
     - Indexes on foreign keys
     - Sample data INSERT statements
     - Column comments

4. **Customize Settings (Optional)**
   - Click **Settings** (gear icon)
   - Options:
     ```
     Primary Key: Defaults to ID columns
     Audit Columns: Add created_by, updated_date
     Row Version Number: Add for optimistic locking
     Prefix: VODAPAY_
     Data Size: 10 rows per table
     ```

5. **Review Generated Tables**
   ```
   VODAPAY_WALLETS (with FK to VODACOM_CUSTOMERS)
   VODAPAY_TRANSACTIONS (with FK to VODAPAY_WALLETS)
   VODAPAY_MERCHANTS
   VODAPAY_CASHBACKS (with FK to VODAPAY_TRANSACTIONS)
   VODAPAY_LIMITS
   ```

6. **Save to SQL Scripts**
   - Click **Save SQL Script**
   - Name: `VodaPay Schema - Quick SQL Generated`
   - Click **Save**

7. **Execute SQL**
   - Click **Review and Run** button
   - Verify: "5 tables will be created"
   - Click **Run**
   - Wait for "Script executed successfully"

8. **Verify Tables Created**
   - SQL Workshop → **Object Browser**
   - Verify 5 new tables exist:
     - VODAPAY_WALLETS (10 sample rows)
     - VODAPAY_TRANSACTIONS (10 sample rows)
     - VODAPAY_MERCHANTS (10 sample rows)
     - VODAPAY_CASHBACKS (10 sample rows)
     - VODAPAY_LIMITS (10 sample rows)

9. **Create Application from Quick SQL**
   - Back in Quick SQL → Click **Create App**
   - APEX generates complete application:
     ```
     Application Name: VodaPay Management System
     Pages:
       - Dashboard (5 charts)
       - Wallets (Interactive Report + Form)
       - Transactions (Interactive Report + Form)
       - Merchants (Interactive Report + Form)
       - Cashbacks (Interactive Report + Form)
       - Limits (Interactive Report + Form)
     Navigation: Complete menu structure
     ```
   - Click **Create Application**

10. **Test Complete VodaPay System**
    - Run application
    - Dashboard shows:
      - Total wallets: 10
      - Total transactions: 10
      - Top merchants
      - Cashback summary
    - Navigate through all pages
    - Test master-detail relationships
    - Add a new wallet
    - Add a new transaction

**✅ Verification Checklist:**
- [ ] Quick SQL script written (5 tables)
- [ ] SQL generated (200+ lines)
- [ ] All 5 tables created
- [ ] Foreign keys created correctly
- [ ] Sample data inserted (10 rows each)
- [ ] Application created (8+ pages)
- [ ] Navigation menu complete
- [ ] Forms show relationships

**💡 Pro Tip:** Quick SQL is the **best method for complex schemas**. Design 20+ tables in minutes. Perfect for prototyping entire systems!

**Quick SQL Shorthand Reference:**
```
/unique      → Add UNIQUE constraint
/nn          → NOT NULL constraint
/check       → CHECK constraint
/references  → Foreign key
num          → NUMBER data type
vc500        → VARCHAR2(500)
date         → DATE type
```

---

## METHOD 8: Starter Application with Oracle Fusion Integration (30 minutes)

### Exercise 8.1: Create ERP-Integrated Application

**Use Case:** Vodacom uses **Oracle Fusion Cloud ERP** for finance/procurement. Create a starter application with pre-configured REST integrations.

**What are Starter Apps?**
Starter Apps are pre-built APEX applications with:
- Pre-configured REST Data Sources
- OAuth 2.0 authentication
- Sample pages and queries
- Best practice code
- Production-ready security

**Prerequisites:**
- Oracle Fusion Cloud instance (or use sample/demo mode)
- REST API credentials (or use demo credentials)

**Steps:**

1. **Open App Gallery**
   - App Builder → **Create**
   - Select **Create App from a Starter App**

2. **Browse Starter Apps**
   - Search: "Oracle Fusion"
   - Available starters:
     - **Oracle Fusion Cloud HCM** (Human Capital Management)
     - **Oracle Fusion Cloud ERP** (Enterprise Resource Planning)
     - **Oracle Fusion Cloud SCM** (Supply Chain Management)
     - **Oracle Integration Cloud** (OIC)

3. **Select Oracle Fusion ERP Starter**
   - Click **Oracle Fusion Cloud ERP**
   - Preview shows:
     ```
     Features:
     - Invoice Management
     - Purchase Orders
     - Expense Reports
     - Supplier Management
     - GL Account Balances
     - Pre-configured REST endpoints
     - OAuth 2.0 authentication
     ```

4. **Configure Application**
   ```
   Application Name: Vodacom ERP Integration
   Schema: Your workspace schema
   Application ID: Auto-generate
   ```

5. **Configure Oracle Fusion Connection**
   
   **Option A: Use Your Fusion Instance**
   ```
   Fusion Instance URL: https://your-instance.fa.em2.oraclecloud.com
   Username: your-fusion-user@vodacom.co.za
   Password: ****************
   Client ID: (from Fusion > Tools > Configuration > Trusted Applications)
   Client Secret: ****************
   ```
   
   **Option B: Use Demo/Sandbox**
   ```
   Use Sample Data: Yes (checked)
   Demo Mode: Yes
   ```
   
   For this lab, select **Option B (Demo Mode)**

6. **Create Application**
   - Review configuration
   - Click **Create Application**
   - APEX creates:
     - 15+ pages
     - REST Data Sources (pre-configured)
     - Web Credentials (OAuth 2.0)
     - Invoices, POs, Expenses pages
     - Sample data (demo mode)

7. **Explore Pre-Built Pages**
   
   **Page 2: Invoice Management**
   - Lists all invoices from Fusion ERP
   - Filters: Status, Supplier, Date Range
   - Actions: View details, Download PDF, Approve
   
   **Page 3: Purchase Orders**
   - Lists all POs
   - Master-detail view (header + lines)
   - Actions: Create PO, Update PO, Submit for approval
   
   **Page 4: Expense Reports**
   - Employee expense submissions
   - Receipt image uploads
   - Approval workflow
   
   **Page 5: Supplier Management**
   - Supplier catalog
   - Registration requests
   - Bank details

8. **Configure Vodacom-Specific Customizations**
   
   **Add Vodacom Branding:**
   - Shared Components → User Interface Attributes
   - Logo: Upload Vodacom logo
   - Icon Color: #E60000
   
   **Customize Invoice Report:**
   - Edit Page 2
   - Add SQL filter:
     ```sql
     WHERE business_unit IN ('Vodacom RSA', 'Vodacom Corporate')
     ```
   
   **Add VodaPay Payment Integration:**
   - Create new page: "Pay Invoice via VodaPay"
   - Add process to call VodaPay API
   - Link from Invoice page

9. **Test REST Integrations**
   
   **Test Invoice Retrieval:**
   - Run application
   - Navigate to Invoices
   - Verify data loads from Fusion Cloud
   - Test filters (Status, Supplier)
   - Test sorting
   
   **Test Purchase Order Creation:**
   - Click "Create PO"
   - Fill in form:
     ```
     Supplier: Huawei South Africa
     Item: Network Equipment
     Quantity: 100
     Unit Price: R50,000
     Total: R5,000,000
     ```
   - Submit to Fusion Cloud
   - Verify PO created in Fusion

10. **Review REST Data Sources**
    - Shared Components → **Data Sources**
    - Pre-configured sources:
      ```
      - fusion_invoices (GET /fscmRestApi/resources/invoices)
      - fusion_purchase_orders (GET /fscmRestApi/resources/purchaseOrders)
      - fusion_suppliers (GET /fscmRestApi/resources/suppliers)
      - fusion_expense_reports (GET /fscmRestApi/resources/expenseReports)
      - fusion_gl_balances (GET /fscmRestApi/resources/generalLedgerBalances)
      ```
    - Each has OAuth 2.0 configured

11. **Review Web Credentials (OAuth)**
    - Shared Components → **Web Credentials**
    - Credential: `fusion_cloud_oauth`
    - Type: OAuth 2.0 Client Credentials
    - Configured with:
      - Authorization URL
      - Token URL
      - Client ID/Secret
      - Scopes

**✅ Verification Checklist:**
- [ ] Starter app created (15+ pages)
- [ ] REST Data Sources configured
- [ ] OAuth 2.0 authentication working
- [ ] Invoice page displays data
- [ ] Can filter/search invoices
- [ ] PO page shows purchase orders
- [ ] Expense report submission works
- [ ] Supplier catalog displays
- [ ] Demo/sample data loads correctly

**💡 Pro Tip:** Starter Apps save **100+ hours** of integration development. Use them for any Oracle Cloud service (ERP, HCM, SCM, OIC, Eloqua).

**Common Starter Apps:**
- Oracle Integration Cloud (OIC)
- Oracle HCM Cloud
- Oracle CPQ Cloud
- Oracle Eloqua Marketing
- Oracle Content Management
- Salesforce (via REST)
- Microsoft Dynamics

---

## METHOD 9: Application Blueprint (15 minutes)

### Exercise 9.1: Use Sample Datasets Blueprint

**Use Case:** Need a feature-rich demo app instantly? Use blueprints with pre-built sample data.

**Steps:**

1. **Access Blueprints**
   - App Builder → **Create**
   - Select **Create App from a Blueprint**

2. **Browse Available Blueprints**
   - **Sample Database Application** (Employee management)
   - **Sample Reporting** (Charts and dashboards)
   - **Sample Desktop** (Desktop-optimized UI)
   - **Sample Mobile** (Mobile-first design)
   - **Demonstration Application** (All APEX features)
   - **Productivity Apps** (Projects, tasks, files)

3. **Select Sample Database Application**
   - Click **Sample Database Application**
   - Preview shows:
     - Dashboard
     - Interactive reports
     - Forms
     - Calendar
     - Trees
     - Charts
     - Sample data included

4. **Create Application**
   ```
   Application Name: Vodacom Demo Showcase
   Schema: Your workspace schema
   Install Supporting Objects: Yes
   ```
   - Click **Create Application**

5. **Customize for Vodacom**
   - Replace "Employees" with "Vodacom Staff"
   - Replace "Projects" with "Network Rollouts"
   - Replace "Tasks" with "Service Tickets"
   - Change theme colors to Vodacom red (#E60000)

6. **Run and Explore**
   - 20+ pages with all APEX features
   - Use as reference for your own apps

**✅ Verification:**
- [ ] Blueprint installed successfully
- [ ] 20+ pages created
- [ ] Sample data loaded
- [ ] All features working
- [ ] Can customize for Vodacom use case

---

## Comparison of All Methods

| Method | Best For | Speed | Complexity | Learning Curve |
|--------|----------|-------|------------|----------------|
| **Wizard** | Existing database tables | ⭐⭐⭐ | Low | Easy |
| **CSV Upload** | Tabular data, Excel exports | ⭐⭐⭐⭐⭐ | Very Low | Very Easy |
| **Excel (XLSX)** | Excel files with dates/numbers | ⭐⭐⭐⭐⭐ | Very Low | Very Easy |
| **XML Upload** | System integrations (SAP, Oracle) | ⭐⭐⭐⭐ | Low | Easy |
| **JSON Upload** | API responses, modern systems | ⭐⭐⭐⭐ | Low | Easy |
| **Copy/Paste** | Quick prototypes, email data | ⭐⭐⭐⭐⭐ | Very Low | Very Easy |
| **Quick SQL** | Complex schemas (10+ tables) | ⭐⭐⭐⭐⭐ | Medium | Medium |
| **Starter Apps** | Oracle Cloud integrations | ⭐⭐⭐⭐ | Medium | Medium |
| **Blueprints** | Demo/reference apps | ⭐⭐⭐⭐⭐ | Very Low | Easy |

**Recommendation for Vodacom:**
- **Customer data:** Use **Wizard** (tables exist)
- **Package catalogs:** Use **CSV** (sales team has Excel)
- **Network towers:** Use **XML** (monitoring system exports)
- **Device inventory:** Use **JSON** (API integration)
- **Quick prototypes:** Use **Copy/Paste**
- **New systems:** Use **Quick SQL** (design entire schema)
- **ERP integration:** Use **Starter Apps**
- **Demos/Training:** Use **Blueprints**

---

## Business Impact Summary

**Time Savings Demonstrated Today:**

| Method | Traditional (Java/PHP) | APEX Time | Time Saved |
|--------|------------------------|-----------|------------|
| Customer Portal (Wizard) | 40 hours | 30 minutes | 98.75% |
| Package Catalog (CSV) | 25 hours | 10 minutes | 99.33% |
| Retail Stores (Excel) | 25 hours | 10 minutes | 99.33% |
| Network Towers (XML) | 30 hours | 15 minutes | 99.17% |
| Device Catalog (JSON) | 30 hours | 15 minutes | 99.17% |
| VodaPay Transactions (Copy/Paste) | 20 hours | 5 minutes | 99.58% |
| VodaPay System (Quick SQL) | 80 hours | 20 minutes | 99.58% |
| ERP Integration (Starter) | 120 hours | 25 minutes | 99.65% |
| **TOTAL** | **370 hours** | **130 minutes** | **99.42%** |

**Cost Savings:**
- Traditional development: 370 hours × R1,500/hour = **R555,000**
- APEX development: 2.17 hours × R1,500/hour = **R3,255**
- **Savings: R551,745 (99.4%)**

**Additional Benefits:**
- 8 production-ready applications in 2 hours
- All applications mobile-responsive
- Built-in security (authentication, authorization)
- Automatic audit trails
- RESTful APIs auto-generated
- Zero infrastructure setup
- Integrated with Oracle Fusion Cloud

---

## Appendix A: Copy/Paste Sample Data

If sample files are unavailable, copy/paste this data directly:

### VodaPay Transactions (Copy/Paste)
```
TRANSACTION_ID	CUSTOMER_ID	TRANSACTION_DATE	TRANSACTION_TYPE	AMOUNT_RAND	MERCHANT_NAME	STATUS	REFERENCE
1	1	2024-11-01	Payment	-250.00	Checkers	Completed	PAY-001
2	1	2024-11-02	Top-up	500.00	Vodacom	Completed	TOP-001
3	3	2024-11-03	Transfer	-1000.00	FNB	Completed	TRF-001
4	5	2024-11-04	Payment	-125.50	Woolworths	Completed	PAY-002
5	7	2024-11-05	Top-up	200.00	Vodacom	Completed	TOP-002
6	3	2024-11-06	Payment	-350.00	Pick n Pay	Completed	PAY-003
7	9	2024-11-07	Transfer	-500.00	Standard Bank	Failed	TRF-002
8	11	2024-11-08	Payment	-89.99	Netflix	Completed	PAY-004
9	13	2024-11-09	Top-up	100.00	Vodacom	Completed	TOP-003
10	15	2024-11-10	Payment	-450.00	Uber	Completed	PAY-005
```

### Customer Support Tickets (Copy/Paste)
```
TICKET_ID	CUSTOMER_ID	SUBJECT	DESCRIPTION	PRIORITY	STATUS	CREATED_DATE	RESOLVED_DATE
1	1	Data not working	Cannot access internet	High	Closed	2024-11-01	2024-11-01
2	3	VodaPay issue	Transaction failed	Critical	Open	2024-11-02	
3	5	Billing query	Overcharged this month	Medium	In Progress	2024-11-03	
4	7	Network coverage	Poor signal in area	Low	Open	2024-11-04	
5	9	Upgrade request	Want to upgrade to 5G	Medium	Closed	2024-11-05	2024-11-06
```

---

## Troubleshooting Guide

### CSV Import Issues
**Problem:** "Invalid column names"
- **Solution:** Ensure first row contains headers (no spaces in column names)

**Problem:** "Date parsing error"
- **Solution:** Use format YYYY-MM-DD or DD-MON-YYYY

### Excel Import Issues
**Problem:** "Sheet not found"
- **Solution:** Verify sheet name (Sheet1, Data, etc.)

**Problem:** "Special characters garbled"
- **Solution:** Save Excel as UTF-8 CSV first, then import

### XML Import Issues
**Problem:** "Root element not found"
- **Solution:** Specify correct root element name (case-sensitive)

**Problem:** "Nested elements not imported"
- **Solution:** APEX imports only direct child elements. Flatten XML first.

### JSON Import Issues
**Problem:** "Invalid JSON"
- **Solution:** Validate JSON at jsonlint.com before importing

**Problem:** "Array not detected"
- **Solution:** Specify correct root path (e.g., "employees.employee")

### Quick SQL Issues
**Problem:** "Foreign key error"
- **Solution:** Ensure referenced table exists first or generate all tables together

**Problem:** "Syntax error"
- **Solution:** Use correct indentation (2 spaces per level)

### Starter App Issues
**Problem:** "OAuth authentication failed"
- **Solution:** Use Demo Mode for this lab. In production, get correct credentials from Oracle Cloud admin.

---

## Verification Checklist - All Methods

- [ ] **Method 1:** Customer Portal created from wizard (6+ pages)
- [ ] **Method 2:** Package Catalog imported from CSV (25 packages)
- [ ] **Method 3:** Retail Stores imported from Excel (15 stores)
- [ ] **Method 4:** Network Towers imported from XML (10 towers)
- [ ] **Method 5:** Device Catalog imported from JSON (15 devices)
- [ ] **Method 6:** VodaPay Transactions created from copy/paste (10 transactions)
- [ ] **Method 7:** VodaPay System generated with Quick SQL (5 tables)
- [ ] **Method 8:** ERP Integration created from Starter App (15+ pages)
- [ ] **Method 9:** Demo Showcase created from Blueprint (20+ pages)
- [ ] **Total:** 8+ complete applications created
- [ ] **Time:** Completed in ~120 minutes
- [ ] **Cost Savings:** R550,000+ demonstrated

---

## Congratulations! 🎉

You've mastered **ALL 9 methods** of creating APEX applications!

**What You've Accomplished:**
- ✅ Created 8+ complete Vodacom applications
- ✅ Imported data from 4 different formats (CSV, Excel, XML, JSON)
- ✅ Used Quick SQL to generate complex schemas
- ✅ Integrated with Oracle Fusion Cloud ERP
- ✅ Demonstrated 99.4% development time savings
- ✅ Saved Vodacom R550,000+ in development costs

**Next Steps:**
- Lab 03: Enhance these applications with Page Designer
- Lab 04: Add advanced reports and forms
- Lab 05: Implement navigation and controls
- Lab 06: Secure applications and optimize performance
- Lab 07: Deploy to Vodacom production

**Skills Gained:**
- Know when to use each creation method
- Import data from any format
- Integrate with Oracle Cloud services
- Design databases with Quick SQL
- Build production-ready apps in minutes

---

**Ready for Lab 03?** Continue to [Lab 03: Pages and Page Designer →](lab-03-pages-and-page-designer-vodacom.md)

**Questions?** Contact your Vodacom APEX training coordinator.

---

**End of Lab 02 - Extended Version**
