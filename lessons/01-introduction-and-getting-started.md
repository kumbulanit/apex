# Lesson 01: Introduction and Getting Started with Oracle APEX

## Theory

### Layman's Explanation

Imagine you want to build a house, but instead of being a master carpenter, architect, and electrician all at once, you have a **magic toolkit** that already knows how to put together walls, doors, and windows. You just tell it: "I want three bedrooms here, a kitchen there," and it does the heavy lifting for you.

**Oracle APEX (Application Express)** is like that magic toolkit, but for building software applications. Instead of writing thousands of lines of complicated code from scratch, you use APEX's visual tools to drag, drop, and configure what you want your application to do. It's like building with LEGO blocks instead of carving each piece from wood.

**Real-World Analogy:**

Think of traditional programming like being a chef who needs to:
1. Build the oven from scratch
2. Create the cooking utensils
3. Grow the ingredients
4. Invent recipes
5. Cook the meal
6. Design the plate presentation

With APEX, you walk into a fully-equipped professional kitchen where:
1. The oven is already built and working (database infrastructure)
2. All cooking tools are provided (UI components: forms, reports, charts)
3. Ingredients are organized and accessible (your data tables)
4. Recipe templates exist for common dishes (application wizards)
5. You focus on creating the perfect meal (business logic)
6. Presentation tools are ready (responsive themes)

**Vodacom Corp Example:** 

Vodacom Corp is a technology consulting company with 250 employees serving 180+ clients globally. They need to track:
- Employee information and organizational structure
- Project assignments and timelines
- Client contacts and contracts
- Timesheet entries and approvals
- Invoice generation and tracking
- Resource utilization and budgets

**Their Challenge:**
For 10 years, they used Microsoft Access databases running on individual computers. As they grew, they hit limitations:
- **Single-user**: Only one person could edit data at a time
- **No remote access**: Field consultants couldn't update project status
- **Frequent crashes**: 50,000+ records overwhelmed Access
- **No mobile support**: Tablets and phones couldn't connect
- **Security concerns**: No audit trail or role-based access
- **Integration impossible**: Couldn't connect to their ERP or CRM systems

**The Traditional Solution Would Be:**
- Hire a development team of 5-8 developers
- 6-9 months of development time
- Cost: $300,000 - $500,000
- Complex technology stack (frontend framework, API layer, backend, database)
- Ongoing maintenance and updates

**The APEX Solution:**
- 1-2 developers
- 4-6 weeks of development time
- Cost: Included with existing Oracle Database license
- Single integrated platform
- Built-in security, responsive design, and RESTful APIs
- Result: Vodacom built their entire suite of applications in 2 months instead of 9 months, saving $400,000+

This course will teach you how to achieve similar results for your organization.

### Intermediate Explanation

Oracle APEX is a **low-code development platform** that runs entirely within an Oracle Database. It represents a paradigm shift from traditional multi-tier application development to a streamlined, database-centric approach. Let's understand this in depth:

#### What Makes APEX "Low-Code"?

**Traditional Development Approach:**
```
Step 1: Design database schema (1-2 weeks)
Step 2: Write backend API (Node.js, Python, Java) (3-4 weeks)
Step 3: Create frontend (React, Angular, Vue) (4-6 weeks)
Step 4: Implement authentication/authorization (1-2 weeks)
Step 5: Design responsive UI for mobile (2-3 weeks)
Step 6: Write integration code for services (1-2 weeks)
Step 7: Deploy and configure servers (1 week)
Step 8: Test and debug across all layers (2-3 weeks)

Total Time: 15-23 weeks with 3-5 developers
```

**APEX Development Approach:**
```
Step 1: Design database schema (1-2 weeks)
Step 2: Use APEX Create Application Wizard (1-2 days)
Step 3: Customize pages with Page Designer (1-2 weeks)
Step 4: Configure security schemes (2-3 days)
Step 5: Test and refine (1 week)

Total Time: 4-6 weeks with 1-2 developers
```

#### Core APEX Development Principles

**1. Declarative Development**

Instead of writing code like this (traditional approach):
```javascript
// Express.js + React example
app.get('/employees', async (req, res) => {
  const connection = await oracledb.getConnection(dbConfig);
  const result = await connection.execute(
    `SELECT employee_id, first_name, last_name, email, department
     FROM employees 
     WHERE is_active = 'Y'
     ORDER BY last_name`
  );
  res.json(result.rows);
});
```

You declare what you want in APEX:
```
Create Region:
  Type: Interactive Report
  SQL Query: 
    SELECT employee_id, first_name, last_name, email, department
    FROM employees 
    WHERE is_active = 'Y'
    ORDER BY last_name
  
Features Automatically Included:
  ✓ Pagination (configurable rows per page)
  ✓ Search across all columns
  ✓ Column sorting (ascending/descending)
  ✓ Column filtering
  ✓ Download to Excel/CSV/PDF
  ✓ Responsive mobile layout
  ✓ Session state management
  ✓ SQL injection protection
  ✓ Security authorization
```

