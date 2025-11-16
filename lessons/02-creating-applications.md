# Lesson 02: Creating Applications in Oracle APEX

## Theory

### Layman's Explanation

Think of creating an APEX application like using a **website template builder** (like Wix or Squarespace), but specifically designed for business software instead of marketing websites. Instead of spending months coding everything from scratch, you answer simple questions and APEX builds a professional application for you automatically.

**Real-World Analogy: Building a House**

Imagine you need a new house. You have three options:

1. **Traditional Custom Build** (Like coding from scratch)
   - Hire architect to draw blueprints (6-8 weeks)
   - Get permits and approvals (2-4 weeks)
   - Hire construction crew (find electricians, plumbers, carpenters)
   - Build foundation, framing, walls, roof, plumbing, electrical (6-12 months)
   - **Total Time: 10-18 months**
   - **Cost: $300,000 - $500,000**

2. **Modular/Prefab Home** (Like APEX)
   - Choose floor plan from catalog (1 day)
   - Customize room layouts, colors, fixtures (1 week)
   - Factory builds modules (4 weeks)
   - Assemble on-site (1 week)
   - **Total Time: 6-8 weeks**
   - **Cost: $150,000 - $250,000**
   - **Quality: Same or better than custom build**

APEX is the "modular home builder" for software. The modules (pages, reports, forms) are pre-built, tested, and professional-quality. You just pick which ones you need and customize them.

**Vodacom's Story: The Breaking Point**

Let's look at what happened at Vodacom before they discovered APEX:

**The Problem (Year 2022):**
- Vodacom had 50 different Microsoft Access databases scattered across departments
- Employee Manager, Project Tracker, Client Portal, Timesheet System, Invoice Manager - all separate Access files
- Maria (Project Manager) couldn't check project status from home - had to VPN and Remote Desktop
- Juan (Developer) spent 6 months building a custom web app for client management using Python Flask
- Access databases crashed weekly, data corruption monthly
- No mobile access - field technicians had to call office for project information
- IT spent 20 hours/week troubleshooting Access database issues

**The Cost:**
- Juan's 6-month custom Python project: $45,000 (salary + infrastructure)
- Lost productivity from crashes: ~$30,000/year
- IT support time: $25,000/year
- **Total: $100,000/year on database problems**

**The APEX Solution (Year 2023):**

Vodacom's CTO attended an Oracle webinar and learned about APEX. They decided to rebuild their most critical system - the Project Management database - as a test.

**What they did:**
1. Exported Access data to Excel (30 minutes)
2. Used APEX "Create from File" to upload Excel (5 minutes)
3. APEX created database table + basic application automatically
4. Used "Create Application Wizard" to add forms, reports, dashboard (1 hour)
5. Customized colors, logos, navigation (2 hours)
6. **Total Development Time: 4 hours**

**What they got:**
- Web-based application accessible from anywhere (office, home, phone)
- Secure login for each employee
- Real-time data (no file locking issues)
- Automatic backups (Oracle Database)
- Professional interface (better than Access)
- Mobile-responsive (works on tablets and phones)
- Zero crashes in first 6 months

**The ROI:**
- **Development cost: $400** (4 hours × $100/hour)
- **Replaced: $45,000 custom development project**
- **Savings: 99% reduction in development cost**
- **Time to market: 4 hours vs 6 months**

**How APEX Makes This Possible:**

Instead of asking Juan to write thousands of lines of code, APEX asks simple questions:

**APEX:** "What tables do you have?"  
**Vodacom:** "PROJECTS, EMPLOYEES, CLIENTS, TASKS"

**APEX:** "What do you want to do with PROJECTS?"  
**Vodacom:** "View list, add new, edit existing, delete completed"

**APEX:** "What should the list look like?"  
**Vodacom:** "Searchable table with filters, 50 rows per page"

**APEX:** *Creates Interactive Report with search, filters, pagination, export to Excel*

**APEX:** "What form fields do you need?"  
**Vodacom:** "Project name, start date, end date, status, assigned employee"

**APEX:** *Creates form with date pickers, dropdown lists, validation*

That's it. No coding required for the basics. APEX generates all the HTML, JavaScript, CSS, SQL, and security automatically.

**What Makes APEX Different from Website Builders:**

Website builders (Wix, Squarespace) are great for marketing sites with mostly static content. APEX is designed for **data-driven business applications** that need:

| Feature | Website Builder | APEX |
|---------|----------------|------|
| **Primary Use** | Marketing websites | Business applications |
| **Data Handling** | Contact forms | Full database CRUD operations |
| **User Management** | Basic login | Role-based access control |
| **Reports** | Static pages | Dynamic, filterable, exportable |
| **Complexity** | 10-20 pages max | 100+ page enterprise apps |
| **Business Logic** | Minimal | Complex workflows, validations |
| **Integration** | Third-party widgets | Direct database, REST APIs, OAuth |

**Example: Employee Directory**

**Wix/Squarespace Approach:**
- Create page, add text boxes, manually type each employee
- Want to update? Find the page, edit HTML, republish
- Want to search? Buy premium plugin
- Want to filter by department? Manually create separate pages

**APEX Approach:**
- Point APEX at EMPLOYEES table
- APEX generates searchable, filterable, sortable report
- Add employee via form (data goes directly to database)
- Changes appear instantly for all users
- Search, filter, export to Excel - all built-in

**Vodacom's Transformation Journey:**

After the Project Management success, Vodacom rebuilt all their applications using APEX:

| Application | Old System | Build Time (APEX) | Status |
|-------------|-----------|------------------|--------|
| Project Management | Access | 4 hours | ✅ Complete |
| Employee Directory | Access | 2 hours | ✅ Complete |
| Client Portal | Custom PHP (6 months) | 8 hours | ✅ Complete |
| Timesheet System | Excel spreadsheets | 6 hours | ✅ Complete |
| Invoice Manager | Access | 5 hours | ✅ Complete |
| Help Desk Tickets | Email-based | 10 hours | ✅ Complete |
| Equipment Checkout | Paper forms | 3 hours | ✅ Complete |

**Total APEX Development Time: 38 hours (less than 1 week)**  
**Total Applications: 7 fully-functional business systems**  
**Total Users: 250 employees + 180 clients**  
**Total Saved: $400,000+ in development costs**

**The Bottom Line:**

Creating APEX applications is like using LEGO blocks instead of carving wooden blocks from scratch. The pieces are pre-made, tested, and professional quality. You just snap them together in the configuration you need. Want a report? Grab the report block. Want a form? Grab the form block. Want a dashboard with charts? Grab those blocks.

In the next sections, we'll learn exactly which "blocks" (wizards, blueprints, file uploads) APEX gives you and when to use each one.

### Intermediate Explanation

APEX provides multiple methods to create applications, each optimized for different scenarios and skill levels. Understanding when to use each method is crucial for efficient development.

**1. Create Application Wizard**
- Step-by-step guided interface for building applications
- Automatically generates pages based on database tables
- Includes pre-configured navigation, reports, and forms
- **Best for:** Standard CRUD applications with existing database schema
- **Time to build:** 5-15 minutes for basic app
- **Skill level:** Beginner-friendly

**2. Create from File**
- Upload spreadsheet (CSV, XLSX, XML, JSON)
- APEX creates database table AND application simultaneously
- Detects data types automatically (dates, numbers, text)
- **Best for:** Quick prototypes when database doesn't exist yet
- **Time to build:** 2-5 minutes
- **Skill level:** No database knowledge required

**3. Blueprints**
- Pre-designed application templates for common business patterns
- Industry-specific layouts and functionality
- Fully customizable after creation
- **Best for:** Standard business scenarios (project tracking, help desk, surveys)
- **Time to build:** 10-20 minutes with customization
- **Skill level:** Intermediate

**4. Sample/Packaged Apps**
- Fully functional, production-ready applications
- Install and use immediately or modify
- Excellent learning resources (inspect code to learn techniques)
- **Best for:** Learning APEX patterns, quick deployment of standard apps
- **Time to build:** 1-2 minutes to install
- **Skill level:** All levels

**5. Copy Existing Application**
- Duplicate entire application including all components
- Rename and modify for new purpose
- Maintains all customizations from original
- **Best for:** Building similar apps, creating dev/test/prod copies
- **Time to build:** 2 minutes to copy, varies for customization
- **Skill level:** Intermediate

**Application Creation Decision Tree:**

```
Need to create APEX app?
    │
    ├─ Database tables exist?
    │   ├─ YES → Use "Create Application Wizard"
    │   │          ↓
    │   │   Standard CRUD app? → Wizard (5-15 min)
    │   │   Complex relationships? → Blueprint (10-20 min)
    │   │
    │   └─ NO → Use "Create from File"
    │              ↓
    │       Upload spreadsheet → APEX creates table + app (2-5 min)
    │
    ├─ Similar to existing app?
    │   └─ YES → Copy existing application (2 min)
    │
    └─ Industry-specific pattern?
        └─ YES → Use Blueprint (Project, Help Desk, Survey)
```

