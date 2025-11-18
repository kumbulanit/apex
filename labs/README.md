# Oracle APEX Training Course - Labs, Assessments & Solutions

## Overview

This directory contains all hands-on lab exercises, assessments, and solutions for the **Vodacom Oracle APEX training course**. 

**🎯 Course Goal:** Build a complete **Enterprise Call Center Management Application** for Vodacom.

Throughout these 7 labs, you will progressively build components of a production-ready call center system that manages:
- **45 million customers** across South Africa
- **5,000+ call center agents** handling customer inquiries
- **Real-time network operations** monitoring
- **Package activations** and service management
- **Customer 360° view** with complete service history
- **Security and compliance** (POPIA requirements)
- **Multi-region deployment** across Vodacom's infrastructure

The materials are designed for beginner-level students with no prior APEX experience.

---

## 📁 Directory Structure

```
/apex/
├── labs/                          # Hands-on lab exercises
│   ├── vodacom-simple-setup.sql  # 🎯 PRIMARY DATABASE SETUP (USE THIS!)
│   ├── drop-vodacom-simple.sql   # Drop script (if errors occur)
│   ├── lab-01-introduction-vodacom.md      # Lab 01: Introduction (60 min) ✅
│   ├── lab-02-creating-applications-vodacom.md  # Lab 02: Creating Apps (90 min) ✅
│   ├── lab-03-pages-and-page-designer-vodacom.md  # Lab 03: Page Designer (120 min) ✅
│   ├── lab-04-reports-and-forms-vodacom.md   # Lab 04: Reports & Forms (90 min) ✅
│   ├── lab-05-controls-and-navigation-vodacom.md  # Lab 05: Controls (90 min) ✅
│   ├── lab-06-security-and-performance-vodacom.md # Lab 06: Security (120 min) ✅
│   └── lab-07-deploying-applications-vodacom.md   # Lab 07: Deployment (90 min) ✅
├── assessments/                   # Knowledge assessments
│   ├── assessment-01.md          # Assessment 01 (100 points)
│   ├── assessment-02.md          # Assessment 02 (100 points)
│   ├── assessment-03.md          # Assessment 03 (TO BE CREATED)
│   ├── assessment-04.md          # Assessment 04 (TO BE CREATED)
│   ├── assessment-05.md          # Assessment 05 (TO BE CREATED)
│   ├── assessment-06.md          # Assessment 06 (TO BE CREATED)
│   └── assessment-07.md          # Assessment 07 (TO BE CREATED)
├── solutions/                     # Complete solutions and explanations
│   ├── lab-01-solutions.md       # Lab 01 Solutions
│   ├── lab-02-solutions.md       # Lab 02 Solutions (TO BE CREATED)
│   ├── lab-03-solutions.md       # Lab 03 Solutions (TO BE CREATED)
│   ├── lab-04-solutions.md       # Lab 04 Solutions (TO BE CREATED)
│   ├── lab-05-solutions.md       # Lab 05 Solutions (TO BE CREATED)
│   ├── lab-06-solutions.md       # Lab 06 Solutions (TO BE CREATED)
│   └── lab-07-solutions.md       # Lab 07 Solutions (TO BE CREATED)
└── slides/                        # PowerPoint slide content (TO BE CREATED)
```

**📌 Note:** Lab files ending with `-vodacom.md` use the Vodacom Simple database (vodacom-simple-setup.sql). 
Alternative versions without `-vodacom` suffix use the TechNova database and are provided for reference only.

---

## 🎯 Lab Exercises Summary

### Lab 01: Introduction and Getting Started (60 minutes)

**File:** `lab-01-introduction-vodacom.md`  
**Prerequisites:** None  
**Database:** Vodacom Simple (vodacom-simple-setup.sql)

**Objectives:**
- Navigate APEX development environment
- Use SQL Workshop tools
- Create database tables with constraints
- Insert sample data
- Create views for reporting

**Key Skills:**
- Workspace navigation
- SQL DDL (CREATE TABLE, CREATE VIEW)
- Primary keys and foreign keys
- Referential integrity
- Basic PL/SQL

**Database Objects Used:**
- VODACOM_CUSTOMERS table
- VODACOM_PACKAGES table
- VODACOM_SUBSCRIPTIONS table

---

