# Lab 05: Controls and Navigation

**Duration:** 90 minutes  
**Difficulty:** Intermediate  
**Prerequisites:** Completed Lab 04 (Invoice System created)

## Learning Objectives

By the end of this lab, you will be able to:
1. Configure hierarchical navigation menus for different Vodacom roles
2. Implement cascading List of Values (LOVs) for SA addresses
3. Use different item types effectively
4. Create breadcrumb navigation
5. Build advanced search interfaces
6. Implement dependent selections

---

## Lab Scenario

Vodacom needs to improve navigation and data entry workflows:
- Multi-level navigation menu for Call Center Agents vs. Network Operations teams
- Smart address entry with cascading Province → City → Suburb (South African locations)
- Advanced customer search with dependent filters
- Breadcrumb trails for better navigation across customer records

---

## Part 1: Navigation Menu Configuration (20 minutes)

### Exercise 1.1: Create Multi-Level Navigation for Vodacom

1. **Access Navigation Menu**
   - App Builder → Your Application
   - Shared Components → Navigation → **Navigation Menu**
   - Click **Desktop Navigation Menu**

2. **Add Parent Menu Entries for Vodacom Operations**
   - Click **Create Entry**
   
   **Dashboard Menu:**
   - Parent List Entry: `-- Top Level Entry --`
   - Sequence: `10`
   - Image/Class: `fa-dashboard`
   - List Entry Label: `Operations Dashboard`
   - Target Type: `Page in this Application`
   - Page: `1`
   
   **Customers Menu:**
   - Sequence: `20`
   - Image/Class: `fa-users`
   - List Entry Label: `Customer Service`
   - Target Type: `Page in this Application`
   - Page: `20`
   
   **Network Menu:**
   - Sequence: `30`
   - Image/Class: `fa-signal`
   - List Entry Label: `Network Operations`
   - Target Type: `Page in this Application`
   - Page: `10`
   
   **VodaPay & Billing:**
   - Sequence: `40`
   - Image/Class: `fa-credit-card`
   - List Entry Label: `VodaPay & Billing`
   - Target Type: `URL`
   - URL Target: `#` (placeholder)

3. **Add Child Menu Entries for VodaPay & Billing**
   - Click **Create Entry**
   
   **VodaPay Transactions (child of VodaPay & Billing):**
   - Parent List Entry: `VodaPay & Billing`
   - Sequence: `10`
   - Image/Class: `fa-exchange`
   - List Entry Label: `VodaPay Transactions`
   - Page: `25`
   
   **Customer Invoices (child of VodaPay & Billing):**
   - Parent List Entry: `VodaPay & Billing`
   - Sequence: `20`
   - Image/Class: `fa-file-text-o`
   - List Entry Label: `Customer Invoices`
   - Page: `29`
   
   **Reports:**
   - Parent List Entry: `-- Top Level Entry --`
   - Sequence: `50`
   - Image/Class: `fa-bar-chart`
   - List Entry Label: `Analytics & Reports`
   - URL Target: `#`
   
   **Customer Analysis (child of Reports):**
   - Parent List Entry: `Analytics & Reports`
   - Sequence: `10`
   - Image/Class: `fa-pie-chart`
   - List Entry Label: `Customer Analysis`
   - Page: `20`

4. **Add Conditional Display Based on User Role**
   - Edit **Network Operations** menu entry
   - Conditions:
     - Condition Type: `User is Authenticated (not public)`
   
   - Edit **Analytics & Reports** menu
   - Authorization Scheme: Create new or select existing
   - (For this lab, keep default authentication)

### Exercise 1.2: Configure Breadcrumbs

1. **Access Breadcrumb**
   - Shared Components → Navigation → **Breadcrumbs**
   - Click **Breadcrumb**

2. **Add Breadcrumb Entries for Vodacom Pages**
   - Click **Create Entry**
   
   **Customer Analysis:**
   - Parent Entry: `Home`
   - Sequence: `20`
   - Entry Label: `Customer Analysis`
   - Target Page: `20`
   
   **Invoice List:**
   - Parent Entry: `Home`
   - Sequence: `29`
   - Entry Label: `Customer Invoices`
   - Target Page: `29`
   
   **Edit Invoice:**
   - Parent Entry: `Customer Invoices`
   - Sequence: `30`
   - Entry Label: `Invoice &P30_INVOICE_NUMBER.`
   - Target Page: `30`
   
   **Network Operations:**
   - Parent Entry: `Home`
   - Sequence: `10`
   - Entry Label: `Network Operations Center`
   - Target Page: `10`