**📚 Learn More:**
- **Tutorial**: [Spreadsheet Lab](https://apex.oracle.com/go/spreadsheet-lab) - Turn a spreadsheet into an app (45 min, Beginner)
- **Tutorial**: [Build a Social Media App](https://apex.oracle.com/go/sm-lab) - Use the Create Application Wizard (1 hour, Beginner)
- **Sample Apps**: Browse [Oracle's Sample Apps Gallery](https://oracle.github.io/apex/) for inspiration

**Deep Dive: How Each Method Works**

#### Create Application Wizard - Technical Flow

When you use the wizard, APEX performs these operations behind the scenes:

```sql
-- 1. Create application metadata record
INSERT INTO wwv_flow_applications (
    id, name, alias, version, owner, created_on
) VALUES (
    apex_application_id.nextval, 'Employee Manager', 'EMP_MGR', '1.0', 'VODACOM_DEV', SYSDATE
);

-- 2. Generate home page (page 1)
INSERT INTO wwv_flow_pages (
    flow_id, page_id, page_name, page_template, page_type
) VALUES (
    :app_id, 1, 'Home', 'Standard', 'Normal'
);

-- 3. Create navigation list
INSERT INTO wwv_flow_lists (
    list_name, list_type, application_id
) VALUES (
    'Desktop Navigation Menu', 'Navigation Menu', :app_id
);

-- 4. For each table selected, generate:
--    - Interactive Report page
--    - Modal form page
--    - Process to handle DML operations
```

**What gets created automatically:**

| Component | Description | Customizable |
|-----------|-------------|--------------|
| **Home Page** | Landing page with logo, navigation | ✅ Fully |
| **Interactive Reports** | One per table, with search/filter | ✅ Fully |
| **Modal Forms** | Add/edit dialogs for each report | ✅ Fully |
| **Navigation Menu** | Side menu or top tabs | ✅ Fully |
| **Authentication** | Login system (APEX accounts by default) | ✅ Can change |
| **Session State** | User session management | ⚙️ Pre-configured |
| **Theme** | Professional UI theme | ✅ Switchable |
| **Authorization** | Page access control | ✅ Can add schemes |

#### Create from File - Data Import Process

The "Create from File" wizard performs intelligent data analysis:

**Create from File Process Flow:**

```
┌────────────────────────────────────────────────┐
│  Step 1: Upload File                           │
│  (Excel, CSV, XML, JSON)                       │
└────────────────────────────────────────────────┘
              ↓
┌────────────────────────────────────────────────┐
│  Step 2: APEX Analyzes Data                    │
│  - Detects column types (DATE, NUMBER, TEXT)   │
│  - Suggests primary key                        │
│  - Identifies lookup columns                   │
└────────────────────────────────────────────────┘
              ↓
┌────────────────────────────────────────────────┐
│  Step 3: Review & Adjust                       │
│  - Confirm/change column types                 │
│  - Set primary key                             │
│  - Choose "Create table + app"                 │
└────────────────────────────────────────────────┘
              ↓
┌────────────────────────────────────────────────┐
│  Step 4: APEX Generates                        │
│  - CREATE TABLE statement                      │
│  - Loads data (bulk insert)                    │
│  - Creates Interactive Report                  │
│  - Creates Form page                           │
│  - Creates application                         │
└────────────────────────────────────────────────┘
              ↓
┌────────────────────────────────────────────────┐
│  Result: Fully functional app in 2-5 minutes!  │
└────────────────────────────────────────────────┘
```

**🎓 Try It Yourself:**
- **Follow Along**: [Spreadsheet Lab](https://apex.oracle.com/go/spreadsheet-lab) - Complete walkthrough of creating from file
- **Advanced Example**: [Movies Watchlist](https://apex.oracle.com/go/movies-lab) - REST + local tables combination

**Step 1: File Analysis**
```
Upload: vodacom_employees.xlsx
Analysis Results:
- Detected 15 columns
- 250 rows of data
- Column types identified:
  * EMPLOYEE_ID: NUMBER (auto-increment suggested)
  * FIRST_NAME: VARCHAR2(100)
  * HIRE_DATE: DATE (detected date format: DD-MON-YYYY)
  * SALARY: NUMBER(10,2) (currency detected)
  * EMAIL: VARCHAR2(100) (pattern: xxx@xxx.com)
  * DEPARTMENT_ID: NUMBER (lookup suggested - found repeated values)
```

**Step 2: Table Creation**
```sql
-- APEX generates optimized CREATE TABLE statement
CREATE TABLE vodacom_employees (
    employee_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name      VARCHAR2(100),
    last_name       VARCHAR2(100),
    email           VARCHAR2(100) UNIQUE,
    phone           VARCHAR2(20),
    hire_date       DATE,
    salary          NUMBER(10,2),
    department_id   NUMBER,
    manager_id      NUMBER,
    is_active       CHAR(1) DEFAULT 'Y',
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    created_by      VARCHAR2(100) DEFAULT USER,
    modified_date   TIMESTAMP,
    modified_by     VARCHAR2(100)
);

-- Create index for common searches
CREATE INDEX idx_emp_dept ON vodacom_employees(department_id);
CREATE INDEX idx_emp_name ON vodacom_employees(last_name, first_name);
```

**Step 3: Data Loading**
```sql
-- APEX uses efficient bulk loading
INSERT INTO vodacom_employees (first_name, last_name, email, ...)
SELECT column1, column2, column3, ...
FROM TABLE(apex_data_parser.parse(
    p_content => :uploaded_file_blob,
    p_file_name => 'vodacom_employees.xlsx',
    p_skip_rows => 1  -- Skip header row
));
```

**Step 4: Application Generation**

APEX then creates an application with:
- Interactive Report showing all imported data
- Form page for editing records
- Search functionality
- Export to Excel/PDF/CSV features
- Automatic pagination

**Time Comparison: Traditional vs APEX**

Let's compare building an Employee Management System:

| Task | Traditional Development | APEX Wizard | APEX from File |
|------|------------------------|-------------|----------------|
| **Database Design** | 2-4 hours | 0 (uses existing) | 0 (auto-created) |
| **Table Creation** | 1 hour | 0 (already exists) | 0 (APEX creates) |
| **Backend API** | 8-16 hours | 0 (auto-generated) | 0 (auto-generated) |
| **Frontend UI** | 16-24 hours | 0 (auto-generated) | 0 (auto-generated) |
| **List/Grid View** | 4-8 hours | 2 minutes | 2 minutes |
| **Add/Edit Forms** | 6-12 hours | 2 minutes | 2 minutes |
| **Search/Filter** | 4-8 hours | 0 (built-in) | 0 (built-in) |
| **Pagination** | 2-4 hours | 0 (built-in) | 0 (built-in) |
| **Validation** | 3-6 hours | 10 minutes | 10 minutes |
| **Security** | 8-16 hours | 5 minutes | 5 minutes |
| **Testing** | 8-16 hours | 2-4 hours | 2-4 hours |
| **TOTAL** | **62-114 hours** | **2-4 hours** | **2-4 hours** |
| **Cost (@$100/hr)** | **$6,200-$11,400** | **$200-$400** | **$200-$400** |

**Savings: 95-97% reduction in development time**

#### Blueprints - Pre-Built Patterns

APEX Blueprints are like architectural templates. Instead of designing from scratch, you choose a proven pattern:

**Available Blueprint Categories:**

1. **Project Tracking**
   - Projects, tasks, milestones, resources
   - Gantt charts, Kanban boards
   - Time tracking, budget management
   - **Use case:** Vodacom Project Management System

2. **Customer Service**
   - Help desk tickets, knowledge base
   - Customer portal, satisfaction surveys
   - SLA tracking, escalation workflows
   - **Use case:** Vodacom Support Portal

3. **Reporting Dashboard**
   - Executive dashboard with KPIs
   - Charts, graphs, metrics
   - Drill-down capability
   - **Use case:** Vodacom Executive Dashboard

4. **Survey Application**
   - Question builder, survey distribution
   - Response collection, analytics
   - Anonymous or authenticated responses
   - **Use case:** Vodacom Employee Satisfaction Surveys

5. **Approval Workflow**
   - Request submission, approval chain
   - Email notifications, audit trail
   - Multi-level approvals
   - **Use case:** Vodacom Expense Approval

**Blueprint Customization Example:**

Let's say Vodacom uses the "Project Tracking" blueprint:

**Out-of-the-box features:**
```
✅ Projects list with status indicators
✅ Task management with assignments
✅ Timeline/Gantt view
✅ Resource allocation
✅ Budget tracking
✅ File attachments
✅ Comments/collaboration
✅ Dashboard with charts
```

**Vodacom customizations:**
```
➕ Add: Client billing integration
➕ Add: Invoice generation
➕ Add: Client portal (read-only view for clients)
➕ Modify: Add custom fields (risk level, contract type)
➕ Modify: Change workflow (add "QA Review" stage)
➕ Remove: Resource allocation (using separate tool)
```

**Time to customize: 4-6 hours vs 40-60 hours building from scratch**

**🎓 Explore More Creation Methods:**
- **Tutorial**: [Shopping Cart App](https://apex.oracle.com/go/shopping-cart-lab) - Full application creation (2 hours, Intermediate)
- **Sample Apps**: [Oracle APEX Sample Apps](https://oracle.github.io/apex/) - Download and explore production-ready apps
- **Documentation**: [Creating Applications](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/creating-applications.html)

**Key Application Components Explained**

Every APEX application consists of these building blocks:

#### 1. Pages
Individual screens in your application. Each page has a specific purpose:

| Page Type | Purpose | Common Uses |
|-----------|---------|-------------|
| **Blank Page** | Empty canvas | Custom layouts, dashboards |
| **Report** | Display data in table/list | Employee list, sales data |
| **Form** | Add/edit single record | Employee details, order entry |
| **Master-Detail** | Parent + child records | Order with line items |
| **Dashboard** | Charts and metrics | Executive summary |
| **Calendar** | Date-based data | Project timeline, appointments |
| **Map** | Geographic data | Store locations, delivery routes |
| **Tree** | Hierarchical data | Org chart, file system |
| **Wizard** | Multi-step process | User registration, order checkout |
| **Login** | Authentication | User login page |

#### 2. Regions
Content areas within a page. Think of regions as boxes that hold information:

```
┌─────────────────────────────────────────┐
│         Page: Employee Details          │
├─────────────────────────────────────────┤
│ ┌─────────────────────────────────────┐ │
│ │  Region: Employee Information       │ │ (Form)
│ │  [Name] [Email] [Phone]            │ │
│ └─────────────────────────────────────┘ │
│ ┌─────────────────────────────────────┐ │
│ │  Region: Project Assignments        │ │ (Report)
│ │  Table: Project | Start | End       │ │
│ └─────────────────────────────────────┘ │
│ ┌─────────────────────────────────────┐ │
│ │  Region: Performance Chart          │ │ (Chart)
│ │  [Bar chart showing metrics]        │ │
│ └─────────────────────────────────────┘ │
└─────────────────────────────────────────┘
```

#### 3. Items
Input fields and display elements:

```sql
-- Example: Employee form items
P2_EMPLOYEE_ID      (Hidden - Primary Key)
P2_FIRST_NAME       (Text Field - Required)
P2_LAST_NAME        (Text Field - Required)
P2_EMAIL            (Text Field with Email validation)
P2_PHONE            (Text Field with Phone format)
P2_HIRE_DATE        (Date Picker)
P2_DEPARTMENT_ID    (Select List - LOV from DEPARTMENTS table)
P2_MANAGER_ID       (Popup LOV - Searchable list of employees)
P2_SALARY           (Number Field with currency format)
P2_IS_ACTIVE        (Switch - Yes/No)
```

#### 4. Navigation
Menus and breadcrumbs for moving between pages:

**Navigation List Example:**
```
📊 Dashboard (Home)
👥 Employees
   ├── Employee List
   ├── Add Employee
   └── Departments
📁 Projects
   ├── All Projects
   ├── My Projects
   └── Project Calendar
💰 Finances
   ├── Invoices
   ├── Expenses
   └── Budget Reports
⚙️ Administration
   ├── Users
   ├── Roles
   └── Settings
```

#### 5. Shared Components
Reusable elements available across the entire application:

**List of Values (LOV):**
```sql
-- Used for dropdown lists, prevents data entry errors
-- Example: Department LOV
SELECT department_name AS display_value,
       department_id AS return_value
FROM departments
ORDER BY department_name;
```

**Application Items:**
```sql
-- Global variables accessible on any page
G_CURRENT_USER_DEPT_ID    (Current user's department)
G_FISCAL_YEAR             (Current fiscal year)
G_COMPANY_NAME            (Application constant)
```

**Authorization Schemes:**
```sql
-- Control who can access pages/features
-- Example: Admin Only
FUNCTION is_admin RETURN BOOLEAN IS
BEGIN
    RETURN apex_util.public_user_in_role(
        p_role => 'Administrator'
    );
END;
```

**Application Processes:**
```sql
-- Code that runs at application level (on login, logout, etc.)
-- Example: Log user activity
BEGIN
    INSERT INTO user_audit_log (username, login_time, ip_address)
    VALUES (:APP_USER, SYSTIMESTAMP, :APP_REMOTE_ADDR);
    COMMIT;
END;
```

#### 6. Supporting Objects
Database objects that support the application:

**Tables and Views:**
```sql
-- Base tables for data storage
VODACOM_EMPLOYEES
VODACOM_PROJECTS
VODACOM_CLIENTS

-- Views for complex queries or security
CREATE OR REPLACE VIEW v_employee_summary AS
SELECT e.employee_id,
       e.first_name || ' ' || e.last_name AS full_name,
       d.department_name,
       COUNT(p.project_id) AS project_count,
       SUM(t.hours_logged) AS total_hours
FROM vodacom_employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN project_assignments pa ON e.employee_id = pa.employee_id
LEFT JOIN vodacom_projects p ON pa.project_id = p.project_id
LEFT JOIN timesheets t ON e.employee_id = t.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name;
```

**PL/SQL Packages:**
```sql
-- Business logic in reusable packages
CREATE OR REPLACE PACKAGE pkg_vodacom_projects AS
    PROCEDURE create_project (
        p_project_name   IN VARCHAR2,
        p_client_id      IN NUMBER,
        p_start_date     IN DATE,
        p_budget         IN NUMBER
    );
    
    FUNCTION get_project_status (
        p_project_id IN NUMBER
    ) RETURN VARCHAR2;
    
    PROCEDURE assign_employee (
        p_project_id    IN NUMBER,
        p_employee_id   IN NUMBER,
        p_role          IN VARCHAR2
    );
END pkg_vodacom_projects;
```

**Vodacom's Application Strategy**

After understanding these methods, Vodacom developed a strategy for each scenario:

| Scenario | Method | Reason |
|----------|--------|--------|
| **Migrating from Access** | Create from File | Quick data import, no schema design needed |
| **New app with existing tables** | Create Application Wizard | Leverages existing database, fast setup |
| **Standard business process** | Blueprint | Proven patterns, less customization |
| **Learning/prototyping** | Sample Apps | Inspect code, learn best practices |
| **Similar to existing app** | Copy Application | Reuse customizations, maintain consistency |

**Real-World Development Timeline (Vodacom Project Manager App):**

**Week 1: Planning & Setup**
- Day 1-2: Gather requirements from users
- Day 3: Design database schema (or export from Access)
- Day 4: Create tables in Oracle Database
- Day 5: Use Create Application Wizard to generate base app

**Week 2: Customization**
- Day 1-2: Customize forms (add validation, default values)
- Day 3: Create dashboard with project metrics charts
- Day 4: Add authorization (managers see all, employees see their projects)
- Day 5: User acceptance testing

**Week 3: Refinement**
- Day 1-2: Implement user feedback
- Day 3: Add email notifications
- Day 4: Performance tuning (add indexes)
- Day 5: Final testing and deployment

**Total: 3 weeks from zero to production**

Compare this to Juan's 6-month custom Python project that achieved similar functionality.

**Common Pitfalls to Avoid**

Based on Vodacom's experience:

❌ **Don't:** Start coding immediately without planning navigation structure  
✅ **Do:** Sketch page hierarchy first (Home → List → Detail flow)

❌ **Don't:** Create separate applications for closely related data  
✅ **Do:** Use one application with multiple page groups

❌ **Don't:** Ignore naming conventions  
✅ **Do:** Use consistent prefixes (TN_EMPLOYEES, TN_PROJECTS)

❌ **Don't:** Skip the wizard and build everything from scratch  
✅ **Do:** Start with wizard, customize after

❌ **Don't:** Create custom code for standard features  
✅ **Do:** Use built-in APEX features (Interactive Report, Modal Forms)

In the next section (Advanced Explanation), we'll dive into the metadata architecture and how APEX stores all these components internally.

### Advanced Explanation

APEX applications are **metadata repositories** stored in the APEX repository schema. Each application consists of:

**Application Architecture:**

```
Application (ID: 100)
├── Pages (1..n)
│   ├── Regions
│   │   ├── Items
│   │   ├── Buttons
│   │   └── Processes
│   ├── Computations
│   ├── Validations
│   └── Dynamic Actions
├── Shared Components
│   ├── Navigation (Lists, Breadcrumbs)
│   ├── LOVs (List of Values)
│   ├── Templates (Page, Region, Report)
│   ├── Authorization Schemes
│   └── Application Items/Processes
├── Supporting Objects
│   ├── Database Objects (Tables, Views)
│   ├── PL/SQL Packages
│   └── Web Source Modules
└── Application Definition
    ├── Properties (Name, Version, Status)
    ├── Security (Authentication, Session)
    └── Globalization
```

**Application Creation Methods Deep Dive:**

| Method | Use Case | Speed | Complexity | Customization |
|--------|----------|-------|------------|---------------|
| Wizard | Standard CRUD apps | Fast | Low | Medium |
| From File | Quick prototypes | Very Fast | Very Low | Limited |
| Blueprint | Industry patterns | Fast | Medium | High |
| From Scratch | Full control | Slow | High | Complete |
| Copy Existing | Similar apps | Fast | Low | High |

**Vodacom Implementation:**
- Created **Project Management App** using wizard (based on existing tables)
- Used **Dashboard Blueprint** for executive reporting
- Installed **Sample App** for team collaboration features
- Each app runs in separate workspace with role-based access

---

## Labs / Practicals

### Lab 1: Simple - Create Application Using Wizard

**Learning Outcomes:**
By the end of this lab, you will be able to:
1. Navigate the Create Application Wizard interface
2. Configure application properties and features
3. Add multiple page types to an application
4. Understand generated page components
5. Test and validate a newly created application

**Estimated Time:** 45-60 minutes

**Business Scenario:**

Vodacom Corp currently manages employee information in a Microsoft Access database that's 10 years old. The HR department (5 people) spends hours each week dealing with:
- Database corruption (rebuilding indexes weekly)
- Concurrent access issues (only one person can edit at a time)
- No remote access (can't work from home)
- Manual export to Excel for reports
- No audit trail (who changed what, when?)

Your task: Build a modern web-based Employee Management application using APEX that:
- Allows multiple simultaneous users
- Works from anywhere (office, home, mobile)
- Has built-in search and filtering
- Exports to Excel with one click
- Tracks all changes automatically

**Prerequisites:**

**Software Requirements:**
- Access to VODACOM_DEV workspace (from Lesson 01)
- Web browser (Chrome, Firefox, Edge, Safari)
- Stable internet connection

**Database Requirements:**
```sql
-- Verify VODACOM_EMPLOYEES table exists (created in Lesson 01)
SELECT COUNT(*) FROM vodacom_employees;
-- Expected: 10-20 sample records

-- If table doesn't exist, create it:
CREATE TABLE vodacom_employees (
    employee_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name      VARCHAR2(100) NOT NULL,
    last_name       VARCHAR2(100) NOT NULL,
    email           VARCHAR2(100) UNIQUE NOT NULL,
    phone           VARCHAR2(20),
    hire_date       DATE DEFAULT SYSDATE,
    department      VARCHAR2(50),
    job_title       VARCHAR2(100),
    salary          NUMBER(10,2),
    manager_id      NUMBER,
    is_active       CHAR(1) DEFAULT 'Y',
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    created_by      VARCHAR2(100) DEFAULT USER
);

-- Insert sample data
INSERT INTO vodacom_employees (first_name, last_name, email, phone, department, job_title, salary)
VALUES ('Maria', 'Garcia', 'maria.garcia@vodacom.com', '+1-555-1001', 'Engineering', 'Senior Developer', 95000);

INSERT INTO vodacom_employees (first_name, last_name, email, phone, department, job_title, salary)
VALUES ('John', 'Chen', 'john.chen@vodacom.com', '+1-555-1002', 'Sales', 'Account Executive', 75000);

INSERT INTO vodacom_employees (first_name, last_name, email, phone, department, job_title, salary)
VALUES ('Sarah', 'Williams', 'sarah.williams@vodacom.com', '+1-555-1003', 'HR', 'HR Manager', 85000);

INSERT INTO vodacom_employees (first_name, last_name, email, phone, department, job_title, salary)
VALUES ('David', 'Kumar', 'david.kumar@vodacom.com', '+1-555-1004', 'Engineering', 'DevOps Engineer', 92000);

INSERT INTO vodacom_employees (first_name, last_name, email, phone, department, job_title, salary)
VALUES ('Lisa', 'Anderson', 'lisa.anderson@vodacom.com', '+1-555-1005', 'Marketing', 'Content Manager', 68000);

COMMIT;
```

**Knowledge Requirements:**
- Basic understanding of database tables (from Lesson 01)
- Familiarity with APEX workspace login
- Basic web navigation skills

---

#### Step-by-Step Instructions

#### **Step 1: Access APEX Workspace**

1. Open your web browser
2. Navigate to: `http://localhost:8080/ords` (or your APEX URL)
3. Click **Workspace Sign In**
4. Enter credentials:
   ```
   Workspace: VODACOM_DEV
   Username: ADMIN (or your developer username)
   Password: [Your password]
   ```
5. Click **Sign In**

**Expected Result:**
- You see the APEX home page with navigation menu
- Top right shows your username
- Available options: App Builder, SQL Workshop, Team Development, Gallery

**Troubleshooting:**
- **Error "Invalid Login Credentials"**: Verify workspace name (case-sensitive), check Caps Lock
- **Page doesn't load**: Check ORDS is running: `lsof -i :8080` (should show java process)
- **Timeout error**: Check database is running: `ps -ef | grep pmon`

---

#### **Step 2: Launch Create Application Wizard**

1. From APEX home page, click **App Builder** (large button in center)
2. You'll see a list of existing applications (may be empty if this is your first)
3. Click **Create** button (top right)
4. You'll see application creation options:

```
┌─────────────────────────────────────────────────────┐
│  How do you want to create your application?        │
├─────────────────────────────────────────────────────┤
│  [Icon] New Application                             │
│         Build app from scratch or using wizard      │
│                                                      │
│  [Icon] From a File                                 │
│         Upload spreadsheet to create app + table    │
│                                                      │
│  [Icon] Use a Blueprint                             │
│         Start from a pre-designed template          │
│                                                      │
│  [Icon] Install a Starter/Packaged App             │
│         Use ready-made application                  │
└─────────────────────────────────────────────────────┘
```

5. Click **New Application**

**Expected Result:**
- Create Application Wizard opens
- Shows "Create an Application" page
- Name field is empty, ready for input

---

#### **Step 3: Configure Application Properties**

You'll see the wizard interface with tabs across the top. Let's configure the basic properties:

**Application Name:**
```
Name: Vodacom Employee Manager
```

**Appearance:**
1. Click **Appearance** (palette icon next to Name field)
2. Select Theme: **Universal Theme - 42** (default, most modern)
3. Select Theme Style: **Vita** (clean, professional look)
   - Alternatives: Vita - Slate (dark theme), Vita - Red (corporate red)
4. Click **Choose Application Icon**
5. Select icon: **fa-users** (people icon)
6. Choose color: **Blue** (corporate standard)
7. Click **Set Application Icon and Color**
8. Click **Save Changes**

**Expected Result:**
- Application name shows "Vodacom Employee Manager" with blue people icon
- Theme shows as "Universal Theme - 42"

**Why this matters:**
- **Universal Theme**: Responsive (works on mobile), WCAG accessible, modern design
- **Vita style**: Professional, widely accepted by business users
- **Icon & color**: Visual identity, helps users recognize app in browser tabs

---

#### **Step 4: Add Features**

Below the application name, you'll see a "Features" section with checkboxes:

Check these features:

```
☑ Install Progressive Web App
  (Allows users to "install" app on mobile home screen)

☑ Configure Progressive Web App
  (Set app icon, splash screen for mobile)

☑ Access Control
  (Manage user roles: Admin, Contributor, Reader)

☑ Activity Reporting
  (Track page views, user sessions, performance)

☑ Feedback
  (Let users submit feedback/bug reports)

☑ About Page
  (Information page about the application)

☑ Theme Style Selection
  (Let users choose light/dark theme)

☑ Push Notifications
  (Send notifications to users - optional)
```

**Recommended for Vodacom:**
- ✅ Access Control (needed for HR admin vs regular users)
- ✅ Activity Reporting (track usage)
- ✅ Feedback (gather user input during rollout)
- ✅ About Page (contact info, version info)
- ⬜ Push Notifications (not needed for employee directory)

Click **Add Feature** after selecting

**Expected Result:**
- Each selected feature adds configuration pages to your application
- You'll see them listed under "Features" section

---

#### **Step 5: Add Pages - Home Page**

Now the critical part: defining what pages your application needs.

By default, APEX creates a **Home** page (Page 1). Let's customize it:

1. In the "Pages" section, you'll see **Home** listed
2. Click **Edit** (pencil icon) next to Home
3. Configure:
   ```
   Page Name: Home
   Set as Home Page: Yes (checked)
   Include Navigation Menu: Yes (checked)
   ```
4. Click **Save Changes**

The Home page will serve as the landing page with:
- Welcome message
- Navigation menu to other pages
- Optional dashboard widgets (we'll add later)

---

#### **Step 6: Add Pages - Interactive Report**

Now let's add the employee list page:

1. Click **Add Page** button
2. Select **Interactive Report**
3. Configure the report:

```
Page Name: Employees
Table or View: VODACOM_EMPLOYEES
Include Form Page: Yes (checked)
Form Page Mode: Modal Dialog
Lookup Columns:
  - MANAGER_ID (lookup to EMPLOYEE_ID - shows manager name)
```

**Advanced Options:**
```
Interactive Report Features:
  ☑ Search Bar
  ☑ Filters
  ☑ Row Selector
  ☑ Download Options (CSV, HTML, PDF)
  ☑ Aggregations
  ☑ Computations
  ☑ Charting
  ☑ Highlight Rows
  ☑ Flashback
```

Keep all default features checked (they're all useful).

4. Click **Add Page**

**Expected Result:**
- Two pages added: 
  - Page 2: Employees (Interactive Report)
  - Page 3: Employee (Form in Modal Dialog)

**What you just created:**
- **Page 2**: List view showing all employees in a searchable, sortable table
- **Page 3**: Form that opens in a popup when user clicks "Edit" or "Add Employee"
- **Automatic linkage**: Report has Edit icon that opens Form with correct employee data

---

#### **Step 7: Add Pages - Dashboard**

Let's add a dashboard with visual analytics:

1. Click **Add Page**
2. Select **Dashboard**
3. Configure:

```
Page Name: Employee Analytics
Chart 1:
  Type: Bar Chart
  Title: Employees by Department
  Table: VODACOM_EMPLOYEES
  Label Column: DEPARTMENT
  Value: Count
  
Chart 2:
  Type: Pie Chart
  Title: Employees by Job Title
  Table: VODACOM_EMPLOYEES
  Label Column: JOB_TITLE
  Value: Count
```

4. Click **Add Page**

**Expected Result:**
- Page 4 added: Employee Analytics
- Will show visual representation of employee distribution

---

#### **Step 8: Add Pages - Calendar (Optional)**

For tracking employee hire dates visually:

1. Click **Add Page**
2. Select **Calendar**
3. Configure:

```
Page Name: Hiring Calendar
Table: VODACOM_EMPLOYEES
Display Column: FIRST_NAME || ' ' || LAST_NAME || ' - ' || JOB_TITLE
Date Column: HIRE_DATE
```

4. Click **Add Page**

**Expected Result:**
- Page 5 added: Hiring Calendar
- Shows employees plotted on calendar by hire date

---

#### **Step 9: Configure Navigation**

Now organize how users navigate between pages:

1. Scroll to **Navigation** section
2. You'll see navigation menu preview:

```
├─ Home
├─ Employees
├─ Employee Analytics
└─ Hiring Calendar
```

3. Click **Edit Navigation Menu**
4. Organize hierarchically:

```
📊 Home
👥 Employees
   ├─ Employee List (Page 2)
   └─ Employee Analytics (Page 4)
📅 Hiring Calendar
⚙️ Administration
   ├─ Access Control (if feature enabled)
   └─ Activity Reports
```

Drag and drop pages to reorder or create parent-child relationships.

5. Click **Save**

**Expected Result:**
- Navigation menu shows logical grouping
- Related pages nested under parent items

---

#### **Step 10: Configure Settings**

Final configuration before creating the application:

1. Scroll to **Settings** section
2. Configure:

```
Authentication Scheme: Application Express Accounts
  (Users log in with APEX workspace credentials)

Authorization Scheme: Reader, Contributor, Administrator
  (Three-tier access control)

Friendly URLs: Yes (checked)
  (Use /employees/123 instead of f?p=100:2:12345...)

Enable Application Debugging: Yes (checked)
  (Useful for troubleshooting during development)

Enable Logging: Yes (checked)
  (Track errors and usage)
```

**Advanced Settings (Optional):**
```
Rejoin Sessions: Yes
  (Return to where user left off)

Deep Linking: Yes
  (Allow bookmarking specific pages)

Browser Cache: Default
  (Let APEX manage caching for performance)

Session Timeout: 3600 seconds (1 hour)
  (Auto logout after 1 hour of inactivity)
```

3. Review all settings

---

#### **Step 11: Create Application**

The moment of truth!

1. Scroll to top
2. Review application summary:

```
Application: Vodacom Employee Manager
Pages: 5 (Home, Employees, Form, Analytics, Calendar)
Features: Access Control, Activity Reporting, Feedback, About Page
Theme: Universal Theme - 42 (Vita)
Authentication: Application Express Accounts
```

3. Click **Create Application** button (top right, blue button)

**What happens next:**
- APEX generates ~500-1000 lines of metadata
- Creates all pages, regions, items, buttons
- Generates SQL for reports and forms
- Sets up navigation structures
- Configures security
- **Time: 30-60 seconds**

**Expected Output:**
```
Creating Application...
✓ Application created (ID: 100)
✓ 5 pages created
✓ Navigation menu created
✓ Authentication scheme configured
✓ Supporting objects verified
✓ Application available for editing

[Run Application] [Edit Application]
```

---

#### **Step 12: First Run - Test Application**

1. Click **Run Application** button (green play icon)
2. New browser tab opens
3. Login page appears:

```
┌──────────────────────────────────────┐
│    Vodacom Employee Manager         │
│           [User Icon]                │
├──────────────────────────────────────┤
│  Username: [____________]            │
│  Password: [____________]            │
│           [Sign In]                  │
└──────────────────────────────────────┘
```

4. Enter your APEX credentials
5. Click **Sign In**

**Expected Result:**
- Application opens showing Home page
- Navigation menu on left side (or top, depending on theme)
- Welcome message
- No errors

---

#### **Step 13: Test Interactive Report**

1. Click **Employees** in navigation menu
2. You should see the employee list:

```
┌─────────────────────────────────────────────────────────────────┐
│ Employees                                    [Add Employee]      │
├─────────────────────────────────────────────────────────────────┤
│ Search: [_______________]  [Go]  [Reset]                        │
├──────┬────────────┬──────────────┬─────────────┬───────────────┤
│ Edit │ First Name │ Last Name    │ Email       │ Department    │
├──────┼────────────┼──────────────┼─────────────┼───────────────┤
│  ✎  │ Maria      │ Garcia       │ maria@...   │ Engineering   │
│  ✎  │ John       │ Chen         │ john@...    │ Sales         │
│  ✎  │ Sarah      │ Williams     │ sarah@...   │ HR            │
│  ✎  │ David      │ Kumar        │ david@...   │ Engineering   │
│  ✎  │ Lisa       │ Anderson     │ lisa@...    │ Marketing     │
└──────┴────────────┴──────────────┴─────────────┴───────────────┘
Rows 1 - 5 of 5                          [Actions ▼] [Download ▼]
```

**Test Report Features:**

**A. Search:**
- Type "Garcia" in search box
- Click **Go**
- Should show only Maria Garcia
- Click **Reset** to clear

**B. Column Sorting:**
- Click **Last Name** column header
- Data sorts alphabetically
- Click again to reverse sort

**C. Filtering:**
- Click **Actions** → **Filter**
- Add filter: Department = Engineering
- Should show Maria and David only
- Remove filter: Actions → Clear All Filters

**D. Download:**
- Click **Download** → **CSV**
- Excel file downloads with all employee data
- Open file to verify data

---

#### **Step 14: Test Form - Add Employee**

1. Click **Add Employee** button (top right of report)
2. Modal dialog opens:

```
┌──────────────────────────────────────┐
│ Employee                     [X]     │
├──────────────────────────────────────┤
│ First Name *   [______________]      │
│ Last Name *    [______________]      │
│ Email *        [______________]      │
│ Phone          [______________]      │
│ Hire Date      [____]  [📅]         │
│ Department     [______________ ▼]    │
│ Job Title      [______________]      │
│ Salary         [______________]      │
│ Manager        [______________ ▼]    │
│ Is Active      [⚪ Yes  ⚪ No]      │
│                                      │
│        [Cancel]  [Create]            │
└──────────────────────────────────────┘
```

3. Enter test data:
```
First Name: Test
Last Name: Employee
Email: test.employee@vodacom.com
Phone: +1-555-0099
Hire Date: (today's date)
Department: IT
Job Title: Test Engineer
Salary: 80000
Manager: (select any employee)
Is Active: Yes
```

4. Click **Create**

**Expected Result:**
- Dialog closes
- Report refreshes automatically
- New employee appears in list
- Success message: "Employee created successfully"

---

#### **Step 15: Test Form - Edit Employee**

1. In the employee list, click **Edit** icon (pencil) for "Test Employee"
2. Form opens with data pre-filled
3. Change:
   - Job Title: "Senior Test Engineer"
   - Salary: 90000
4. Click **Save**

**Expected Result:**
- Dialog closes
- Report refreshes
- Test Employee now shows updated title
- Success message: "Employee updated successfully"

---

#### **Step 16: Test Dashboard**

1. Click **Employee Analytics** in navigation menu
2. You should see:

**Chart 1: Employees by Department**
```
Engineering  ■■■■■ (2)
Sales        ■■ (1)
HR           ■■ (1)
Marketing    ■■ (1)
IT           ■■ (1)
```

**Chart 2: Employees by Job Title**
```
Pie chart showing distribution:
- Senior Developer: 16.7%
- Account Executive: 16.7%
- HR Manager: 16.7%
- DevOps Engineer: 16.7%
- Content Manager: 16.7%
- Senior Test Engineer: 16.7%
```

**Expected Result:**
- Charts render properly
- Data reflects current employee count
- Charts are interactive (hover shows details)

---

#### **Step 17: Validation Checklist**

Verify all components work:

```
✓ Login page loads correctly
✓ Home page displays after login
✓ Navigation menu shows all pages
✓ Employee report displays all records
✓ Search functionality works
✓ Column sorting works
✓ Filters work
✓ Download to CSV/Excel works
✓ Add Employee form opens
✓ New employee can be created
✓ Edit Employee form opens with data
✓ Existing employee can be updated
✓ Dashboard charts render
✓ Dashboard shows accurate data
✓ Calendar page loads (if created)
✓ About page accessible
✓ Logout works (doesn't error)
```

Check off each item. If any fail, see Troubleshooting section below.

---

#### **Troubleshooting**

**Problem: Report shows "No data found"**
- **Cause**: Table is empty or wrong table selected
- **Solution**:
  ```sql
  -- Check if data exists
  SELECT COUNT(*) FROM vodacom_employees;
  -- Should return > 0
  
  -- If 0, insert sample data (see Prerequisites section)
  ```

**Problem: Form doesn't open when clicking Edit**
- **Cause**: Form page not linked correctly
- **Solution**:
  - Edit Page 2 (Report)
  - Check Link Column property points to Page 3
  - Set Primary Key item: P3_EMPLOYEE_ID
  - Save and re-test

**Problem: New employee doesn't save**
- **Cause**: Validation error or missing required fields
- **Solution**:
  - Check for error message at top of form
  - Ensure required fields (*) are filled
  - Check email format is valid
  - Verify email doesn't already exist (UNIQUE constraint)

**Problem: Dashboard charts don't render**
- **Cause**: No data in table or SQL error
- **Solution**:
  - Verify data exists: `SELECT DEPARTMENT, COUNT(*) FROM vodacom_employees GROUP BY DEPARTMENT;`
  - Edit Page 4, check chart SQL
  - Run SQL in SQL Workshop to test

**Problem: "Session state protection" error**
- **Cause**: Security setting blocking request
- **Solution**:
  - Edit application properties
  - Session State Protection: Moderate (not Unrestricted)
  - Save and re-test

**Problem: Changes don't appear after clicking Save**
- **Cause**: Process not running or SQL error
- **Solution**:
  - Enable Debug mode: Help → Debug → Toggle
  - Reproduce error
  - View Debug: Help → Debug → View Debug
  - Look for SQL errors in process execution

---

#### **Lab Summary**

**What You Accomplished:**
✅ Created a complete web application in less than 1 hour
✅ Built 5 functional pages without writing code
✅ Implemented search, sort, filter capabilities
✅ Created data entry forms with validation
✅ Generated visual analytics dashboard
✅ Deployed a multi-user, web-accessible system

**Key Concepts Covered:**
- Create Application Wizard workflow
- Page types (Report, Form, Dashboard, Calendar)
- Navigation menu configuration
- Authentication and authorization
- Theme selection and appearance
- Testing and validation procedures

**Real-World Impact:**
- **Vodacom HR Department**: Can now manage employees from anywhere
- **Cost**: ~$50 (1 hour development) vs $5,000+ for custom development
- **Time**: 1 hour vs 4-6 weeks traditional development
- **Maintenance**: Zero code to maintain, APEX handles updates
- **Scalability**: Works for 5 users or 5,000 users

**Next Steps:**
1. Customize form validations (email format, salary range)
2. Add more dashboard charts (hiring trends, salary analysis)
3. Implement role-based access (HR Admin can delete, others can only view)
4. Add email notifications when new employees are added
5. Export application and install in TEST environment

**Time Spent on This Lab:** ______ minutes  
(Target: 45-60 minutes)

---

#### **Additional Resources**

**Vodacom Internal Resources:**
- Wiki: Internal APEX Development Standards
- Slack: #apex-development channel
- Video: "Your First APEX App" (10 minutes)

**Oracle Documentation:**
- [Create Application Wizard Guide](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/creating-applications.html)
- [Universal Theme Documentation](https://apex.oracle.com/ut)
- [Interactive Reports](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/managing-interactive-reports.html)

**Practice Exercises:**
1. Add a second table: DEPARTMENTS, create similar app
2. Create master-detail: PROJECTS → TASKS
3. Build calendar showing project deadlines

**Office Hours:**
- Tuesdays 2-3 PM: APEX Q&A with DevOps team
- Fridays 11-12 PM: Lab review sessions

---

---

### Lab 2: Intermediate - Create Application from Spreadsheet

**Learning Outcomes:**
By the end of this lab, you will be able to:
1. Prepare data in Excel/CSV format for APEX import
2. Use the "Create from File" wizard
3. Understand APEX data type detection
4. Customize auto-generated applications
5. Handle data import errors and corrections

**Estimated Time:** 60-75 minutes

**Business Scenario:**

Vodacom's Sales department has been managing client information in Excel spreadsheets for years. Problems they face:

- **Version Control Issues**: 5 different "Clients_Final_v3.xlsx" files
- **Data Inconsistency**: Client name spelled differently in different sheets
- **No Validation**: Phone numbers like "call office" or "TBD"
- **No Collaboration**: Only one person can edit at a time
- **No History**: Can't see who changed what
- **Security Risk**: Spreadsheets emailed around, stored on USB drives

**Current State:**
- 180 client records across 3 Excel files
- Revenue data scattered in separate quarterly reports
- Contact information frequently out of date
- No way to track client interactions
- Sales reps duplicate effort (don't know who contacted whom)

**Your Mission:**

Build a centralized Client Management system by:
1. Consolidating Excel data into single source
2. Using APEX to create table + application in one step
3. Adding validation rules to prevent bad data
4. Giving entire sales team (15 people) access

**Expected Outcome:**
- Single source of truth for client data
- Web-accessible from office, home, mobile
- Real-time updates (no more version conflicts)
- Validation prevents data quality issues
- Audit trail of all changes

---

#### **Prerequisites**

**Software Requirements:**
- Microsoft Excel, Google Sheets, or LibreOffice Calc
- Access to VODACOM_DEV workspace
- Web browser with good internet connection

**Knowledge Requirements:**
- Basic Excel skills (rows, columns, data entry)
- Understanding of data types (text, numbers, dates)
- Completed Lab 1 (familiarity with APEX interface)

**Sample Data Preparation:**
Before starting, you'll need client data. You can use:
- **Option A**: Existing Excel file (from Vodacom Sales dept)
- **Option B**: Create sample file following steps below
- **Option C**: Use CSV format if Excel not available

---

#### **Step 1: Create Excel Spreadsheet with Client Data**

Open Excel and create a new workbook named `vodacom_clients.xlsx`

**Column Headers (Row 1):**
```
| Company Name | Contact Name | Title | Email | Phone | Country | Industry | Annual Revenue | First Contact Date | Status | Notes |
```

**Sample Data (Rows 2-11) - Enter exactly as shown:**

| Company Name | Contact Name | Title | Email | Phone | Country | Industry | Annual Revenue | First Contact Date | Status | Notes |
|--------------|--------------|-------|-------|-------|---------|----------|----------------|-------------------|--------|-------|
| Acme Corporation | John Smith | VP Operations | john.smith@acmecorp.com | +1-555-2001 | USA | Manufacturing | 5000000 | 2023-01-15 | Active | Interested in ERP migration |
| GlobalTech Ltd | Jane Doe | CTO | jane.doe@globaltech.co.uk | +44-20-5555-0200 | United Kingdom | Technology | 3000000 | 2023-02-20 | Active | Needs cloud solution |
| FastRetail Inc | Bob Lee | IT Manager | bob.lee@fastretail.jp | +81-3-5555-0300 | Japan | Retail | 8000000 | 2022-11-05 | Active | Oracle APEX project underway |
| EuroBank AG | Maria Schmidt | Head of IT | m.schmidt@eurobank.de | +49-69-5555-0400 | Germany | Finance | 15000000 | 2023-03-10 | Prospect | Compliance requirements |
| MexiPharma SA | Carlos Rodriguez | CIO | carlos.r@mexipharma.mx | +52-55-5555-0500 | Mexico | Healthcare | 4500000 | 2023-04-01 | Active | Phase 2 starting |
| AussieMine Pty | Sarah Johnson | Digital Director | s.johnson@ausmine.au | +61-2-5555-0600 | Australia | Mining | 12000000 | 2022-09-15 | On Hold | Budget frozen Q1 |
| Nordic Foods AB | Erik Andersson | VP Technology | erik@nordicfoods.se | +46-8-5555-0700 | Sweden | Food & Beverage | 6000000 | 2023-05-20 | Active | Multi-year contract |
| IndiaServe Pvt | Priya Patel | COO | priya.patel@indiaserve.in | +91-22-5555-0800 | India | Services | 2500000 | 2023-06-12 | Prospect | Price negotiation |
| CanadaCo Inc | David Wong | IT Lead | d.wong@canadaco.ca | +1-416-555-0900 | Canada | Logistics | 7000000 | 2023-02-28 | Active | Expansion planned |
| BrazilTech Ltda | Ana Silva | Tech Manager | ana.silva@braziltech.br | +55-11-5555-1000 | Brazil | Technology | 3800000 | 2023-07-05 | Active | Training needed |

**Important Data Quality Tips:**

✅ **DO:**
- Use consistent date format (YYYY-MM-DD)
- Use numeric values for revenue (no $ signs or commas)
- Keep phone numbers in international format
- Use consistent country names (full name, not abbreviations)
- Fill all cells (use "N/A" if data missing, not blank)

❌ **DON'T:**
- Mix date formats (01/15/2023 and 2023-01-15)
- Use currency symbols ($5,000,000)
- Use vague values ("a lot", "TBD", "???")
- Leave headers empty
- Use special characters in column names (use underscores not spaces)

**Save the file:**
- File → Save As
- Location: Desktop or Documents folder
- Format: Excel Workbook (.xlsx)
- Name: `vodacom_clients.xlsx`

---

#### **Step 2: Access Create From File Wizard**

1. Log into APEX workspace: `VODACOM_DEV`
2. Click **App Builder**
3. Click **Create** button (top right)
4. Select **From a File**

**You'll see upload interface:**
```
┌──────────────────────────────────────────────────┐
│  Create Application from File                    │
├──────────────────────────────────────────────────┤
│  Drop file here or click to browse               │
│  [         Drag & Drop Zone        ]             │
│                                                   │
│  Supported formats:                              │
│  • Excel (.xlsx, .xls)                          │
│  • CSV (.csv)                                    │
│  • Text (.txt, .tsv)                            │
│  • XML (.xml)                                    │
│  • JSON (.json)                                  │
│                                                   │
│  Maximum file size: 50 MB                        │
└──────────────────────────────────────────────────┘
```

---

#### **Step 3: Upload File**

**Option A: Drag and Drop**
1. Open file explorer, locate `vodacom_clients.xlsx`
2. Drag file onto APEX upload zone
3. File uploads, shows progress bar
4. After upload: "File uploaded successfully"

**Option B: Browse and Select**
1. Click **Browse** button in upload zone
2. Navigate to file location
3. Select `vodacom_clients.xlsx`
4. Click **Open**
5. File uploads automatically

**Expected Result:**
```
✓ File uploaded: vodacom_clients.xlsx (45 KB)
✓ 10 rows detected
✓ 11 columns detected

[Next] button becomes active
```

Click **Next**

---

#### **Step 4: Data Preview and Configuration**

APEX analyzes your file and shows preview. You'll see:

**Data Preview Table:**
```
Row | Company Name       | Contact Name  | Title        | Email              | ... 
----|-------------------|---------------|--------------|--------------------|-
1   | Acme Corporation  | John Smith    | VP Operations| john.smith@acme... |
2   | GlobalTech Ltd    | Jane Doe      | CTO          | jane.doe@global... |
3   | FastRetail Inc    | Bob Lee       | IT Manager   | bob.lee@fastr...   |
... (showing first 5 rows)
```

**Table Configuration:**

1. **Table Name:**
   ```
   Table Name: VODACOM_CLIENTS
   
   (APEX auto-suggests based on filename)
   ```
   
   **Naming Rules:**
   - Max 30 characters
   - Start with letter
   - Only letters, numbers, underscores
   - No spaces, no special characters

2. **Primary Key Column:**
   ```
   Primary Key: [Create identity column] (selected)
   Column Name: CLIENT_ID
   Type: NUMBER (identity/auto-increment)
   ```

3. **Column Data Types:**

APEX auto-detects, but review each column:

| Column Name | Detected Type | Correct? | Action |
|-------------|---------------|----------|--------|
| COMPANY_NAME | VARCHAR2(100) | ✅ Yes | Keep |
| CONTACT_NAME | VARCHAR2(100) | ✅ Yes | Keep |
| TITLE | VARCHAR2(50) | ✅ Yes | Keep |
| EMAIL | VARCHAR2(100) | ✅ Yes | Keep |
| PHONE | VARCHAR2(20) | ✅ Yes | Keep |
| COUNTRY | VARCHAR2(50) | ✅ Yes | Keep |
| INDUSTRY | VARCHAR2(50) | ✅ Yes | Keep |
| ANNUAL_REVENUE | NUMBER | ✅ Yes | Keep |
| FIRST_CONTACT_DATE | DATE | ✅ Yes | Keep |
| STATUS | VARCHAR2(20) | ✅ Yes | Keep |
| NOTES | VARCHAR2(4000) | ✅ Yes | Keep |

**If type detection is wrong:**
- Click dropdown next to column
- Select correct type (VARCHAR2, NUMBER, DATE, CLOB)
- Adjust length if needed

**Advanced Options (Optional):**

```
☑ Add audit columns
  (Adds: CREATED_DATE, CREATED_BY, MODIFIED_DATE, MODIFIED_BY)

☐ Add row version number
  (For optimistic locking - advanced feature)

☑ Create indexes
  (On frequently searched columns: COMPANY_NAME, EMAIL, COUNTRY)
```

Check **Add audit columns** (recommended for tracking changes)

Click **Next**

---

#### **Step 5: Data Loading Options**

**Load Method:**
```
○ Upload file and create table, do not create application
● Upload file, create table, and create application
○ Append data to existing table
```

Select: **Upload file, create table, and create application** (2nd option)

**Application Configuration:**
```
Application Name: Vodacom Client Management
Application Type: Database
  ● New application
  ○ Add to existing application
```

**Page Configuration:**
```
Create the following pages:
☑ Interactive Report (list all clients)
☑ Form (add/edit clients)
☑ Dashboard (client analytics)

Report Features:
☑ Search
☑ Filters
☑ Download
☑ Pagination
```

**Authentication:**
```
Authentication: Application Express Accounts
Authorization: Reader, Contributor, Administrator
```

Click **Create Application**

---

#### **Step 6: Watch the Magic Happen**

APEX performs multiple operations automatically:

**Progress Indicators:**
```
⏳ Uploading file data... ✓ Complete (2 seconds)
⏳ Analyzing data structure... ✓ Complete (1 second)
⏳ Creating table VODACOM_CLIENTS... ✓ Complete (3 seconds)
⏳ Creating primary key constraint... ✓ Complete (1 second)
⏳ Creating indexes... ✓ Complete (2 seconds)
⏳ Loading data (10 rows)... ✓ Complete (1 second)
⏳ Creating application (ID: 101)... ✓ Complete (5 seconds)
⏳ Generating pages... ✓ Complete (8 seconds)
⏳ Configuring navigation... ✓ Complete (2 seconds)
⏳ Finalizing application... ✓ Complete (1 second)

Total Time: ~26 seconds
```

**Success Screen:**
```
✓ Application Created Successfully

Application ID: 101
Application Name: Vodacom Client Management
Table Created: VODACOM_CLIENTS (10 rows)
Pages Created: 5

[Run Application]  [Edit Application]
```

---

#### **Step 7: Review Generated Database Table**

Before running the app, let's verify the table was created correctly:

1. In APEX, click **SQL Workshop** (top menu)
2. Click **SQL Commands**
3. Enter and run:

```sql
-- Check table structure
DESCRIBE vodacom_clients;
```

**Expected Output:**
```
Name               Null?    Type
------------------ -------- -------------------
CLIENT_ID          NOT NULL NUMBER (generated always as identity)
COMPANY_NAME                VARCHAR2(100)
CONTACT_NAME                VARCHAR2(100)
TITLE                       VARCHAR2(50)
EMAIL                       VARCHAR2(100)
PHONE                       VARCHAR2(20)
COUNTRY                     VARCHAR2(50)
INDUSTRY                    VARCHAR2(50)
ANNUAL_REVENUE              NUMBER
FIRST_CONTACT_DATE          DATE
STATUS                      VARCHAR2(20)
NOTES                       VARCHAR2(4000)
CREATED_DATE                TIMESTAMP(6)
CREATED_BY                  VARCHAR2(255)
MODIFIED_DATE               TIMESTAMP(6)
MODIFIED_BY                 VARCHAR2(255)
```

4. Verify data:
```sql
-- Check row count
SELECT COUNT(*) FROM vodacom_clients;
-- Should return: 10

-- View all data
SELECT client_id, company_name, contact_name, country, annual_revenue
FROM vodacom_clients
ORDER BY company_name;
```

**Expected Output:**
```
CLIENT_ID | COMPANY_NAME       | CONTACT_NAME      | COUNTRY        | ANNUAL_REVENUE
----------|-------------------|-------------------|----------------|---------------
1         | Acme Corporation  | John Smith        | USA            | 5000000
2         | AussieMine Pty    | Sarah Johnson     | Australia      | 12000000
3         | BrazilTech Ltda   | Ana Silva         | Brazil         | 3800000
...
```

5. Check indexes:
```sql
SELECT index_name, column_name
FROM user_ind_columns
WHERE table_name = 'VODACOM_CLIENTS'
ORDER BY index_name, column_position;
```

**Expected Output:**
```
INDEX_NAME                 | COLUMN_NAME
--------------------------|-------------
VODACOM_CLIENTS_PK       | CLIENT_ID
VODACOM_CLIENTS_IDX1     | COMPANY_NAME
VODACOM_CLIENTS_IDX2     | EMAIL
```

---

#### **Step 8: Run and Test the Application**

1. Go back to **App Builder**
2. Find application: **Vodacom Client Management**
3. Click **Run Application** (green play button)

**Login Page:**
- Enter your APEX credentials
- Click **Sign In**

**Home Page appears with:**
- Application title: "Vodacom Client Management"
- Navigation menu
- Welcome message

---

#### **Step 9: Test Interactive Report**

1. Click **Clients** in navigation menu

**You should see:**
```
┌──────────────────────────────────────────────────────────────────────────────┐
│ Clients                                              [Add Client]             │
├──────────────────────────────────────────────────────────────────────────────┤
│ Search: [_______________] [Go]                                               │
├──────┬──────────────────┬───────────────┬──────────────────┬─────────────────┤
│ Edit │ Company Name     │ Contact Name  │ Country          │ Annual Revenue  │
├──────┼──────────────────┼───────────────┼──────────────────┼─────────────────┤
│  ✎  │ Acme Corporation │ John Smith    │ USA              │ $5,000,000     │
│  ✎  │ AussieMine Pty   │ Sarah Johnson │ Australia        │ $12,000,000    │
│  ✎  │ BrazilTech Ltda  │ Ana Silva     │ Brazil           │ $3,800,000     │
│  ✎  │ CanadaCo Inc     │ David Wong    │ Canada           │ $7,000,000     │
│  ✎  │ EuroBank AG      │ Maria Schmidt │ Germany          │ $15,000,000    │
│  ✎  │ FastRetail Inc   │ Bob Lee       │ Japan            │ $8,000,000     │
│  ✎  │ GlobalTech Ltd   │ Jane Doe      │ United Kingdom   │ $3,000,000     │
│  ✎  │ IndiaServe Pvt   │ Priya Patel   │ India            │ $2,500,000     │
│  ✎  │ MexiPharma SA    │ Carlos Rodrig │ Mexico           │ $4,500,000     │
│  ✎  │ Nordic Foods AB  │ Erik Andersson│ Sweden           │ $6,000,000     │
└──────┴──────────────────┴───────────────┴──────────────────┴─────────────────┘
Rows 1 - 10 of 10                          [Actions ▼] [Download ▼] [Subscribe ▼]
```

**Test Report Features:**

**A. Search by Company:**
```
Search: "Acme"
[Go]
Result: Shows only Acme Corporation row
```

**B. Filter by Country:**
```
Actions → Filter
Column: COUNTRY
Operator: =
Value: USA
Apply
Result: Shows Acme Corporation and CanadaCo Inc
```

**C. Sort by Revenue:**
```
Click "Annual Revenue" column header
Result: Sorts largest to smallest
```

**D. Download to Excel:**
```
Download → CSV
Result: File "clients.csv" downloads with all 10 records
Open in Excel to verify
```

---

#### **Step 10: Test Form - Add New Client**

1. Click **Add Client** button

**Form opens in modal dialog:**
```
┌──────────────────────────────────────────┐
│ Client                           [X]     │
├──────────────────────────────────────────┤
│ Company Name *   [__________________]    │
│ Contact Name     [__________________]    │
│ Title            [__________________]    │
│ Email            [__________________]    │
│ Phone            [__________________]    │
│ Country          [__________________]    │
│ Industry         [__________________]    │
│ Annual Revenue   [__________________]    │
│ First Contact    [____] [📅]            │
│ Status           [_______ ▼]             │
│ Notes            [__________________]    │
│                  [__________________]    │
│                  [__________________]    │
│                                          │
│         [Cancel]  [Create]               │
└──────────────────────────────────────────┘
```

2. Enter test client data:
```
Company Name: TestCompany LLC
Contact Name: Test User
Title: CEO
Email: test@testcompany.com
Phone: +1-555-0098
Country: USA
Industry: Testing
Annual Revenue: 1000000
First Contact Date: (today's date)
Status: Prospect
Notes: Test client for training purposes
```

3. Click **Create**

**Expected Result:**
- Dialog closes
- Report refreshes
- TestCompany LLC appears in list
- Success message: "Client created"

---

#### **Step 11: Test Form - Edit Existing Client**

1. Click **Edit** icon next to "TestCompany LLC"
2. Form opens with data pre-filled
3. Change:
   - Status: Active
   - Annual Revenue: 1500000
   - Notes: "Training completed successfully"
4. Click **Save**

**Expected Result:**
- Changes saved
- Report refreshes
- TestCompany shows updated values

---

#### **Step 12: View Dashboard (If Created)**

1. Click **Dashboard** in navigation menu

**You should see charts:**

**Chart 1: Clients by Country**
```
Bar Chart:
USA             ■■ (2)
Australia       ■ (1)
Brazil          ■ (1)
Canada          ■ (1)
Germany         ■ (1)
...
```

**Chart 2: Revenue by Industry**
```
Pie Chart:
- Technology: 30%
- Manufacturing: 20%
- Finance: 25%
- Healthcare: 15%
- Other: 10%
```

**Chart 3: Client Status**
```
Donut Chart:
- Active: 8 (73%)
- Prospect: 2 (18%)
- On Hold: 1 (9%)
```

---

#### **Step 13: Validation & Testing**

Run through this checklist:

```
✓ Table VODACOM_CLIENTS exists in database
✓ All 10 original rows loaded correctly
✓ Primary key CLIENT_ID auto-increments
✓ Audit columns track changes (CREATED_DATE, MODIFIED_BY)
✓ Application appears in App Builder
✓ Login page works
✓ Interactive Report displays all clients
✓ Search functionality works
✓ Column sorting works
✓ Filters work
✓ Download to CSV/Excel works
✓ Add Client form opens
✓ New client can be created
✓ Edit Client form opens with correct data
✓ Client can be updated
✓ Dashboard charts render (if included)
✓ No SQL errors in page loads
```

---

#### **Step 14: Add Custom Validation**

Let's enhance the form with validation rules:

1. Go to **App Builder** → **Vodacom Client Management**
2. Find form page (usually Page 3)
3. Click page number to edit
4. Find **P3_EMAIL** item
5. Right-click → **Create Validation**
6. Configure:

```
Validation Name: Email Format Check
Type: Function Body (returning Boolean)
PL/SQL Function:
```

```sql
RETURN REGEXP_LIKE(:P3_EMAIL, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$');
```

```
Error Message: Please enter a valid email address (e.g., name@company.com)
Display Location: Inline with Field
```

7. Click **Create Validation**

**Test validation:**
- Try to save client with email: "notanemail"
- Should show error: "Please enter a valid email address"

---

#### **Troubleshooting Common Issues**

**Problem: File upload fails with "Invalid format"**
- **Cause**: File corruption or unsupported format
- **Solution**:
  - Save Excel as CSV, try uploading CSV instead
  - Check file size < 50 MB
  - Remove any formulas, keep only raw data

**Problem: Data types detected incorrectly (e.g., dates show as text)**
- **Cause**: Inconsistent date formats in Excel
- **Solution**:
  - Format all date cells in Excel as YYYY-MM-DD
  - Re-upload file
  - Or manually change column type in preview screen

**Problem: Special characters display as "?" or gibberish**
- **Cause**: Character encoding mismatch
- **Solution**:
  - Save Excel as "CSV UTF-8"
  - Or in APEX, set file encoding to UTF-8 before upload

**Problem: Duplicate primary key error when loading**
- **Cause**: Excel contains ID column that conflicts
- **Solution**:
  - Delete ID column from Excel before upload
  - Let APEX create identity column automatically

**Problem: Application created but no data in table**
- **Cause**: Data loading step failed silently
- **Solution**:
  ```sql
  -- Manually load data from saved file
  -- Use Data Workshop → Data Load
  ```

**Problem: Revenue shows as text not number**
- **Cause**: Excel cells formatted as text, or contain $ symbols
- **Solution**:
  - Remove all currency symbols from Excel
  - Format cells as Number with 0 decimals
  - Re-upload

---

#### **Lab Summary**

**What You Accomplished:**
✅ Created database table from Excel in seconds (vs hours of CREATE TABLE coding)
✅ Loaded 10 client records automatically (vs manual INSERT statements)
✅ Generated complete application with zero code
✅ Built searchable, filterable report interface
✅ Created data entry forms with validation
✅ Generated analytics dashboard
✅ Eliminated Excel version control problems
✅ Gave team web-based collaborative access

**Key Concepts Covered:**
- Spreadsheet-to-database workflow
- APEX automatic data type detection
- Table creation with audit columns
- Application generation from file
- Data validation techniques
- Testing imported applications

**Real-World Impact for Vodacom Sales:**

**Before (Excel spreadsheet):**
- 5 different versions of client list
- Last updated: "sometime last month"
- Only 1 person can edit at a time
- Emailed around (security risk)
- No validation (bad phone numbers, emails)
- Manual reporting (hours of copy-paste)

**After (APEX application):**
- Single source of truth
- Real-time updates
- 15 sales reps can access simultaneously
- Secure login, role-based access
- Automatic validation
- One-click Excel export for reports
- Audit trail of all changes

**Time Saved:**
- Traditional development: 20-30 hours (schema design, CRUD code, UI, testing)
- APEX from file: 1 hour (mostly data prep and testing)
- **Savings: 95%+ reduction in development time**

**Cost Saved:**
- Traditional: $2,000-$3,000 (developer time)
- APEX: $100 (1 hour × $100/hr)
- **Savings: $1,900-$2,900**

---

#### **Additional Enhancements (Optional)**

Challenge yourself with these improvements:

1. **Add Email Validation:**
   - Ensure email format is correct
   - Check for duplicates

2. **Add Revenue Categorization:**
   - Create computed column: Small (<$2M), Medium ($2-10M), Large (>$10M)

3. **Add Client Logo Upload:**
   - Add BLOB column for storing company logos
   - Display logos in report

4. **Create Follow-up Tracking:**
   - New table: VODACOM_FOLLOWUPS (client_id, follow_up_date, notes)
   - Link to clients

5. **Add Email Notifications:**
   - Send email when new client added
   - Notify sales manager of high-value prospects

---

#### **Next Steps**

1. Import your real client data (replace test data)
2. Customize form layout (reorder fields, group related fields)
3. Add more charts to dashboard
4. Create filtered views (My Clients, Active Only, High Value)
5. Export application for deployment to TEST environment

**Time Spent on This Lab:** ______ minutes  
(Target: 60-75 minutes)

---

#### **Additional Resources**

**Vodacom Internal:**
- Sales department SharePoint: "Client Management Best Practices"
- Training video: "Excel to APEX Migration" (15 minutes)

**Oracle Documentation:**
- [Create Application from File](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/creating-an-application-from-a-spreadsheet.html)
- [Data Loading](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/loading-data.html)

**Practice:**
- Try with different Excel files (employee data, inventory, sales records)
- Experiment with CSV, XML, JSON formats

---

---

### Lab 3: Advanced - Multi-Table Application with Master-Detail

**Objective:** Build complete project management app with related tables.

**Step 1: Create Application Structure**

```sql
-- Ensure tables exist from Lesson 01
SELECT table_name FROM user_tables
WHERE table_name IN ('VODACOM_PROJECTS', 'VODACOM_EMPLOYEES', 'VODACOM_TASKS');
```

**Step 2: Use Create Application Wizard**

1. App Builder → **Create** → **New Application**
2. Name: `Vodacom Project Manager`

**Add Multiple Pages:**

```
Page 2: Interactive Report
  - Name: Projects
  - Table: VODACOM_PROJECTS
  - Include Form: Yes
  
Page 4: Interactive Report
  - Name: Tasks
  - Table: VODACOM_TASKS
  - Include Form: Yes
  
Page 6: Master Detail
  - Master Table: VODACOM_PROJECTS
  - Detail Table: VODACOM_TASKS
  - Relationship: PROJECT_ID
```

**Step 3: Customize Navigation**

In Navigation Menu, organize:
```
📊 Dashboard (Home)
👥 Employees
📁 Projects
  ├── All Projects
  └── Project Tasks (Master-Detail)
📋 Tasks
⚙️ Settings
```

**Step 4: Add Dashboard Charts**

1. Create new page: Dashboard
2. Add regions:
   - Chart: Projects by Status
   - Chart: Tasks by Priority
   - Report: Recent Projects

**Chart SQL (Projects by Status):**
```sql
SELECT status AS label,
       COUNT(*) AS value
FROM vodacom_projects
GROUP BY status;
```

**Step 5: Configure Security**

Application Properties → Security:
```
Authentication: Application Express Accounts
Authorization Scheme: Create "Admin" role
Session Timeout: 3600 seconds
Deep Linking: Enabled
```

**Expected Output:**
- Fully functional multi-page application
- Master-detail interface for projects and tasks
- Dashboard with charts
- Secure navigation

---

## Real-World Practical

### Vodacom Corp Scenario: Customer Portal Development

**Business Context:**

Vodacom's clients complain they can't see project status in real-time. They have to call or email for updates. Vodacom needs a **customer-facing portal** where clients can:

1. View their projects and progress
2. See assigned team members
3. Download invoices
4. Submit change requests
5. View project timelines

**Your Mission:**

Build a customer portal application with:
- Secure client login (clients see only their data)
- Read-only access (no editing)
- Modern, professional interface
- Mobile-responsive design

**Implementation Steps:**

**Step 1: Create Client Users Table**

```sql
CREATE TABLE vodacom_client_users (
    client_user_id  NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    client_id       NUMBER NOT NULL,
    username        VARCHAR2(100) UNIQUE NOT NULL,
    email           VARCHAR2(100) UNIQUE NOT NULL,
    full_name       VARCHAR2(200),
    is_active       CHAR(1) DEFAULT 'Y',
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT fk_client_user_client 
        FOREIGN KEY (client_id) 
        REFERENCES tn_clients(client_id)
);

-- Create sample client user
INSERT INTO vodacom_client_users (client_id, username, email, full_name)
VALUES (1, 'john.acme', 'john@acme.com', 'John Smith');
COMMIT;
```

**Step 2: Create Custom Authentication Scheme**

1. Shared Components → Authentication Schemes
2. Create: Custom
3. Name: Client Portal Auth
4. Authentication Function:

```sql
FUNCTION authenticate_client (
    p_username IN VARCHAR2,
    p_password IN VARCHAR2
) RETURN BOOLEAN
IS
    l_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO l_count
    FROM vodacom_client_users
    WHERE username = p_username
      AND is_active = 'Y';
    
    IF l_count = 1 THEN
        -- In production, use password hashing
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
```

**Step 3: Create Application with Restricted Data**

Use wizard to create app with these pages:

**My Projects Page:**
```sql
-- Only show projects for logged-in client
SELECT p.project_id,
       p.project_name,
       p.status,
       p.start_date,
       p.end_date,
       e.first_name || ' ' || e.last_name AS project_manager
FROM vodacom_projects p
JOIN vodacom_employees e ON p.project_manager = e.emp_id
WHERE p.client_id = (
    SELECT client_id 
    FROM vodacom_client_users 
    WHERE username = :APP_USER
);
```

**Step 4: Add Download Invoices Feature**

Create report with download link:
```sql
SELECT invoice_number,
       invoice_date,
       total,
       status,
       apex_util.prepare_url(
           'f?p=' || :APP_ID || ':DOWNLOAD_INVOICE:' || :APP_SESSION || 
           ':::INVOICE_ID:' || invoice_id
       ) AS download_link
FROM vodacom_invoices
WHERE client_id = (
    SELECT client_id 
    FROM vodacom_client_users 
    WHERE username = :APP_USER
);
```

**Expected Outcomes:**
- Secure client portal with role-based data access
- Clients see only their projects and invoices
- Professional, mobile-responsive UI
- Zero maintenance (auto-updates with data changes)

---

## Assessment

### Multiple Choice Questions

**Q1:** Which APEX creation method is fastest for prototyping from existing data?

A) Create from Scratch  
B) Create from File (spreadsheet upload)  
C) Copy Existing Application  
D) Use Packaged App  

**Answer: B**

---

**Q2:** In Vodacom's application, what is a Master-Detail page used for?

A) User authentication  
B) Displaying related data (e.g., project and its tasks) on one page  
C) Creating database backups  
D) Sending email notifications  

**Answer: B**

---

**Q3:** What is stored in APEX Shared Components?

A) Only database tables  
B) Reusable elements like LOVs, templates, and authorization schemes  
C) User passwords  
D) Server configuration files  

