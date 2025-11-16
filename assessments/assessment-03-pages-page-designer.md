# Assessment 03: Pages and Page Designer

**Duration:** 45 minutes  
**Total Points:** 100 points  
**Passing Score:** 70%  
**Prerequisites:** Completed Lab 03 (Vodacom Customer Portal)

---

## Part A: Multiple Choice Questions (40 points - 2 points each)

**1. The Page Designer interface in APEX 23.1 is divided into how many main panes?**
- [ ] A) 2 panes
- [ ] B) 3 panes
- [ ] C) 4 panes
- [ ] D) 5 panes

**2. Which Page Designer pane displays the visual page structure?**
- [ ] A) Left Pane (Rendering Tree)
- [ ] B) Central Pane (Layout)
- [ ] C) Right Pane (Properties)
- [ ] D) Gallery

**3. What is the fastest way to add a new region to a page?**
- [ ] A) Write SQL code manually
- [ ] B) Right-click on the Rendering tree and select "Create Region"
- [ ] C) Restart APEX
- [ ] D) Import from another application

**4. A Classic Report in APEX:**
- [ ] A) Cannot be customized
- [ ] B) Is read-only with fixed layout
- [ ] C) Requires JavaScript coding
- [ ] D) Only works on mobile devices

**5. An Interactive Report allows end users to:**
- [ ] A) Edit the database directly
- [ ] B) Customize filtering, sorting, and column display
- [ ] C) Delete pages
- [ ] D) Modify other users' data

**6. Which region type would you use to display a single record for editing?**
- [ ] A) Interactive Report
- [ ] B) Form
- [ ] C) Chart
- [ ] D) List

**7. Page items (fields) are identified by:**
- [ ] A) Random numbers
- [ ] B) P[PAGE_NUMBER]_[ITEM_NAME] format
- [ ] C) Only letters
- [ ] D) User-defined colors

**8. Conditional display in APEX allows you to:**
- [ ] A) Show/hide regions based on criteria
- [ ] B) Delete data automatically
- [ ] C) Change database structure
- [ ] D) Create new tables

**9. A page process typically runs:**
- [ ] A) Only when the page loads
- [ ] B) When a button is clicked or page submits
- [ ] C) Every second automatically
- [ ] D) Never

**10. What does SQL Query Source mean for a region?**
- [ ] A) The region cannot display data
- [ ] B) Data comes from a custom SELECT statement
- [ ] C) Only stored procedures allowed
- [ ] D) No database access

**11. The Master-Detail relationship in APEX shows:**
- [ ] A) Unrelated data
- [ ] B) Parent record with related child records
- [ ] C) Only charts
- [ ] D) External website content

**12. To make a field required in a form, you set:**
- [ ] A) The color to red
- [ ] B) Value Required property to Yes
- [ ] C) Delete the field
- [ ] D) Rename it

**13. Dynamic Actions in APEX allow:**
- [ ] A) Client-side interactivity without coding JavaScript
- [ ] B) Database deletion
- [ ] C) User authentication only
- [ ] D) File system access

**14. Which property controls whether a region is visible?**
- [ ] A) Display Position
- [ ] B) Condition Type
- [ ] C) Source Type
- [ ] D) Region Name

**15. The Rendering Tree in Page Designer shows:**
- [ ] A) Server logs
- [ ] B) All page components (regions, items, buttons)
- [ ] C) Database schema
- [ ] D) User passwords

**16. A Cards region is best used for:**
- [ ] A) Displaying tabular data in spreadsheet format
- [ ] B) Visual display of records with images/icons
- [ ] C) Running SQL scripts
- [ ] D) User authentication

**17. What is a page template?**
- [ ] A) A database backup
- [ ] B) Defines the overall layout and structure of a page
- [ ] C) A type of SQL query
- [ ] D) User credentials

**18. LOV (List of Values) in APEX is used for:**
- [ ] A) Providing dropdown/select list options
- [ ] B) Deleting records
- [ ] C) Server configuration
- [ ] D) Page navigation

**19. In Vodacom's Customer Portal, the Province filter uses:**
- [ ] A) Manual typing only
- [ ] B) LOV from VODACOM_CUSTOMERS table
- [ ] C) External API
- [ ] D) Random values

**20. The Property Editor (right pane) allows you to:**
- [ ] A) Only view properties, not edit
- [ ] B) Modify properties of selected components
- [ ] C) Delete the entire application
- [ ] D) Create new workspaces

---