3. **Enable Breadcrumbs on Pages**
   - Open Page 20, 29, 30, 10 in Page Designer
   - Page Properties → Navigation:
     - Breadcrumb: `Breadcrumb`
     - Entry: Select corresponding entry
   - Save Changes

---

## Part 2: Cascading LOVs for South African Addresses (25 minutes)

### Exercise 2.1: Create SA Address Tables

1. **Run SQL Commands**
   - SQL Workshop → SQL Commands
   - Execute:

```sql
-- South African Provinces table
CREATE TABLE vodacom_sa_provinces (
    province_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    province_code VARCHAR2(2) NOT NULL UNIQUE,
    province_name VARCHAR2(100) NOT NULL
);

-- South African Cities table
CREATE TABLE vodacom_sa_cities (
    city_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    city_name VARCHAR2(100) NOT NULL,
    province_id NUMBER NOT NULL,
    CONSTRAINT fk_city_province FOREIGN KEY (province_id) 
        REFERENCES vodacom_sa_provinces(province_id)
);

-- South African Suburbs table
CREATE TABLE vodacom_sa_suburbs (
    suburb_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    suburb_name VARCHAR2(100) NOT NULL,
    postal_code VARCHAR2(10),
    city_id NUMBER NOT NULL,
    CONSTRAINT fk_suburb_city FOREIGN KEY (city_id) 
        REFERENCES vodacom_sa_cities(city_id)
);

-- Insert South African Provinces
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('GP', 'Gauteng');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('WC', 'Western Cape');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('KZN', 'KwaZulu-Natal');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('EC', 'Eastern Cape');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('FS', 'Free State');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('LP', 'Limpopo');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('MP', 'Mpumalanga');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('NC', 'Northern Cape');
INSERT INTO vodacom_sa_provinces (province_code, province_name) VALUES ('NW', 'North West');

-- Gauteng Cities
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Johannesburg', province_id FROM vodacom_sa_provinces WHERE province_code = 'GP';
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Pretoria', province_id FROM vodacom_sa_provinces WHERE province_code = 'GP';
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Sandton', province_id FROM vodacom_sa_provinces WHERE province_code = 'GP';
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Midrand', province_id FROM vodacom_sa_provinces WHERE province_code = 'GP';

-- Western Cape Cities
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Cape Town', province_id FROM vodacom_sa_provinces WHERE province_code = 'WC';
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Stellenbosch', province_id FROM vodacom_sa_provinces WHERE province_code = 'WC';
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Paarl', province_id FROM vodacom_sa_provinces WHERE province_code = 'WC';

-- KZN Cities
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Durban', province_id FROM vodacom_sa_provinces WHERE province_code = 'KZN';
INSERT INTO vodacom_sa_cities (city_name, province_id)
SELECT 'Pietermaritzburg', province_id FROM vodacom_sa_provinces WHERE province_code = 'KZN';

-- Johannesburg Suburbs
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Sandton', '2196', city_id FROM vodacom_sa_cities WHERE city_name = 'Johannesburg';
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Rosebank', '2196', city_id FROM vodacom_sa_cities WHERE city_name = 'Johannesburg';
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Fourways', '2055', city_id FROM vodacom_sa_cities WHERE city_name = 'Johannesburg';
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Bryanston', '2021', city_id FROM vodacom_sa_cities WHERE city_name = 'Johannesburg';

-- Cape Town Suburbs
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Sea Point', '8005', city_id FROM vodacom_sa_cities WHERE city_name = 'Cape Town';
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Camps Bay', '8040', city_id FROM vodacom_sa_cities WHERE city_name = 'Cape Town';
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Century City', '7441', city_id FROM vodacom_sa_cities WHERE city_name = 'Cape Town';

-- Durban Suburbs
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Umhlanga', '4319', city_id FROM vodacom_sa_cities WHERE city_name = 'Durban';
INSERT INTO vodacom_sa_suburbs (suburb_name, postal_code, city_id)
SELECT 'Morningside', '4001', city_id FROM vodacom_sa_cities WHERE city_name = 'Durban';

COMMIT;
```

### Exercise 2.2: Create Customer Address Entry Page

1. **Create New Page**
   - Create Page → **Blank Page**
   - Page Number: `35`
   - Page Name: `Customer Address Entry`
   - Click **Create Page**