**Answer: B**

---

**Q4:** Which authentication method should Vodacom use for the customer portal?

A) Open Access (no authentication)  
B) Database accounts for all clients  
C) Custom authentication with client-specific logic  
D) Social Media Sign-in only  

**Answer: C**

---

**Q5:** What happens when you create an application using the wizard?

A) Only empty pages are created  
B) APEX generates pages, navigation, and basic functionality automatically  
C) You must write all SQL code manually  
D) Applications cannot be modified after creation  

**Answer: B**

---

### Short Answer Questions

**Q1:** Explain the difference between creating an application "From a File" vs "Using the Wizard."

**Model Answer:**
- **From a File**: Upload spreadsheet (CSV/Excel), APEX creates both the database table and application automatically. Fastest method for quick prototypes when you don't have existing database tables. Limited customization during creation.
- **Using the Wizard**: Build on existing database tables with full control over page types, navigation structure, and features. More flexibility, better for production applications with complex requirements.

---

**Q2:** Vodacom needs to ensure clients only see their own project data. Describe two ways to implement this security.

**Model Answer:**
1. **SQL WHERE Clause**: Add filter in every query: `WHERE client_id = (SELECT client_id FROM client_users WHERE username = :APP_USER)`. Ensures data isolation at query level.
2. **Authorization Scheme**: Create authorization scheme that checks client_id match, apply to pages/regions. More maintainable for complex applications.
3. **VPD (Virtual Private Database)**: Oracle-level row security that automatically filters queries. Most secure but requires DBA setup.