### Lab 02: Creating Applications (90 minutes)

**File:** `lab-02-creating-applications-vodacom.md`  
**Prerequisites:** Completed Lab 01  
**Database:** Vodacom Simple (vodacom-simple-setup.sql)

**Objectives:**
- Create applications using the wizard
- Import data from spreadsheets
- Build apps with custom SQL queries
- Use application blueprints
- Customize dashboards and reports

**Key Skills:**
- Application creation methods (4 approaches)
- Page types (Dashboard, Interactive Report, Form, Chart, Calendar)
- Navigation menu configuration
- Conditional formatting
- Blueprint customization

**Applications Created:**
- Customer Management Portal (vodacom_customers)
- Package Management (vodacom_packages)
- Subscription Tracker (vodacom_subscriptions)
- Support Ticket System (vodacom_support_tickets)

**Time Savings Demonstrated:** 99% vs. traditional development

---

### Lab 03: Pages and Page Designer (120 minutes)

**File:** `lab-03-pages-and-page-designer-vodacom.md`  
**Prerequisites:** Completed Lab 02  
**Database:** Vodacom Simple (vodacom-simple-setup.sql)

**Objectives:**
- Master three-panel Page Designer interface
- Create Contract Dashboard with KPI cards
- Build Interactive Grid with inline editing
- Add chart regions for data visualization
- Implement Dynamic Actions for interactivity
- Create modal dialog pages

**Key Skills:**
- Page Designer navigation
- Region types (Static, Interactive Grid, Chart)
- Computations and aggregations
- Dynamic Actions (auto-refresh, confirmations)
- CSS styling for custom display
- Modal dialog creation

**Components Built:**
- Contract Dashboard with KPIs
- Interactive Grid for customer contracts
- Donut chart for contract status
- Bar chart for revenue analysis
- 3 Dynamic Actions
- Quick-add modal dialog

---

### Lab 04: Reports and Forms (90 minutes)

**File:** `lab-04-reports-and-forms-vodacom.md`  
**Prerequisites:** Completed Lab 03  
**Database:** Vodacom Simple (vodacom-simple-setup.sql)

**Objectives:**
- Create advanced Interactive Reports with filtering
- Build Interactive Grids for bulk editing
- Implement master-detail forms
- Add conditional highlighting
- Configure download options (CSV, PDF, Excel)
- Create transaction management system

**Key Skills:**
- Interactive Report customization
- Search and filter regions
- Interactive Grid DML processing
- Master-detail relationships
- Conditional formatting
- Popup LOVs and cascading selects

**Applications Created:**
- Customer Analysis Report (vodacom_customers)
- Transaction Entry Grid (vodacom_transactions)
- Support Ticket Master-Detail (vodacom_support_tickets)
- Complete transaction management system

---

### Lab 05: Controls and Navigation (90 minutes)

**File:** `lab-05-controls-and-navigation-vodacom.md`  
**Prerequisites:** Completed Lab 04  
**Database:** Vodacom Simple (vodacom-simple-setup.sql)

**Objectives:**
- Configure hierarchical navigation menus
- Implement cascading LOVs (Package → Contract Type)
- Use different item types effectively
- Build advanced search interfaces
- Create breadcrumb navigation
- Implement dependent selections

**Key Skills:**
- Navigation menu hierarchy
- Cascading LOV configuration
- Item types (Select, Shuttle, Checkbox, Radio, Switch)
- Popup LOVs with search
- Multi-select interfaces
- Dynamic item behavior

**Features Implemented:**
- Multi-level navigation menu
- Package selection with cascading LOVs
- Customer assignment interface
- Advanced contract search
- Breadcrumb trails

---

### Lab 06: Security and Performance (120 minutes)

**File:** `lab-06-security-and-performance-vodacom.md`  
**Prerequisites:** Completed Lab 05  
**Database:** Vodacom Simple (vodacom-simple-setup.sql)

**Objectives:**
- Configure authentication and authorization schemes
- Implement row-level security with VPD
- Add audit trail functionality
- Prevent SQL injection and XSS attacks
- Optimize SQL queries and add indexes
- Use APEX Advisor for best practices

**Key Skills:**
- Authorization schemes (Admin, Manager, Agent)
- Session state protection
- Virtual Private Database (VPD) policies
- Input validation and escaping
- Query optimization with EXPLAIN PLAN
- Region caching strategies
- Debug mode usage