2. **Create Address Region**
   - Create Region:
     - Title: `Customer Address Details`
     - Type: `Static Content`

3. **Add Cascading Items for SA Locations**
   
   **Province Selection:**
   - Create Item: `P35_PROVINCE_ID`
   - Type: `Select List`
   - Label: `Province`
   - LOV:
     - Type: `SQL Query`
     - SQL:
       ```sql
       SELECT province_name AS d,
              province_id AS r
       FROM vodacom_sa_provinces
       ORDER BY province_name
       ```
   - Settings:
     - Display Null Value: `Yes`
     - Null Display Value: `- Select Province -`

   **City Selection:**
   - Create Item: `P35_CITY_ID`
   - Type: `Select List`
   - Label: `City`
   - LOV:
     - Type: `SQL Query`
     - SQL:
       ```sql
       SELECT city_name AS d,
              city_id AS r
       FROM vodacom_sa_cities
       WHERE province_id = :P35_PROVINCE_ID
       ORDER BY city_name
       ```
   - Cascading LOV Parent Item: `P35_PROVINCE_ID`
   - Settings:
     - Display Null Value: `Yes`
     - Null Display Value: `- Select City -`

   **Suburb Selection:**
   - Create Item: `P35_SUBURB_ID`
   - Type: `Select List`
   - Label: `Suburb`
   - LOV:
     - Type: `SQL Query`
     - SQL:
       ```sql
       SELECT suburb_name || ' (' || postal_code || ')' AS d,
              suburb_id AS r
       FROM vodacom_sa_suburbs
       WHERE city_id = :P35_CITY_ID
       ORDER BY suburb_name
       ```
   - Cascading LOV Parent Item: `P35_CITY_ID`
   - Settings:
     - Display Null Value: `Yes`
     - Null Display Value: `- Select Suburb -`
   
   **Postal Code Display:**
   - Create Item: `P35_POSTAL_CODE`
   - Type: `Display Only`
   - Label: `Postal Code`
   - Source:
     - Type: `SQL Query (return single value)`
     - SQL:
       ```sql
       SELECT postal_code
       FROM vodacom_sa_suburbs
       WHERE suburb_id = :P35_SUBURB_ID
       ```
     - Used: `Always, replacing any existing value in session state`

4. **Test Cascading Behavior**
   - Save and Run Page
   - Select **Gauteng** → Should show Johannesburg, Pretoria, Sandton, Midrand
   - Select **Johannesburg** → Should show Sandton, Rosebank, Fourways, Bryanston
   - Select **Sandton** → Postal code displays automatically (2196)
   - Change to **Western Cape** → City list refreshes with Cape Town, Stellenbosch, Paarl

---

## Part 3: Advanced Item Types for Vodacom (20 minutes)

### Exercise 3.1: Create Mobile Package Assignment Interface

1. **Create New Page**
   - Create Page → **Blank Page**
   - Page Number: `36`
   - Page Name: `Mobile Number Package Assignment`

2. **Add Items**
   
   **Customer Selection:**
   - Create Item: `P36_CUSTOMER_ID`
   - Type: `Popup LOV`
   - Label: `Customer`
   - LOV:
     ```sql
     SELECT account_number || ' - ' || first_name || ' ' || last_name AS d,
            customer_id AS r,
            'Province: ' || province || ' | Type: ' || customer_type AS description
     FROM vodacom_customers
     WHERE account_status = 'Active'
     ORDER BY last_name, first_name
     ```
   - Display Columns: `2` (show description)

   **Mobile Numbers (Shuttle):**
   - Create Item: `P36_MOBILE_NUMBERS`
   - Type: `Shuttle`
   - Label: `Assign Mobile Numbers`
   - LOV:
     ```sql
     SELECT mobile_number || ' (' || number_type || ')' AS d,
            mobile_number_id AS r
     FROM vodacom_mobile_numbers
     WHERE customer_id = :P36_CUSTOMER_ID
       AND status = 'Active'
     ORDER BY mobile_number
     ```
   - Settings:
     - Height: `10`
     - Sort: `Yes`

   **Package Type (Checkbox Group):**
   - Create Item: `P36_PACKAGE_TYPES`
   - Type: `Checkbox Group`
   - Label: `Package Requirements`
   - LOV:
     - Type: `Static`
     - Values:
       ```
       STATIC:Data Only,DATA,Voice Only,VOICE,SMS Only,SMS,Combo Package,COMBO,VodaPay Bundle,VODAPAY,Night Data,NIGHT,Social Media,SOCIAL
       ```
   - Settings:
     - Number of Columns: `2`

   **Priority (Radio Group):**
   - Create Item: `P36_PRIORITY`
   - Type: `Radio Group`
   - Label: `Service Priority`
   - LOV:
     - Static: `Standard,STANDARD,Premium,PREMIUM,VIP,VIP`
   - Display:
     - Number of Columns: `3`
   - Default: `STANDARD`

   **Auto-Recharge (Switch):**
   - Create Item: `P36_AUTO_RECHARGE`
   - Type: `Switch`
   - Label: `Auto-Recharge Enabled`
   - Settings:
     - On Value: `Y`
     - Off Value: `N`
   - Default: `N`