---

**Q3:** What are the advantages of using Application Blueprints for Vodacom's development?

**Model Answer:**
Blueprints provide:
- **Pre-built patterns**: Industry-standard layouts (dashboards, portals, tracking systems)
- **Best practices**: Security, navigation, and UX patterns already implemented
- **Time savings**: 50-70% faster than building from scratch
- **Consistency**: Standardized look across applications
- **Customizable**: Can modify after creation to fit Vodacom's specific needs

Example: Use "Project Tracking Blueprint" as starting point for Vodacom's project management system.

---

### Practical Project Challenge

**Project: Build Vodacom Timesheet Application**

**Requirements:**

1. **Application Creation (25 points)**
   - Use Create Application Wizard
   - Name: Vodacom Timesheet Manager
   - Based on VODACOM_TIMESHEETS table
   - Include employee and task lookup

2. **Pages Required (40 points)**
   - Dashboard: Weekly hours by employee (chart)
   - My Timesheets: Report showing logged-in user's time entries
   - Submit Time: Form to add new timesheet entry
   - Approvals: Manager view to approve/reject timesheets
   - Reports: Monthly summary by project

3. **Business Logic (20 points)**
   - Validate: Hours per day cannot exceed 24
   - Calculate: Weekly totals automatically
   - Notification: Email manager when timesheet submitted
   - Default: Today's date when creating entry

