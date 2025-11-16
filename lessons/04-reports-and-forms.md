# Lesson 04: Building Reports and Forms

## Theory

### Layman's Explanation

**Reports** = Looking at information (like browsing Netflix - you see movies, filter by genre, search)  
**Forms** = Changing information (like your Netflix profile - you edit name, password, preferences)

Think of reports and forms as the two fundamental ways humans interact with data:
- **Reports**: "Show me what's there" (read-only viewing)
- **Forms**: "Let me change it" (editing/creating)

APEX provides multiple types of each, from simple to sophisticated, so you can choose the right tool for the job.

**Real-World Analogy: Library System**

**Reports = Card Catalog / Search System:**
- Browse all books (catalog)
- Search by title, author, genre
- Filter (only sci-fi, only available)
- Sort (by popularity, publication date)
- Export list to print

**Forms = Checkout/Return Card:**
- Fill in: Your name, library card number, book title
- Select: Pickup location from dropdown
- Choose: Delivery or in-person
- Submit: Process checkout

**Vodacom's Report & Form Journey: From Chaos to Clarity**

Let's see how Vodacom transformed their most frustrating data management challenge: the Project Status Report and Project Edit Form.

**The Old Way (Microsoft Access):**

**Project Status Report Problems:**
- Fixed columns (couldn't hide what you didn't need)
- No search (had to scroll through 5,300 projects to find one)
- Slow (10-15 seconds to load all records)
- Crashed if you tried to export to Excel
- No filters (couldn't show "only my projects" or "only overdue")
- One layout for everyone (executives wanted summary, managers wanted details)

**Maria's Horror Story (Project Manager):**
"Every Monday morning, my boss asks for a project status report. I would:
1. Open Access database (2 minutes waiting)
2. Run the Project Status query (1 minute)
3. Scroll through 5,300 rows to find my 12 projects (5 minutes)
4. Copy-paste each row to Excel manually (15 minutes)
5. Format in Excel (10 minutes)
6. Email to boss (1 minute)
**Total: 34 minutes, every single week**

And if my boss said 'Can you add the budget column?' - I had to call IT, they'd modify the Access query (2-day turnaround), and I'd wait. Zero control."

**Project Edit Form Problems:**
- No validation (could enter end date before start date)
- No dropdowns (had to remember client IDs)
- No file attachments (stored separately in folders)
- No audit trail (who changed the budget from $500K to $50K?)
- Single-user (if someone else editing, you're locked out)

**John's Frustration (Developer):**
"I spent 3 days building a custom form with cascading dropdowns in Access VBA. The code was 800 lines. Then someone asked to add one field, and I had to reposition everything manually, pixel by pixel. Took 4 hours. I started dreading form changes."

**The APEX Transformation:**

**Interactive Report for Project Status:**

John rebuilt the Access report as an APEX Interactive Report in **8 minutes**:

1. Create Page → Interactive Report
2. Table: PROJECTS
3. Run page
4. **Done**

**What Maria got (without asking):**
- ✅ **Built-in search bar**: Type "Acme" - instant results
- ✅ **Column filters**: Click Status → Select "Active" → Done
- ✅ **Sortable columns**: Click any header to sort
- ✅ **Show/hide columns**: Actions → Select Columns → Hide Budget (executives don't need to see)
- ✅ **Save custom views**: "My Projects", "Overdue Projects", "Executive Summary"
- ✅ **One-click Excel export**: Download → CSV → Opens in Excel perfectly formatted
- ✅ **Fast**: Loads 5,300 rows in 0.4 seconds
- ✅ **Never crashes**: Handles 50 simultaneous users

**Maria's New Monday Morning:**
1. Open APEX app (5 seconds)
2. Click saved filter: "My Projects - Active" (2 seconds)
3. Click Download → Excel (3 seconds)
4. Email to boss (1 minute)
**Total: 70 seconds vs 34 minutes (97% time saved)**

**Annual time saved: 27 hours** (52 weeks × 33 minutes saved)

**Interactive Grid for Bulk Updates:**

Vodacom needed to update project statuses for 50 projects quarterly (end of Q1, Q2, Q3, Q4).

**Old Access way:**
- Open edit form for Project 1
- Change status from "Active" to "Planning"
- Save, close
- Repeat 49 more times
**Time: 90 minutes (50 × 1.8 minutes per edit)**

**APEX Interactive Grid:**
John created an Interactive Grid in **5 minutes**. Now:
- See all 50 projects in spreadsheet view
- Click status cell → Select new status from dropdown
- Move to next row with arrow key
- Edit all 50 in 2 minutes
- Click **Save** once
- All 50 projects updated
**Time: 3 minutes vs 90 minutes (97% time saved)**

**Form for Project Editing:**

John rebuilt the project edit form in APEX - took **12 minutes** including validations:

**What he got automatically:**
- ✅ Date pickers (no more typos like "13/45/2023")
- ✅ Dropdowns populated from database (select client from list, not memorize IDs)
- ✅ Automatic validation (end date can't be before start date)
- ✅ Audit trail (who, what, when - automatic)
- ✅ Concurrent editing (multiple users can edit different projects)
- ✅ Mobile-friendly (works on phone, tablet)
- ✅ File attachments (upload documents directly in form)

**Validation Example:**

**Access (800 lines of VBA):**
```vba
Private Sub btnSave_Click()
  If IsNull(txtEndDate.Value) Then
    MsgBox "End Date required"
    txtEndDate.SetFocus
    Exit Sub
  End If
  
  If txtEndDate.Value < txtStartDate.Value Then
    MsgBox "End Date must be after Start Date"
    txtEndDate.SetFocus
    Exit Sub
  End If
  
  If Len(txtProjectName.Value) = 0 Then
    MsgBox "Project Name required"
    txtProjectName.SetFocus
    Exit Sub
  End If
  
  ' ... 780 more lines of validation logic
End Sub
```

**APEX (Zero code - built-in UI):**
1. Item P2_END_DATE → Validation → Create
2. Type: "Item >= Item"
3. Item 1: P2_END_DATE
4. Item 2: P2_START_DATE
5. Error Message: "End Date must be after Start Date"
6. **Done - 30 seconds**

**The Numbers: Vodacom's Report & Form ROI**

| Metric | Before (Access) | After (APEX) | Improvement |
|--------|----------------|--------------|-------------|
| **Report build time** | 8 hours | 8 minutes | 98.3% faster |
| **Form build time** | 24 hours (3 days) | 12 minutes | 99.2% faster |
| **Report load time** | 10-15 seconds | 0.4 seconds | 96-97% faster |
| **Weekly report prep** | 34 minutes | 70 seconds | 97% faster |
| **Bulk update (50 records)** | 90 minutes | 3 minutes | 97% faster |
| **Form maintenance** | 4 hours per change | 5 minutes | 98% faster |
| **User customization** | Not possible | Unlimited | ∞ better |
| **Mobile access** | No | Yes | N/A |
| **Concurrent users** | 1 | Unlimited | ∞ better |
| **Annual dev cost** | $52,000 | $5,200 | 90% reduction |

**Total Annual Savings: $46,800 + 280 hours reclaimed for strategic work**

**The Four Report Types Explained (Simple Analogy)**

**1. Interactive Report = Google Search Results**
- You search, filter, sort
- You control the view
- Perfect for: End-users who need flexibility

**2. Interactive Grid = Google Sheets**
- Edit cells inline
- Spreadsheet-like interface
- Perfect for: Bulk data entry, quick updates

**3. Classic Report = Printed Newspaper**
- Fixed layout
- Developer controls everything
- Perfect for: PDF invoices, formatted printouts

**4. Faceted Search = Amazon Product Filters**
- Filters on left (price range, brand, rating)
- Results update as you filter
- Perfect for: Large datasets with many attributes

**The Three Form Types Explained**

**1. Standard Form = Paper Form on Clipboard**
- One record at a time
- Full page dedicated to editing
- Perfect for: Detailed records with many fields

**2. Modal Dialog Form = Sticky Note Popup**
- Quick edit without leaving page
- Popup overlay
- Perfect for: Simple edits (change status, update date)

**3. Master-Detail Form = Order with Line Items**
- Top section: Order info (master)
- Bottom section: Products in order (detail)
- Perfect for: Parent-child relationships

**Vodacom's "Aha!" Moment**

Sarah (developer) was in a meeting when the CFO said: "We need a new report showing revenue by client, by month, with drill-down to individual projects."

**Old Sarah (Access days):** "I can have that ready in 2 weeks."

**New Sarah (APEX):** "Give me 10 minutes."

She opened her laptop:
1. Created Interactive Report
2. Wrote SQL query with aggregation
3. Added chart region
4. Added drill-down link
5. **Presented finished report 8 minutes later**

**CFO:** "Wait, what? You're done?"

**CEO:** "This is why we switched to APEX."

**The Bottom Line**

Reports and forms are where users spend 90% of their time in your application. APEX makes both:
- **Faster to build** (minutes vs days)
- **Easier to use** (intuitive, modern UI)
- **More powerful** (features you'd never code manually)
- **Self-service** (users customize without calling IT)

Vodacom's users went from "I hate the database" to "I love how easy this is" - purely because of better reports and forms built in a fraction of the time.

In the next sections, we'll dive into exactly how to build each report type, when to use each form type, and pro tips from Vodacom's experience.

### Intermediate Explanation

**Report Types:**
- **Interactive Report**: End-users can filter, sort, customize
- **Interactive Grid**: Editable spreadsheet-like interface
- **Classic Report**: Fixed layout, developer-controlled
- **Faceted Search**: Google-like search with filters

**Interactive Report vs Interactive Grid Comparison:**

```
┌─────────────────────────────────────────────────────────────┐
│              INTERACTIVE REPORT vs INTERACTIVE GRID         │
├─────────────────────────────┬───────────────────────────────┤
│   Interactive Report        │   Interactive Grid            │
├─────────────────────────────┼───────────────────────────────┤
│ ✓ Read-only display         │ ✓ Inline editing              │
│ ✓ Built-in search           │ ✓ Spreadsheet-like            │
│ ✓ Column filters            │ ✓ Add/delete rows             │
│ ✓ Sorting                   │ ✓ Copy/paste                  │
│ ✓ Download (CSV, PDF)       │ ✓ Cell-level validation       │
│ ✓ Aggregations (SUM, AVG)   │ ✓ Bulk save                   │
│ ✓ Chart view                │ ✓ Master-detail support       │
│ ✓ Highlighting              │ ✓ Row-level locking           │
│ ✓ Save custom views         │ ✓ Download (CSV)              │
│                             │                               │
│ ❌ Cannot edit inline        │ ❌ No chart view              │
│ ❌ No bulk operations        │ ❌ Limited aggregations       │
│                             │                               │
│ USE FOR:                    │ USE FOR:                      │
│ • Browse data               │ • Edit multiple records       │
│ • Search & filter           │ • Data entry                  │
│ • Reporting                 │ • Spreadsheet replacement     │
│ • Executive dashboards      │ • Bulk updates                │
└─────────────────────────────┴───────────────────────────────┘
```

**🎓 Learn More:**
- **Tutorial**: [Shopping Cart App](https://apex.oracle.com/go/shopping-cart-lab) - Interactive Reports and Forms (2 hours, Intermediate)
- **Tutorial**: [Online Book Store](https://apex.oracle.com/go/obs-lab) - Advanced reporting with AI (5 hours, Advanced)
- **Tutorial**: [Movies Watchlist](https://apex.oracle.com/go/movies-lab) - Master-detail patterns (2 hours, Intermediate)

**Form Types:**
- **Standard Form**: One record at a time
- **Modal Dialog Form**: Popup overlay
- **Master-Detail**: Parent record + child records
- **Tabular Form**: Edit multiple rows (deprecated, use Interactive Grid)

**Form Types Visual Comparison:**

```
┌────────────────────────────────────────────────────────┐
│                  FORM TYPES                            │
├────────────────────────────────────────────────────────┤
│                                                        │
│  STANDARD FORM (Full Page)                            │
│  ┌──────────────────────────────────────────────────┐ │
│  │ Page: Edit Employee          [Save] [Delete]     │ │
│  │ ┌────────────────────────────────────────────┐   │ │
│  │ │ First Name: [John                    ]     │   │ │
│  │ │ Last Name:  [Smith                   ]     │   │ │
│  │ │ Email:      [john.smith@company.com  ]     │   │ │
│  │ │ Department: [Engineering           ▼]      │   │ │
│  │ │ Salary:     [$95,000                 ]     │   │ │
│  │ │ Hire Date:  [01/15/2024        📅]         │   │ │
│  │ └────────────────────────────────────────────┘   │ │
│  └──────────────────────────────────────────────────┘ │
│  Use for: Detailed records, many fields               │
│                                                        │
├────────────────────────────────────────────────────────┤
│                                                        │
│  MODAL DIALOG FORM (Popup)                            │
│  ┌─────────────────────────────────┐                  │
│  │ Edit Employee         [✕]       │                  │
│  ├─────────────────────────────────┤                  │
│  │ First Name: [John        ]      │                  │
│  │ Last Name:  [Smith       ]      │                  │
│  │ Email:      [john@...    ]      │                  │
│  │                                 │                  │
│  │     [Cancel]  [Save]            │                  │
│  └─────────────────────────────────┘                  │
│  Use for: Quick edits, 2-5 fields, stay on page       │
│                                                        │
├────────────────────────────────────────────────────────┤
│                                                        │
│  MASTER-DETAIL FORM                                    │
│  ┌──────────────────────────────────────────────────┐ │
│  │ PROJECT (Master)                                  │ │
│  │ Name:   [Website Redesign        ]  [Save]       │ │
│  │ Budget: [$50,000                 ]               │ │
│  ├──────────────────────────────────────────────────┤ │
│  │ TASKS (Detail - Interactive Grid)  [+ Add Task]  │ │
│  │ ┌────────────────┬────────┬────────────┐        │ │
│  │ │ Task           │ Hours  │ Status     │        │ │
│  │ ├────────────────┼────────┼────────────┤        │ │
│  │ │ Design mockups │ 40     │ Complete   │        │ │
│  │ │ User testing   │ 20     │ In Progress│        │ │
│  │ │ Development    │ 160    │ Not Started│        │ │
│  │ └────────────────┴────────┴────────────┘        │ │
│  └──────────────────────────────────────────────────┘ │
│  Use for: Parent-child relationships                   │
│                                                        │
└────────────────────────────────────────────────────────┘
```

**🎓 See Examples:**
- **Tutorial**: [Shopping Cart](https://apex.oracle.com/go/shopping-cart-lab) - Master-detail forms with cart management
- **Sample Apps**: [Oracle APEX Gallery](https://oracle.github.io/apex/) - Explore form patterns
- **Documentation**: [Forms Guide](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/managing-forms.html)

### Advanced Explanation

**Interactive Report Architecture:**
- AJAX-based pagination
- Client-side column hiding/showing
- Server-side filtering and sorting
- Session state for user customizations
- Download to CSV/PDF/Excel

**Interactive Grid:**
- JavaScript DataTable library
- Row-level locking
- Inline editing with validations
- Bulk DML operations
- Supports cell-level formatting

---

## Labs / Practicals

### Lab 1: Simple - Create Interactive Report

**Objective:** Build searchable employee directory for Vodacom.

**Steps:**
1. Create Page → Report → Interactive Report
2. Table: `VODACOM_EMPLOYEES`
3. Include all columns
4. Run page
5. Test: Search, filter, sort, download

**Expected:** Fully functional report with toolbar

---

### Lab 2: Intermediate - Interactive Grid with Inline Editing

**Objective:** Allow managers to bulk-update project assignments.

**Steps:**
```sql
-- Create Interactive Grid page
Source SQL:
SELECT a.assignment_id,
       p.project_name,
       e.first_name || ' ' || e.last_name AS employee,
       a.role,
       a.allocation_pct,
       a.start_date,
       a.end_date
FROM vodacom_assignments a
JOIN vodacom_projects p ON a.project_id = p.project_id
JOIN vodacom_employees e ON a.employee_id = e.emp_id;

-- Enable editing
Attributes:
  Editable: Yes
  Update Allowed: Yes
  Delete Allowed: Yes
  Primary Key: ASSIGNMENT_ID
```

**Features:**
- Inline edit cells
- Add/delete rows
- Save button commits changes
- Validations fire on edit

---

### Lab 3: Advanced - Master-Detail Form

**Objective:** Edit project with embedded tasks list.

**Steps:**
1. Create Page → Form → Master Detail
2. Master: VODACOM_PROJECTS
3. Detail: VODACOM_TASKS (PROJECT_ID relationship)
4. Configure:
   - Master form shows project fields
   - Detail region shows tasks Interactive Grid
   - Add task button
5. Save process updates both tables

**Result:** Edit project and tasks on one page

---

## Real-World Practical

### Vodacom Invoice Management System

**Requirements:**
- Interactive Report: All invoices with filters
- Form: Create/edit invoice
- Interactive Grid: Line items (products/services)
- Total calculation (auto-sum line items)
- Status workflow (Draft → Sent → Paid)
- Email invoice as PDF

**Implementation:**
- Report with conditional formatting (overdue = red)
- Master-Detail form (invoice + line items)
- Dynamic actions for calculations
- Process to generate PDF and email

---

## Assessment

### MCQs

**Q1:** What's the main difference between Interactive Report and Classic Report?

A) No difference  
B) Interactive Report allows end-user customization (sort, filter)  
C) Classic Report is faster  
D) Interactive Report requires JavaScript programming  

**Answer: B**

**Q2:** Which form type is best for editing parent-child data together?

A) Standard Form  
B) Modal Dialog  
C) Master-Detail Form  
D) Tabular Form  

**Answer: C**

**Q3:** What does Interactive Grid allow that Interactive Report doesn't?

A) Filtering data  
B) Inline editing of multiple rows  
C) Downloading to Excel  
D) Sorting columns  