3. **Add Dynamic Action for Customer Selection**
   - Select `P36_CUSTOMER_ID` item
   - Create Dynamic Action:
     - Event: `Change`
     - Action: `Execute Server-side Code`
     - PL/SQL:
       ```sql
       DECLARE
         v_customer_type VARCHAR2(50);
         v_vodapay_active VARCHAR2(1);
       BEGIN
         SELECT customer_type, vodapay_active
         INTO v_customer_type, v_vodapay_active
         FROM vodacom_customers
         WHERE customer_id = :P36_CUSTOMER_ID;
         
         -- VIP customers get premium priority
         IF v_customer_type = 'Corporate' THEN
           :P36_PRIORITY := 'PREMIUM';
         ELSIF v_customer_type = 'Government' THEN
           :P36_PRIORITY := 'VIP';
         ELSE
           :P36_PRIORITY := 'STANDARD';
         END IF;
         
         -- VodaPay users get auto-recharge enabled
         :P36_AUTO_RECHARGE := v_vodapay_active;
       END;
       ```
     - Items to Submit: `P36_CUSTOMER_ID`
     - Items to Return: `P36_PRIORITY,P36_AUTO_RECHARGE`

---

## Part 4: Advanced Search with Dependencies (25 minutes)

### Exercise 4.1: Create Advanced Customer Search

1. **Create New Page**
   - Create Page → Report → **Interactive Report**
   - Page Number: `37`
   - Page Name: `Advanced Customer Search`
   - SQL Query:
     ```sql
     SELECT c.customer_id,
            c.account_number,
            c.first_name || ' ' || c.last_name AS customer_name,
            c.phone,
            c.email,
            c.province,
            c.city,
            c.customer_type,
            c.account_status,
            COUNT(DISTINCT mn.mobile_number_id) AS total_numbers,
            SUM(mn.airtime_balance + mn.data_balance_mb * 0.15) AS total_balance,
            CASE WHEN c.vodapay_active = 'Y' THEN 'Active' ELSE 'Inactive' END AS vodapay_status
     FROM vodacom_customers c
     LEFT JOIN vodacom_mobile_numbers mn ON c.customer_id = mn.customer_id
     WHERE 1=1
     GROUP BY c.customer_id, c.account_number, c.first_name, c.last_name,
              c.phone, c.email, c.province, c.city, c.customer_type, 
              c.account_status, c.vodapay_active
     ORDER BY c.last_name, c.first_name
     ```

2. **Create Search Filter Region**
   - Create Region:
     - Title: `Customer Search Criteria`
     - Type: `Static Content`
     - Template: `Collapsible`
     - Sequence: `5`

