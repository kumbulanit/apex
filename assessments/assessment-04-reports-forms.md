# Assessment 04: Reports and Forms

**Duration:** 45 minutes  
**Total Points:** 100 points  
**Passing Score:** 70%  
**Prerequisites:** Completed Lab 04 (Vodacom Reporting and Data Management)

---

## Part A: Multiple Choice Questions (40 points - 2 points each)

**1. What is the main advantage of Interactive Reports over Classic Reports?**
- [ ] A) Faster performance
- [ ] B) End-user customization (filtering, sorting, grouping)
- [ ] C) Simpler SQL queries
- [ ] D) No database connection needed

**2. In an Interactive Report, the Actions menu allows users to:**
- [ ] A) Delete database tables
- [ ] B) Filter data, download, save reports
- [ ] C) Modify page design
- [ ] D) Create new applications

**3. Which Interactive Report feature allows users to create their own calculations?**
- [ ] A) Filters
- [ ] B) Computed Columns
- [ ] C) Highlights
- [ ] D) Aggregates

**4. To make a column editable in an Interactive Grid, you must:**
- [ ] A) Delete the column first
- [ ] B) Set the column to "Read Only = No"
- [ ] C) Restart APEX
- [ ] D) Write JavaScript code

**5. A form in APEX is typically used for:**
- [ ] A) Displaying multiple records in a grid
- [ ] B) Editing a single record (CRUD operations)
- [ ] C) Running reports only
- [ ] D) Deleting applications

**6. What does DML (Data Manipulation Language) include?**
- [ ] A) CREATE, ALTER, DROP
- [ ] B) INSERT, UPDATE, DELETE
- [ ] C) GRANT, REVOKE
- [ ] D) COMMIT, ROLLBACK only

**7. Form validation in APEX ensures:**
- [ ] A) Data meets business rules before saving
- [ ] B) Faster page loading
- [ ] C) Better colors
- [ ] D) Automatic backups

**8. A "Not Null" validation means:**
- [ ] A) The field can be empty
- [ ] B) The field must have a value
- [ ] C) The field is hidden
- [ ] D) The field is read-only

**9. What is a LOV (List of Values) used for in forms?**
- [ ] A) Calculating totals
- [ ] B) Providing dropdown options from query
- [ ] C) Deleting records
- [ ] D) Creating tables

**10. The Automatic Row Processing (DML) process:**
- [ ] A) Manually saves each field
- [ ] B) Automatically handles INSERT/UPDATE/DELETE
- [ ] C) Requires custom PL/SQL
- [ ] D) Only works on Mondays

**11. In Vodacom's Customer Service Portal, which report type is best for call center agents to search customers?**
- [ ] A) Classic Report (fixed)
- [ ] B) Interactive Report (searchable, filterable)
- [ ] C) Chart
- [ ] D) Calendar

**12. A Master-Detail form shows:**
- [ ] A) Unrelated data
- [ ] B) Parent record with related child records
- [ ] C) Only summary data
- [ ] D) External websites

**13. Conditional formatting in reports allows:**
- [ ] A) Highlighting rows based on criteria
- [ ] B) Deleting data
- [ ] C) Changing database structure
- [ ] D) User authentication

**14. The Interactive Grid differs from Interactive Report because:**
- [ ] A) It's read-only
- [ ] B) It allows inline editing of multiple records
- [ ] C) It has no features
- [ ] D) It's slower

**15. Form regions can be based on:**
- [ ] A) Tables only
- [ ] B) Views only
- [ ] C) Tables, views, or stored procedures
- [ ] D) External APIs only

**16. What is a cascading LOV?**
- [ ] A) A waterfall chart
- [ ] B) Second dropdown filtered by first selection
- [ ] C) Deleting all data
- [ ] D) Report printing

**17. In Vodacom's Package Management form, what validates that price is positive?**
- [ ] A) Color scheme
- [ ] B) Check constraint or validation (PRICE_RAND > 0)
- [ ] C) Navigation menu
- [ ] D) Logo

**18. The "Lost Update" protection in forms prevents:**
- [ ] A) Saving data
- [ ] B) Two users overwriting each other's changes
- [ ] C) Page loading
- [ ] D) Report viewing

**19. A tabular form allows:**
- [ ] A) Editing one record
- [ ] B) Editing multiple records in spreadsheet style
- [ ] C) No editing
- [ ] D) Only viewing charts

**20. Download formats available in Interactive Reports include:**
- [ ] A) Only PDF
- [ ] B) CSV, Excel, PDF, HTML, Email
- [ ] C) Only text files
- [ ] D) Images only

---

## Part B: True/False Questions (20 points - 2 points each)