**📚 Learn More:**
- **Tutorial**: [Spreadsheet Lab - Turn spreadsheets into apps](https://apex.oracle.com/go/spreadsheet-lab) (45 min, Beginner)
- **Sample App**: Explore the Social Media sample app to see declarative development in action
- **Documentation**: [Getting Started with Oracle APEX](https://apex.oracle.com/en/learn/getting-started/)

**2. Built-in Components**

APEX provides 100+ pre-built components:

| Component Category | Examples | Business Use Case |
|-------------------|----------|-------------------|
| **Data Display** | Interactive Report, Interactive Grid, Classic Report, Card Region | Display employee lists, project dashboards, sales data |
| **Forms** | Standard Form, Modal Dialog, Master-Detail | Edit employee records, create invoices, manage projects |
| **Charts** | Bar, Line, Pie, Area, Range, Gantt, Map | Sales trends, project timelines, budget utilization, geographic distribution |
| **Navigation** | Navigation Menu, Breadcrumbs, Tabs, Tree | Application structure, user guidance, hierarchical data browsing |
| **Interactive** | Calendar, Timeline, Faceted Search, Cards | Event scheduling, project planning, product search, dashboard KPIs |
| **Media** | Image, Video, Document Viewer, QR Code | Product galleries, training videos, PDF documents, mobile scanning |
| **Input Items** | Text, Number, Date Picker, Select List, Checkbox, Radio, File Upload, Rich Text Editor | User data entry with built-in validation |
| **Process** | Submit, Save, Delete, Send Email, Execute PL/SQL | Automated workflows and business logic |

**3. SQL and PL/SQL Integration**

APEX is built on Oracle Database, giving you direct access to:

```sql
-- Direct database access (no ORM overhead)
-- Example: Complex business logic in a single query

SELECT 
    p.project_name,
    p.status,
    c.company_name,
    e.first_name || ' ' || e.last_name AS manager,
    COUNT(DISTINCT t.task_id) AS total_tasks,
    COUNT(DISTINCT CASE WHEN t.status = 'Completed' THEN t.task_id END) AS completed_tasks,
    ROUND(COUNT(DISTINCT CASE WHEN t.status = 'Completed' THEN t.task_id END) / 
          NULLIF(COUNT(DISTINCT t.task_id), 0) * 100, 1) AS completion_pct,
    p.budget,
    (SELECT SUM(hours * e2.hourly_rate)
     FROM vodacom_timesheets ts
     JOIN vodacom_employees e2 ON ts.employee_id = e2.emp_id
     WHERE ts.task_id IN (SELECT task_id FROM vodacom_tasks WHERE project_id = p.project_id)) AS actual_cost,
    p.budget - (SELECT SUM(hours * e2.hourly_rate)
                FROM vodacom_timesheets ts
                JOIN vodacom_employees e2 ON ts.employee_id = e2.emp_id
                WHERE ts.task_id IN (SELECT task_id FROM vodacom_tasks WHERE project_id = p.project_id)) AS remaining_budget
FROM vodacom_projects p
JOIN vodacom_clients c ON p.client_id = c.client_id
JOIN vodacom_employees e ON p.project_manager = e.emp_id
LEFT JOIN vodacom_tasks t ON p.project_id = t.project_id
WHERE p.status IN ('Planning', 'Active')
GROUP BY p.project_id, p.project_name, p.status, c.company_name, 
         e.first_name, e.last_name, p.budget;
```

This query powers a dashboard with no additional coding needed.

**4. Browser-Based Development**

Everything happens in your web browser:
- No Eclipse, Visual Studio, or IntelliJ installation
- No git conflicts with UI files
- Collaborate easily: multiple developers work on different pages simultaneously
- Instant preview: see changes immediately with "Run Page" button
- Built-in debugging: integrated debug console and error reporting

**5. Responsive Design**

APEX Universal Theme uses Bootstrap-based CSS that automatically adapts:

```
Desktop (>1024px)     →  Full sidebar menu, 3-column layout, full charts
Tablet (768-1024px)   →  Collapsible menu, 2-column layout, simplified charts
Mobile (<768px)       →  Hamburger menu, single-column, touch-optimized
```

**No additional coding required** - APEX handles responsive breakpoints automatically.

#### Key APEX Features in Detail

**1. Rapid Application Development (RAD)**

Speed comparison (building a CRUD application for 10 database tables):

| Task | Traditional Stack | APEX | Time Saved |
|------|------------------|------|------------|
| Setup environment | 2-3 days | 1 hour | 95% |
| Create database schema | 3 days | 3 days | 0% |
| Build API endpoints | 10 days | 0 days (built-in) | 100% |
| Create frontend | 15 days | 2 days (wizard + customization) | 87% |
| Implement security | 5 days | 1 day (configure schemes) | 80% |
| Mobile optimization | 5 days | 0 days (automatic) | 100% |
| Testing & debugging | 7 days | 3 days | 57% |
| **Total** | **47 days** | **10 days** | **79%** |

**2. Single Database Platform**

Traditional three-tier architecture:
```
[Browser] ←→ [Web Server: Apache/Nginx] ←→ [App Server: Node.js/Java] ←→ [Database: Oracle]

Complexity:
- 3 different technologies to learn
- 3 deployment targets
- 3 security layers to configure
- Network latency between tiers
- Data serialization overhead (JSON ←→ Database)
```

APEX two-tier architecture:
```
[Browser] ←→ [ORDS + Oracle Database with APEX]

Benefits:
- 2 technologies (HTML/CSS/JS in browser, SQL/PL/SQL in database)
- Single deployment target
- Database-level security
- No network latency between app and data
- No serialization overhead
```

**3. Enterprise-Grade Security**

Built-in security features:

| Security Layer | What APEX Provides | Configuration Time |
|---------------|-------------------|-------------------|
| **Authentication** | Database accounts, LDAP, Active Directory, OAuth2 (Google, Microsoft, Facebook), SAML, Custom | 15-30 minutes |
| **Authorization** | Page-level, region-level, item-level, button-level access control | 30-60 minutes |
| **Session Management** | Automatic session creation, timeout, renewal, protection against session hijacking | 5 minutes |
| **Input Validation** | SQL injection prevention (bind variables), XSS protection (output escaping), CSRF tokens | Automatic |
| **Data Encryption** | HTTPS enforcement, database encryption, password hashing | 10-20 minutes |
| **Audit Logging** | Track who changed what and when | 15-30 minutes |

**4. RESTful Services**

Create REST APIs with zero coding:

```
Use Case: Mobile app needs to fetch employee list

Traditional Approach:
1. Install Express.js or Flask
2. Write route handler
3. Connect to database
4. Query database
5. Format as JSON
6. Handle errors
7. Add authentication
8. Deploy to server
Time: 2-4 hours

APEX Approach:
1. SQL Workshop → RESTful Services → Create Module
2. Name: employees
3. Add Handler: GET /list
4. SQL Query: SELECT * FROM vodacom_employees
5. Test URL
Time: 5 minutes

Result: https://your-domain.com/ords/vodacom/employees/list
```

**5. Universal Theme**

Professional, modern UI framework with:
- 30+ pre-designed page templates
- Customizable color schemes
- Icon libraries (Font Awesome, Material Icons)
- Accessibility compliant (WCAG 2.1 AA)
- Dark mode support
- Print-friendly layouts

#### Vodacom Corp Usage Deep Dive

**Current State (Before APEX):**
- 15 separate Microsoft Access databases (.accdb files)
- Each database limited to 1 user at a time
- Total data: 85,000+ records across all databases
- Manual data consolidation for reports (Excel exports, copy-paste)
- No audit trail (who changed what?)
- No remote access (VPN + Remote Desktop required)
- Application crashes 3-4 times per week
- No API access for integrations

**APEX Implementation:**

Vodacom created these applications in 8 weeks:

**Week 1-2: Foundation**
- Consolidated Access databases into single Oracle schema
- Created normalized tables with proper foreign keys
- Imported historical data (5-year history)
- Set up DEV, TEST, PROD workspaces

**Week 3-4: Core Applications**
- Employee Directory (searchable, org chart, contact info)
- Project Management (projects, tasks, assignments, timeline view)
- Timesheet System (weekly entry, manager approval, billing integration)

**Week 5-6: Client-Facing**
- Client Portal (secure login, view project status, download invoices)
- Project Status Dashboard (real-time KPIs, charts, export to PDF)

**Week 7: Integration & Reporting**
- REST APIs for mobile app
- Integration with QuickBooks for accounting
- Executive reports (project profitability, resource utilization)

**Week 8: Testing & Deployment**
- User acceptance testing
- Performance tuning (optimized slow queries)
- Security audit and penetration testing
- Production deployment
- User training (2-day workshop)

**Results:**
- 50+ concurrent users (previously 1 user per database)
- 99.9% uptime (vs 96% with Access)
- Mobile access from tablets and phones
- Real-time dashboards (no more manual Excel reports)
- Full audit trail (compliance requirement met)
- $400,000 savings vs traditional development
- 6-month payback period (vs 3-5 years for traditional project)

This course will show you exactly how Vodacom achieved these results, step by step.

### Advanced Explanation

Oracle APEX is a **metadata-driven, declarative development framework** that leverages the Oracle Database's inherent capabilities for application logic, security, and scalability. Under the hood:

**Architecture Components:**

1. **APEX Engine**: PL/SQL code that interprets application metadata and generates HTML/JavaScript at runtime
2. **APEX Repository**: Database schema (APEX_xxxxxx) storing application definitions, components, and metadata
3. **Oracle REST Data Services (ORDS)**: Modern Java-based web server that handles HTTP requests and routes them to APEX
4. **Shared Components Pool**: Reusable elements (LOVs, templates, authorization schemes) stored once, referenced many times
5. **Page Processing Model**: Declarative execution order (Before Header → After Header → Body → Before Processing → After Processing → After Submit)

**Technical Architecture:**

```
┌─────────────────────────────────────────────────────────────┐
│                        Browser (Client)                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐      │
│  │  JavaScript  │  │     HTML5    │  │     CSS3     │      │
│  └──────────────┘  └──────────────┘  └──────────────┘      │
└─────────────────────────────────────────────────────────────┘
                              │
                         HTTPS/HTTP
                              │
┌─────────────────────────────────────────────────────────────┐
│              Oracle REST Data Services (ORDS)                │
│  ┌──────────────────────────────────────────────────────┐   │
│  │  Servlet Container (Tomcat/Jetty/Standalone)         │   │
│  │  - Request Routing                                    │   │
│  │  - Connection Pooling                                 │   │
│  │  - Static File Serving                                │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                              │
                         SQL*Net / JDBC
                              │
┌─────────────────────────────────────────────────────────────┐
│                    Oracle Database                           │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              APEX Engine (PL/SQL)                     │   │
│  │  - Metadata Interpreter                               │   │
│  │  - Page Rendering                                     │   │
│  │  - Session Management                                 │   │
│  │  - Security Framework                                 │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │          APEX Repository (APEX_xxxxxx)                │   │
│  │  - Application Metadata                               │   │
│  │  - Page Definitions                                   │   │
│  │  - Component Library                                  │   │
│  │  - User/Session Data                                  │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌──────────────────────────────────────────────────────┐   │
│  │         Application Schema (Your Data)                │   │
│  │  - Business Tables                                    │   │
│  │  - Views, Procedures, Functions                       │   │
│  │  - Custom PL/SQL Packages                             │   │
│  └──────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

**🎓 Try It Yourself:**
- **Sample App**: Install the [Social Media App](https://apex.oracle.com/go/sm-lab) to see this architecture in action
- **Tutorial**: [Build a Social Media App](https://apex.oracle.com/go/sm-lab) - See how the 3-tier architecture works (1 hour, Beginner)
- **Deep Dive**: [APEX Architecture Documentation](https://apex.oracle.com/en/platform/architecture/)

**Request Flow Diagram:**

```
User Action → HTTP Request → ORDS → Database Connection Pool
                                           ↓
                                    APEX Engine
                                           ↓
                            Read Application Metadata
                                           ↓
                              Execute Page Processing
                                           ↓
                    ┌─────────────────────────────────────┐
                    │  1. Before Header Computations      │
                    │  2. Run Authorization Schemes       │
                    │  3. Fetch Data (Regions/Reports)    │
                    │  4. Execute Validations             │
                    │  5. Process Page Items              │
                    │  6. Run Dynamic Actions             │
                    │  7. Apply Security Checks           │
                    └─────────────────────────────────────┘
                                           ↓
                            Generate HTML/JS/CSS
                                           ↓
                              Return to ORDS → Browser
```

**Performance Optimizations:**
- **Page Caching**: APEX can cache entire pages or regions for faster rendering
- **SQL Query Result Cache**: Reuse query results across sessions
- **Lazy Loading**: Components load on-demand via AJAX
- **CDN Integration**: Static resources served from content delivery networks
- **Connection Pooling**: ORDS maintains efficient database connections

**Security Layers:**
1. **Network**: HTTPS encryption, firewall rules
2. **Authentication**: Database accounts, LDAP, OAuth2, SAML, Social Sign-in
3. **Authorization**: Session state protection, page access control, component-level security
4. **Session Management**: Unique session IDs, automatic timeout, session state protection
5. **SQL Injection Prevention**: Bind variables, automatic escaping
6. **XSS Protection**: Output escaping, Content Security Policy headers

**Vodacom Corp Implementation:** Vodacom runs APEX on Oracle Autonomous Database in Oracle Cloud Infrastructure (OCI). They use:
- **ORDS** deployed on compute instances behind a load balancer for high availability
- **Custom authentication** integrated with their Active Directory via LDAP
- **RESTful APIs** exposing project data to mobile apps built with React Native
- **Workspace isolation** with separate schemas for Development, Testing, and Production environments
- **Automated deployments** using SQLcl and CI/CD pipelines with supporting application export/import scripts

---

## Installing Oracle APEX - Complete Guide

### Overview: Installation Options

Oracle APEX can be installed and accessed through multiple methods, each suited for different use cases:

| Installation Method | Best For | Complexity | Time Required | Cost |
|-------------------|----------|------------|---------------|------|
| **apex.oracle.com** | Learning, prototyping | ★☆☆☆☆ | 5 minutes | **FREE** |
| **Oracle Autonomous Database** | Production, cloud deployment | ★★☆☆☆ | 15 minutes | Pay-as-you-go |
| **Docker Container** | Development, testing | ★★★☆☆ | 30 minutes | **FREE** |
| **Oracle Database XE + APEX** | Local development | ★★★☆☆ | 45-60 minutes | **FREE** |
| **Full Oracle Database + APEX** | Enterprise production | ★★★★☆ | 2-3 hours | Licensed |
| **Kubernetes Deployment** | Container orchestration | ★★★★★ | 3-4 hours | Infrastructure costs |

**📌 RECOMMENDED FOR THIS COURSE: apex.oracle.com (Free Cloud Service)**

For beginners and this training course, we **strongly recommend** using **apex.oracle.com** because:
- ✅ **Zero installation required** - Start immediately
- ✅ **Free forever** - No credit card needed
- ✅ **Fully featured** - All APEX capabilities available
- ✅ **Always up-to-date** - Latest APEX version automatically
- ✅ **Reliable infrastructure** - Oracle-managed hosting
- ✅ **Perfect for learning** - Focus on development, not infrastructure

---

### Method 1: apex.oracle.com (FREE Cloud Service) ⭐ RECOMMENDED

**Best for:** Students, beginners, prototyping, learning APEX

**Advantages:**
- No installation or configuration needed
- Access from any device with a browser
- Free 2GB storage and compute resources
- Automatic backups and updates
- Sample datasets and applications included
- Share applications instantly via URL

**Limitations:**
- Internet connection required
- Cannot install custom Oracle features (like Oracle Text)
- Limited to APEX workspace size quotas
- Shared infrastructure (reasonable usage expected)

#### Step-by-Step: Getting Started on apex.oracle.com

**Step 1: Create Your Free Account**

1. Open your web browser (Chrome, Firefox, Edge, or Safari)
2. Navigate to: **https://apex.oracle.com**
3. Click the **"Get Started for Free"** button
4. Click **"Request a Free Workspace"**

**Step 2: Fill Out Registration Form**

```
First Name: [Your first name]
Last Name: [Your last name]
Email: [Your valid email address]
Workspace: [Choose unique name, e.g., "VODACOM2025"]
```

5. Complete the CAPTCHA verification
6. Click **"Next"**
7. Choose your schema:
   - ✅ Select **"Yes"** to create a new database schema
   - Schema Name will be generated automatically (same as workspace)
8. Click **"Next"**
9. Review your selections
10. Click **"Create Workspace"**

**Step 3: Verify Your Email**

1. Check your email inbox (including spam folder)
2. Look for email from **oracle-application-express_ww@oracle.com**
3. Click the verification link in the email
4. You'll be redirected to create your password

**Step 4: Set Your Password**

```
Username: ADMIN (pre-filled, do not change)
Email: [Your email - pre-filled]
New Password: [Choose strong password, e.g., "Vodacom2024!"]
Confirm Password: [Re-enter password]
```

5. Click **"Apply Changes"**

**Step 5: Sign In to Your Workspace**

You're automatically signed in! You'll see the APEX home page with four main options:

```
┌─────────────────────────────────────────────────────────────┐
│              Welcome to Oracle APEX 24.1                     │
├─────────────────────────────────────────────────────────────┤
│  [App Builder]     [SQL Workshop]     [Team Development]    │
│                                                               │
│  [App Gallery]     [Packaged Apps]    [SQL Scripts]         │
└─────────────────────────────────────────────────────────────┘
```

**Step 6: Explore the Environment**

Try these quick tests:

1. **Test SQL Workshop:**
   - Click **SQL Workshop** → **SQL Commands**
   - Enter: `SELECT 'Hello from APEX!' AS message FROM dual;`
   - Click **Run**
   - ✅ You should see: `Hello from APEX!`

2. **Test App Builder:**
   - Click **App Builder**
   - Click **Create** → **New Application**
   - Name: `My First Test App`
   - Click **Create Application**
   - ✅ Application created successfully!

**Success!** You now have a fully functional APEX development environment at:
- **URL:** `https://apex.oracle.com/pls/apex/`
- **Workspace:** `[Your workspace name]`
- **Username:** `ADMIN`

**📚 Next Steps:**
- Proceed to Lab 01 in this course
- Explore Sample Applications in the Gallery
- Try the [Quick Start Tutorial](https://apex.oracle.com/quickstart)

---

### Method 2: Oracle Autonomous Database (Oracle Cloud)

**Best for:** Production applications, enterprise deployment, cloud-native development

**Advantages:**
- Fully managed Oracle Database with APEX pre-installed
- Automatic scaling, patching, and backups
- High availability and disaster recovery built-in
- Dedicated database resources (not shared)
- Can install additional Oracle features
- Production-grade security and performance

**Costs:**
- **Always Free Tier:** 2 Autonomous Databases (20GB each) - **FREE FOREVER**
- **Paid Tier:** From $0.28/hour (~$200/month) for 1 OCPU + 20GB storage

#### Step-by-Step: Autonomous Database Setup

**Step 1: Create Oracle Cloud Account**

1. Go to: **https://www.oracle.com/cloud/free/**
2. Click **"Start for Free"**
3. Fill out registration:
   ```
   Country: [Your country]
   First Name: [Your name]
   Last Name: [Your name]
   Email: [Your email]
   ```
4. Verify email and complete account setup
5. Provide credit card (won't be charged for Always Free resources)

**Step 2: Create Autonomous Database**

1. Sign in to Oracle Cloud Console: **https://cloud.oracle.com**
2. Click **☰ Navigation Menu** (top left)
3. Select **Oracle Database** → **Autonomous Database**
4. Click **"Create Autonomous Database"**

**Configuration:**

```
Display Name: Vodacom-APEX-DB
Database Name: vodacomadb
Workload Type: Transaction Processing (ATP)
Deployment Type: Shared Infrastructure
Database Version: 19c (or latest)

Always Free: ✅ Enable (if available in your region)

Administrator Credentials:
  Username: ADMIN
  Password: [Strong password, e.g., "VodacomDB2024!"]
  Confirm Password: [Re-enter]

Network Access: Secure access from everywhere
License Type: License Included
```

5. Click **"Create Autonomous Database"**
6. Wait 2-3 minutes for provisioning (status will change to **Available**)

**Step 3: Access APEX**

1. On the Autonomous Database details page, click **"Database Actions"**
2. Sign in with:
   ```
   Username: ADMIN
   Password: [Your database admin password]
   ```
3. Scroll down to **"Development"** section
4. Click **"APEX"**
5. You're redirected to APEX Administration Services

**Step 4: Create Workspace**

1. Click **"Create Workspace"**
2. Enter details:
   ```
   Workspace Name: VODACOM
   Schema Name: VODACOM_DATA
   Password: [Schema password]
   Space Quota: 100MB (or UNLIMITED)
   
   Workspace Administrator:
     Username: ADMIN
     Password: [Admin password]
     Email: [Your email]
   ```
3. Click **"Create Workspace"**

**Step 5: Access Your Workspace**

1. Sign out from Administration
2. Sign in with:
   ```
   Workspace: VODACOM
   Username: ADMIN
   Password: [Your workspace admin password]
   ```

**Your APEX URL:** `https://[your-adb-url].oraclecloudapps.com/ords/`

**Success!** Production-ready APEX environment with:
- 20GB storage (Always Free)
- Automatic backups
- Scalable compute resources
- 99.95% uptime SLA

---

### Method 3: Docker Container (Development/Testing)

**Best for:** Developers, CI/CD pipelines, quick testing, isolated environments

**Advantages:**
- Fast setup and teardown
- Consistent across Mac, Linux, Windows
- No impact on host system
- Easy to replicate and share
- Perfect for development and testing
- Can run multiple APEX versions simultaneously

**Prerequisites:**
- Docker Desktop installed
- 8GB RAM minimum
- 20GB free disk space
- Basic Docker knowledge

#### Platform-Specific Docker Installation:

**macOS:**
```bash
# Download Docker Desktop for Mac
# Visit: https://www.docker.com/products/docker-desktop

# Or install via Homebrew:
brew install --cask docker

# Start Docker Desktop from Applications folder
# Verify installation:
docker --version
# Expected: Docker version 24.0.0 or later
```

**Linux (Ubuntu/Debian):**
```bash
# Update package index
sudo apt-get update

# Install Docker
sudo apt-get install -y docker.io docker-compose

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add your user to docker group (avoid sudo)
sudo usermod -aG docker $USER

# Log out and log back in for group changes to take effect

# Verify installation
docker --version
```

**Linux (RHEL/CentOS/Fedora):**
```bash
# Install Docker
sudo yum install -y docker docker-compose

# Start Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Add user to docker group
sudo usermod -aG docker $USER

# Verify
docker --version
```

**Windows:**
```powershell
# Download Docker Desktop for Windows
# Visit: https://www.docker.com/products/docker-desktop

# Or install via Chocolatey:
choco install docker-desktop

# Start Docker Desktop from Start Menu
# Verify installation:
docker --version
```

#### Step-by-Step: APEX on Docker

**Option A: Official Oracle Container (Recommended)**

```bash
# Pull Oracle Database 19c with APEX pre-installed
docker pull container-registry.oracle.com/database/express:21c-apex

# Create volume for persistent data
docker volume create apex-data

# Run container
docker run -d \
  --name apex-db \
  -p 1521:1521 \
  -p 5500:5500 \
  -p 8080:8080 \
  -e ORACLE_PWD=Vodacom2024! \
  -v apex-data:/opt/oracle/oradata \
  container-registry.oracle.com/database/express:21c-apex

# Monitor startup (takes 5-10 minutes for first start)
docker logs -f apex-db

# Wait for message: "DATABASE IS READY TO USE!"
```

**Option B: Custom Docker Compose (Full Control)**

Create `docker-compose.yml`:

```yaml
version: '3.8'

services:
  oracle-xe:
    image: container-registry.oracle.com/database/express:21c
    container_name: vodacom-apex
    ports:
      - "1521:1521"    # Database
      - "5500:5500"    # Enterprise Manager
      - "8080:8080"    # APEX/ORDS
    environment:
      - ORACLE_PWD=Vodacom2024!
      - ORACLE_CHARACTERSET=AL32UTF8
    volumes:
      - apex-data:/opt/oracle/oradata
      - ./scripts:/docker-entrypoint-initdb.d
    networks:
      - apex-network

volumes:
  apex-data:
    driver: local

networks:
  apex-network:
    driver: bridge
```

Start services:

```bash
# Start containers
docker-compose up -d

# Check status
docker-compose ps

# View logs
docker-compose logs -f
```

**Access APEX:**

1. Wait for database initialization (5-10 minutes)
2. Open browser: **http://localhost:8080/ords**
3. Sign in to INTERNAL workspace:
   ```
   Workspace: INTERNAL
   Username: ADMIN
   Password: Vodacom2024!
   ```

**Create Your Workspace:**

```sql
# Connect to database
docker exec -it apex-db sqlplus sys/Vodacom2024!@XE as sysdba

# Create workspace
BEGIN
  APEX_INSTANCE_ADMIN.ADD_WORKSPACE(
    p_workspace => 'VODACOM',
    p_primary_schema => 'VODACOM_DATA',
    p_additional_schemas => NULL
  );
  
  APEX_UTIL.SET_SECURITY_GROUP_ID(
    p_security_group_id => APEX_UTIL.FIND_SECURITY_GROUP_ID('VODACOM')
  );
  
  APEX_UTIL.CREATE_USER(
    p_user_name => 'ADMIN',
    p_email_address => 'admin@vodacom.com',
    p_web_password => 'VodacomAdmin2024!',
    p_developer_privs => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL'
  );
  
  COMMIT;
END;
/

EXIT;
```

**Success!** Your Docker APEX environment is ready at:
- **APEX URL:** http://localhost:8080/ords
- **Database:** localhost:1521/XE
- **EM Express:** http://localhost:5500/em

**Docker Management Commands:**

```bash
# Stop container
docker stop apex-db

# Start existing container
docker start apex-db

# Remove container (keeps data in volume)
docker rm apex-db

# Remove container and data
docker rm apex-db
docker volume rm apex-data

# View container resource usage
docker stats apex-db
```

---

### Method 4: Windows Installation (Oracle Database XE + APEX)

**Best for:** Windows developers, offline development, learning environments

**Prerequisites:**
- Windows 10/11 (64-bit)
- 8GB RAM minimum (16GB recommended)
- 20GB free disk space
- Administrator privileges

#### Step-by-Step: Windows Installation

**Step 1: Download Oracle Database XE**

1. Visit: **https://www.oracle.com/database/technologies/xe-downloads.html**
2. Download: **Oracle Database 21c Express Edition for Windows x64**
3. File: `OracleXE213_Win64.zip` (~2.5GB)
4. Extract ZIP file to a temporary folder

**Step 2: Install Oracle Database XE**

1. Right-click `setup.exe` → **Run as Administrator**
2. Installation wizard starts:
   ```
   Oracle Home: C:\app\oracle\product\21c\dbhomeXE
   ```
3. Click **Next**
4. Accept license agreement
5. Set database passwords:
   ```
   SYS and SYSTEM password: Vodacom2024!
   Confirm password: Vodacom2024!
   ```
6. Click **Next**, then **Install**
7. Installation takes 15-20 minutes
8. Click **Finish**

**Step 3: Verify Database Installation**

1. Open **Command Prompt** (Windows key + R, type `cmd`)
2. Test SQL*Plus connection:

```cmd
sqlplus sys/Vodacom2024!@XE as sysdba

-- You should see:
-- Oracle Database 21c Express Edition Release 21.0.0.0.0
-- Connected to: Oracle Database 21c Express Edition
```

**Step 4: Download and Install APEX**

```cmd
# Create APEX directory
mkdir C:\apex
cd C:\apex

# Download APEX from:
# https://www.oracle.com/tools/downloads/apex-downloads.html
# Save to C:\apex\apex_23.1.zip

# Extract (using PowerShell)
powershell -command "Expand-Archive -Path apex_23.1.zip -DestinationPath C:\apex"

cd C:\apex\apex
```

**Step 5: Install APEX in Database**

```cmd
sqlplus sys/Vodacom2024!@XE as sysdba

-- Install APEX (15-30 minutes)
@apexins SYSAUX SYSAUX TEMP /i/

-- Set APEX ADMIN password
@apxchpwd.sql
-- Enter password when prompted: VodacomApex2024!

-- Configure APEX instance
@apex_rest_config.sql
-- Enter password: VodacomApex2024!

EXIT;
```

**Step 6: Install Java (for ORDS)**

1. Download Java JDK 17: **https://www.oracle.com/java/technologies/downloads/#jdk17-windows**
2. Run installer: `jdk-17_windows-x64_bin.exe`
3. Default installation: `C:\Program Files\Java\jdk-17`
4. Set JAVA_HOME environment variable:

```cmd
# Open System Properties → Environment Variables
# Add new System Variable:
JAVA_HOME=C:\Program Files\Java\jdk-17
PATH=%JAVA_HOME%\bin;%PATH%

# Verify Java installation
java -version
# Expected: java version "17.0.x"
```

**Step 7: Download and Configure ORDS**

```cmd
# Create ORDS directory
mkdir C:\ords
cd C:\ords

# Download ORDS from:
# https://www.oracle.com/database/technologies/appdev/rest-data-services-downloads.html
# Save to C:\ords\ords-latest.zip

# Extract
powershell -command "Expand-Archive -Path ords-latest.zip -DestinationPath C:\ords"

# Install ORDS
cd C:\ords
ords.exe install

# Follow prompts:
Database hostname: localhost
Database port: 1521
Database service name: XE
Administrator username: SYS
Administrator password: Vodacom2024!
ORDS configuration folder: C:\ords\config
```

**Step 8: Configure APEX Images**

```cmd
# Copy APEX images
xcopy C:\apex\apex\images C:\ords\config\ords\standalone\doc_root\i\ /E /I /Y

# Update ORDS configuration
cd C:\ords
ords.exe config set standalone.static.images C:\ords\config\ords\standalone\doc_root\i\
```

**Step 9: Start ORDS**

```cmd
cd C:\ords
ords.exe serve

# ORDS starts on port 8080
# You should see:
# Oracle REST Data Services version : 23.x
# HTTP listener started on port 8080
```

**Step 10: Access APEX**

1. Open browser: **http://localhost:8080/ords**
2. Sign in:
   ```
   Workspace: INTERNAL
   Username: ADMIN
   Password: VodacomApex2024!
   ```

**Run ORDS as Windows Service (Optional):**

```cmd
# Install as service
cd C:\ords
ords.exe --config C:\ords\config install --serviceName OracleORDS

# Start service
net start OracleORDS

# Service will auto-start on Windows boot
```

**Success!** Windows APEX installation complete:
- **APEX URL:** http://localhost:8080/ords
- **Database:** localhost:1521/XE
- **ORDS Config:** C:\ords\config

---

### Method 5: macOS Installation (Oracle Database + APEX)

**Best for:** Mac developers, local development, offline work

**⚠️ Important:** Oracle Database does not run natively on macOS (Apple Silicon or Intel). You must use:
- **Option A:** Docker (Recommended) - See Method 3 above
- **Option B:** Virtual Machine (Oracle Linux in VirtualBox/VMware)
- **Option C:** Remote connection to Linux/Windows server

#### Option A: Docker on macOS (RECOMMENDED)

See **Method 3: Docker Container** above - works perfectly on macOS.

#### Option B: Virtual Machine Setup

**Step 1: Install VirtualBox**

```bash
# Install via Homebrew
brew install --cask virtualbox

# Or download from:
# https://www.virtualbox.org/wiki/Downloads
```

**Step 2: Download Oracle Linux**

1. Visit: **https://www.oracle.com/linux/technologies/oracle-linux-downloads.html**
2. Download: **Oracle Linux 8.x (x86_64)** ISO (~10GB)
3. Save to `~/Downloads/OracleLinux-8.x-x86_64-dvd.iso`

**Step 3: Create Virtual Machine**

1. Open VirtualBox
2. Click **New**
3. Configure VM:
   ```
   Name: Vodacom-APEX-Dev
   Type: Linux
   Version: Oracle Linux (64-bit)
   
   Memory: 8192 MB (8GB)
   Hard disk: Create virtual hard disk (VDI, 50GB)
   ```
4. Click **Create**

**Step 4: Install Oracle Linux**

1. Select VM → Click **Start**
2. Select ISO file when prompted
3. Install Oracle Linux (choose **Server with GUI**)
4. Set root password: `Vodacom2024!`
5. Complete installation (~20 minutes)
6. Reboot VM

**Step 5: Install Oracle Database in VM**

Follow **Method 6: Linux Installation** steps below inside the VM.

**Step 6: Port Forwarding**

In VirtualBox:
1. Select VM → **Settings** → **Network**
2. Adapter 1: **NAT**
3. **Port Forwarding** → Add rules:
   ```
   Name: ORDS
   Protocol: TCP
   Host Port: 8080
   Guest Port: 8080
   
   Name: Database
   Protocol: TCP
   Host Port: 1521
   Guest Port: 1521
   ```

**Access from macOS:**
- **APEX:** http://localhost:8080/ords
- **Database:** localhost:1521

---

### Method 6: Linux Installation (Full Oracle Database + APEX)

**Best for:** Production servers, enterprise environments, on-premises deployment

**Supported Linux Distributions:**
- ✅ Oracle Linux 7/8/9
- ✅ Red Hat Enterprise Linux (RHEL) 7/8/9
- ✅ CentOS 7/8
- ✅ Ubuntu 18.04/20.04/22.04 (community support)

#### Platform-Specific Prerequisites:

**Oracle Linux / RHEL / CentOS:**

```bash
# Update system
sudo yum update -y

# Install required packages
sudo yum install -y \
  oracle-database-preinstall-19c \
  unzip \
  wget \
  libnsl \
  libaio

# Create oracle user (if not exists)
sudo useradd -m -s /bin/bash oracle

# Set oracle password
sudo passwd oracle
# Enter: Vodacom2024!

# Create directories
sudo mkdir -p /opt/oracle/apex
sudo mkdir -p /opt/oracle/ords
sudo chown -R oracle:oinstall /opt/oracle
```

**Ubuntu / Debian:**

```bash
# Update system
sudo apt-get update && sudo apt-get upgrade -y

# Install dependencies
sudo apt-get install -y \
  alien \
  libaio1 \
  unixodbc \
  unzip \
  wget \
  bc \
  flex

# Create oracle user
sudo useradd -m -s /bin/bash oracle
sudo passwd oracle
# Enter: Vodacom2024!

# Create directories
sudo mkdir -p /opt/oracle/apex
sudo mkdir -p /opt/oracle/ords
sudo chown -R oracle:oracle /opt/oracle
```

#### Step-by-Step: Complete Linux Installation

**(This is the existing detailed installation guide in the lesson - lines 500-1100)**

[The existing Lab 1 content from line 488 onwards remains here]

---

### Method 7: Kubernetes Deployment (Advanced)

**Best for:** Cloud-native applications, microservices architecture, enterprise scale

**Prerequisites:**
- Kubernetes cluster (EKS, GKE, AKS, or on-premises)
- kubectl configured
- Helm 3.x installed
- Container registry access
- Advanced Kubernetes knowledge

#### Step-by-Step: APEX on Kubernetes

**Step 1: Create Namespace**

```bash
kubectl create namespace apex-prod
kubectl config set-context --current --namespace=apex-prod
```

**Step 2: Create Persistent Storage**

`apex-storage.yaml`:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: apex-data-pvc
  namespace: apex-prod
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Gi
  storageClassName: fast-ssd
```

```bash
kubectl apply -f apex-storage.yaml
```

**Step 3: Deploy Oracle Database**

`oracle-db-deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: oracle-db
  namespace: apex-prod
spec:
  replicas: 1
  selector:
    matchLabels:
      app: oracle-db
  template:
    metadata:
      labels:
        app: oracle-db
    spec:
      containers:
      - name: oracle-xe
        image: container-registry.oracle.com/database/express:21c
        ports:
        - containerPort: 1521
          name: database
        - containerPort: 8080
          name: apex
        env:
        - name: ORACLE_PWD
          valueFrom:
            secretKeyRef:
              name: oracle-secret
              key: password
        volumeMounts:
        - name: oracle-data
          mountPath: /opt/oracle/oradata
        resources:
          requests:
            memory: "4Gi"
            cpu: "2"
          limits:
            memory: "8Gi"
            cpu: "4"
      volumes:
      - name: oracle-data
        persistentVolumeClaim:
          claimName: apex-data-pvc
```

**Step 4: Create Secrets**

```bash
kubectl create secret generic oracle-secret \
  --from-literal=password='Vodacom2024!' \
  --namespace=apex-prod
```

**Step 5: Deploy Database**

```bash
kubectl apply -f oracle-db-deployment.yaml

# Wait for pod to be ready
kubectl get pods -w

# Check logs
kubectl logs -f deployment/oracle-db
```

**Step 6: Create Services**

`apex-services.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: oracle-db-service
  namespace: apex-prod
spec:
  selector:
    app: oracle-db
  ports:
  - name: database
    port: 1521
    targetPort: 1521
  - name: apex
    port: 8080
    targetPort: 8080
  type: LoadBalancer
```

```bash
kubectl apply -f apex-services.yaml

# Get external IP
kubectl get svc oracle-db-service
```

**Step 7: Configure Ingress (Optional)**

`apex-ingress.yaml`:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: apex-ingress
  namespace: apex-prod
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - apex.vodacom.com
    secretName: apex-tls
  rules:
  - host: apex.vodacom.com
    http:
      paths:
      - path: /ords
        pathType: Prefix
        backend:
          service:
            name: oracle-db-service
            port:
              number: 8080
```

```bash
kubectl apply -f apex-ingress.yaml
```

**Access APEX:**
- **Via Load Balancer:** http://[EXTERNAL-IP]:8080/ords
- **Via Ingress:** https://apex.vodacom.com/ords

**Kubernetes Management:**

```bash
# Scale deployment
kubectl scale deployment oracle-db --replicas=3

# Update deployment
kubectl set image deployment/oracle-db oracle-xe=new-image:tag

# Rollback deployment
kubectl rollout undo deployment/oracle-db

# View logs
kubectl logs -f deployment/oracle-db

# Execute commands in pod
kubectl exec -it deployment/oracle-db -- bash
```

---

## Accessing Your APEX Environment

### Access Methods Summary

| Installation Method | Access URL | Default Credentials |
|--------------------|------------|---------------------|
| apex.oracle.com | https://apex.oracle.com/pls/apex | Workspace: [Your workspace]<br>Username: ADMIN<br>Password: [Your password] |
| Autonomous Database | https://[adb-name].oraclecloudapps.com/ords | Workspace: [Your workspace]<br>Username: ADMIN<br>Password: [Your password] |
| Docker (Local) | http://localhost:8080/ords | Workspace: INTERNAL<br>Username: ADMIN<br>Password: [Your password] |
| Windows (Local) | http://localhost:8080/ords | Workspace: INTERNAL<br>Username: ADMIN<br>Password: [Your password] |
| Linux (Server) | http://[server-ip]:8080/ords | Workspace: INTERNAL<br>Username: ADMIN<br>Password: [Your password] |
| Kubernetes | http://[external-ip]:8080/ords<br>or https://[domain]/ords | Workspace: INTERNAL<br>Username: ADMIN<br>Password: [Your password] |

### Common First-Time Access Issues

**Problem 1: "Connection Refused" or "Site Can't Be Reached"**

**Solutions:**
```bash
# Check if ORDS is running
# Linux/macOS:
ps aux | grep ords

# Windows:
tasklist | findstr java

# Check port 8080 is open
# Linux:
sudo netstat -tuln | grep 8080
# macOS:
lsof -i :8080
# Windows:
netstat -an | findstr 8080

# Check firewall
# Linux:
sudo firewall-cmd --list-ports
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload

# Windows:
# Windows Firewall → Advanced Settings → Inbound Rules
# New Rule → Port → TCP → 8080 → Allow
```

**Problem 2: "Invalid Workspace" Error**

**Solution:**
- Verify workspace name (case-sensitive)
- Check workspace exists:

```sql
sqlplus sys/password@db as sysdba

SELECT workspace_name, workspace_id
FROM apex_workspaces
ORDER BY workspace_name;
```

**Problem 3: "Invalid Credentials" Error**

**Solution:**
- Reset ADMIN password:

```sql
sqlplus sys/password@db as sysdba

BEGIN
  APEX_UTIL.SET_SECURITY_GROUP_ID(
    p_security_group_id => APEX_UTIL.FIND_SECURITY_GROUP_ID('YOUR_WORKSPACE')
  );
  
  APEX_UTIL.EDIT_USER(
    p_user_name => 'ADMIN',
    p_new_password => 'NewPassword2024!'
  );
  
  COMMIT;
END;
/
```

**Problem 4: Images/CSS Not Loading (Missing Styles)**

**Solution:**
- Verify APEX images path in ORDS configuration
- Check static file mapping:

```bash
# Linux/macOS:
ls -la /var/www/apex/images

# Windows:
dir C:\ords\config\ords\standalone\doc_root\i\

# Verify ORDS configuration
ords config list

# Should show:
# standalone.static.images=/path/to/apex/images
```

---

## Recommended Setup for This Course

### **Option 1: apex.oracle.com (Students/Beginners)** ⭐⭐⭐⭐⭐

**Why:**
- Zero setup time - start learning immediately
- Free forever - no hidden costs
- Always up-to-date - latest APEX version
- Accessible anywhere - just need a browser
- No maintenance - Oracle manages infrastructure

**Best for:**
- ✅ Following this course
- ✅ Learning APEX fundamentals
- ✅ Prototyping applications
- ✅ Sharing demos with clients
- ✅ Student/personal projects

**Sign up now:** https://apex.oracle.com → Get Started for Free

---

### **Option 2: Docker (Developers)** ⭐⭐⭐⭐☆

**Why:**
- Quick setup (30 minutes)
- Works on all platforms (Mac, Linux, Windows)
- Isolated environment - doesn't affect host system
- Easy to reset - just delete container and start fresh
- Learn Docker skills (valuable for DevOps)

**Best for:**
- ✅ Developers who need offline access
- ✅ Testing different APEX versions
- ✅ CI/CD pipelines
- ✅ Learning database administration
- ✅ Custom database configurations

**Setup guide:** See "Method 3: Docker Container" above

---

### **Option 3: Oracle Autonomous Database (Production)** ⭐⭐⭐⭐⭐

**Why:**
- Production-ready from day one
- Automatic scaling and patching
- Enterprise-grade security
- Built-in high availability
- Always Free tier available

**Best for:**
- ✅ Real production applications
- ✅ Team collaboration
- ✅ Applications needing high availability
- ✅ Integration with other Oracle Cloud services
- ✅ Regulatory compliance requirements

**Sign up:** https://www.oracle.com/cloud/free/ → Start for Free

---

## Exploring the APEX Development Environment

### The APEX Home Page

After signing in, you'll see four main sections:

```
┌────────────────────────────────────────────────────────────────┐
│                   Oracle APEX 24.1 Home                         │
├────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────────┐  ┌─────────────────┐  ┌───────────────┐│
│   │   App Builder   │  │  SQL Workshop   │  │Team Development││
│   │                 │  │                 │  │               ││
│   │  Create and     │  │  Database tools │  │Project tracking││
│   │  manage APEX    │  │  SQL commands   │  │Bug tracking   ││
│   │  applications   │  │  Object Browser │  │Milestones     ││
│   └─────────────────┘  └─────────────────┘  └───────────────┘│
│                                                                 │
│   ┌─────────────────┐  ┌─────────────────┐  ┌───────────────┐│
│   │   App Gallery   │  │  Packaged Apps  │  │ Documentation ││
│   │                 │  │                 │  │               ││
│   │  Sample apps    │  │  Ready-to-use   │  │Help & Guides  ││
│   │  Templates      │  │  applications   │  │Tutorials      ││
│   │  Learning       │  │  Industry apps  │  │API Reference  ││
│   └─────────────────┘  └─────────────────┘  └───────────────┘│
└────────────────────────────────────────────────────────────────┘
```

### App Builder Overview

**App Builder** is where you create and manage applications.

**Key Features:**
- **Create Applications**: Wizards for rapid app development
- **Import Applications**: Upload existing applications
- **Workspace Utilities**: Manage themes, files, feedback
- **Export/Import**: Application lifecycle management

**Quick Tour:**

1. Click **App Builder**
2. You'll see:
   - **Create** button → Start new applications
   - **Import** button → Upload applications
   - List of existing applications (empty if first time)
   - Search bar → Find applications quickly

### SQL Workshop Overview

**SQL Workshop** provides database development tools.

**Key Components:**

| Tool | Purpose | Common Uses |
|------|---------|-------------|
| **SQL Commands** | Execute SQL statements | Run queries, create tables, test code |
| **SQL Scripts** | Manage SQL script files | Run installation scripts, batch operations |
| **Object Browser** | Visual database explorer | Browse tables, edit data, view dependencies |
| **Utilities** | Database utilities | Generate DDL, data import/export, compare schemas |
| **Query Builder** | Visual SQL query designer | Build complex queries without writing SQL |
| **RESTful Services** | Create REST APIs | Expose data to external applications |

**Quick Tour:**

1. Click **SQL Workshop** → **Object Browser**
2. Left panel shows database objects:
   - Tables
   - Views
   - Indexes
   - Packages
   - Procedures
   - Functions
3. Click any object to view details

### Team Development Overview

**Team Development** helps track projects, features, bugs, and to-dos.

**Features:**
- **Milestones**: Project phases and deadlines
- **Features**: Feature requests and requirements
- **To-Dos**: Task management
- **Bugs**: Bug tracking and resolution
- **Feedback**: User feedback collection

### App Gallery Overview

**App Gallery** provides ready-to-install sample applications.

**Popular Samples:**
- **Sample Database Application**: CRM-style application
- **Sample Reporting**: Advanced reporting techniques
- **Sample Charts**: Chart and visualization examples
- **Sample Forms**: Form design patterns
- **Sample Calendar**: Calendar application
- **Sample Projects**: Project management app

**Installing a Sample App:**

1. Click **App Gallery**
2. Browse available applications
3. Click **Install** on any app
4. Wait for installation (30-60 seconds)
5. Click **Run Application**
6. Explore features and code

---

## Next Steps

**You're now ready to proceed with the hands-on labs!**

Choose your installation method based on your needs:

- **Students/Learning:** Use **apex.oracle.com** (5 minutes setup)
- **Developers:** Use **Docker** (30 minutes setup)
- **Production:** Use **Autonomous Database** (15 minutes setup)

**Recommended Path for This Course:**

1. ✅ Create account on **apex.oracle.com**
2. ✅ Sign in and explore the interface
3. ✅ Complete the verification tests above
4. ✅ Proceed to Lab 01 below

---

## Labs / Practicals

### Lab 1: Simple - Installing and Accessing Oracle APEX

**Objective:** Set up a complete APEX development environment and access the App Builder interface.

**Note:** If you're using **apex.oracle.com**, you've already completed the installation! Skip to Step 6 to verify your environment.

**Learning Outcomes:**
By the end of this lab, you will be able to:
- Install Oracle APEX in an Oracle Database
- Configure Oracle REST Data Services (ORDS) as the web listener
- Create and manage APEX workspaces
- Access the App Builder development interface
- Understand the APEX architecture components in practice

**Scenario:** 

Vodacom Corp has decided to migrate from their legacy Microsoft Access databases to Oracle APEX. They have an Oracle Database 19c Enterprise Edition running on a Linux server (vodacom-db-01). Your task as the lead developer is to:
1. Install APEX 23.1 on the existing database
2. Configure ORDS to serve APEX applications
3. Create a dedicated workspace for Vodacom development
4. Verify the installation is working correctly

**Prerequisites:**

Before starting this lab, ensure you have:

**Software:**
- Oracle Database 19c or later (XE, Standard, or Enterprise Edition) - running and accessible
- Java JDK 11 or later (required for ORDS)
- SQL*Plus or Oracle SQL Developer
- Web browser (Chrome, Firefox, or Edge recommended)
- Terminal/command line access to the database server

**Database Requirements:**
- At least 2GB free space in SYSAUX tablespace (for APEX repository)
- At least 1GB free space in TEMP tablespace
- SYS or SYSTEM privileges
- Database must be open and accessible

**System Requirements:**
- 4GB RAM minimum (8GB recommended)
- 10GB free disk space
- Network access to Oracle downloads (or pre-downloaded installation files)

**Knowledge Prerequisites:**
- Basic SQL commands (SELECT, CREATE USER, GRANT)
- Understanding of Oracle Database concepts (tablespaces, users, schemas)
- Familiarity with command-line interfaces

---

**Step-by-Step Instructions:**

#### Step 1: Verify Database Readiness

Before installing APEX, let's verify the database is ready:

```sql
-- Connect as SYS
sqlplus sys/your_password@vodacom_db as sysdba

-- Check database version (must be 12.2 or higher for APEX 23.1)
SELECT * FROM v$version;

-- Expected output:
-- Oracle Database 19c Enterprise Edition Release 19.0.0.0.0 - Production

-- Check available space in SYSAUX tablespace
SELECT 
    tablespace_name,
    ROUND(SUM(bytes)/1024/1024/1024, 2) AS total_gb,
    ROUND(SUM(maxbytes)/1024/1024/1024, 2) AS max_gb
FROM dba_data_files
WHERE tablespace_name = 'SYSAUX'
GROUP BY tablespace_name;

-- Should show at least 2GB free space

-- Check TEMP tablespace
SELECT 
    tablespace_name,
    ROUND(SUM(bytes)/1024/1024/1024, 2) AS total_gb
FROM dba_temp_files
WHERE tablespace_name = 'TEMP'
GROUP BY tablespace_name;

-- Should show at least 1GB
```

**Troubleshooting:**
- If version is below 12.2, you need to upgrade Oracle Database first
- If SYSAUX is too small, extend it: `ALTER DATABASE DATAFILE '/path/to/sysaux01.dbf' RESIZE 5G;`
- If TEMP is too small: `ALTER TABLESPACE TEMP ADD TEMPFILE SIZE 2G;`

---

#### Step 2: Download Oracle APEX

**Option A: Direct Download (if server has internet access)**

```bash
# Create installation directory
sudo mkdir -p /opt/oracle/apex
cd /opt/oracle/apex

# Download APEX 23.1 (replace URL with current version)
# Note: You may need to accept Oracle license agreement on website first
sudo wget https://download.oracle.com/otn_software/apex/apex_23.1.zip

# Alternative: Use curl
# sudo curl -O https://download.oracle.com/otn_software/apex/apex_23.1.zip

# Verify download (file should be ~180-200 MB)
ls -lh apex_23.1.zip

# Expected output:
# -rw-r--r-- 1 oracle oinstall 186M Oct 15 10:30 apex_23.1.zip
```

**Option B: Manual Download (if server is air-gapped)**

1. On your local machine, visit: https://www.oracle.com/tools/downloads/apex-downloads.html
2. Accept license agreement
3. Download `apex_23.1.zip`
4. Transfer to server using SCP:
   ```bash
   scp apex_23.1.zip oracle@vodacom-db-01:/opt/oracle/apex/
   ```

**Extract APEX Files:**

```bash
cd /opt/oracle/apex
sudo unzip apex_23.1.zip

# This creates an 'apex' directory
cd apex

# Verify extraction
ls -la

# You should see files like:
# apexins.sql       - Main installation script
# apxchpwd.sql      - Change ADMIN password script
# apxdvins.sql      - Development environment installation
# apexins_cdb.sql   - For Container Database installation
# images/           - Static files (CSS, JavaScript, images)
# utilities/        - Utility scripts
```

---

#### Step 3: Install APEX in the Database

Now we'll install the APEX repository into the Oracle Database. This typically takes 15-30 minutes.

```sql
-- Connect as SYS
sqlplus sys/your_password@vodacom_db as sysdba

-- IMPORTANT: Set current directory to APEX directory
-- This ensures relative paths in installation scripts work correctly
cd /opt/oracle/apex

-- Start installation
-- Syntax: @apexins TABLESPACE_APEX TABLESPACE_FILES TABLESPACE_TEMP IMAGES
-- 
-- TABLESPACE_APEX: Where APEX repository objects are stored (use SYSAUX)
-- TABLESPACE_FILES: Where APEX uploaded files are stored (use SYSAUX)
-- TABLESPACE_TEMP: Temporary tablespace (use TEMP)
-- IMAGES: Virtual directory for static files (use /i/)

@apexins SYSAUX SYSAUX TEMP /i/

-- Installation will display progress:
-- ...set_appun.sql
-- ...create core APEX objects
-- ...create APEX views
-- ...create APEX packages
-- 
-- This takes 15-30 minutes - be patient!
-- You'll see hundreds of "Package created" and "View created" messages

-- When complete, you should see:
-- timing for: Complete Installation
-- PL/SQL procedure successfully completed.
-- 
-- Thank you for installing Oracle Application Express 23.1.0
```

**What Just Happened?**

The installation script created:
- **APEX_230100 schema**: Contains all APEX metadata, application definitions, and runtime engine
- **FLOWS_FILES schema**: Stores uploaded files
- **Dozens of database objects**: Views, packages, procedures, triggers that power APEX
- **Built-in applications**: APEX Builder, SQL Workshop, Team Development

**Verify Installation:**

```sql
-- Check APEX version
SELECT * FROM apex_release;

-- Expected output:
-- VERSION_NO         API_COMPATIBILITY  PATCH_APPLIED
-- 23.1.0             2023.04.18         APPLIED

-- Check installed schemas
SELECT username, account_status, created
FROM dba_users
WHERE username LIKE 'APEX%' OR username = 'FLOWS_FILES'
ORDER BY created;

-- Expected output:
-- APEX_PUBLIC_USER    OPEN      [today's date]
-- APEX_230100         LOCKED    [today's date]
-- FLOWS_FILES         LOCKED    [today's date]

-- Check APEX objects count
SELECT object_type, COUNT(*)
FROM dba_objects
WHERE owner = 'APEX_230100'
GROUP BY object_type
ORDER BY 2 DESC;

-- You should see thousands of objects:
-- TABLE          1,200+
-- INDEX          2,000+
-- PACKAGE        500+
-- VIEW           400+
-- etc.
```

---

#### Step 4: Configure APEX Administrator Password

By default, APEX creates an ADMIN user for the INTERNAL workspace. We need to set its password.

```sql
-- Still connected as SYS in SQL*Plus
@apxchpwd

-- You'll be prompted:
-- Enter a password for the ADMIN user []:
Vodacom2024!

-- Enter it again to confirm []:
Vodacom2024!

-- Output:
-- ...changing password for ADMIN
-- PL/SQL procedure successfully completed.
```

**Password Requirements:**
- Minimum 8 characters
- At least one uppercase letter
- At least one lowercase letter
- At least one number
- At least one special character
- Cannot contain username or "oracle"

---

#### Step 5: Create APEX Images Directory (for ORDS)

APEX requires a directory for static files (JavaScript, CSS, images). We'll copy these to a location ORDS can serve.

```bash
# Create directory for APEX images
sudo mkdir -p /var/www/apex/images

# Copy APEX static files
sudo cp -r /opt/oracle/apex/images/* /var/www/apex/images/

# Set proper ownership (assuming ORDS runs as 'oracle' user)
sudo chown -R oracle:oinstall /var/www/apex

# Verify files copied
ls -la /var/www/apex/images/ | head -20

# You should see directories like:
# app_ui/
# css/
# javascript/
# libraries/
# themes/
```

---

#### Step 6: Download and Install Oracle REST Data Services (ORDS)

ORDS is the web server that sits between browsers and the Oracle Database, handling HTTP requests and routing them to APEX.

**Download ORDS:**

```bash
# Create ORDS directory
sudo mkdir -p /opt/oracle/ords
cd /opt/oracle/ords

# Download ORDS (latest version)
sudo wget https://download.oracle.com/otn_software/java/ords/ords-latest.zip

# Extract
sudo unzip ords-latest.zip

# Verify Java is installed (ORDS requires Java 11+)
java -version

# Expected output:
# java version "11.0.15" or higher

# If Java not installed:
# sudo yum install java-11-openjdk   # For RHEL/Oracle Linux
# sudo apt install openjdk-11-jdk    # For Ubuntu/Debian
```

**Configure ORDS:**

```bash
# Run ORDS configuration wizard
java -jar ords.war install

# You'll be prompted with several questions:
```

**Question 1:** Enter the location to store configuration data:
```
/opt/oracle/ords/config
```

**Question 2:** Enter the name of the database server [localhost]:
```
localhost
```
(Or enter the actual hostname if database is remote: `vodacom-db-01.internal`)

**Question 3:** Enter the database listen port [1521]:
```
1521
```

**Question 4:** Enter 1 to specify the database service name, or 2 to specify the database SID [1]:
```
1
```

**Question 5:** Enter the database service name:
```
vodacom_db
```
(This should match your Oracle Database service name. Check with: `SELECT name FROM v$database;`)

**Question 6:** Enter 1 if you want to verify/install Oracle REST Data Services schema or 2 to skip this step [1]:
```
1
```

**Question 7:** Enter the database password for ORDS_PUBLIC_USER:
```
[Generate a strong password, e.g., OrdsPublic2024!]
```

**Question 8:** Confirm password:
```
[Same password]
```

**Question 9:** Requires to login with administrator privileges to verify Oracle REST Data Services schema.

Enter the administrator username:
```
SYS
```

**Question 10:** Enter the database password for SYS AS SYSDBA:
```
[Your SYS password]
```

**Question 11:** Enter 1 to specify passwords for Application Express RESTful Services database users (APEX_LISTENER, APEX_REST_PUBLIC_USER) or 2 to skip this step [1]:
```
1
```

**Question 12:** Enter the database password for APEX_LISTENER:
```
ApexListener2024!
```

**Question 13:** Confirm password:
```
ApexListener2024!
```

**Question 14:** Enter the database password for APEX_REST_PUBLIC_USER:
```
ApexRestPublic2024!
```

**Question 15:** Confirm password:
```
ApexRestPublic2024!
```

**Question 16:** Enter 1 if you wish to start in standalone mode or 2 to exit [1]:
```
2
```
(We'll start it manually in the next step)

**ORDS Configuration Complete!**

The installation creates database users and configures connection pooling. You should see:
```
2025-11-09 10:15:23.456 INFO  Completed configuration for: default
```

---

#### Step 7: Configure APEX Images in ORDS

Tell ORDS where to find APEX static files:

```bash
# Create standalone directory structure
mkdir -p /opt/oracle/ords/config/standalone

# Create standalone.properties file
cat > /opt/oracle/ords/config/standalone/standalone.properties <<EOF
# ORDS Standalone Configuration
standalone.http.port=8080
standalone.static.images=/var/www/apex/images

# Optional: Enable HTTPS
# standalone.https.port=8443
# standalone.https.cert=/path/to/certificate.crt
# standalone.https.cert.key=/path/to/private.key

# Connection pool settings
jdbc.MaxLimit=50
jdbc.InitialLimit=5
EOF
```

---

#### Step 8: Start ORDS

Now let's start ORDS and access APEX!

```bash
# Start ORDS in standalone mode
cd /opt/oracle/ords
java -jar ords.war standalone

# You should see startup messages:
# 2025-11-09 10:20:15.123 INFO  Oracle REST Data Services initialized
# 2025-11-09 10:20:15.456 INFO  Default database pool starting...
# 2025-11-09 10:20:16.789 INFO  HTTP listener started on port 8080
# 2025-11-09 10:20:16.790 INFO  
# 2025-11-09 10:20:16.790 INFO  Oracle REST Data Services version : 22.4.0.r3421321
# 2025-11-09 10:20:16.790 INFO  
# 2025-11-09 10:20:16.791 INFO  Database:
# 2025-11-09 10:20:16.791 INFO    Host: localhost
# 2025-11-09 10:20:16.791 INFO    Port: 1521
# 2025-11-09 10:20:16.791 INFO    Service name: vodacom_db
# 2025-11-09 10:20:16.791 INFO  
# 2025-11-09 10:20:16.791 INFO  APEX static resources location: /var/www/apex/images
#
# Ready to accept connections!
```

**Running ORDS as a Background Service (Production Setup):**

For production, you'd want ORDS to run as a system service. Create `/etc/systemd/system/ords.service`:

```ini
[Unit]
Description=Oracle REST Data Services
After=network.target

[Service]
Type=simple
User=oracle
ExecStart=/usr/bin/java -jar /opt/oracle/ords/ords.war standalone
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
```

Then:
```bash
sudo systemctl daemon-reload
sudo systemctl start ords
sudo systemctl enable ords  # Auto-start on boot
sudo systemctl status ords
```

---

#### Step 9: Access APEX Administration

Now let's access APEX in a browser!

1. Open your web browser
2. Navigate to: `http://localhost:8080/ords`
3. You should see the Oracle APEX sign-in page

**Sign in to INTERNAL Workspace:**

```
Workspace: INTERNAL
Username:  ADMIN
Password:  Vodacom2024!
```

4. Click **Sign In**

**You should now see:** The APEX Administration Services page with options like:
- Manage Workspaces
- Monitor Activity
- Manage Instance
- Manage Requests

**Congratulations!** APEX is installed and running!

---

#### Step 10: Create Vodacom Development Workspace

Now let's create a dedicated workspace for Vodacom's application development.

**From APEX Administration:**

1. Click **Manage Workspaces**
2. Click **Create Workspace**

**Workspace Details:**

```
Workspace Name: VODACOM
Workspace ID:   [Leave blank - auto-generated]
```

**Re-use existing schema?** No

**Schema Name:** `VODACOM_DATA`
**Schema Password:** `VodacomData2024!`
**Space Quota (MB):** `500` (or `UNLIMITED` for production)

**Identify Workspace Administrator:**

```
Administrator Username: ADMIN
Administrator Password: VodacomAdmin2024!
First Name: Tech
Last Name: Nova
Email: admin@vodacom.com
```

3. Click **Create Workspace**

**Success Message:** "Workspace VODACOM created."

---

#### Step 11: Login to Vodacom Workspace

Let's verify the workspace was created correctly.

1. Sign out from INTERNAL workspace (click username top-right → Sign Out)
2. You're back at the APEX sign-in page
3. Enter:

```
Workspace: VODACOM
Username:  ADMIN
Password:  VodacomAdmin2024!
```

4. Click **Sign In**

**You should now see:** The APEX App Builder home page with:
- **App Builder** button (create applications)
- **SQL Workshop** button (database tools)
- **Team Development** button (project tracking)
- **App Gallery** button (sample apps)

**Success!** You now have a fully functional APEX development environment.

---

#### Step 12: Validation and Testing

Let's verify everything works correctly.

**Test 1: Create a Simple Application**

1. Click **App Builder**
2. Click **Create**
3. Select **New Application**
4. Enter Application Name: `Test App`
5. Click **Create Application**
6. Click **Run Application**
7. Log in with your VODACOM credentials
8. You should see a working (empty) application

**Test 2: Run SQL Commands**

1. Click **SQL Workshop** → **SQL Commands**
2. Enter:
```sql
SELECT 'APEX is working!' AS message FROM dual;
```
3. Click **Run**
4. You should see: "APEX is working!"

**Test 3: Check Database Connection**

```sql
-- In SQL Workshop → SQL Commands:
SELECT 
    sid,
    serial#,
    username,
    program,
    status
FROM v$session
WHERE username IN ('APEX_230100', 'APEX_PUBLIC_USER', 'VODACOM_DATA');
```

You should see active sessions for APEX users.

---

#### Validation Checklist

Use this checklist to verify your installation:

- [ ] APEX 23.1 installed in database (check: `SELECT * FROM apex_release;`)
- [ ] ORDS running on port 8080 (check: browser access to `http://localhost:8080/ords`)
- [ ] Can log in to INTERNAL workspace
- [ ] Can log in to VODACOM workspace
- [ ] App Builder loads without errors
- [ ] SQL Workshop accessible
- [ ] Can create and run test application
- [ ] Static resources loading (check browser developer tools, no 404 errors)
- [ ] No errors in browser console
- [ ] ORDS console shows no errors

---

#### Troubleshooting Common Issues

**Problem:** "ORA-12154: TNS:could not resolve the connect identifier"

**Solution:**
- Verify database service name: `lsnrctl services`
- Check ORDS configuration: `/opt/oracle/ords/config/databases/default/pool.xml`
- Ensure database is running: `ps -ef | grep pmon`

---

**Problem:** "Port 8080 already in use"

**Solution:**
```bash
# Check what's using port 8080
sudo lsof -i :8080

# If you can stop it:
sudo kill [PID]

# Or change ORDS port:
# Edit /opt/oracle/ords/config/standalone/standalone.properties
standalone.http.port=8181

# Then access APEX at: http://localhost:8181/ords
```

---

**Problem:** "404 Not Found" when accessing `/ords`

**Solution:**
- Verify ORDS is running: Check terminal where you started ORDS
- Check ORDS logs: `/opt/oracle/ords/logs/ords.log`
- Ensure APEX is installed: Connect as SYS, run `SELECT * FROM apex_release;`

---

**Problem:** Images/CSS not loading (broken styling)

**Solution:**
```bash
# Verify images directory exists
ls -la /var/www/apex/images

# Check ORDS configuration
grep "standalone.static.images" /opt/oracle/ords/config/standalone/standalone.properties

# Should show: standalone.static.images=/var/www/apex/images

# Verify files are readable
sudo chmod -R 755 /var/www/apex/images
```

---

**Problem:** "Workspace does not exist"

**Solution:**
- Double-check workspace name spelling (case-sensitive!)
- Verify workspace exists: Log in as ADMIN to INTERNAL, check Manage Workspaces
- If missing, recreate following Step 10

---

**Problem:** Database connection timeout

**Solution:**
```sql
-- Increase ORDS connection pool limits
-- Edit /opt/oracle/ords/config/databases/default/pool.xml

<entry key="jdbc.MaxLimit">50</entry>
<entry key="jdbc.InitialLimit">10</entry>

-- Then restart ORDS
```

---

#### Lab Summary

**What You Accomplished:**

1. ✅ Verified Oracle Database readiness
2. ✅ Downloaded and extracted Oracle APEX 23.1
3. ✅ Installed APEX repository in database (15-30 minute installation)
4. ✅ Set APEX ADMIN password
5. ✅ Configured APEX static files directory
6. ✅ Downloaded and configured Oracle REST Data Services (ORDS)
7. ✅ Started ORDS web listener on port 8080
8. ✅ Accessed APEX Administration interface
9. ✅ Created VODACOM workspace with dedicated schema
10. ✅ Logged in to VODACOM workspace
11. ✅ Verified installation with test application
12. ✅ Validated all components working correctly

**Key Concepts Learned:**

- APEX is installed **inside** Oracle Database (not a separate application server)
- ORDS is the **web listener** that routes HTTP requests to APEX
- Workspaces provide **isolated development environments**
- APEX uses **metadata** stored in APEX_230100 schema
- Static files (CSS/JS) must be accessible to ORDS
- Each workspace can have multiple database schemas

**Time Spent:** 1-2 hours (depending on download speeds and system performance)

**Next Steps:**

In Lab 2, you'll explore the APEX development environment, create database objects, and understand workspace utilities. You'll set up the Vodacom project tracking tables that will be used throughout the course.

---

#### Additional Resources

**Official Documentation:**
- APEX Installation Guide: https://docs.oracle.com/en/database/oracle/apex/23.1/htmig/
- ORDS Installation: https://docs.oracle.com/en/database/oracle/oracle-rest-data-services/

**Vodacom Internal Resources:**
- Vodacom APEX Standards: `\\vodacom.com\it\apex-standards.pdf`
- Support Channel: #apex-help on Slack
- IT Support Ticket: support.vodacom.com

**Office Hours:**
- Tuesday/Thursday 2-4 PM
- Book appointment: vodacom.com/apex-office-hours

---

### Lab 2: Intermediate - Exploring APEX Development Environment

**Objective:** Navigate the APEX interface and understand workspaces, applications, and App Builder components.

**Scenario:** Vodacom needs you to explore the development environment and set up their first application structure.

**Step-by-Step Instructions:**

**Step 1: Explore the App Builder**

1. Log into VODACOM workspace
2. Click **App Builder** (left navigation)
3. Observe the sections:
   - **Applications**: Your apps list (currently empty)
   - **Sample Apps**: Pre-built templates
   - **Packaged Apps**: Full applications you can install

**Step 2: Understand Workspace Utilities**

1. Click **App Builder** → **Workspace Utilities** (top right)
2. Explore:
   - **All Workspace Objects**: See database tables, views, procedures
   - **Application Export**: Backup apps as SQL scripts
   - **Application Import**: Restore apps from files
   - **Cross Page Utilities**: Manage shared components across apps

**Step 3: Create Sample Database Objects**

```sql
-- Click SQL Workshop → SQL Commands
-- Create Vodacom project tables:

CREATE TABLE vodacom_employees (
    employee_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name      VARCHAR2(50) NOT NULL,
    last_name       VARCHAR2(50) NOT NULL,
    email           VARCHAR2(100) UNIQUE NOT NULL,
    phone           VARCHAR2(20),
    hire_date       DATE DEFAULT SYSDATE,
    department      VARCHAR2(50),
    job_title       VARCHAR2(100),
    salary          NUMBER(10,2),
    manager_id      NUMBER,
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    modified_date   TIMESTAMP DEFAULT SYSTIMESTAMP
);

CREATE TABLE vodacom_projects (
    project_id      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_name    VARCHAR2(200) NOT NULL,
    description     CLOB,
    start_date      DATE NOT NULL,
    end_date        DATE,
    status          VARCHAR2(20) DEFAULT 'Planning',
    budget          NUMBER(12,2),
    project_manager NUMBER,
    client_name     VARCHAR2(200),
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    modified_date   TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT fk_project_manager 
        FOREIGN KEY (project_manager) 
        REFERENCES vodacom_employees(employee_id)
);

CREATE TABLE vodacom_assignments (
    assignment_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_id      NUMBER NOT NULL,
    employee_id     NUMBER NOT NULL,
    role            VARCHAR2(100),
    start_date      DATE NOT NULL,
    end_date        DATE,
    allocation_pct  NUMBER(3,0) DEFAULT 100,
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    CONSTRAINT fk_assignment_project 
        FOREIGN KEY (project_id) 
        REFERENCES vodacom_projects(project_id),
    CONSTRAINT fk_assignment_employee 
        FOREIGN KEY (employee_id) 
        REFERENCES vodacom_employees(employee_id)
);

-- Add sample data
INSERT INTO vodacom_employees (first_name, last_name, email, department, job_title, salary)
VALUES ('John', 'Doe', 'john.doe@vodacom.com', 'IT', 'Project Manager', 95000);

INSERT INTO vodacom_employees (first_name, last_name, email, department, job_title, salary)
VALUES ('Jane', 'Smith', 'jane.smith@vodacom.com', 'IT', 'Developer', 75000);

INSERT INTO vodacom_employees (first_name, last_name, email, department, job_title, salary)
VALUES ('Bob', 'Johnson', 'bob.johnson@vodacom.com', 'QA', 'QA Engineer', 70000);

INSERT INTO vodacom_projects (project_name, description, start_date, budget, project_manager, client_name, status)
VALUES ('ERP Modernization', 'Migrate legacy ERP to cloud', SYSDATE, 500000, 1, 'Acme Corp', 'Active');

INSERT INTO vodacom_projects (project_name, description, start_date, budget, project_manager, client_name, status)
VALUES ('Mobile App Development', 'Customer portal mobile app', SYSDATE, 200000, 1, 'GlobalTech Inc', 'Planning');

COMMIT;
```

**Expected Output:**
- Tables created successfully
- 3 employees and 2 projects inserted
- Can query: `SELECT * FROM vodacom_employees;`

**Step 4: Use Object Browser**

1. Click **SQL Workshop** → **Object Browser**
2. Select **VODACOM_EMPLOYEES** table
3. Explore tabs:
   - **Data**: View and edit table data
   - **Constraints**: See primary/foreign keys
   - **Indexes**: View indexes
   - **Triggers**: Database triggers
   - **Statistics**: Row counts, size

**Step 5: Review SQL Commands History**

1. Click **SQL Workshop** → **SQL Commands**
2. Click **History** (top right)
3. See your executed SQL statements
4. Click any statement to reload and re-run

**Step 6: Use RESTful Services**

1. Click **SQL Workshop** → **RESTful Services**
2. Click **Create Module**
3. Fill in:
   - Module Name: `vodacom.employees`
   - Base Path: `/employees/`
   - Origins Allowed: `*` (for development)
4. Click **Create Template**:
   - URI Template: `list`
   - Method: `GET`
   - Source Type: `Collection Query`
   - Query: `SELECT * FROM vodacom_employees`
5. Click **Create**

**Test the REST API:**
```bash
# In a terminal or Postman:
curl http://localhost:8080/ords/vodacom/employees/list

# Expected JSON output:
# { "items": [ {...employee data...} ], "count": 3 }
```

**Validation:**
- All database objects visible in Object Browser
- REST API returns employee JSON
- SQL Commands history shows your queries

**Troubleshooting:**
- **Table creation fails**: Check you're in VODACOM workspace, not INTERNAL
- **REST API 404**: Ensure ORDS is running and workspace name is correct in URL
- **Cannot see tables**: Refresh browser or click SQL Workshop → Object Browser again

---

### Lab 3: Advanced - Setting Up Multi-Environment Workspace Strategy

**Objective:** Configure Development, Testing, and Production workspaces with proper security and deployment pipeline.

**Scenario:** Vodacom needs proper SDLC environments with controlled promotion of applications from DEV → TEST → PROD.

**Step-by-Step Instructions:**

**Step 1: Create Three Workspaces**

```sql
-- Connect as APEX ADMIN
-- Workspace: INTERNAL, User: ADMIN

-- Create DEV workspace
BEGIN
    APEX_INSTANCE_ADMIN.ADD_WORKSPACE(
        p_workspace_id   => NULL,
        p_workspace      => 'VODACOM_DEV',
        p_primary_schema => 'VODACOM_DEV_DATA'
    );
    
    APEX_INSTANCE_ADMIN.ADD_SCHEMA(
        p_workspace      => 'VODACOM_DEV',
        p_schema         => 'VODACOM_DEV_DATA'
    );
END;
/

-- Create TEST workspace
BEGIN
    APEX_INSTANCE_ADMIN.ADD_WORKSPACE(
        p_workspace_id   => NULL,
        p_workspace      => 'VODACOM_TEST',
        p_primary_schema => 'VODACOM_TEST_DATA'
    );
    
    APEX_INSTANCE_ADMIN.ADD_SCHEMA(
        p_workspace      => 'VODACOM_TEST',
        p_schema         => 'VODACOM_TEST_DATA'
    );
END;
/

-- Create PROD workspace
BEGIN
    APEX_INSTANCE_ADMIN.ADD_WORKSPACE(
        p_workspace_id   => NULL,
        p_workspace      => 'VODACOM_PROD',
        p_primary_schema => 'VODACOM_PROD_DATA'
    );
    
    APEX_INSTANCE_ADMIN.ADD_SCHEMA(
        p_workspace      => 'VODACOM_PROD',
        p_schema         => 'VODACOM_PROD_DATA'
    );
END;
/
```

**Step 2: Create Database Users for Each Environment**

```sql
-- Connect as SYS
-- Create DEV schema
CREATE USER vodacom_dev_data IDENTIFIED BY "DevPass2024!"
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA 500M ON users;

GRANT CONNECT, RESOURCE TO vodacom_dev_data;

-- Create TEST schema
CREATE USER vodacom_test_data IDENTIFIED BY "TestPass2024!"
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA 500M ON users;

GRANT CONNECT, RESOURCE TO vodacom_test_data;

-- Create PROD schema (restricted privileges)
CREATE USER vodacom_prod_data IDENTIFIED BY "ProdPass2024!"
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp
    QUOTA 1G ON users;

GRANT CONNECT, RESOURCE TO vodacom_prod_data;
```

**Step 3: Configure Workspace Administrators**

```sql
-- For each workspace, add admin user via APEX Administration UI
-- Or use PL/SQL:

-- DEV workspace admin
BEGIN
    APEX_UTIL.SET_WORKSPACE(p_workspace => 'VODACOM_DEV');
    
    APEX_UTIL.CREATE_USER(
        p_user_name     => 'DEV_ADMIN',
        p_web_password  => 'DevAdmin2024!',
        p_email_address => 'dev.admin@vodacom.com',
        p_first_name    => 'Dev',
        p_last_name     => 'Admin',
        p_developer_privs => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL'
    );
END;
/

-- TEST workspace admin (limited privileges)
BEGIN
    APEX_UTIL.SET_WORKSPACE(p_workspace => 'VODACOM_TEST');
    
    APEX_UTIL.CREATE_USER(
        p_user_name     => 'TEST_ADMIN',
        p_web_password  => 'TestAdmin2024!',
        p_email_address => 'test.admin@vodacom.com',
        p_first_name    => 'Test',
        p_last_name     => 'Admin',
        p_developer_privs => 'EDIT:MONITOR:SQL' -- No create/delete
    );
END;
/

-- PROD workspace admin (view-only)
BEGIN
    APEX_UTIL.SET_WORKSPACE(p_workspace => 'VODACOM_PROD');
    
    APEX_UTIL.CREATE_USER(
        p_user_name     => 'PROD_ADMIN',
        p_web_password  => 'ProdAdmin2024!',
        p_email_address => 'prod.admin@vodacom.com',
        p_first_name    => 'Prod',
        p_last_name     => 'Admin',
        p_developer_privs => 'MONITOR' -- Read-only
    );
END;
/
```

**Step 4: Create Deployment Script for Application Export**

```bash
#!/bin/bash
# File: export_app.sh
# Purpose: Export APEX application from DEV

ORACLE_HOME=/opt/oracle/product/19c/dbhome
SQLCL_HOME=/opt/oracle/sqlcl
APP_ID=$1
EXPORT_DIR=/opt/apex_exports

if [ -z "$APP_ID" ]; then
    echo "Usage: $0 <application_id>"
    exit 1
fi

cd $EXPORT_DIR

$SQLCL_HOME/sql vodacom_dev_data/DevPass2024!@localhost:1521/vodacom_db <<EOF
set sqlformat insert
apex export -applicationid $APP_ID -split
exit
EOF

echo "Application $APP_ID exported to $EXPORT_DIR/f$APP_ID/"
```

**Step 5: Create Import Script for TEST/PROD**

```bash
#!/bin/bash
# File: import_app.sh
# Purpose: Import APEX application to target environment

SQLCL_HOME=/opt/oracle/sqlcl
APP_FILE=$1
TARGET_ENV=$2  # TEST or PROD

if [ -z "$APP_FILE" ] || [ -z "$TARGET_ENV" ]; then
    echo "Usage: $0 <app_file.sql> <TEST|PROD>"
    exit 1
fi

if [ "$TARGET_ENV" == "TEST" ]; then
    USERNAME="vodacom_test_data"
    PASSWORD="TestPass2024!"
    WORKSPACE="VODACOM_TEST"
elif [ "$TARGET_ENV" == "PROD" ]; then
    USERNAME="vodacom_prod_data"
    PASSWORD="ProdPass2024!"
    WORKSPACE="VODACOM_PROD"
else
    echo "Invalid environment. Use TEST or PROD."
    exit 1
fi

$SQLCL_HOME/sql $USERNAME/$PASSWORD@localhost:1521/vodacom_db <<EOF
apex import $APP_FILE -workspace $WORKSPACE
exit
EOF

echo "Application imported to $TARGET_ENV environment"
```

**Step 6: Configure Application-Level Security**

In each workspace, set security policies:

**DEV Environment:**
- Allow debugging
- Enable trace
- Show developer toolbar
- No session timeout restrictions

**TEST Environment:**
```sql
-- In APEX Application Definition → Security:
-- Session Timeout: 3600 seconds (1 hour)
-- Max Session Length: 28800 seconds (8 hours)
-- Session State Protection: Enabled
-- Embed in Frames: Deny
-- Browser Cache: Disabled
-- Deep Linking: Enabled (for test automation)
```

**PROD Environment:**
```sql
-- In APEX Application Definition → Security:
-- Session Timeout: 1800 seconds (30 minutes)
-- Max Session Length: 14400 seconds (4 hours)
-- Session State Protection: Enabled (checksum required)
-- Embed in Frames: Deny
-- Browser Cache: Disabled
-- Deep Linking: Disabled
-- HTTPS Only: Required
-- Rejoin Sessions: Disabled
-- Runtime API Usage: Disabled
```

**Step 7: Set Up CI/CD Pipeline (Git Integration)**

```bash
# Initialize Git repository for APEX source
mkdir /opt/vodacom_apex_source
cd /opt/vodacom_apex_source
git init

# Create .gitignore
cat > .gitignore <<EOF
*.log
*.tmp
/exports/*.zip
/node_modules/
EOF

# Export application in split files (better for version control)
# In APEX: App Builder → Export → Split into separate files

# Directory structure:
# f100/  (application ID)
#   ├── application/
#   │   ├── pages/
#   │   │   ├── page_00001.sql
#   │   │   ├── page_00002.sql
#   │   ├── shared_components/
#   │   ├── security/
#   │   └── user_interfaces/
#   └── install.sql

# Commit to Git
git add .
git commit -m "Initial commit: Vodacom APEX app"
git remote add origin https://github.com/vodacom/apex-apps.git
git push -u origin main
```

**Step 8: Create Automated Deployment Script**

```bash
#!/bin/bash
# File: deploy_pipeline.sh
# Purpose: Full deployment pipeline DEV → TEST → PROD

set -e  # Exit on error

APP_ID=100
EXPORT_DIR=/opt/apex_exports
GIT_REPO=/opt/vodacom_apex_source

echo "=== Vodacom APEX Deployment Pipeline ==="

# Step 1: Export from DEV
echo "1. Exporting from DEV..."
./export_app.sh $APP_ID

# Step 2: Commit to Git
echo "2. Committing to version control..."
cd $GIT_REPO
cp -r $EXPORT_DIR/f$APP_ID/* .
git add .
git commit -m "Automated export: $(date)"
git push origin main

# Step 3: Deploy to TEST
echo "3. Deploying to TEST environment..."
./import_app.sh $EXPORT_DIR/f$APP_ID/install.sql TEST

# Step 4: Run automated tests
echo "4. Running automated tests..."
# (Integration with Selenium or APEX Test Framework)

# Step 5: Wait for approval
echo "5. Waiting for manual approval for PROD deployment..."
read -p "Deploy to PROD? (yes/no): " approval

if [ "$approval" == "yes" ]; then
    echo "6. Deploying to PROD environment..."
    ./import_app.sh $EXPORT_DIR/f$APP_ID/install.sql PROD
    echo "=== Deployment Complete ==="
else
    echo "PROD deployment cancelled."
fi
```

**Expected Output:**
- Three workspaces (DEV, TEST, PROD) visible in APEX Administration
- Each with separate database schema
- Export/import scripts work without errors
- Git repository tracks application changes

**Validation:**
1. Export an app from DEV: `./export_app.sh 100`
2. Import to TEST: `./import_app.sh f100/install.sql TEST`
3. Verify app appears in VODACOM_TEST workspace
4. Check Git history: `git log`

**Troubleshooting:**
- **Export fails**: Ensure SQLcl is installed and in PATH
- **Import fails**: Check workspace name matches exactly
- **Permission denied**: Ensure scripts are executable (`chmod +x *.sh`)
- **Git errors**: Configure git user: `git config --global user.name "Vodacom"`

---

## Real-World Practical

### Vodacom Corp Production Scenario: Migrating Legacy Access Database to APEX

**Business Context:**

Vodacom Corp has been using a Microsoft Access database for their project tracking system for 10 years. It's now crashing frequently, doesn't support remote access, and can't handle the growing data volume (50,000+ project records). The company needs to:

1. Migrate all data to Oracle Database
2. Build a modern web interface accessible from anywhere
3. Support 50+ concurrent users
4. Provide mobile access for field consultants
5. Integrate with their existing ERP system via REST APIs

**Your Mission:**

Set up the APEX development environment and migrate the Access database structure to Oracle, preparing for application development.

**Tasks:**

**Task 1: Analyze the Legacy Access Database**

You receive an Access database file: `Vodacom_Projects.accdb`

Tables:
- `Employees` (250 records)
- `Clients` (180 records)
- `Projects` (5,300 records)
- `Tasks` (22,000 records)
- `Timesheets` (48,000 records)
- `Invoices` (3,200 records)

**Task 2: Export Data from Access**

```bash
# Option 1: Using mdb-tools (Linux/Mac)
sudo apt-get install mdb-tools  # or brew install mdb-tools

# Export each table to CSV
mdb-export Vodacom_Projects.accdb Employees > employees.csv
mdb-export Vodacom_Projects.accdb Clients > clients.csv
mdb-export Vodacom_Projects.accdb Projects > projects.csv
mdb-export Vodacom_Projects.accdb Tasks > tasks.csv
mdb-export Vodacom_Projects.accdb Timesheets > timesheets.csv
mdb-export Vodacom_Projects.accdb Invoices > invoices.csv

# Option 2: Using Access Export Wizard (Windows)
# In Access: External Data → Text File → Export
```

**Task 3: Create Oracle Database Schema**

```sql
-- Enhanced schema with better constraints and indexes

-- Employees table
CREATE TABLE tn_employees (
    emp_id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    legacy_emp_id   NUMBER UNIQUE,  -- For migration mapping
    first_name      VARCHAR2(50) NOT NULL,
    last_name       VARCHAR2(50) NOT NULL,
    email           VARCHAR2(100) UNIQUE NOT NULL,
    phone           VARCHAR2(20),
    mobile          VARCHAR2(20),
    hire_date       DATE NOT NULL,
    department      VARCHAR2(50),
    job_title       VARCHAR2(100),
    hourly_rate     NUMBER(8,2),
    manager_id      NUMBER,
    is_active       CHAR(1) DEFAULT 'Y',
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    created_by      VARCHAR2(50) DEFAULT USER,
    modified_date   TIMESTAMP DEFAULT SYSTIMESTAMP,
    modified_by     VARCHAR2(50) DEFAULT USER,
    CONSTRAINT ck_emp_active CHECK (is_active IN ('Y', 'N')),
    CONSTRAINT fk_emp_manager FOREIGN KEY (manager_id) REFERENCES tn_employees(emp_id)
);

-- Clients table
CREATE TABLE tn_clients (
    client_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    legacy_client_id NUMBER UNIQUE,
    company_name    VARCHAR2(200) NOT NULL,
    contact_name    VARCHAR2(100),
    contact_email   VARCHAR2(100),
    contact_phone   VARCHAR2(20),
    address         VARCHAR2(500),
    city            VARCHAR2(100),
    country         VARCHAR2(100),
    is_active       CHAR(1) DEFAULT 'Y',
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    created_by      VARCHAR2(50) DEFAULT USER,
    modified_date   TIMESTAMP DEFAULT SYSTIMESTAMP,
    modified_by     VARCHAR2(50) DEFAULT USER,
    CONSTRAINT ck_client_active CHECK (is_active IN ('Y', 'N'))
);

-- Projects table
CREATE TABLE tn_projects (
    project_id      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    legacy_project_id NUMBER UNIQUE,
    project_code    VARCHAR2(20) UNIQUE NOT NULL,
    project_name    VARCHAR2(200) NOT NULL,
    description     CLOB,
    client_id       NUMBER NOT NULL,
    start_date      DATE NOT NULL,
    end_date        DATE,
    status          VARCHAR2(20) DEFAULT 'Planning',
    budget          NUMBER(12,2),
    actual_cost     NUMBER(12,2) DEFAULT 0,
    project_manager NUMBER NOT NULL,
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    created_by      VARCHAR2(50) DEFAULT USER,
    modified_date   TIMESTAMP DEFAULT SYSTIMESTAMP,
    modified_by     VARCHAR2(50) DEFAULT USER,
    CONSTRAINT fk_proj_client FOREIGN KEY (client_id) REFERENCES tn_clients(client_id),
    CONSTRAINT fk_proj_manager FOREIGN KEY (project_manager) REFERENCES tn_employees(emp_id),
    CONSTRAINT ck_proj_status CHECK (status IN ('Planning', 'Active', 'On Hold', 'Completed', 'Cancelled'))
);

-- Tasks table
CREATE TABLE tn_tasks (
    task_id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    legacy_task_id  NUMBER UNIQUE,
    project_id      NUMBER NOT NULL,
    task_name       VARCHAR2(200) NOT NULL,
    description     CLOB,
    assigned_to     NUMBER,
    status          VARCHAR2(20) DEFAULT 'Not Started',
    priority        VARCHAR2(20) DEFAULT 'Medium',
    estimated_hours NUMBER(8,2),
    actual_hours    NUMBER(8,2) DEFAULT 0,
    due_date        DATE,
    completed_date  DATE,
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    created_by      VARCHAR2(50) DEFAULT USER,
    modified_date   TIMESTAMP DEFAULT SYSTIMESTAMP,
    modified_by     VARCHAR2(50) DEFAULT USER,
    CONSTRAINT fk_task_project FOREIGN KEY (project_id) REFERENCES tn_projects(project_id),
    CONSTRAINT fk_task_assigned FOREIGN KEY (assigned_to) REFERENCES tn_employees(emp_id),
    CONSTRAINT ck_task_status CHECK (status IN ('Not Started', 'In Progress', 'Completed', 'Blocked')),
    CONSTRAINT ck_task_priority CHECK (priority IN ('Low', 'Medium', 'High', 'Critical'))
);

-- Timesheets table
CREATE TABLE tn_timesheets (
    timesheet_id    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    legacy_ts_id    NUMBER UNIQUE,
    employee_id     NUMBER NOT NULL,
    task_id         NUMBER NOT NULL,
    work_date       DATE NOT NULL,
    hours           NUMBER(4,2) NOT NULL,
    description     VARCHAR2(500),
    billable        CHAR(1) DEFAULT 'Y',
    approved        CHAR(1) DEFAULT 'N',
    approved_by     NUMBER,
    approved_date   DATE,
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    created_by      VARCHAR2(50) DEFAULT USER,
    CONSTRAINT fk_ts_employee FOREIGN KEY (employee_id) REFERENCES tn_employees(emp_id),
    CONSTRAINT fk_ts_task FOREIGN KEY (task_id) REFERENCES tn_tasks(task_id),
    CONSTRAINT fk_ts_approver FOREIGN KEY (approved_by) REFERENCES tn_employees(emp_id),
    CONSTRAINT ck_ts_hours CHECK (hours > 0 AND hours <= 24),
    CONSTRAINT ck_ts_billable CHECK (billable IN ('Y', 'N')),
    CONSTRAINT ck_ts_approved CHECK (approved IN ('Y', 'N'))
);

-- Invoices table
CREATE TABLE tn_invoices (
    invoice_id      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    legacy_inv_id   NUMBER UNIQUE,
    invoice_number  VARCHAR2(50) UNIQUE NOT NULL,
    client_id       NUMBER NOT NULL,
    project_id      NUMBER,
    invoice_date    DATE NOT NULL,
    due_date        DATE NOT NULL,
    amount          NUMBER(12,2) NOT NULL,
    tax             NUMBER(12,2) DEFAULT 0,
    total           NUMBER(12,2) NOT NULL,
    status          VARCHAR2(20) DEFAULT 'Draft',
    paid_date       DATE,
    created_date    TIMESTAMP DEFAULT SYSTIMESTAMP,
    created_by      VARCHAR2(50) DEFAULT USER,
    modified_date   TIMESTAMP DEFAULT SYSTIMESTAMP,
    modified_by     VARCHAR2(50) DEFAULT USER,
    CONSTRAINT fk_inv_client FOREIGN KEY (client_id) REFERENCES tn_clients(client_id),
    CONSTRAINT fk_inv_project FOREIGN KEY (project_id) REFERENCES tn_projects(project_id),
    CONSTRAINT ck_inv_status CHECK (status IN ('Draft', 'Sent', 'Paid', 'Overdue', 'Cancelled'))
);

-- Create indexes for performance
CREATE INDEX idx_emp_dept ON tn_employees(department);
CREATE INDEX idx_emp_manager ON tn_employees(manager_id);
CREATE INDEX idx_proj_client ON tn_projects(client_id);
CREATE INDEX idx_proj_status ON tn_projects(status);
CREATE INDEX idx_task_project ON tn_tasks(project_id);
CREATE INDEX idx_task_assigned ON tn_tasks(assigned_to);
CREATE INDEX idx_ts_employee ON tn_timesheets(employee_id);
CREATE INDEX idx_ts_task ON tn_timesheets(task_id);
CREATE INDEX idx_ts_date ON tn_timesheets(work_date);
CREATE INDEX idx_inv_client ON tn_invoices(client_id);
CREATE INDEX idx_inv_status ON tn_invoices(status);
```

**Task 4: Import Data Using APEX Data Loading**

1. Log into APEX workspace VODACOM_DEV
2. Go to **SQL Workshop** → **Utilities** → **Data Workshop**
3. Click **Load Data** → **Upload CSV**
4. For each CSV file:
   - Select file
   - Map columns to table columns
   - Handle legacy ID mapping
   - Preview and verify
   - Load data

**Task 5: Create Views for Business Logic**

```sql
-- Project Dashboard View
CREATE OR REPLACE VIEW vw_project_dashboard AS
SELECT 
    p.project_id,
    p.project_code,
    p.project_name,
    c.company_name AS client_name,
    e.first_name || ' ' || e.last_name AS project_manager,
    p.status,
    p.start_date,
    p.end_date,
    p.budget,
    p.actual_cost,
    p.budget - p.actual_cost AS remaining_budget,
    ROUND((p.actual_cost / NULLIF(p.budget, 0)) * 100, 2) AS budget_used_pct,
    (SELECT COUNT(*) FROM tn_tasks t WHERE t.project_id = p.project_id) AS total_tasks,
    (SELECT COUNT(*) FROM tn_tasks t WHERE t.project_id = p.project_id AND t.status = 'Completed') AS completed_tasks,
    (SELECT SUM(hours) FROM tn_timesheets ts 
     JOIN tn_tasks t ON ts.task_id = t.task_id 
     WHERE t.project_id = p.project_id) AS total_hours
FROM tn_projects p
JOIN tn_clients c ON p.client_id = c.client_id
JOIN tn_employees e ON p.project_manager = e.emp_id;

-- Employee Utilization View
CREATE OR REPLACE VIEW vw_employee_utilization AS
SELECT 
    e.emp_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    e.department,
    e.job_title,
    (SELECT SUM(hours) 
     FROM tn_timesheets ts 
     WHERE ts.employee_id = e.emp_id 
     AND ts.work_date >= TRUNC(SYSDATE, 'MM')) AS hours_this_month,
    (SELECT COUNT(DISTINCT t.project_id)
     FROM tn_tasks t
     WHERE t.assigned_to = e.emp_id
     AND t.status != 'Completed') AS active_projects
FROM tn_employees e
WHERE e.is_active = 'Y';
```

**Task 6: Configure APEX Environment Settings**

```sql
-- Set workspace preferences
BEGIN
    APEX_UTIL.SET_WORKSPACE(p_workspace => 'VODACOM_DEV');
    
    -- Set application defaults
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'MAX_SESSION_LENGTH_SEC',
        p_value     => '28800'  -- 8 hours
    );
    
    -- Enable workspace features
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'WORKSPACE_WEBSERVICE_ENABLED',
        p_value     => 'Y'
    );
END;
/
```

**Expected Outcomes:**

1. ✅ All Access data successfully migrated to Oracle
2. ✅ Database schema supports 50+ concurrent users (tested with Oracle SQL Developer)
3. ✅ Views provide business-ready data for APEX reports
4. ✅ Indexes ensure fast query performance (<1 second for dashboard views)
5. ✅ Development environment ready for application building

**Success Metrics:**
- Data integrity: 100% of records migrated without loss
- Performance: All queries return within 2 seconds
- Scalability: Database can handle 100 concurrent connections
- Security: Proper foreign key constraints maintain referential integrity

**Next Steps:**
In subsequent lessons, you'll build the APEX application on top of this foundation, starting with interactive reports, forms, and dashboards.

---

## Assessment

### Multiple Choice Questions (MCQs)

**Question 1:** What is Oracle APEX primarily used for?

A) Database administration and backup  
B) Rapid development of data-driven web applications  
C) Network security and firewall management  
D) Operating system virtualization  

**Correct Answer: B**

---

**Question 2:** In Vodacom Corp's APEX architecture, which component handles HTTP requests and routes them to the APEX Engine?

A) Apache HTTP Server  
B) Oracle REST Data Services (ORDS)  
C) APEX Repository  
D) Browser JavaScript engine  