**Answer: B**

### Short Answer

**Q1:** Vodacom wants users to customize their project report (hide columns, save filters). Which report type should you use and why?

**Answer:** Interactive Report. It allows end-users to:
- Filter by any column
- Sort and re-order columns
- Hide/show columns
- Save customizations as private or public reports
- Download data
All without developer intervention.

**Q2:** Explain when to use a Standard Form vs Modal Dialog Form.

**Answer:**
- **Standard Form**: Use for complex records with many fields, requiring full page space. User commits to editing, clear navigation.
- **Modal Dialog**: Use for quick edits (2-5 fields), keeping context of parent page. Better UX for small changes without losing place.

Vodacom example: Edit employee (standard), Update task status (modal).

### Practical Challenge

**Project:** Build Vodacom Project Status Report

**Requirements:**
1. Interactive Report showing:
   - Project name, client, manager, status, budget
   - Conditional formatting: Overbudget = red, On Track = green
   - Filters: Status, Date range, Manager
2. Link to edit form
3. Master-Detail form:
   - Master: Project details
   - Detail: Interactive Grid of tasks
   - Calculate: Total task hours, budget remaining
4. Charts: Budget utilization gauge

**Deliverables:**
- Report with 3+ customization options
- Working master-detail form
- Screenshots of conditional formatting
- Export SQL file