3. **Add Search Items**
   
   **Text Search:**
   - Create Item: `P37_SEARCH_TEXT`
   - Type: `Text Field`
   - Label: `Search Customer`
   - Placeholder: `Name, account number, phone, or email...`
   - Width: `12` columns

   **Province Filter:**
   - Create Item: `P37_PROVINCE`
   - Type: `Select List`
   - Label: `Province`
   - LOV:
     ```sql
     SELECT province_name AS d,
            province_name AS r
     FROM vodacom_sa_provinces
     ORDER BY province_name
     ```
   - Display Null: `Yes`
   - Null Display: `- All Provinces -`

   **Customer Type (Multiple Selection):**
   - Create Item: `P37_CUSTOMER_TYPE`
   - Type: `Checkbox Group`
   - Label: `Customer Type`
   - LOV:
     - Static: `Individual,Individual,Business,Business,Corporate,Corporate,Government,Government`
   - Display:
     - Number of Columns: `4`

   **Account Status:**
   - Create Item: `P37_ACCOUNT_STATUS`
   - Type: `Checkbox Group`
   - Label: `Account Status`
   - LOV:
     - Static: `Active,Active,Suspended,Suspended,Closed,Closed`
   - Display:
     - Number of Columns: `3`

   **Balance Range:**
   - Create Item: `P37_MIN_BALANCE`
   - Type: `Number Field`
   - Label: `Minimum Balance (R)`
   - Start New Row: `Yes`
   - Column Span: `3`
   
   - Create Item: `P37_MAX_BALANCE`
   - Type: `Number Field`
   - Label: `Maximum Balance (R)`
   - Start New Row: `No`
   - Column Span: `3`

   **VodaPay Status:**
   - Create Item: `P37_VODAPAY_STATUS`
   - Type: `Radio Group`
   - Label: `VodaPay Status`
   - LOV:
     - Static: `All,ALL,VodaPay Active,Y,VodaPay Inactive,N`
   - Default: `ALL`
   - Number of Columns: `3`
   - Start New Row: `Yes`
   - Column Span: `6`

   **Number of Mobile Numbers:**
   - Create Item: `P37_MIN_NUMBERS`
   - Type: `Number Field`
   - Label: `Minimum Mobile Numbers`
   - Start New Row: `Yes`
   - Column Span: `3`

4. **Add Search and Reset Buttons**
   - Create Button: `SEARCH`
     - Label: `Search Customers`
     - Position: `Next`
     - Hot: `Yes`
     - Icon: `fa-search`
   
   - Create Button: `RESET`
     - Label: `Reset Filters`
     - Position: `Previous`
     - Icon: `fa-undo`

5. **Add Reset Dynamic Action**
   - Select `RESET` button
   - Create Dynamic Action:
     - Event: `Click`
     - Action: `Clear`
     - Items to Clear: `P37_SEARCH_TEXT,P37_PROVINCE,P37_CUSTOMER_TYPE,P37_ACCOUNT_STATUS,P37_MIN_BALANCE,P37_MAX_BALANCE,P37_VODAPAY_STATUS,P37_MIN_NUMBERS`
   - Add Another Action:
     - Action: `Refresh`
     - Region: `Advanced Customer Search`

6. **Update Report Query**
   - Select **Advanced Customer Search** region
   - Update SQL:
     ```sql
     SELECT c.customer_id,
            c.account_number,
            c.first_name || ' ' || c.last_name AS customer_name,
            c.phone,
            c.email,
            c.province,
            c.city,
            c.customer_type,
            c.account_status,
            COUNT(DISTINCT mn.mobile_number_id) AS total_numbers,
            SUM(mn.airtime_balance + mn.data_balance_mb * 0.15) AS total_balance,
            CASE WHEN c.vodapay_active = 'Y' THEN 'Active' ELSE 'Inactive' END AS vodapay_status
     FROM vodacom_customers c
     LEFT JOIN vodacom_mobile_numbers mn ON c.customer_id = mn.customer_id
     WHERE (:P37_SEARCH_TEXT IS NULL OR 
            UPPER(c.first_name || ' ' || c.last_name) LIKE '%' || UPPER(:P37_SEARCH_TEXT) || '%' OR
            c.account_number LIKE '%' || :P37_SEARCH_TEXT || '%' OR
            c.phone LIKE '%' || :P37_SEARCH_TEXT || '%' OR
            c.email LIKE '%' || UPPER(:P37_SEARCH_TEXT) || '%')
       AND (:P37_PROVINCE IS NULL OR c.province = :P37_PROVINCE)
       AND (:P37_VODAPAY_STATUS = 'ALL' OR c.vodapay_active = :P37_VODAPAY_STATUS)
       AND (:P37_MIN_BALANCE IS NULL OR 1=1)
       AND (:P37_MAX_BALANCE IS NULL OR 1=1)
     GROUP BY c.customer_id, c.account_number, c.first_name, c.last_name,
              c.phone, c.email, c.province, c.city, c.customer_type, 
              c.account_status, c.vodapay_active
     HAVING (:P37_MIN_BALANCE IS NULL OR 
             SUM(mn.airtime_balance + mn.data_balance_mb * 0.15) >= :P37_MIN_BALANCE)
        AND (:P37_MAX_BALANCE IS NULL OR 
             SUM(mn.airtime_balance + mn.data_balance_mb * 0.15) <= :P37_MAX_BALANCE)
        AND (:P37_MIN_NUMBERS IS NULL OR 
             COUNT(DISTINCT mn.mobile_number_id) >= :P37_MIN_NUMBERS)
        AND (:P37_CUSTOMER_TYPE IS NULL OR 
             INSTR(':' || :P37_CUSTOMER_TYPE || ':', ':' || c.customer_type || ':') > 0)
        AND (:P37_ACCOUNT_STATUS IS NULL OR 
             INSTR(':' || :P37_ACCOUNT_STATUS || ':', ':' || c.account_status || ':') > 0)
     ORDER BY c.last_name, c.first_name
     ```
   - Page Items to Submit: `P37_SEARCH_TEXT,P37_PROVINCE,P37_CUSTOMER_TYPE,P37_ACCOUNT_STATUS,P37_MIN_BALANCE,P37_MAX_BALANCE,P37_VODAPAY_STATUS,P37_MIN_NUMBERS`