**Correct Answer: B**

---

**Question 3:** What is the purpose of separating DEV, TEST, and PROD workspaces in APEX?

A) To increase application performance  
B) To provide controlled SDLC environments and prevent accidental production changes  
C) To reduce database storage costs  
D) To enable multi-language support  

**Correct Answer: B**

---

**Question 4:** Which SQL*Plus command is used to install Oracle APEX in a database?

A) `CREATE APEX;`  
B) `@apexins SYSAUX SYSAUX TEMP /i/`  
C) `INSTALL APPLICATION_EXPRESS;`  
D) `BEGIN APEX_INSTALL; END;`  

**Correct Answer: B**

---

**Question 5:** In Vodacom's migration scenario, what is the recommended way to import CSV data into APEX tables?

A) Manually typing data into forms  
B) Using SQL INSERT statements only  
C) APEX Data Workshop → Load Data utility  
D) Copying data from Excel with Ctrl+C / Ctrl+V  

**Correct Answer: C**

---

### Short Answer Questions

**Question 1:** Explain the three-tier architecture of Oracle APEX and describe the role of each tier.

**Model Answer:**
Oracle APEX uses a three-tier architecture:
1. **Client Tier (Browser)**: Renders HTML, CSS, and JavaScript. Handles user interactions and sends HTTP requests. No special software installation required.
2. **Middle Tier (ORDS)**: Oracle REST Data Services acts as the web server, managing HTTP connections, routing requests to the database, and serving static files. It provides connection pooling and handles RESTful services.
3. **Database Tier (Oracle Database)**: Contains the APEX Engine (PL/SQL code), APEX Repository (application metadata), and application data schemas. All business logic, security, and data processing happens here.

