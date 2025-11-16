# Assessment 02: Creating Applications

**Duration:** 30 minutes  
**Total Points:** 100 points  
**Passing Score:** 70%

---

## Part A: Multiple Choice Questions (40 points - 2 points each)

**1. Which method is the FASTEST way to create an APEX application from existing Excel data?**
- [ ] A) Manual table creation then wizard
- [ ] B) Create from File (spreadsheet import)
- [ ] C) SQL query creation
- [ ] D) Blueprint installation

**2. When using the Create Application Wizard, which page type displays data in a grid with sorting and filtering?**
- [ ] A) Form
- [ ] B) Chart
- [ ] C) Interactive Report
- [ ] D) Calendar

**3. The "Include Form" checkbox when creating an Interactive Report:**
- [ ] A) Creates a second page for editing records
- [ ] B) Adds a search form to the report
- [ ] C) Enables form validation
- [ ] D) Requires additional licensing

**4. Application blueprints in APEX are:**
- [ ] A) Database backup files
- [ ] B) Pre-built application templates
- [ ] C) Security configurations
- [ ] D) SQL query builders

**5. Which Universal Theme number is the default for new APEX 23.1 applications?**
- [ ] A) Universal Theme 40
- [ ] B) Universal Theme 41
- [ ] C) Universal Theme 42
- [ ] D) Universal Theme 50

**6. When importing a spreadsheet, APEX automatically:**
- [ ] A) Detects column data types
- [ ] B) Creates the database table
- [ ] C) Generates a basic application
- [ ] D) All of the above

**7. A Dashboard page typically contains:**
- [ ] A) Only text content
- [ ] B) Charts, KPIs, and summary information
- [ ] C) Only forms for data entry
- [ ] D) External website links

**8. The Page Designer interface has how many main panels?**
- [ ] A) 2
- [ ] B) 3
- [ ] C) 4
- [ ] D) 5

**9. When creating an application from SQL query, you can:**
- [ ] A) Only use simple SELECT statements
- [ ] B) Include calculated columns and complex joins
- [ ] C) Not use WHERE clauses
- [ ] D) Only query one table

**10. What happens when you click "Create Application" in the wizard?**
- [ ] A) Only the database is updated
- [ ] B) APEX generates all pages, navigation, and security
- [ ] C) You must manually code each page
- [ ] D) The application is immediately published

**11. Shared Components in an APEX application include:**
- [ ] A) Navigation menus
- [ ] B) Authentication schemes
- [ ] C) Lists and breadcrumbs
- [ ] D) All of the above

**12. A Form page is used to:**
- [ ] A) Display multiple records in a grid
- [ ] B) Edit a single record
- [ ] C) Show charts and graphs
- [ ] D) Import data

**13. The Application ID is:**
- [ ] A) Always the same for all applications
- [ ] B) A unique number assigned to each application
- [ ] C) The same as the page number
- [ ] D) Optional in APEX

**14. Which file formats can be imported with "Create from File"?**
- [ ] A) Only .xlsx
- [ ] B) Only .csv
- [ ] C) .xlsx, .csv, .xml, .json
- [ ] D) Only text files

**15. Calendar pages in APEX require:**
- [ ] A) A start date column
- [ ] B) A display column for event names
- [ ] C) End date column (optional)
- [ ] D) All of the above

**16. The Gallery in APEX App Builder provides:**
- [ ] A) Image storage
- [ ] B) Sample applications and blueprints
- [ ] C) Database backup tools
- [ ] D) User management

**17. When you "Run Application", APEX:**
- [ ] A) Compiles the code permanently
- [ ] B) Generates runtime pages and requires login
- [ ] C) Deletes test data
- [ ] D) Creates database backups

**18. Application-level settings are configured in:**
- [ ] A) Individual pages only
- [ ] B) Shared Components > Edit Application Definition
- [ ] C) SQL Workshop
- [ ] D) Object Browser

**19. In TechNova's case, creating the Employee Management System with APEX vs. traditional coding saved approximately:**
- [ ] A) 50% time
- [ ] B) 75% time
- [ ] C) 90% time
- [ ] D) 99% time

**20. Chart pages visualize data using:**
- [ ] A) Only bar charts
- [ ] B) Various chart types (bar, pie, line, etc.)
- [ ] C) Only tables
- [ ] D) Text reports

---

## Part B: True/False Questions (20 points - 2 points each)

**21. You must be a SQL expert to create APEX applications using wizards.**
- [ ] True
- [ ] False

**22. A single APEX application can contain multiple page types (reports, forms, charts).**
- [ ] True
- [ ] False

**23. Once created, an APEX application cannot be modified.**
- [ ] True
- [ ] False

**24. The Create Application Wizard automatically generates navigation menus.**
- [ ] True
- [ ] False

**25. Spreadsheet import creates both the table and a complete application.**
- [ ] True
- [ ] False

**26. Application blueprints can be customized after installation.**
- [ ] True
- [ ] False

**27. Every page in an APEX application must be connected to a database table.**
- [ ] True
- [ ] False

**28. You can preview an application blueprint before installing it.**
- [ ] True
- [ ] False

**29. Custom SQL queries in reports can include JOINs and calculated columns.**
- [ ] True
- [ ] False

**30. APEX applications only work on desktop computers, not mobile devices.**
- [ ] True
- [ ] False

---

## Part C: Matching Questions (10 points - 1 point each)

**Match each page type with its primary purpose:**

**Page Types:**
31. Interactive Report  
32. Form  
33. Dashboard  
34. Calendar  
35. Chart  
36. Classic Report  
37. Blank Page  
38. Login Page  
39. Master Detail  
40. Wizard  