## Part B: True/False Questions (20 points - 2 points each)

**21. Page Designer provides a drag-and-drop interface for designing pages.**
- [ ] True
- [ ] False

**22. You must write HTML code to create forms in APEX.**
- [ ] True
- [ ] False

**23. Every region on a page must be connected to a database table.**
- [ ] True
- [ ] False

**24. Dynamic Actions can trigger when a button is clicked or a field value changes.**
- [ ] True
- [ ] False

**25. Interactive Reports automatically save user preferences (column order, filters).**
- [ ] True
- [ ] False

**26. You can have multiple regions on a single APEX page.**
- [ ] True
- [ ] False

**27. Page processes can run before or after the page displays.**
- [ ] True
- [ ] False

**28. All page items are automatically visible to end users.**
- [ ] True
- [ ] False

**29. You can copy regions from one page to another in Page Designer.**
- [ ] True
- [ ] False

**30. Cards regions cannot display data from database queries.**
- [ ] True
- [ ] False

---

## Part C: Component Matching (10 points - 1 point each)

**Match each Page Designer component with its purpose:**

**Components:**
31. Region  
32. Page Item  
33. Button  
34. Page Process  
35. Dynamic Action  
36. Validation  
37. Computation  
38. Branch  
39. Authorization Scheme  
40. Breadcrumb  

**Purposes:**
A. Calculates values before saving  
B. Container for content (reports, forms, charts)  
C. Triggers page submit or action  
D. Checks data meets requirements  
E. Client-side interactive behavior  
F. Background server-side operation (save, email, etc.)  
G. Navigation aid showing page hierarchy  
H. Input/output field (text, date, number)  
I. Controls who can access page/component  
J. Redirects to another page after processing  

**Your Answers:**
31. ___  32. ___  33. ___  34. ___  35. ___  
36. ___  37. ___  38. ___  39. ___  40. ___

---

## Part D: Short Answer Questions (15 points - 5 points each)

**41. Explain the three main panes in Page Designer and their roles in application development.**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**42. What is the difference between a Classic Report and an Interactive Report? When would you use each in Vodacom's applications?**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**43. Describe how Master-Detail pages work and provide a Vodacom business scenario where this would be useful.**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

---

## Part E: Practical Exercise (15 points)

**44. Page Design for Vodacom Package Management**

You need to create a **Package Activation** page for Vodacom call center agents. Design the page structure:

**Business Requirements:**
- Agent searches for customer by mobile number or account number
- Display customer details (name, account status, current package)
- Show available packages filtered by customer type (Prepaid/Contract)
- Allow agent to select new package and activation date
- Display package details (data, voice, SMS, price)
- Submit activation request with confirmation

**Your Page Design:**

**Regions (List all regions, their type, and source):**

| Region Name | Region Type | SQL Source (if applicable) | Purpose |
|-------------|-------------|---------------------------|----------|
| 1. _________ | ____________ | ________________________ | ________ |
| 2. _________ | ____________ | ________________________ | ________ |
| 3. _________ | ____________ | ________________________ | ________ |
| 4. _________ | ____________ | ________________________ | ________ |

**Page Items (List key items with data type):**

| Item Name | Type | Required? | LOV Source (if applicable) |
|-----------|------|-----------|---------------------------|
| P5_MOBILE_NUMBER | _______ | Yes | _______________ |
| P5_CUSTOMER_ID | _______ | ___ | _______________ |
| P5_PACKAGE_ID | _______ | ___ | _______________ |
| P5_ACTIVATION_DATE | _______ | ___ | _______________ |

**Page Processes (Describe what happens when agent submits):**

```
Process 1 (Name & Purpose):
_____________________________________________________________________________

Process 2 (Name & Purpose):
_____________________________________________________________________________
```

**Validations (List 2-3 validations needed):**

```
1. _________________________________________________________________________
2. _________________________________________________________________________
3. _________________________________________________________________________
```

**Dynamic Actions (List 1-2 interactive behaviors):**

```
1. _________________________________________________________________________
2. _________________________________________________________________________
```

---

## Answer Key (For Instructor Use Only)

### Part A: Multiple Choice
1. B (3 panes)  2. B  3. B  4. B  5. B  6. B  7. B  8. A  9. B  10. B
11. B  12. B  13. A  14. B  15. B  16. B  17. B  18. A  19. B  20. B

### Part B: True/False
21. True  22. False  23. False  24. True  25. True
26. True  27. True  28. False  29. True  30. False