4. **Security (15 points)**
   - Employees see only their own timesheets
   - Managers see their team's timesheets
   - Admin sees all timesheets
   - Prevent editing approved timesheets

**Deliverables:**
- Exported application SQL file
- Screenshots of all pages
- Documentation of business rules
- Test data (at least 20 timesheet entries)

**Evaluation Criteria:**
- Functionality: All features work correctly (40%)
- Security: Proper data isolation (20%)
- UI/UX: Professional, intuitive interface (20%)
- Code Quality: Well-structured SQL, comments (20%)

---

## PowerPoint Slides

### Slide 1: Creating Applications in Oracle APEX
**Vodacom Corp Training - Lesson 02**

### Slide 2: Application Creation Methods
**Four Ways to Build APEX Apps**

1. **Create Application Wizard** - Step-by-step guided creation
2. **From a File** - Upload spreadsheet, instant app
3. **Blueprints** - Industry templates
4. **Packaged Apps** - Pre-built solutions

**Choose based on: Speed vs Customization needs**

### Slide 3: Application Architecture
**Components of an APEX Application**

- **Pages**: Individual screens
- **Regions**: Content areas on pages
- **Items**: Input fields, display elements
- **Navigation**: Menus, breadcrumbs, tabs
- **Shared Components**: Reusable elements
- **Supporting Objects**: Database objects