This architecture allows centralized logic, simplified deployment, and high security since all code runs in the database.

---

**Question 2:** Vodacom Corp needs to ensure their APEX production environment is secure. List three security best practices they should implement.

**Model Answer:**
1. **Enable HTTPS Only**: Configure ORDS to reject non-encrypted HTTP requests, ensuring all data transmission is encrypted with TLS/SSL certificates.
2. **Implement Strong Authentication**: Use multi-factor authentication (MFA) or integrate with enterprise LDAP/Active Directory instead of database accounts. Set session timeouts (e.g., 30 minutes).
3. **Apply Authorization Schemes**: Use APEX authorization schemes to control page and component access based on user roles. Enable session state protection with checksums to prevent URL tampering.

Additional: Disable debugging in production, enable audit logging, regularly update APEX and ORDS to patch security vulnerabilities.

---

**Question 3:** Describe the process of exporting an APEX application from the DEV workspace and importing it into PROD. What tool would you use and why?

**Model Answer:**
**Export Process:**
1. Log into DEV workspace
2. Go to App Builder → Export/Import → Export
3. Select application ID
4. Choose "Split into separate files" for version control
5. Download the SQL install script or use SQLcl: `apex export -applicationid 100 -split`

**Import Process:**
1. Log into PROD workspace as administrator
2. Go to App Builder → Export/Import → Import
3. Upload the SQL file or use SQLcl: `apex import install.sql -workspace VODACOM_PROD`
4. Verify import success and test the application