**Security Features:**
- Role-based access control
- Row-level security on transactions
- Audit log with triggers
- SQL injection prevention
- XSS protection
- Password policies

---

### Lab 07: Deploying Applications (90 minutes)

**File:** `lab-07-deploying-applications-vodacom.md`  
**Prerequisites:** Completed Lab 06  
**Database:** Vodacom Simple (vodacom-simple-setup.sql)

**Objectives:**
- Export and import APEX applications
- Manage supporting objects and data
- Set up multiple environments (DEV, TEST, PROD)
- Use SQLcl for automated deployment
- Integrate with Git version control
- Create CI/CD pipelines with GitHub Actions

**Key Skills:**
- Application export/import
- Environment-specific configuration
- Build options for feature toggling
- SQLcl automation
- Git branching strategies
- CI/CD pipeline creation
- Rollback procedures

**Deployment Infrastructure:**
- Environment configuration table
- Automated deployment scripts
- Git repository with branches
- GitHub Actions workflow
- Deployment logging
- Rollback procedures

---

## 📝 Assessment Summary

Each assessment includes:
- **Multiple Choice** (40 points) - 20 questions on core concepts
- **True/False** (20 points) - 10 questions on key principles
- **Short Answer** (20 points) - 4 questions requiring explanation
- **Practical Exercises** (20 points) - 2 hands-on coding/design tasks

**Total Points:** 100 per assessment  
**Passing Score:** 70%  
**Time Limit:** 30 minutes per assessment

### Assessment 01: Introduction and Getting Started
- APEX architecture and components
- SQL DDL and DML
- Database objects (tables, views, indexes)
- Constraints and relationships
- PL/SQL basics

### Assessment 02: Creating Applications
- Application creation methods
- Page types and their purposes
- Wizards vs. manual creation
- Blueprints and Gallery
- Application structure

### Assessments 03-07 *(TO BE CREATED)*
- Follow same format as Assessment 01-02
- Aligned with lesson objectives
- Include practical scenarios
- Provide complete answer keys

---

## ✅ Solution Guides

### Lab 01 Solutions
**Contents:**
- Complete SQL scripts with explanations
- Step-by-step walkthrough
- Column-by-column table analysis
- Verification queries
- Troubleshooting common issues
- Challenge exercise solutions
- Key concept reinforcement

**Features:**
- Expected output for all queries
- Alternative solutions demonstrated
- Best practice explanations
- Performance considerations
- Real-world application notes

### Solutions 02-07 *(TO BE CREATED)*
- Same comprehensive format
- Screenshot descriptions
- Common mistakes addressed
- Performance tips included

---

## 🗄️ Sample Database

### 🎯 RECOMMENDED SETUP: `vodacom-simple-setup.sql`

**✅ QUICK START - USE THIS SCRIPT FOR ALL LABS!**

This is the complete Vodacom enterprise database for all training exercises. It contains ALL tables from `setup-sample-data-vodacom.sql` in a simplified format with 10 records per table.

**What It Creates:**
- **13 Core Enterprise Tables:**
  1. VODACOM_DEPARTMENTS (HR, Finance, Sales, IT, etc.)
  2. VODACOM_EMPLOYEES (Agents, managers, technicians)
  3. VODACOM_CUSTOMERS (Full customer profiles with provinces, account types)
  4. VODACOM_MOBILE_NUMBERS (SIM cards linked to customers)
  5. VODACOM_PACKAGES (Prepaid, contract, data plans)
  6. VODACOM_TRANSACTIONS (Purchases with package and employee references)
  7. VODACOM_NETWORK_TOWERS (Cell towers across SA provinces)
  8. VODACOM_NETWORK_ISSUES (Network outages and maintenance)
  9. VODACOM_CUSTOMER_SUPPORT (Support tickets with agent assignments)
  10. VODACOM_SALES (Device sales with commissions)
  11. VODACOM_VODAPAY_ACCOUNTS (Mobile wallet accounts)
  12. VODACOM_INVOICES (Monthly billing with tax calculations)
  13. VODACOM_INVOICE_ITEMS (Line items for invoices)