---

## PowerPoint Slides

### Slide 1: Building Reports and Forms
**Vodacom Training - Lesson 04**

### Slide 2: Report Types Comparison

| Type | Use Case | Editable | User Customization |
|------|----------|----------|--------------------|
| Interactive Report | Data browsing | No | High |
| Interactive Grid | Data editing | Yes | High |
| Classic Report | Fixed layouts | No | None |
| Faceted Search | Search-focused | No | Medium |

### Slide 3: Interactive Report Features
✅ Built-in search  
✅ Column filtering  
✅ Sorting  
✅ Highlighting  
✅ Aggregations (sum, avg)  
✅ Chart views  
✅ Download (Excel, CSV, PDF)  
✅ Save custom reports  

**No coding required!**

### Slide 4: Interactive Grid
**Excel-like Editing**

- Inline cell editing
- Add/delete rows
- Copy/paste
- Keyboard navigation
- Bulk save
- Validations
- Master-detail support

**Best for:** Batch data entry

### Slide 5: Form Types

**Standard Form:** Full page, complex data  
**Modal Dialog:** Quick popup edit  
**Master-Detail:** Parent + children together  

**Choose based on:** Data complexity and UX flow

### Slide 6: Master-Detail Pattern
```
┌─────────────────────────────┐
│   PROJECT DETAILS (Master)  │
│   Name: [____________]      │
│   Budget: [________]        │
├─────────────────────────────┤
│   TASKS (Detail Grid)       │
│   Task     Hours   Status   │
│   Task 1   8       Done     │
│   Task 2   16      Active   │
│   [Add Task]                │
└─────────────────────────────┘
```

### Slide 7: Conditional Formatting
**Visual Indicators**

```sql
-- Highlight overbudget projects in red
CASE 
  WHEN actual_cost > budget THEN 'red-text'
  WHEN actual_cost > budget * 0.9 THEN 'yellow-text'
  ELSE 'green-text'
END AS css_class
```

Makes data actionable at a glance!

### Slide 8: Vodacom Use Cases
**Reports:**
- Employee directory (Interactive Report)
- Project dashboard (Classic Report + Charts)
- Invoice search (Faceted Search)

**Forms:**
- Edit employee (Standard Form)
- Quick task update (Modal Dialog)
- Project + tasks (Master-Detail)

### Slide 9: Best Practices
✅ Use Interactive Report for read-only browsing  
✅ Use Interactive Grid for bulk editing  
✅ Add search bar to reports  
✅ Enable download options  
✅ Use modal dialogs for quick edits  
✅ Master-detail for related data  
✅ Add conditional formatting for insights  

### Slide 10: Lab Exercises
**Lab 1:** Employee directory (Interactive Report)  
**Lab 2:** Assignment management (Interactive Grid)  
**Lab 3:** Project + tasks (Master-Detail)  

**Challenge:** Invoice management system