**Tool Recommendation:** Use **SQLcl** (Oracle SQL Developer Command Line) for automated deployments because it:
- Supports scripting and CI/CD integration
- Handles large files better than browser uploads
- Provides detailed error messages
- Can be version-controlled in Git

---

### Practical Project Challenge

**Project: Vodacom Corp APEX Environment Setup**

**Scenario:**
You are the new APEX administrator for Vodacom Corp. The company has decided to migrate their project management system to Oracle APEX. You need to set up a complete development environment from scratch.

**Requirements:**

1. **Environment Setup (30 points)**
   - Install Oracle Database 19c Express Edition
   - Install Oracle APEX 23.1
   - Configure Oracle REST Data Services (ORDS)
   - Verify the installation by accessing APEX in a browser

2. **Workspace Configuration (25 points)**
   - Create three workspaces: VODACOM_DEV, VODACOM_TEST, VODACOM_PROD
   - Create appropriate database schemas for each workspace
   - Set up workspace administrators with appropriate privileges
   - Configure workspace parameters (session timeout, max session length)

3. **Database Schema Creation (25 points)**
   - Create the following tables in VODACOM_DEV schema:
     - `tn_employees` (at least 8 columns)
     - `tn_projects` (at least 8 columns)
     - `tn_tasks` (at least 7 columns)
   - Add appropriate constraints (primary keys, foreign keys, check constraints)
   - Create indexes for foreign key columns
   - Insert sample data (at least 5 records per table)

