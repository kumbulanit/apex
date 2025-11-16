# Assessment 01: Introduction and Getting Started

**Duration:** 30 minutes  
**Total Points:** 100 points  
**Passing Score:** 70%

---

## Part A: Multiple Choice Questions (40 points - 2 points each)

**1. What is Oracle Application Express (APEX) primarily used for?**
- [ ] A) Database administration only
- [ ] B) Low-code application development
- [ ] C) Network security
- [ ] D) Data warehousing

**2. Which component processes HTTP requests and connects to the Oracle database?**
- [ ] A) APEX Engine
- [ ] B) Oracle REST Data Services (ORDS)
- [ ] C) Web Browser
- [ ] D) SQL Workshop

**3. In APEX, a workspace is:**
- [ ] A) A physical office location
- [ ] B) An isolated development environment with its own schema
- [ ] C) A type of database table
- [ ] D) A reporting tool

**4. Which SQL Workshop tool would you use to view and manage database tables graphically?**
- [ ] A) SQL Commands
- [ ] B) SQL Scripts
- [ ] C) Object Browser
- [ ] D) RESTful Services

**5. What does the GENERATED ALWAYS AS IDENTITY clause do in a column definition?**
- [ ] A) Encrypts the column data
- [ ] B) Creates an auto-incrementing primary key
- [ ] C) Validates user input
- [ ] D) Generates random numbers

**6. A PRIMARY KEY constraint ensures:**
- [ ] A) The column cannot be null
- [ ] B) Each row has a unique value in that column
- [ ] C) Both A and B
- [ ] D) The column contains only numbers

**7. A FOREIGN KEY constraint:**
- [ ] A) Encrypts sensitive data
- [ ] B) Creates a relationship between two tables
- [ ] C) Generates automatic indexes
- [ ] D) Validates email addresses

**8. The DEFAULT clause in a column definition:**
- [ ] A) Sets a mandatory value that cannot be changed
- [ ] B) Provides an automatic value if none is specified
- [ ] C) Encrypts the column
- [ ] D) Creates an index

**9. What is the purpose of a database view?**
- [ ] A) To backup data
- [ ] B) To provide a simplified or customized presentation of table data
- [ ] C) To delete records
- [ ] D) To create users

**10. In the three-tier APEX architecture, what is the role of the database tier?**
- [ ] A) Display the user interface
- [ ] B) Store and manage data, execute PL/SQL
- [ ] C) Handle HTTP requests
- [ ] D) Run the web browser

**11. What SQL command is used to permanently save changes to the database?**
- [ ] A) SAVE
- [ ] B) COMMIT
- [ ] C) UPDATE
- [ ] D) PERSIST

**12. Which of the following is a benefit of Oracle APEX over traditional development?**
- [ ] A) Requires extensive coding knowledge
- [ ] B) Rapid application development
- [ ] C) Desktop-only deployment
- [ ] D) Single-user access

**13. The DUAL table in Oracle is used for:**
- [ ] A) Storing user credentials
- [ ] B) Testing functions and selecting constants
- [ ] C) Creating backups
- [ ] D) Managing transactions

**14. What does SQL stand for?**
- [ ] A) Structured Query Language
- [ ] B) Simple Question Language
- [ ] C) System Quality Logic
- [ ] D) Standard Query Library

**15. An INDEX in a database:**
- [ ] A) Deletes duplicate records
- [ ] B) Improves query performance
- [ ] C) Encrypts data
- [ ] D) Creates backups

**16. The CHECK constraint is used to:**
- [ ] A) Verify database backups
- [ ] B) Ensure column values meet specific criteria
- [ ] C) Create relationships between tables
- [ ] D) Generate reports

**17. What does the LEFT JOIN operation do?**
- [ ] A) Returns only matching rows from both tables
- [ ] B) Returns all rows from the left table and matching rows from the right
- [ ] C) Deletes rows from the left table
- [ ] D) Sorts data alphabetically

**18. The UNIQUE constraint ensures:**
- [ ] A) No two rows can have the same value in that column
- [ ] B) The column is encrypted
- [ ] C) The column is indexed
- [ ] D) The column contains only text

**19. In TechNova's case study, what was a major problem with their Access database?**
- [ ] A) It was too expensive
- [ ] B) Only one user could access it at a time
- [ ] C) It had too many features
- [ ] D) It required cloud hosting

**20. PL/SQL is used in Oracle for:**
- [ ] A) Styling web pages
- [ ] B) Procedural programming and database logic
- [ ] C) Creating spreadsheets
- [ ] D) Editing images

---

## Part B: True/False Questions (20 points - 2 points each)

**21. APEX applications require installation of software on user computers.**
- [ ] True
- [ ] False

**22. A workspace in APEX can contain multiple applications.**
- [ ] True
- [ ] False

**23. The Object Browser in SQL Workshop can only view tables, not edit them.**
- [ ] True
- [ ] False

**24. NOT NULL constraint means the column must always have a value.**
- [ ] True
- [ ] False

**25. Foreign keys can reference any column in another table.**
- [ ] True
- [ ] False

**26. A database view stores actual data like a table.**
- [ ] True
- [ ] False