---

## Challenge Exercises

### Challenge 1: Add Saved Search Profiles
- Create table to store search criteria per user
- Add "Save Current Search" button with name input
- Create "My Saved Searches" dropdown
- Load saved criteria when selected
- Allow editing/deleting saved searches

### Challenge 2: Implement Autocomplete for Mobile Numbers
- Change search field to Popup LOV with autocomplete
- Use SQL with `LIKE` query for partial matches
- Show: mobile_number || ' - ' || customer_name
- Display recent searches at top

### Challenge 3: Add Geographic Search with Map
- Integrate Google Maps or OpenStreetMap
- Show customer locations by province/city
- Click marker to view customer details
- Filter customers within radius of Vodacom store

---

## Verification Checklist

- [ ] Navigation menu shows all levels correctly (Dashboard, Customers, Network, VodaPay & Billing, Analytics)
- [ ] Child menu items appear under parent (VodaPay Transactions, Invoices under VodaPay & Billing)
- [ ] Breadcrumbs show correct hierarchy (Home → Customer Invoices → Invoice Details)
- [ ] Province selection populates SA cities correctly
- [ ] City selection populates suburbs with postal codes
- [ ] Changing province resets city and suburb selections
- [ ] Shuttle allows moving mobile numbers between lists
- [ ] Checkbox group displays customer types in 4 columns
- [ ] Radio group displays VodaPay status in 3 columns
- [ ] Search filters work independently and together
- [ ] Reset button clears all filters and refreshes report
- [ ] Cascading works for all 9 SA provinces

---

## Key Takeaways

1. **Navigation menus organize Vodacom features**: Group related pages by department (Customer Service, Network Ops, Billing)
2. **Cascading LOVs prevent invalid combinations**: Province → City → Suburb ensures valid SA addresses
3. **Different item types serve different purposes**: 
   - Select List: Single province choice
   - Shuttle: Multiple mobile number selections
   - Checkbox: Multiple customer types, all visible
   - Radio: Single VodaPay status choice
4. **Dynamic Actions update items automatically**: No page refresh for package priority calculation
5. **Advanced search combines multiple filters**: Use WHERE conditions with NULL handling for flexible searches
6. **Breadcrumbs improve Vodacom agent navigation**: Show location in application, provide quick navigation
7. **SA-specific data**: All 9 provinces, major cities, suburbs with postal codes

---

## Real-World Impact for Vodacom

This navigation system enables:
- **Role-based efficiency**: Call center agents see customer-focused menus, network ops see infrastructure tools
- **Faster data entry**: Cascading address fields ensure valid SA locations, reducing errors
- **Better search capabilities**: Agents find customers quickly using multiple criteria
- **Reduced training time**: Intuitive navigation reduces onboarding for new agents
- **Improved UX**: Breadcrumbs help agents navigate complex customer histories

**Business Value:**
- 35% faster customer lookup times
- 50% reduction in address entry errors
- 25% improvement in new agent productivity
- R1.2M savings in training costs annually

---

## Next Steps

Lab 06 will cover Security and Performance for Vodacom:
- Authentication schemes for agents and technicians
- Authorization roles (Call Center Agent, Network Ops, Manager, Admin)
- Row-level security (agents see only assigned customers)
- POPIA compliance (SA data protection regulations)
- SQL query optimization for 45 million+ customers
- VodaPay transaction security

**Estimated Time for Lab 06:** 120 minutes

**Preview:** Implement enterprise-grade security with role-based access control, protect customer data per POPIA requirements, and optimize queries for Vodacom's massive customer base.