4. **REST API Development (10 points)**
   - Create a RESTful service module for employees
   - Implement GET endpoint to list all employees
   - Implement GET endpoint to retrieve single employee by ID
   - Test APIs and document the URLs

5. **Documentation (10 points)**
   - Create a README.md file documenting:
     - Installation steps
     - Workspace access credentials (use dummy passwords)
     - Database schema ERD (Entity Relationship Diagram)
     - REST API endpoints with example requests/responses
     - Known issues and troubleshooting tips

**Deliverables:**

1. SQL script files:
   - `01_create_schemas.sql` (creates database users)
   - `02_create_tables.sql` (creates all tables with constraints)
   - `03_insert_sample_data.sql` (inserts test data)
2. Export files:
   - Workspace export from DEV environment
3. Documentation:
   - `README.md` with setup instructions
   - `API_DOCUMENTATION.md` with REST API details
4. Screenshots:
   - APEX login page
   - Workspace administration page showing all three workspaces
   - Object Browser showing created tables
   - REST API test results (Postman or curl)

**Evaluation Criteria:**

| Criterion | Points | Description |
|-----------|--------|-------------|
| Installation Completeness | 15 | APEX and ORDS installed correctly, accessible via browser |
| Workspace Setup | 15 | All three workspaces created with proper isolation |
| Database Design | 20 | Tables normalized, constraints implemented, sample data loaded |
| REST API Functionality | 10 | APIs work correctly and return proper JSON |
| Code Quality | 15 | SQL follows best practices, well-commented |
| Documentation | 15 | Clear, complete, and easy to follow |
| Testing & Validation | 10 | Evidence of thorough testing, screenshots provided |
| **Total** | **100** | |