**21. Users can save their Interactive Report customizations (filters, column order) as Named Reports.**
- [ ] True
- [ ] False

**22. Forms can only insert new records, not update existing ones.**
- [ ] True
- [ ] False

**23. Validations run on the server side before data is saved.**
- [ ] True
- [ ] False

**24. Interactive Grids support pagination, sorting, and filtering like Interactive Reports.**
- [ ] True
- [ ] False

**25. You must write custom PL/SQL for basic form INSERT/UPDATE operations.**
- [ ] True
- [ ] False

**26. Classic Reports can be grouped and have aggregate functions (SUM, AVG, COUNT).**
- [ ] True
- [ ] False

**27. A form can have multiple buttons (Save, Delete, Cancel) with different actions.**
- [ ] True
- [ ] False

**28. LOVs can be static (hardcoded) or dynamic (from database query).**
- [ ] True
- [ ] False

**29. Interactive Reports automatically include search functionality.**
- [ ] True
- [ ] False

**30. Forms cannot display data from multiple tables.**
- [ ] True
- [ ] False

---

## Part C: SQL Query Challenges (15 points - 5 points each)

Write SQL queries for these Vodacom reporting requirements:

**31. Customer Revenue Report**

Write a query that shows:
- Customer full name (first + last name)
- Province
- Customer type (Prepaid/Contract)
- Total package spend (sum of all package activations)
- Number of active mobile numbers
- VodaPay active status

Only include customers with total spend > R500. Order by spend descending.

```sql
-- Your SQL query:









```

**32. Package Performance Dashboard**

Write a query for a Classic Report showing:
- Package name
- Package type
- Price in Rands
- Number of activations (count from VODACOM_PACKAGE_ACTIVATIONS)
- Total revenue generated (price × activations)
- Average customer rating (from activations table)
- Status badge ("Top Seller" if activations > 100, "Popular" if > 50, "Standard" otherwise)

Order by total revenue descending.

```sql
-- Your SQL query:









```

**33. Call Center Agent Performance**

Write a query showing:
- Agent name
- Total calls handled today
- Average call duration in minutes
- Resolved calls count
- Resolution rate percentage
- Performance rating ("Excellent" if rate > 90%, "Good" if > 80%, "Needs Improvement" otherwise)

Only include calls from today (TRUNC(SYSDATE)). Group by agent.

```sql
-- Your SQL query:









```

---

## Part D: Form Design Questions (10 points)

**34. Vodacom Package Form Design (10 points)**

Design a form for creating/editing Vodacom data packages. List all required components:

**Page Items (fields) - List 8-10 items:**

| Item Name | Type | Required? | Validation/LOV |
|-----------|------|-----------|----------------|
| P10_PACKAGE_ID | Hidden | Yes | Auto-generated |
| P10_PACKAGE_NAME | ________ | ___ | ______________ |
| P10_PACKAGE_TYPE | ________ | ___ | ______________ |
| P10_DATA_MB | ________ | ___ | ______________ |
| P10_VOICE_MINUTES | ________ | ___ | ______________ |
| P10_SMS_COUNT | ________ | ___ | ______________ |
| P10_PRICE_RAND | ________ | ___ | ______________ |
| P10_VALIDITY_DAYS | ________ | ___ | ______________ |
| P10_DESCRIPTION | ________ | ___ | ______________ |
| P10_ACTIVE | ________ | ___ | ______________ |

**Validations (List 3-4 validations):**

```
1. _________________________________________________________________________
2. _________________________________________________________________________
3. _________________________________________________________________________
4. _________________________________________________________________________
```

**Buttons:**

```
1. Button Name: __________ | Action: ______________ | Condition: __________
2. Button Name: __________ | Action: ______________ | Condition: __________
3. Button Name: __________ | Action: ______________ | Condition: __________
```

---

## Part E: Practical Scenario (15 points)

**35. Vodacom Call Center Reporting System**

You're building a reporting system for Vodacom call center managers. Design the following:

**Requirement 1: Agent Performance Interactive Report (5 points)**

Managers need to track agent performance metrics. Design an Interactive Report with:

**Columns to include:**
```
1. _________________________________________________________________________
2. _________________________________________________________________________
3. _________________________________________________________________________
4. _________________________________________________________________________
5. _________________________________________________________________________
6. _________________________________________________________________________
```

**Computed Columns (2-3 calculated fields):**
```
1. _________________________________________________________________________
2. _________________________________________________________________________
3. _________________________________________________________________________
```

**Conditional Highlighting Rules:**
```
1. Highlight in GREEN if: __________________________________________________
2. Highlight in RED if: ____________________________________________________
3. Highlight in YELLOW if: _________________________________________________
```