- **7 Contract Management Tables:**
  14. VODACOM_SUBSCRIPTIONS (Active customer subscriptions)
  15. VODACOM_SUPPORT_TICKETS (Legacy support system)
  16. VODACOM_CONTRACT_TYPES (12-36 month contract options)
  17. VODACOM_CUSTOMER_CONTRACTS (Customer contracts with devices)
  18. VODACOM_CONTRACT_RENEWALS (Upgrade history)
  19. VODACOM_CONTRACT_PENALTIES (Early termination fees, late payments)
  20. VODACOM_CONTRACT_BENEFITS (Loyalty rewards, perks)

**Key Features:**
- **20 total tables** with complete referential integrity
- **10 records per table** (200 total records) - perfect for training
- **Real South African data** (provinces, ID numbers, mobile formats, R currency)
- **Foreign key relationships** properly ordered (parent tables before children)
- **Enterprise features:** Departments, employees, network infrastructure, invoicing, VodaPay
- **Ready for all lab exercises** - Labs 1-7 fully compatible

**Usage:**
1. Log into APEX workspace
2. SQL Workshop > SQL Scripts
3. Upload `vodacom-simple-setup.sql`
4. Click Run (execution time: ~30 seconds)
5. Verify completion (should show "VODACOM DATABASE SETUP COMPLETE! TOTAL: 20 TABLES WITH 200 SAMPLE RECORDS")

**Database Size:**
- **Tables:** 20 (13 core + 7 contract)
- **Records:** 200 (10 per table)
- **Sequences:** 20 (one per table)
- **Foreign Keys:** 30+ relationships
- **Ready for immediate use in all labs**

**Troubleshooting:**
If you get errors (table already exists, constraint violations, etc.):
1. Upload and run `drop-vodacom-simple.sql` first
2. Then run `vodacom-simple-setup.sql` again
3. All errors should be resolved
4. Script includes DROP TABLE statements at the beginning

---

### Alternative Reference: `setup-sample-data-vodacom.sql`

**⚠️ REFERENCE ONLY - Not needed for labs**

This is the comprehensive Vodacom database with 30+ records per table. It contains the same schema as `vodacom-simple-setup.sql` but with more data for production-like demonstrations.

**What It Creates:**
- Same 20 tables as vodacom-simple-setup.sql
- 30+ records per table (vs. 10 in simplified version)
- More employees, customers, transactions
- Greater geographic coverage
- More complex business scenarios

**When to Use:**
- Production demonstrations requiring larger datasets
- Performance testing with more records
- Advanced instructor demonstrations
- **NOT required for lab exercises** (use vodacom-simple-setup.sql instead)

**File Location:** `/Users/kumbulani/Desktop/apex/labs/setup-sample-data-vodacom.sql`

---

### Legacy Reference: `setup-sample-data.sql`

**⚠️ ADVANCED OPTION - Only if instructed**

This is the comprehensive TechNova Corp database (used in some lessons).

**What It Creates:**
- 13 database tables with relationships
- 7 departments
- 50 employees
- 20 clients
- 30 projects with tasks
- Timesheet records
- Expense tracking
- Invoice system
- Audit log table

**Key Features:**
- Complete referential integrity
- Identity columns for primary keys
- Check constraints for data validation
- Indexes for performance
- Sample data for realistic scenarios
- Views for reporting
- Comments on all objects

**Usage:**
1. Log into APEX workspace
2. SQL Workshop > SQL Scripts
3. Upload `setup-sample-data.sql`
4. Click Run
5. Verify completion (should show "Setup Complete!")

**Database Size:**
- Tables: 13
- Indexes: 20+
- Views: 2
- Constraints: 30+
- Sample Records: 100+ across all tables

---

## 📚 Using These Materials

### For Instructors:

**Before Class:**
1. Run `setup-sample-data.sql` in demo workspace
2. Review lab exercises and time allocations
3. Print assessment answer keys
4. Test all exercises in your APEX environment
5. Prepare workspace logins for students

**During Class:**
1. Share screen for demonstrations
2. Give students 5-10 minutes for each exercise section
3. Walk through solutions after attempts
4. Use assessment after each lesson
5. Provide hints before showing complete solutions

**Time Allocations:**
- Lesson delivery: 2 hours
- Lab exercise: 60-90 minutes
- Assessment: 30 minutes
- Review: 30 minutes
- **Total per lesson:** 3-4 hours