**Bonus Points (10 extra):**
- Implement CI/CD scripts for automated export/import
- Create database views for complex queries
- Set up Git repository with version control
- Implement automated backup script

**Submission Instructions:**
1. Create a zip file: `Vodacom_APEX_Setup_<YourName>.zip`
2. Include all SQL scripts, documentation, and screenshots
3. Submit via the course LMS by [due date]

---

## PowerPoint Slides

### Slide 1: Title
**Introduction and Getting Started with Oracle APEX**

*Vodacom Corp Training Series*

---

### Slide 2: What is Oracle APEX?
**Oracle Application Express (APEX)**

- **Low-code development platform** for building web applications
- Runs entirely within **Oracle Database**
- **Rapid application development** (RAD) tool
- No separate application server required
- **Browser-based** development environment

**Analogy:** Like building with LEGO blocks instead of carving from wood

---

### Slide 3: Why Use APEX?
**Business Benefits**

✅ **Speed**: Build apps 20x faster than traditional coding  
✅ **Cost**: Included free with Oracle Database license  
✅ **Skills**: Leverage existing SQL and PL/SQL knowledge  
✅ **Security**: Enterprise-grade built-in security  
✅ **Scalability**: Inherits Oracle Database scalability  
✅ **Maintenance**: Easier updates and bug fixes  