### Slide 4: Create Application Wizard
**Step-by-Step Application Generation**

1. Name and appearance
2. Add pages (reports, forms, charts)
3. Configure navigation
4. Set features (authentication, feedback)
5. Create application

**Result: Working app in 5 minutes!**

### Slide 5: Vodacom Use Case
**Employee Manager Application**

- Interactive Report: Browse all employees
- Form Page: Add/edit employee details
- Dashboard: Visual analytics
- Navigation: Easy menu access

**Built in 10 minutes using wizard**

### Slide 6: Master-Detail Pages
**Related Data on One Screen**

**Master**: Projects list  
**Detail**: Tasks for selected project

**Benefits:**
- Intuitive navigation
- Reduced clicks
- Better user experience
- Automatic relationship handling

### Slide 7: Application Security
**Controlling Data Access**

**Authentication**: Who can log in?  
**Authorization**: What can they see?

**Vodacom Client Portal:**
- Clients see only their projects
- Employees see all data
- Managers approve timesheets

**Implement via SQL WHERE clauses or Authorization Schemes**

### Slide 8: Best Practices
**APEX Application Development Tips**

✅ Use naming conventions (TN_ prefix)  
✅ Plan navigation structure first  
✅ Start simple, add complexity gradually  
✅ Test with real data volume  
✅ Document business rules  
✅ Use shared components for reusability  
✅ Version control (export regularly)  

### Slide 9: Next Steps
**Lesson 03 Preview**

📄 Managing Pages  
🎨 Page Designer Interface  
🧩 Adding Regions, Items, Buttons  
⚡ Dynamic Actions  

**Hands-on: Customize Vodacom applications**

### Slide 10: Lab Exercise
**Build Your First APEX Application**

**Lab 1**: Employee Manager (wizard)  
**Lab 2**: Client Portal (from spreadsheet)  
**Lab 3**: Project Manager (master-detail)

**Challenge**: Timesheet Application

**All using Vodacom Corp scenario!**