### For Students:

**How to Use Labs:**
1. Read the Lab Scenario first - understand business context
2. Attempt exercises independently
3. Verify results with Expected Results sections
4. Troubleshoot using Common Issues guides
5. Try Challenge Exercises for extra practice
6. Only check Solutions after attempting
7. Review Key Takeaways at end

**How to Use Assessments:**
1. Complete after finishing the corresponding lesson
2. Set 30-minute timer
3. Attempt all questions without notes
4. Check answers with instructor
5. Review incorrect answers
6. Passing score: 70% (70 points)

**Study Tips:**
- Complete labs in sequence - each builds on previous
- Run all SQL queries yourself - don't just read
- Experiment with variations
- Break complex tasks into smaller steps
- Ask questions when stuck

---

## 🎓 Learning Objectives by Lab

| Lab | Primary Skills | Secondary Skills |
|-----|---------------|------------------|
| 01 | SQL DDL, Database Objects | Workspace navigation, PL/SQL basics |
| 02 | Application creation, Wizards | Page types, Navigation, Blueprints |
| 03 | Page Designer, Components | Rendering tree, Dynamic Actions |
| 04 | Reports, Forms, Grids | Master-detail, Validations |
| 05 | Navigation, LOVs, Controls | Cascading dropdowns, User experience |
| 06 | Security, Authentication | Row-level security, Performance tuning |
| 07 | Deployment, CI/CD, Git | Export/import, Environment management |

---

## 📊 Progress Tracking

### Completion Checklist

**Labs:**
- [x] Lab 01: Introduction (60 min) ✅ CREATED - `lab-01-introduction-vodacom.md`
- [x] Lab 02: Creating Applications (90 min) ✅ CREATED - `lab-02-creating-applications-vodacom.md`
- [x] Lab 03: Pages and Page Designer (120 min) ✅ CREATED - `lab-03-pages-and-page-designer-vodacom.md`
- [x] Lab 04: Reports and Forms (90 min) ✅ CREATED - `lab-04-reports-and-forms-vodacom.md`
- [x] Lab 05: Controls and Navigation (90 min) ✅ CREATED - `lab-05-controls-and-navigation-vodacom.md`
- [x] Lab 06: Security and Performance (120 min) ✅ CREATED - `lab-06-security-and-performance-vodacom.md`
- [x] Lab 07: Deploying Applications (90 min) ✅ CREATED - `lab-07-deploying-applications-vodacom.md`

**Assessments:**
- [ ] Assessment 01 (30 min) ✅ CREATED
- [ ] Assessment 02 (30 min) ✅ CREATED
- [ ] Assessment 03 (30 min)
- [ ] Assessment 04 (30 min)
- [ ] Assessment 05 (30 min)
- [ ] Assessment 06 (30 min)
- [ ] Assessment 07 (30 min)

**Solutions:**
- [ ] Lab 01 Solutions ✅ CREATED
- [ ] Lab 02 Solutions
- [ ] Lab 03 Solutions
- [ ] Lab 04 Solutions
- [ ] Lab 05 Solutions
- [ ] Lab 06 Solutions
- [ ] Lab 07 Solutions

**Database:**
- [x] Vodacom Simple Setup ✅ UPDATED (vodacom-simple-setup.sql - 20 tables, 200 records)
- [x] Vodacom Drop Script ✅ CREATED (drop-vodacom-simple.sql)
- [ ] Vodacom Full Data ✅ REFERENCE ONLY (setup-sample-data-vodacom.sql - 20 tables, 600+ records)
- [ ] TechNova Sample Data ✅ LEGACY REFERENCE (setup-sample-data.sql - 13 tables, 100+ records)

**Total Progress:** 12/24 items complete (50%) - **ALL LABS COMPLETE!**

---

## 🎉 Milestone Achievement

**ALL 7 LAB EXERCISES NOW COMPLETE!**

Each lab includes:
- ✅ Detailed step-by-step instructions
- ✅ Business scenario context (TechNova Corp)
- ✅ Learning objectives and key skills
- ✅ SQL code examples with explanations
- ✅ Challenge exercises for advanced learners
- ✅ Verification checklists
- ✅ Troubleshooting guidance
- ✅ Key takeaways section