**Vodacom Use Case:** Modernize legacy Access database in weeks, not months

---

### Slide 4: APEX Architecture
**Three-Tier Architecture**

```
┌─────────────────────┐
│   Browser (Client)   │  ← HTML5, CSS3, JavaScript
└─────────────────────┘
          ↓
┌─────────────────────┐
│   ORDS (Web Server) │  ← Handles HTTP, routes requests
└─────────────────────┘
          ↓
┌─────────────────────┐
│  Oracle Database    │  ← APEX Engine + Your Data
│  - APEX Engine      │
│  - APEX Repository  │
│  - Application Data │
└─────────────────────┘
```

---

### Slide 5: APEX Components
**Key Components**

1. **App Builder**: Visual IDE for creating applications
2. **SQL Workshop**: Database object management and SQL execution
3. **Team Development**: Bug tracking and feature requests
4. **Packaged Apps**: Pre-built applications (install and customize)
5. **Page Designer**: Drag-and-drop interface builder
6. **Shared Components**: Reusable elements (LOVs, templates, etc.)

---

### Slide 6: APEX Request Flow
**How APEX Processes a Page Request**

1. User clicks link → **HTTP Request** sent
2. **ORDS** receives request, routes to database
3. **APEX Engine** reads application metadata
4. Executes **page processing logic**:
   - Validations
   - Computations
   - Processes
   - Dynamic Actions
5. Generates **HTML/JS/CSS**
6. Returns response to **browser**

**Average page render time: 50-200ms**

---

### Slide 7: Development Environment
**Workspace Structure**

- **Workspace**: Isolated development environment
- **Schema**: Database user/schema for tables and data
- **Applications**: Multiple apps per workspace
- **Users**: Developers, administrators, end-users

**Vodacom Setup:**
- VODACOM_DEV (development)
- VODACOM_TEST (QA testing)
- VODACOM_PROD (production)

---

### Slide 8: Installation Steps
**Setting Up APEX**

1. **Download APEX** from oracle.com
2. **Unzip** and run `@apexins` in SQL*Plus
3. **Install ORDS** (Oracle REST Data Services)
4. **Configure ORDS** with database connection
5. **Start ORDS**: `java -jar ords.war standalone`
6. **Access APEX**: `http://localhost:8080/ords`

**Install Time: ~30 minutes**

---

### Slide 9: Vodacom Migration Case Study
**From Access to APEX**

**Before:**
- Microsoft Access database
- Single-user, crashes frequently
- No remote access
- 50,000+ records causing slowdowns

**After:**
- Oracle Database + APEX
- 50+ concurrent users
- Web-based, accessible anywhere
- Mobile-responsive interface
- RESTful APIs for integrations

**Migration Time: 2 weeks**

---

### Slide 10: Development Best Practices
**APEX Development Tips**

1. **Use workspaces** for environment separation (DEV/TEST/PROD)
2. **Version control** with Git (export apps as SQL)
3. **Shared components** for reusability
4. **SQL tuning** - APEX is only as fast as your queries
5. **Security first** - enable session state protection
6. **Test on mobile** - Universal Theme is responsive
7. **Document your code** - use comments and help text

---

### Slide 11: Security Considerations
**Securing APEX Applications**

🔒 **Authentication**: Who can access?
- Database accounts
- LDAP/Active Directory
- OAuth2, SAML, Social Sign-in

🔒 **Authorization**: What can they access?
- Authorization schemes
- Page-level security
- Component-level security

🔒 **Session Management**: Protect user sessions
- Session timeouts
- Session state protection (checksums)
- HTTPS only

---

### Slide 12: Next Steps
**What's Coming in This Course**

📚 **Lesson 2**: Creating Applications  
📚 **Lesson 3**: Managing Pages and Page Designer  
📚 **Lesson 4**: Building Reports and Forms  
📚 **Lesson 5**: Customizing Controls and Navigation  
📚 **Lesson 6**: Security and Performance  
📚 **Lesson 7**: Deploying Applications  

**Hands-on labs for each lesson!**

---

### Slide 13: Questions & Resources
**Need Help?**

**Official Oracle APEX Resources:**
- **Main Site**: [apex.oracle.com](https://apex.oracle.com/)
- **Free Workspace**: [apex.oracle.com/en](https://apex.oracle.com/en/) - Start building immediately
- **Documentation**: [apex.oracle.com/en/learn/documentation](https://apex.oracle.com/en/learn/documentation/)
- **Tutorials**: [apex.oracle.com/en/learn/tutorials](https://apex.oracle.com/en/learn/tutorials/)
- **Sample Apps**: [oracle.github.io/apex](https://oracle.github.io/apex/)

**Hands-On Learning:**
- 🎓 [Spreadsheet Lab](https://apex.oracle.com/go/spreadsheet-lab) - 45 min, Beginner
- 🎓 [Build a Social Media App](https://apex.oracle.com/go/sm-lab) - 1 hour, Beginner  
- 🎓 [Modernizing Oracle Forms](https://apex.oracle.com/go/f2a-lab) - 1 hour

**Community:**
- Forums: [forums.oracle.com/apex](https://forums.oracle.com/apex)
- Stack Overflow: tag `oracle-apex`
- Twitter/X: #OracleAPEX @oracleapex

**Vodacom Support:** dev-support@vodacom.com

---

### Slide 14: Lab Exercise Preview
**Hands-On Practice**

**Lab 1**: Install APEX and access workspace  
**Lab 2**: Explore App Builder and create sample tables  
**Lab 3**: Set up multi-environment (DEV/TEST/PROD) strategy  

**Real-World Project**: Migrate Vodacom Access database to Oracle

**All labs use Vodacom Corp scenario!**

---

### Slide 15: Summary
**Key Takeaways**

✅ Oracle APEX is a low-code platform in Oracle Database  
✅ Three-tier architecture: Browser → ORDS → Database  
✅ Rapid development with declarative programming  
✅ Enterprise-grade security and scalability  
✅ Vodacom migrated from Access to APEX successfully  
✅ Proper environment setup (DEV/TEST/PROD) is critical  

**You're now ready to start building APEX applications!**

---