**27. COMMIT makes database changes permanent.**
- [ ] True
- [ ] False

**28. APEX requires users to write extensive JavaScript code for basic applications.**
- [ ] True
- [ ] False

**29. You can run SQL queries in APEX using the SQL Commands tool.**
- [ ] True
- [ ] False

**30. Indexes slow down database queries.**
- [ ] True
- [ ] False

---

## Part C: Short Answer Questions (20 points - 5 points each)

**31. Explain the three-tier architecture of Oracle APEX. Name and briefly describe each tier.**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**32. What is referential integrity, and how do foreign keys enforce it? Provide an example from the TechNova database.**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**33. List and describe three major benefits TechNova would gain by migrating from Microsoft Access to Oracle APEX.**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**34. Explain the difference between a table and a view in Oracle. When would you use each?**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

---

## Part D: Practical Exercises (20 points - 10 points each)

**35. Write SQL: Create a PROJECTS table**

Write a CREATE TABLE statement for a PROJECTS table with these requirements:
- PROJECT_ID: Auto-incrementing primary key
- PROJECT_NAME: Required text field, max 200 characters
- CLIENT_NAME: Optional text field, max 200 characters
- START_DATE: Date field
- BUDGET: Number with 2 decimal places
- STATUS: Text field that can only contain: 'Planning', 'Active', 'Completed', 'Cancelled'
- Created date and created by fields with automatic values

```sql
-- Your SQL statement:








```

**36. Write SQL: Query with JOIN and calculations**

Write a query that:
- Joins the EMPLOYEES and DEPARTMENTS tables
- Shows: employee full name (first + last), department name, salary, and years of service
- Only includes active employees
- Calculates years of service using hire_date
- Orders by years of service descending

```sql
-- Your SQL statement:








```

---

## Answer Key (For Instructor Use Only)

### Part A: Multiple Choice
1. B  2. B  3. B  4. C  5. B  6. C  7. B  8. B  9. B  10. B
11. B  12. B  13. B  14. A  15. B  16. B  17. B  18. A  19. B  20. B

### Part B: True/False
21. False  22. True  23. False  24. True  25. False
26. False  27. True  28. False  29. True  30. False

### Part C: Short Answer (Sample Answers)

**31. Three-tier APEX architecture:**
- **Browser Tier**: User's web browser displays the UI, sends HTTP requests
- **Application Tier**: ORDS receives requests, APEX Engine processes them, generates HTML
- **Database Tier**: Oracle Database stores data, executes PL/SQL, returns results

**32. Referential integrity:**
Ensures relationships between tables remain valid. Foreign keys enforce it by preventing:
- Child records referencing non-existent parent records
- Deletion of parent records with dependent children
Example: EMPLOYEES.DEPARTMENT_ID references DEPARTMENTS.DEPARTMENT_ID - cannot assign employee to non-existent department.

**33. TechNova benefits from APEX migration:**
1. **Multi-user concurrent access**: Replace single-user Access with unlimited concurrent users
2. **Web-based accessibility**: Access from anywhere, no desktop software needed, mobile-friendly
3. **Data integrity & security**: Enforced constraints, role-based security, audit trails
4. **Stability**: No crashes like Access, enterprise-grade database reliability
5. **Scalability**: Handle 250 employees and growth, robust performance

**34. Table vs. View:**
- **Table**: Physical storage of data, rows are stored on disk, can INSERT/UPDATE/DELETE
- **View**: Virtual table based on a query, no physical storage, simplifies complex queries, provides security by limiting column access
- **Use table** for: storing actual data
- **Use view** for: simplified reporting, combining data from multiple tables, restricting column access

### Part D: Practical Exercises (Sample Solutions)

**35. CREATE TABLE solution:**
```sql
CREATE TABLE projects (
    project_id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    project_name     VARCHAR2(200) NOT NULL,
    client_name      VARCHAR2(200),
    start_date       DATE,
    budget           NUMBER(15,2),
    status           VARCHAR2(20) DEFAULT 'Planning' 
                     CHECK (status IN ('Planning','Active','Completed','Cancelled')),
    created_date     DATE DEFAULT SYSDATE,
    created_by       VARCHAR2(100) DEFAULT USER
);
```

**36. Query solution:**
```sql
SELECT e.first_name || ' ' || e.last_name AS full_name,
       d.department_name,
       e.salary,
       TRUNC(MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12, 1) AS years_of_service
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE e.status = 'Active'
ORDER BY years_of_service DESC;
```

---

## Grading Rubric

| Section | Points | Criteria |
|---------|--------|----------|
| Part A (MC) | 40 | 2 points per correct answer |
| Part B (T/F) | 20 | 2 points per correct answer |
| Part C (Short Answer) | 20 | 5 points each - Full credit for complete, accurate answers; Partial credit for incomplete but correct information |
| Part D (Practical) | 20 | 10 points each - 10 pts for fully correct syntax and logic; 7 pts for minor errors; 4 pts for major errors but some understanding shown |
| **TOTAL** | **100** | Pass = 70+ points |

---

**Student Name:** ______________________________  
**Date:** ______________  
**Score:** ______ / 100  
**Pass/Fail:** __________

**Instructor Notes:**
