# Lab 05: Controls and Navigation

**Duration:** 90 minutes  
**Difficulty:** Intermediate  
**Prerequisites:** Completed Lab 04 (Invoice System created)

## Learning Objectives

By the end of this lab, you will be able to:
1. Configure hierarchical navigation menus
2. Implement cascading List of Values (LOVs)
3. Use different item types effectively
4. Create breadcrumb navigation
5. Build advanced search interfaces
6. Implement dependent selections

---

## Lab Scenario

**🎯 Building the Enterprise Call Center Application - Lab 5 of 7**

You're building the **Navigation & User Experience** for Vodacom's call center application.

**What You're Building This Lab:**
- **Role-Based Navigation** - Agent, Supervisor, Manager, Admin menus
- **Smart Address Entry** - South African provinces (Gauteng, Western Cape, etc.) with cascading City selection
- **Advanced Customer Search** - Filter 45M customers by multiple criteria
- **Agent Desktop Interface** - Streamlined controls for 5,000+ agents

**How This Fits the Complete Application:**
```
Vodacom Enterprise Call Center Application
├── Customer Management (Labs 1-2) ✅
├── Network Operations (Lab 3) ✅
├── Reporting & Forms (Lab 4) ✅
├── 🎨 Navigation & UX (Lab 5) ← YOU ARE HERE
│   ├── Role-Based Menus (Agent/Manager/Admin)
│   ├── SA Address Cascading (9 Provinces)
│   ├── Advanced Search Filters
│   └── Agent Desktop Layout
├── Security & Performance (Lab 6)
└── Production Deployment (Lab 7)
```

**Enterprise UX Requirements:**
- 5,000+ agents need fast, intuitive interfaces
- Role-based navigation (agents see different menus than managers)
- South African context (provinces, cities, postal codes)
- Minimize clicks for high call volume

---

## Part 1: Navigation Menu Configuration (20 minutes)

### Exercise 1.1: Create Multi-Level Navigation

1. **Access Navigation Menu**
   - App Builder → Your Application
   - Shared Components → Navigation → **Navigation Menu**
   - Click **Desktop Navigation Menu**

2. **Add Parent Menu Entries**
   - Click **Create Entry**
   
   **Dashboard Menu:**
   - Parent List Entry: `-- Top Level Entry --`
   - Sequence: `10`
   - Image/Class: `fa-dashboard`
   - List Entry Label: `Dashboard`
   - Target Type: `Page in this Application`
   - Page: `1`
   
   **Clients Menu:**
   - Sequence: `20`
   - Image/Class: `fa-users`
   - List Entry Label: `Clients`
   - Target Type: `Page in this Application`
   - Page: `20`
   
   **Projects Menu:**
   - Sequence: `30`
   - Image/Class: `fa-folder`
   - List Entry Label: `Projects`
   - Target Type: `Page in this Application`
   - Page: `3`
   
   **Time & Invoicing:**
   - Sequence: `40`
   - Image/Class: `fa-money`
   - List Entry Label: `Time & Invoicing`
   - Target Type: `URL`
   - URL Target: `#` (placeholder)

3. **Add Child Menu Entries**
   - Click **Create Entry**
   
   **Timesheets (child of Time & Invoicing):**
   - Parent List Entry: `Time & Invoicing`
   - Sequence: `10`
   - Image/Class: `fa-clock-o`
   - List Entry Label: `Timesheets`
   - Page: `25`
   
   **Invoices (child of Time & Invoicing):**
   - Parent List Entry: `Time & Invoicing`
   - Sequence: `20`
   - Image/Class: `fa-file-text-o`
   - List Entry Label: `Invoices`
   - Page: `29`
   
   **Reports:**
   - Parent List Entry: `-- Top Level Entry --`
   - Sequence: `50`
   - Image/Class: `fa-bar-chart`
   - List Entry Label: `Reports`
   - URL Target: `#`
   
   **Client Analysis (child of Reports):**
   - Parent List Entry: `Reports`
   - Sequence: `10`
   - Image/Class: `fa-pie-chart`
   - List Entry Label: `Client Analysis`
   - Page: `20`

4. **Add Conditional Display**
   - Edit **Reports** menu entry
   - Conditions:
     - Condition Type: `User is Authenticated (not public)`
   
   - Edit **Time & Invoicing** menu
   - Authorization Scheme: Create new or select existing
   - (For this lab, keep default authentication)

### Exercise 1.2: Configure Breadcrumbs