**Requirement 2: Call Detail Form (5 points)**

Agents need to log call details. Design a form with necessary fields and validations:

**Form Fields:**
```
1. Call ID (Hidden, auto-generated)
2. _________________________________________________________________________
3. _________________________________________________________________________
4. _________________________________________________________________________
5. _________________________________________________________________________
6. _________________________________________________________________________
```

**Business Logic/Validations:**
```
1. _________________________________________________________________________
2. _________________________________________________________________________
3. _________________________________________________________________________
```

**Requirement 3: Customer Satisfaction Chart (5 points)**

Create a chart visualization specification:

**Chart Type:** ___________

**SQL Query Logic (Describe what data to show):**
```
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**Chart Series/Labels:**
```
X-Axis: _____________________________________________________________________
Y-Axis: _____________________________________________________________________
Group By: ___________________________________________________________________
```

---

## Answer Key (For Instructor Use Only)

### Part A: Multiple Choice
1. B  2. B  3. B  4. B  5. B  6. B  7. A  8. B  9. B  10. B
11. B  12. B  13. A  14. B  15. C  16. B  17. B  18. B  19. B  20. B

### Part B: True/False
21. True  22. False  23. True  24. True  25. False
26. True  27. True  28. True  29. True  30. False

### Part C: SQL Query Solutions

**31. Customer Revenue Report:**
```sql
SELECT c.first_name || ' ' || c.last_name AS full_name,
       c.province,
       c.customer_type,
       SUM(p.price_rand) AS total_spend,
       (SELECT COUNT(*) 
        FROM vodacom_mobile_numbers mn 
        WHERE mn.customer_id = c.customer_id 
          AND mn.status = 'Active') AS active_numbers,
       c.vodapay_active
FROM vodacom_customers c
LEFT JOIN vodacom_package_activations pa ON c.customer_id = pa.customer_id
LEFT JOIN vodacom_packages p ON pa.package_id = p.package_id
GROUP BY c.customer_id, c.first_name, c.last_name, c.province, 
         c.customer_type, c.vodapay_active
HAVING SUM(p.price_rand) > 500
ORDER BY total_spend DESC;
```

**32. Package Performance Dashboard:**
```sql
SELECT p.package_name,
       p.package_type,
       p.price_rand,
       COUNT(pa.activation_id) AS activation_count,
       p.price_rand * COUNT(pa.activation_id) AS total_revenue,
       AVG(pa.customer_rating) AS avg_rating,
       CASE 
         WHEN COUNT(pa.activation_id) > 100 THEN 'Top Seller'
         WHEN COUNT(pa.activation_id) > 50 THEN 'Popular'
         ELSE 'Standard'
       END AS status_badge
FROM vodacom_packages p
LEFT JOIN vodacom_package_activations pa ON p.package_id = pa.package_id
GROUP BY p.package_id, p.package_name, p.package_type, p.price_rand
ORDER BY total_revenue DESC;
```

**33. Call Center Agent Performance:**
```sql
SELECT a.agent_name,
       COUNT(c.call_id) AS total_calls,
       ROUND(AVG(c.call_duration_minutes), 1) AS avg_duration,
       SUM(CASE WHEN c.resolution_status = 'Resolved' THEN 1 ELSE 0 END) AS resolved_count,
       ROUND(SUM(CASE WHEN c.resolution_status = 'Resolved' THEN 1 ELSE 0 END) 
             / COUNT(c.call_id) * 100, 1) AS resolution_rate,
       CASE
         WHEN (SUM(CASE WHEN c.resolution_status = 'Resolved' THEN 1 ELSE 0 END) 
               / COUNT(c.call_id) * 100) > 90 THEN 'Excellent'
         WHEN (SUM(CASE WHEN c.resolution_status = 'Resolved' THEN 1 ELSE 0 END) 
               / COUNT(c.call_id) * 100) > 80 THEN 'Good'
         ELSE 'Needs Improvement'
       END AS performance_rating
