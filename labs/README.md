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
│   ├── setup-sample-data.sql     # Complete database setup script
│   ├── lab-01-introduction.md    # Lab 01: Introduction (60 min) ✅
│   ├── lab-02-creating-applications.md  # Lab 02: Creating Apps (90 min) ✅
│   ├── lab-03-pages-and-page-designer.md  # Lab 03: Page Designer (120 min) ✅
│   ├── lab-04-reports-and-forms.md   # Lab 04: Reports & Forms (90 min) ✅
│   ├── lab-05-controls-and-navigation.md  # Lab 05: Controls (90 min) ✅
│   ├── lab-06-security-and-performance.md # Lab 06: Security (120 min) ✅
│   └── lab-07-deploying-applications.md      # Lab 07: Deployment (90 min) ✅
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

---

## 🎯 Lab Exercises Summary

### Lab 01: Introduction and Getting Started (60 minutes)
**Prerequisites:** None  
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

**Database Objects Created:**
- DEPARTMENTS table (4 records)
- EMPLOYEES table (4 records)
- V_EMPLOYEE_DETAILS view
- 3 indexes on EMPLOYEES

---

### Lab 02: Creating Applications (90 minutes)
**Prerequisites:** Completed Lab 01  
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
- Employee Management System (5 pages)
- Client Management (spreadsheet import)
- Project Tracker (custom SQL)
- Sample Database App (blueprint)

**Time Savings Demonstrated:** 99% vs. traditional development

---

### Lab 03: Pages and Page Designer (120 minutes)
**Prerequisites:** Completed Lab 02  
**Objectives:**
- Master three-panel Page Designer interface
- Create Project Dashboard with KPI cards
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
- Project Dashboard with 4 KPIs
- Interactive Grid for project management
- Donut chart for project status
- Bar chart for budget analysis
- 3 Dynamic Actions
- Quick-add modal dialog

---

### Lab 04: Reports and Forms (90 minutes)
**Prerequisites:** Completed Lab 03  
**Objectives:**
- Create advanced Interactive Reports with filtering
- Build Interactive Grids for bulk editing
- Implement master-detail forms
- Add conditional highlighting
- Configure download options (CSV, PDF, Excel)
- Create invoice management system

**Key Skills:**
- Interactive Report customization
- Search and filter regions
- Interactive Grid DML processing
- Master-detail relationships
- Conditional formatting
- Popup LOVs and cascading selects

**Applications Created:**
- Client Analysis Report (page 20)
- Timesheet Entry Grid (page 25)
- Invoice Master-Detail (pages 29-30)
- Complete invoice line items system

---

### Lab 05: Controls and Navigation (90 minutes)
**Prerequisites:** Completed Lab 04  
**Objectives:**
- Configure hierarchical navigation menus
- Implement cascading LOVs (Country → State → City)
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
- Address entry with cascading LOVs
- Team assignment with Shuttle control
- Advanced project search (page 37)
- Breadcrumb trails

---

### Lab 06: Security and Performance (120 minutes)
**Prerequisites:** Completed Lab 05  
**Objectives:**
- Configure authentication and authorization schemes
- Implement row-level security with VPD
- Add audit trail functionality
- Prevent SQL injection and XSS attacks
- Optimize SQL queries and add indexes
- Use APEX Advisor for best practices

**Key Skills:**
- Authorization schemes (Admin, Manager, Employee)
- Session state protection
- Virtual Private Database (VPD) policies
- Input validation and escaping
- Query optimization with EXPLAIN PLAN
- Region caching strategies
- Debug mode usage

**Security Features:**
- Role-based access control
- Row-level security on timesheets
- Audit log with triggers
- SQL injection prevention
- XSS protection
- Password policies

---

### Lab 07: Deploying Applications (90 minutes)
**Prerequisites:** Completed Lab 06  
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

### Setup Script: `setup-sample-data.sql`

**What It Creates:**
- 13 database tables with relationships
- 7 departments
- 50 employees (sample)
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
- [x] Lab 01: Introduction (60 min) ✅ CREATED
- [x] Lab 02: Creating Applications (90 min) ✅ CREATED
- [x] Lab 03: Pages and Page Designer (120 min) ✅ CREATED
- [x] Lab 04: Reports and Forms (90 min) ✅ CREATED
- [x] Lab 05: Controls and Navigation (90 min) ✅ CREATED
- [x] Lab 06: Security and Performance (120 min) ✅ CREATED
- [x] Lab 07: Deploying Applications (90 min) ✅ CREATED

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
- [ ] Sample Data SQL Script ✅ CREATED (13 tables, 100+ records)

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