1. **Access Breadcrumb**
   - Shared Components → Navigation → **Breadcrumbs**
   - Click **Breadcrumb**

2. **Add Breadcrumb Entries**
   - Click **Create Entry**
   
   **Client Analysis:**
   - Parent Entry: `Home`
   - Sequence: `20`
   - Entry Label: `Client Analysis`
   - Target Page: `20`
   
   **Invoice Details:**
   - Parent Entry: `Home`
   - Sequence: `29`
   - Entry Label: `Invoices`
   - Target Page: `29`
   
   **Edit Invoice:**
   - Parent Entry: `Invoices`
   - Sequence: `30`
   - Entry Label: `Invoice &P30_INVOICE_NUMBER.`
   - Target Page: `30`

3. **Enable Breadcrumbs on Pages**
   - Open Page 20, 29, 30 in Page Designer
   - Page Properties → Navigation:
     - Breadcrumb: `Breadcrumb`
     - Entry: Select corresponding entry
   - Save Changes

---

## Part 2: Cascading LOVs (25 minutes)

### Exercise 2.1: Create Address Tables (if not exists)

1. **Run SQL Commands**
   - SQL Workshop → SQL Commands
   - Execute:

```sql
-- Countries table
CREATE TABLE technova_countries (
    country_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    country_code VARCHAR2(2) NOT NULL UNIQUE,
    country_name VARCHAR2(100) NOT NULL
);

-- States/Provinces table
CREATE TABLE technova_states (
    state_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    state_code VARCHAR2(10) NOT NULL,
    state_name VARCHAR2(100) NOT NULL,
    country_id NUMBER NOT NULL,
    CONSTRAINT fk_state_country FOREIGN KEY (country_id) 
        REFERENCES technova_countries(country_id)
);

-- Cities table
CREATE TABLE technova_cities (
    city_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    city_name VARCHAR2(100) NOT NULL,
    state_id NUMBER NOT NULL,
    CONSTRAINT fk_city_state FOREIGN KEY (state_id) 
        REFERENCES technova_states(state_id)
);

-- Insert sample data
INSERT INTO technova_countries (country_code, country_name) VALUES ('US', 'United States');
INSERT INTO technova_countries (country_code, country_name) VALUES ('CA', 'Canada');
INSERT INTO technova_countries (country_code, country_name) VALUES ('ZA', 'South Africa');

-- US States
INSERT INTO technova_states (state_code, state_name, country_id)
SELECT 'CA', 'California', country_id FROM technova_countries WHERE country_code = 'US';
INSERT INTO technova_states (state_code, state_name, country_id)
SELECT 'NY', 'New York', country_id FROM technova_countries WHERE country_code = 'US';
INSERT INTO technova_states (state_code, state_name, country_id)
SELECT 'TX', 'Texas', country_id FROM technova_countries WHERE country_code = 'US';

-- Canadian Provinces
INSERT INTO technova_states (state_code, state_name, country_id)
SELECT 'ON', 'Ontario', country_id FROM technova_countries WHERE country_code = 'CA';
INSERT INTO technova_states (state_code, state_name, country_id)
SELECT 'QC', 'Quebec', country_id FROM technova_countries WHERE country_code = 'CA';

-- South African Provinces
INSERT INTO technova_states (state_code, state_name, country_id)
SELECT 'GP', 'Gauteng', country_id FROM technova_countries WHERE country_code = 'ZA';
INSERT INTO technova_states (state_code, state_name, country_id)
SELECT 'WC', 'Western Cape', country_id FROM technova_countries WHERE country_code = 'ZA';

-- US Cities
INSERT INTO technova_cities (city_name, state_id)
SELECT 'Los Angeles', state_id FROM technova_states WHERE state_code = 'CA' AND country_id = (SELECT country_id FROM technova_countries WHERE country_code = 'US');
INSERT INTO technova_cities (city_name, state_id)
SELECT 'San Francisco', state_id FROM technova_states WHERE state_code = 'CA' AND country_id = (SELECT country_id FROM technova_countries WHERE country_code = 'US');
INSERT INTO technova_cities (city_name, state_id)
SELECT 'New York City', state_id FROM technova_states WHERE state_code = 'NY';
INSERT INTO technova_cities (city_name, state_id)
SELECT 'Houston', state_id FROM technova_states WHERE state_code = 'TX';

-- Canadian Cities
INSERT INTO technova_cities (city_name, state_id)
SELECT 'Toronto', state_id FROM technova_states WHERE state_code = 'ON';
INSERT INTO technova_cities (city_name, state_id)
SELECT 'Montreal', state_id FROM technova_states WHERE state_code = 'QC';

-- South African Cities
INSERT INTO technova_cities (city_name, state_id)
SELECT 'Johannesburg', state_id FROM technova_states WHERE state_code = 'GP';
INSERT INTO technova_cities (city_name, state_id)
SELECT 'Cape Town', state_id FROM technova_states WHERE state_code = 'WC';

COMMIT;
```