**Purposes:**
A. Display and edit a single record  
B. Show events on a calendar grid  
C. Display high-level KPIs and summaries  
D. Sortable, filterable data grid  
E. Visualize data graphically  
F. Simple read-only data display  
G. Custom content without pre-built structure  
H. User authentication  
I. Related parent-child records on one page  
J. Multi-step data entry process  

**Your Answers:**
31. ___  32. ___  33. ___  34. ___  35. ___  
36. ___  37. ___  38. ___  39. ___  40. ___

---

## Part D: Short Answer Questions (15 points - 5 points each)

**41. Explain the difference between creating an application using the wizard versus importing from a spreadsheet. When would you use each method?**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**42. What are three key advantages of using application blueprints in APEX? Provide specific examples.**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**43. Describe how calculated columns in SQL queries provide business value. Give an example from the Project Tracker application created in the lab.**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

---

## Part E: Practical Exercise (15 points)

**44. Application Design Scenario**

You are tasked with creating an Invoice Management application for TechNova. Design an application structure by specifying:

**Requirements:**
- Track invoices (invoice number, client, date, amount, status)
- Track invoice line items (description, quantity, price)
- View dashboard with key metrics
- Search and filter invoices
- Edit invoice details
- View invoice history by client

**Your Design (Complete the table):**

| Page # | Page Name | Page Type | Purpose | Data Source(s) |
|--------|-----------|-----------|---------|----------------|
| 1 | __________ | Dashboard | _____________ | ______________ |
| 2 | __________ | ___________ | List all invoices | INVOICES table |
| 3 | __________ | Form | _____________ | ______________ |
| 4 | __________ | ___________ | _____________ | INVOICE_ITEMS |
| 5 | __________ | Chart | Show invoice status | ______________ |

**Navigation Structure:**
Draw or describe the navigation menu structure:
```
Your navigation menu:




```

**Key calculated columns or business logic:**
```
List 2-3 calculated columns you would include:
1. _____________________________________________________________________
2. _____________________________________________________________________
3. _____________________________________________________________________
```

---

## Answer Key (For Instructor Use Only)

### Part A: Multiple Choice
1. B  2. C  3. A  4. B  5. C  6. D  7. B  8. B  9. B  10. B
11. D  12. B  13. B  14. C  15. D  16. B  17. B  18. B  19. D  20. B

### Part B: True/False
21. False  22. True  23. False  24. True  25. True
26. True  27. False  28. True  29. True  30. False

### Part C: Matching
31. D  32. A  33. C  34. B  35. E
36. F  37. G  38. H  39. I  40. J

### Part D: Short Answer (Sample Answers)

**41. Wizard vs. Spreadsheet:**
- **Wizard**: Used when database tables already exist. Provides full control over page types, layouts, and customization. Best for complex applications with existing schema.
- **Spreadsheet**: Fastest method when data exists in Excel/CSV. APEX creates table automatically and generates basic application. Best for quick prototypes or simple data management apps.
- **When to use wizard**: Existing database, complex requirements, need custom page types
- **When to use spreadsheet**: Quick demos, importing existing data, simple CRUD operations

**42. Blueprint advantages:**
1. **Rapid prototyping**: Demonstrate concepts to stakeholders in minutes, not days
2. **Learning tool**: Study well-structured code and best practices from experts
3. **Starting point**: Customize pre-built apps instead of building from scratch, saving 70-80% development time
Examples: Sample Database App for learning, Starter Apps for quick MVPs, Demo Apps for presenting capabilities

**43. Calculated columns business value:**
Calculated columns transform raw data into actionable insights without storing redundant information.
**Examples from Project Tracker:**
- **Timeline Status** (Overdue/Due Soon/On Track): Instantly identifies at-risk projects
- **Budget Used %**: Shows financial health, prevents cost overruns
- **Remaining Budget**: Helps project managers plan resources
- **Duration Days**: Enables project timeline analysis
**Value**: Provides instant business intelligence, eliminates manual calculations, supports decision-making

### Part E: Practical Exercise (Sample Solution)

**Page Structure:**

| Page # | Page Name | Page Type | Purpose | Data Source |
|--------|-----------|-----------|---------|-------------|
| 1 | Dashboard | Dashboard | Show KPIs, revenue, overdue | INVOICES (aggregated) |
| 2 | Invoice List | Interactive Report | List all invoices | INVOICES |
| 3 | Invoice Details | Form | Edit invoice header | INVOICES |
| 4 | Line Items | Interactive Grid | Manage invoice items | INVOICE_ITEMS |
| 5 | Revenue Chart | Chart | Show revenue by status | INVOICES (grouped) |

**Navigation:**
```
- Home (Dashboard)
- Invoices
  - Invoice List
  - Create New
- Reports
  - Revenue Chart
  - Overdue Invoices
- Administration
  - Clients
  - Settings
```

**Calculated Columns:**
1. `Days Overdue = SYSDATE - due_date (where status != 'Paid')`
2. `Total Amount = subtotal + tax_amount`
3. `Payment Status = CASE WHEN due_date < SYSDATE AND status != 'Paid' THEN 'Overdue' ELSE status END`

---

## Grading Rubric

| Section | Points | Criteria |
|---------|--------|----------|
| Part A (MC) | 40 | 2 points per correct answer |
| Part B (T/F) | 20 | 2 points per correct answer |
| Part C (Matching) | 10 | 1 point per correct match |
| Part D (Short Answer) | 15 | 5 points each - full marks for comprehensive answers with examples |
| Part E (Practical) | 15 | 3 pts for each complete page design, 3 pts for navigation structure, 3 pts for calculated columns |
| **TOTAL** | **100** | Pass = 70+ points |

---

**Student Name:** ______________________________  
**Date:** ______________  
**Score:** ______ / 100  
**Pass/Fail:** __________

**Instructor Notes:**