**Total Lab Content:**
- **7 comprehensive lab files** (3,500+ lines total)
- **90-120 minutes** per lab
- **10-12 hours** of hands-on exercises
- **Progressive difficulty** from beginner to advanced
- **Real-world scenarios** throughout

---

## 🔧 Technical Requirements

**APEX Version:** 23.1 or higher  
**Database:** Oracle 19c or higher  
**Browser:** Chrome, Firefox, or Edge (latest versions)  
**Screen Resolution:** 1280x720 minimum (1920x1080 recommended)  
**Internet:** Required for apex.oracle.com (or local APEX installation)

**Student Prerequisites:**
- Basic understanding of databases
- Familiarity with SQL SELECT statements
- Web browser proficiency
- No APEX experience required

---

## 📞 Support and Resources

**During Training:**
- Instructor assistance during lab time
- Peer collaboration encouraged
- Reference lesson materials
- Use APEX built-in help (? icon)

**After Training:**
- Oracle APEX Documentation: https://docs.oracle.com/en/database/oracle/apex/
- APEX Community Forum: https://community.oracle.com/apex
- TechNova Corp internal wiki (fictional)

**Common Resources:**
- SQL Quick Reference in each lab
- Keyboard shortcuts cheat sheet
- APEX best practices guide

---

## 📄 License and Usage

**For TechNova Corp Internal Training Use**

These materials are designed for the Oracle APEX training course delivered to TechNova Corp. Instructors may modify content to suit specific class needs. Students may use materials for personal learning.

---

## 📝 Feedback and Updates

**Version:** 2.0 (November 2025)  
**Last Updated:** November 9, 2025  
**Status:** ✅ **ALL 7 LABS COMPLETE!** Assessments 1-2 and Solutions 1 completed. Assessments 3-7 and Solutions 2-7 remain in development.

**Recent Completion:**
- ✅ Lab 03: Pages and Page Designer (617 lines) - COMPLETE
- ✅ Lab 04: Reports and Forms (600+ lines) - COMPLETE
- ✅ Lab 05: Controls and Navigation (650+ lines) - COMPLETE
- ✅ Lab 06: Security and Performance (700+ lines) - COMPLETE
- ✅ Lab 07: Deploying Applications (650+ lines) - COMPLETE

**Remaining Work:**
- Assessments 03-07 (5 assessments needed)
- Solutions 02-07 (6 solution guides needed)
- PowerPoint slide decks
- Video script outlines

**Estimated Time to Complete:**
- Assessments 03-07: ~5-6 hours
- Solutions 02-07: ~12-15 hours
- Slide decks: ~8-10 hours
- **Total: 25-31 hours**

**Submit Feedback:**
Contact course developer or training coordinator with suggestions for improvement.

---

**Course Developer Notes:**

*Current Status (Nov 9, 2025):*
- ✅ **ALL 7 LABS COMPLETE!** (Lab 01-07)
- ✅ Comprehensive database setup script created (13 tables, complete schema)
- ✅ Lab 01 completed with detailed exercises and troubleshooting
- ✅ Lab 02 completed with 4 application creation methods
- ✅ Lab 03 completed with Page Designer mastery (617 lines)
- ✅ Lab 04 completed with Reports and Forms (600+ lines)
- ✅ Lab 05 completed with Controls and Navigation (650+ lines)
- ✅ Lab 06 completed with Security and Performance (700+ lines)
- ✅ Lab 07 completed with Deployment and CI/CD (650+ lines)
- ✅ Assessment 01 completed with answer key
- ✅ Assessment 02 completed with answer key
- ✅ Lab 01 Solutions completed with explanations

*Estimated Time to Complete Remaining Materials:*
- ~~Labs 03-07: ~15-20 hours~~ ✅ **COMPLETE!**
- Assessments 03-07: ~5-6 hours
- Solutions 02-07: ~12-15 hours
- Slide decks: ~8-10 hours
- **Total Remaining: 25-31 hours**

*Priority Sequence:*
1. ~~Complete Labs 03-07 (most critical for hands-on learning)~~ ✅ **DONE!**
2. Create Assessments 03-07 (needed for evaluation)
3. Finish Solutions 02-07 (support for students)
4. Develop slide decks (instructor presentations)

---

**End of README**