### Exercise 2.2: Create Address Entry Page

1. **Create New Page**
   - Create Page → **Blank Page**
   - Page Number: `35`
   - Page Name: `Client Address Entry`
   - Click **Create Page**

2. **Create Address Region**
   - Create Region:
     - Title: `Client Address`
     - Type: `Static Content`

3. **Add Cascading Items**
   
   **Country Selection:**
   - Create Item: `P35_COUNTRY_ID`
   - Type: `Select List`
   - Label: `Country`
   - LOV:
     - Type: `SQL Query`
     - SQL:
       ```sql
       SELECT country_name AS d,
              country_id AS r
       FROM technova_countries
       ORDER BY country_name
       ```
   - Settings:
     - Display Null Value: `Yes`
     - Null Display Value: `- Select Country -`

   **State/Province Selection:**
   - Create Item: `P35_STATE_ID`
   - Type: `Select List`
   - Label: `State/Province`
   - LOV:
     - Type: `SQL Query`
     - SQL:
       ```sql
       SELECT state_name AS d,
              state_id AS r
       FROM technova_states
       WHERE country_id = :P35_COUNTRY_ID
       ORDER BY state_name
       ```
   - Cascading LOV Parent Item: `P35_COUNTRY_ID`
   - Settings:
     - Display Null Value: `Yes`
     - Null Display Value: `- Select State -`

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
       FROM technova_cities
       WHERE state_id = :P35_STATE_ID
       ORDER BY city_name
       ```
   - Cascading LOV Parent Item: `P35_STATE_ID`
   - Settings:
     - Display Null Value: `Yes`
     - Null Display Value: `- Select City -`

4. **Test Cascading Behavior**
   - Save and Run Page
   - Select **United States** → Should show CA, NY, TX
   - Select **California** → Should show Los Angeles, San Francisco
   - Change to **Canada** → State list refreshes automatically

---

## Part 3: Advanced Item Types (20 minutes)

### Exercise 3.1: Create Multi-Select Interface

1. **Create New Page**
   - Create Page → **Blank Page**
   - Page Number: `36`
   - Page Name: `Project Team Assignment`

2. **Add Items**
   
   **Project Selection:**
   - Create Item: `P36_PROJECT_ID`
   - Type: `Popup LOV`
   - Label: `Project`
   - LOV:
     ```sql
     SELECT project_name AS d,
            project_id AS r,
            'Budget: R' || TO_CHAR(budget, '999,999,999') || ' - ' || status AS description
     FROM technova_projects
     ORDER BY project_name
     ```
   - Display Columns: `2` (show description)

   **Team Members (Shuttle):**
   - Create Item: `P36_TEAM_MEMBERS`
   - Type: `Shuttle`
   - Label: `Assign Team Members`
   - LOV:
     ```sql
     SELECT first_name || ' ' || last_name || ' (' || job_title || ')' AS d,
            emp_id AS r
     FROM technova_employees
     WHERE is_active = 'Y'
     ORDER BY last_name, first_name
     ```
   - Settings:
     - Height: `10`
     - Sort: `Yes`

   **Project Skills (Checkbox Group):**
   - Create Item: `P36_REQUIRED_SKILLS`
   - Type: `Checkbox Group`
   - Label: `Required Skills`
   - LOV:
     - Type: `Static`
     - Values:
       ```
       STATIC:Java Development,JAVA,Python Programming,PYTHON,React Development,REACT,SQL & Database,SQL,UI/UX Design,DESIGN,DevOps,DEVOPS,Cloud Architecture,CLOUD
       ```
   - Settings:
     - Number of Columns: `2`

   **Priority (Radio Group):**
   - Create Item: `P36_PRIORITY`
   - Type: `Radio Group`
   - Label: `Priority`
   - LOV:
     - Static: `High,HIGH,Medium,MEDIUM,Low,LOW`
   - Display:
     - Number of Columns: `3`

   **Budget Approval (Switch):**
   - Create Item: `P36_BUDGET_APPROVED`
   - Type: `Switch`
   - Label: `Budget Approved`
   - Settings:
     - On Value: `Y`
     - Off Value: `N`

3. **Add Dynamic Action for Project Selection**
   - Select `P36_PROJECT_ID` item
   - Create Dynamic Action:
     - Event: `Change`
     - Action: `Execute Server-side Code`
     - PL/SQL:
       ```sql
       DECLARE
         v_manager_id NUMBER;
         v_budget NUMBER;
       BEGIN
         SELECT pm_emp_id, budget
         INTO v_manager_id, v_budget
         FROM technova_projects
         WHERE project_id = :P36_PROJECT_ID;
         
         :P36_BUDGET_APPROVED := CASE WHEN v_budget > 500000 THEN 'N' ELSE 'Y' END;
       END;
       ```
     - Items to Submit: `P36_PROJECT_ID`
     - Items to Return: `P36_BUDGET_APPROVED`

---

## Part 4: Advanced Search with Dependencies (25 minutes)

### Exercise 4.1: Create Advanced Project Search

1. **Create New Page**
   - Create Page → Report → **Interactive Report**
   - Page Number: `37`
   - Page Name: `Advanced Project Search`
   - SQL Query:
     ```sql
     SELECT p.project_id,
            p.project_name,
            c.company_name AS client,
            e.first_name || ' ' || e.last_name AS project_manager,
            p.start_date,
            p.end_date,
            p.budget,
            p.status,
            COUNT(DISTINCT pa.emp_id) AS team_size
     FROM technova_projects p
     JOIN technova_clients c ON p.client_id = c.client_id
     LEFT JOIN technova_employees e ON p.pm_emp_id = e.emp_id
     LEFT JOIN technova_project_assignments pa ON p.project_id = pa.project_id
     WHERE 1=1
     GROUP BY p.project_id, p.project_name, c.company_name,
              e.first_name, e.last_name, p.start_date,
              p.end_date, p.budget, p.status
     ORDER BY p.start_date DESC
     ```

2. **Create Search Filter Region**
   - Create Region:
     - Title: `Search Criteria`
     - Type: `Static Content`
     - Template: `Collapsible`
     - Sequence: `5`

3. **Add Search Items**
   
   **Text Search:**
   - Create Item: `P37_SEARCH_TEXT`
   - Type: `Text Field`
   - Label: `Search Project Name`
   - Placeholder: `Enter project name or keywords...`
   - Width: `12` columns

   **Client Filter:**
   - Create Item: `P37_CLIENT_ID`
   - Type: `Select List`
   - Label: `Client`
   - LOV:
     ```sql
     SELECT company_name AS d,
            client_id AS r
     FROM technova_clients
     ORDER BY company_name
     ```
   - Display Null: `Yes`
   - Null Display: `- All Clients -`

   **Status (Multiple Selection):**
   - Create Item: `P37_STATUS`
   - Type: `Checkbox Group`
   - Label: `Status`
   - LOV:
     - Static: `Active,Active,In Progress,In Progress,Completed,Completed,On Hold,On Hold`
   - Display:
     - Number of Columns: `4`

   **Budget Range:**
   - Create Item: `P37_MIN_BUDGET`
   - Type: `Number Field`
   - Label: `Minimum Budget`
   - Start New Row: `Yes`
   - Column Span: `3`
   
   - Create Item: `P37_MAX_BUDGET`
   - Type: `Number Field`
   - Label: `Maximum Budget`
   - Start New Row: `No`
   - Column Span: `3`

   **Date Range:**
   - Create Item: `P37_START_DATE_FROM`
   - Type: `Date Picker`
   - Label: `Start Date From`
   - Start New Row: `Yes`
   - Column Span: `3`
   
   - Create Item: `P37_START_DATE_TO`
   - Type: `Date Picker`
   - Label: `To`
   - Start New Row: `No`
   - Column Span: `3`

   **Team Size:**
   - Create Item: `P37_MIN_TEAM_SIZE`
   - Type: `Number Field`
   - Label: `Minimum Team Size`
   - Start New Row: `Yes`
   - Column Span: `3`

4. **Add Search and Reset Buttons**
   - Create Button: `SEARCH`
     - Label: `Search Projects`
     - Position: `Next`
     - Hot: `Yes`
   
   - Create Button: `RESET`
     - Label: `Reset Filters`
     - Position: `Previous`

5. **Add Reset Dynamic Action**
   - Select `RESET` button
   - Create Dynamic Action:
     - Event: `Click`
     - Action: `Clear`
     - Items to Clear: `P37_SEARCH_TEXT,P37_CLIENT_ID,P37_STATUS,P37_MIN_BUDGET,P37_MAX_BUDGET,P37_START_DATE_FROM,P37_START_DATE_TO,P37_MIN_TEAM_SIZE`
   - Add Another Action:
     - Action: `Refresh`
     - Region: `Advanced Project Search`

6. **Update Report Query**
   - Select **Advanced Project Search** region
   - Update SQL:
     ```sql
     SELECT p.project_id,
            p.project_name,
            c.company_name AS client,
            e.first_name || ' ' || e.last_name AS project_manager,
            p.start_date,
            p.end_date,
            p.budget,
            p.status,
            COUNT(DISTINCT pa.emp_id) AS team_size
     FROM technova_projects p
     JOIN technova_clients c ON p.client_id = c.client_id
     LEFT JOIN technova_employees e ON p.pm_emp_id = e.emp_id
     LEFT JOIN technova_project_assignments pa ON p.project_id = pa.project_id
     WHERE (:P37_SEARCH_TEXT IS NULL OR 
            UPPER(p.project_name) LIKE '%' || UPPER(:P37_SEARCH_TEXT) || '%')
       AND (:P37_CLIENT_ID IS NULL OR p.client_id = :P37_CLIENT_ID)
       AND (:P37_MIN_BUDGET IS NULL OR p.budget >= :P37_MIN_BUDGET)
       AND (:P37_MAX_BUDGET IS NULL OR p.budget <= :P37_MAX_BUDGET)
       AND (:P37_START_DATE_FROM IS NULL OR p.start_date >= :P37_START_DATE_FROM)
       AND (:P37_START_DATE_TO IS NULL OR p.start_date <= :P37_START_DATE_TO)
     GROUP BY p.project_id, p.project_name, c.company_name,
              e.first_name, e.last_name, p.start_date,
              p.end_date, p.budget, p.status
     HAVING (:P37_MIN_TEAM_SIZE IS NULL OR COUNT(DISTINCT pa.emp_id) >= :P37_MIN_TEAM_SIZE)
        AND (:P37_STATUS IS NULL OR 
             INSTR(':' || :P37_STATUS || ':', ':' || p.status || ':') > 0)
     ORDER BY p.start_date DESC
     ```
   - Page Items to Submit: `P37_SEARCH_TEXT,P37_CLIENT_ID,P37_STATUS,P37_MIN_BUDGET,P37_MAX_BUDGET,P37_START_DATE_FROM,P37_START_DATE_TO,P37_MIN_TEAM_SIZE`

---

## Challenge Exercises

### Challenge 1: Add Saved Searches
- Create table to store search criteria
- Add "Save Current Search" button
- Create "My Saved Searches" dropdown
- Load saved criteria when selected

### Challenge 2: Implement Autocomplete
- Change `P37_SEARCH_TEXT` to Popup LOV
- Use SQL with `LIKE` query
- Show recent/popular searches

### Challenge 3: Add Navigation Breadcrumb Trail
- Create custom breadcrumb region
- Show: Home > Reports > Advanced Search > Results
- Make each level clickable

---

## Verification Checklist

- [ ] Navigation menu shows all levels correctly
- [ ] Child menu items appear under parent
- [ ] Breadcrumbs show correct hierarchy
- [ ] Country selection populates states
- [ ] State selection populates cities
- [ ] Changing country resets state and city
- [ ] Shuttle allows moving items between lists
- [ ] Checkbox group displays in 2 columns
- [ ] Radio group displays in 3 columns
- [ ] Search filters work independently and together
- [ ] Reset button clears all filters

---

## Key Takeaways

1. **Navigation menus organize features**: Group related pages logically
2. **Cascading LOVs prevent invalid combinations**: Country → State → City
3. **Different item types serve different purposes**: 
   - Select List: Single choice
   - Shuttle: Multiple selections with visual feedback
   - Checkbox: Multiple selections, grid display
   - Radio: Single choice, all visible
4. **Dynamic Actions update items automatically**: No page refresh needed
5. **Advanced search combines multiple filters**: Use WHERE conditions with NULL handling
6. **Breadcrumbs improve user navigation**: Show where users are, provide quick navigation

---

## Next Steps

Lab 06 will cover Security and Performance:
- Authentication schemes
- Authorization and roles
- Session state protection
- SQL query optimization
- Debug mode and performance tuning

**Estimated Time for Lab 06:** 90 minutes