FROM vodacom_agents a
JOIN vodacom_calls c ON a.agent_id = c.agent_id
WHERE TRUNC(c.call_date) = TRUNC(SYSDATE)
GROUP BY a.agent_id, a.agent_name
ORDER BY resolution_rate DESC;
```

### Part D: Form Design (Sample Solution)

**Page Items:**

| Item Name | Type | Required? | Validation/LOV |
|-----------|------|-----------|----------------|
| P10_PACKAGE_ID | Hidden | Yes | Auto-generated |
| P10_PACKAGE_NAME | Text | Yes | Max 200 chars |
| P10_PACKAGE_TYPE | Select List | Yes | LOV: Data Only, Voice Only, SMS Only, Combo, Contract |
| P10_DATA_MB | Number | No | >= 0 |
| P10_VOICE_MINUTES | Number | No | >= 0 |
| P10_SMS_COUNT | Number | No | >= 0 |
| P10_PRICE_RAND | Number | Yes | > 0, max 2 decimals |
| P10_VALIDITY_DAYS | Number | Yes | Between 1 and 365 |
| P10_DESCRIPTION | Textarea | No | Max 500 chars |
| P10_ACTIVE | Checkbox | Yes | Y/N |

**Validations:**
1. **Price Positive**: `PRICE_RAND must be > 0` (Item validation)
2. **Validity Range**: `VALIDITY_DAYS between 1 and 365`
3. **Package Name Unique**: `Package name already exists` (SQL: `SELECT 1 FROM vodacom_packages WHERE package_name = :P10_PACKAGE_NAME AND package_id != :P10_PACKAGE_ID`)
4. **At least one service**: `Package must include Data, Voice, or SMS` (Validation: `DATA_MB > 0 OR VOICE_MINUTES > 0 OR SMS_COUNT > 0`)

**Buttons:**
1. **SAVE** | Submit page, run DML process | Always
2. **DELETE** | Confirm delete, run delete process | Only on existing record (P10_PACKAGE_ID IS NOT NULL)
3. **CANCEL** | Redirect to report page | Always

### Part E: Practical Scenario (Sample Solution)

**Requirement 1: Agent Performance Interactive Report**

**Columns:**
1. Agent Name
2. Team/Department
3. Shift (Morning/Afternoon/Night)
4. Total Calls Handled
5. Average Call Duration (minutes)
6. Calls Resolved
7. Resolution Rate %
8. Average Customer Rating (1-5)
9. First Call Resolution %

**Computed Columns:**
1. `Resolution Rate = (Resolved Calls / Total Calls) * 100`
2. `Performance Score = (Resolution Rate * 0.6) + (Avg Rating * 20 * 0.4)` (weighted score)
3. `Efficiency = Total Calls / Hours Worked`

**Conditional Highlighting:**
1. GREEN: Resolution Rate >= 90% AND Avg Rating >= 4.5 (Excellent performance)
2. RED: Resolution Rate < 70% OR Avg Rating < 3.0 (Needs improvement)
3. YELLOW: Resolution Rate 70-89% (Good performance)

**Requirement 2: Call Detail Form**

**Form Fields:**
1. Call ID (Hidden, auto-generated)
2. Customer Mobile Number (Text, required, LOV from VODACOM_MOBILE_NUMBERS)
3. Call Type (Select: Technical, Billing, Sales, General Inquiry)
4. Call Start Time (Timestamp, required, default SYSDATE)
5. Call End Time (Timestamp)
6. Issue Description (Textarea, required)
7. Resolution Status (Select: Resolved, Escalated, Pending, Callback Required)
8. Resolution Notes (Textarea)
9. Customer Satisfaction Rating (Radio: 1-5 stars)

**Business Logic/Validations:**
1. **End Time After Start**: `Call End Time must be after Start Time`
2. **Resolution Required**: `If status = 'Resolved', Resolution Notes required`
3. **Duration Limit**: `Call duration < 60 minutes` (prevent data entry errors)
4. **Customer Valid**: `Mobile number must belong to active customer`

**Requirement 3: Customer Satisfaction Chart**

**Chart Type:** Column Chart (with trend line)

**SQL Query Logic:**
```
Show daily average customer satisfaction ratings for last 30 days
Group by date
Include call volume (secondary axis)
Compare by call type (series)
```

**Chart Series/Labels:**
- X-Axis: Date (last 30 days)
- Y-Axis (Primary): Average Satisfaction Rating (1-5 scale)
- Y-Axis (Secondary): Call Volume
- Group By: Call Type (Technical, Billing, Sales, General)
- Series: 4 series (one per call type) + trend line

---

## Grading Rubric

| Section | Points | Criteria |
|---------|--------|----------|
| Part A (MC) | 40 | 2 points per correct answer |
| Part B (T/F) | 20 | 2 points per correct answer |
| Part C (SQL) | 15 | 5 points each - Correct syntax, logic, and business requirements |
| Part D (Form Design) | 10 | Items (4 pts), Validations (3 pts), Buttons (3 pts) |
| Part E (Scenario) | 15 | Report (5 pts), Form (5 pts), Chart (5 pts) |
| **TOTAL** | **100** | Pass = 70+ points |

---

**Student Name:** ______________________________  
**Date:** ______________  
**Score:** ______ / 100  
**Pass/Fail:** __________

**Instructor Notes:**