### Part C: Component Matching
31. B  32. H  33. C  34. F  35. E
36. D  37. A  38. J  39. I  40. G

### Part D: Short Answer (Sample Answers)

**41. Three main panes:**
- **Left Pane (Rendering Tree)**: Hierarchical view of all page components (regions, items, buttons, processes). Used to select, organize, and navigate components. Shows component dependencies and relationships.
- **Central Pane (Layout)**: Visual representation of the page as users will see it. Drag-and-drop interface for positioning regions. Live preview of page design.
- **Right Pane (Property Editor)**: Displays and allows editing of properties for selected component. Context-sensitive based on selection. Configure appearance, behavior, source, conditions, security.

**42. Classic vs Interactive Report:**
- **Classic Report**: 
  - Fixed layout, no end-user customization
  - Developer controls all formatting
  - Faster rendering, better for large datasets
  - Use for: Printable reports, fixed dashboards, executive summaries
- **Interactive Report**: 
  - End users can filter, sort, group, pivot
  - Save personal/public customizations
  - Built-in search, highlighting, charting
  - Use for: Data exploration, call center lookups, analyst tools
- **Vodacom usage**: 
  - Classic: Monthly executive revenue reports (fixed format)
  - Interactive: Agent customer lookup (need filtering/search)

**43. Master-Detail pages:**
Show parent record (master) with related child records (detail) on one page. Parent displayed in form region (single record), children in Interactive Grid (multiple editable rows).
**Vodacom scenario**: 
- **Master**: Customer account (VODACOM_CUSTOMERS)
- **Detail**: Customer's mobile numbers (VODACOM_MOBILE_NUMBERS)
- **Use case**: Call center agent views customer with all their phone numbers
- **Benefit**: Single screen reduces agent clicks, improves call handling time

### Part E: Practical Exercise (Sample Solution)

**Regions:**

| Region Name | Region Type | SQL Source | Purpose |
|-------------|-------------|-----------|----------|
| 1. Customer Search | Form | N/A (search inputs) | Agent enters mobile/account number |
| 2. Customer Details | Display Only Form | `SELECT * FROM vodacom_customers WHERE customer_id = :P5_CUSTOMER_ID` | Show customer info |
| 3. Available Packages | Interactive Report | `SELECT * FROM vodacom_packages WHERE active='Y' AND package_type = :P5_CUSTOMER_TYPE` | List packages |
| 4. Activation Request | Form | VODACOM_PACKAGE_ACTIVATIONS | Submit activation |

**Page Items:**

| Item Name | Type | Required? | LOV Source |
|-----------|------|-----------|------------|
| P5_MOBILE_NUMBER | Text | Yes | N/A |
| P5_CUSTOMER_ID | Hidden | Yes | N/A |
| P5_PACKAGE_ID | Select List | Yes | `SELECT package_name, package_id FROM vodacom_packages WHERE active='Y'` |
| P5_ACTIVATION_DATE | Date Picker | Yes | N/A |

**Page Processes:**
1. **Lookup Customer** (After Submit): Query VODACOM_CUSTOMERS by mobile number, populate P5_CUSTOMER_ID and customer details
2. **Activate Package** (After Submit): Insert into VODACOM_PACKAGE_ACTIVATIONS, update customer's active package, send confirmation SMS

**Validations:**
1. Customer exists: `Mobile number must belong to active Vodacom customer`
2. Package compatibility: `Selected package must be available for customer type (Prepaid/Contract)`
3. Activation date: `Date must be today or future date (within 30 days)`

**Dynamic Actions:**
1. **On Mobile Number Change**: Execute server-side lookup, populate customer details region
2. **On Package Selection**: Display package details (data GB, price, validity) in info region

---

## Grading Rubric

| Section | Points | Criteria |
|---------|--------|----------|
| Part A (MC) | 40 | 2 points per correct answer |
| Part B (T/F) | 20 | 2 points per correct answer |
| Part C (Matching) | 10 | 1 point per correct match |
| Part D (Short Answer) | 15 | 5 points each - Complete explanations with examples |
| Part E (Practical) | 15 | Regions (4 pts), Items (3 pts), Processes (3 pts), Validations (3 pts), Dynamic Actions (2 pts) |
| **TOTAL** | **100** | Pass = 70+ points |

---

**Student Name:** ______________________________  
**Date:** ______________  
**Score:** ______ / 100  
**Pass/Fail:** __________

**Instructor Notes:**
