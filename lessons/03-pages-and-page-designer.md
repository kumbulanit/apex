# Lesson 03: Managing Pages and Page Designer

## Theory

### Layman's Explanation

Imagine you're designing rooms in your house using an interior design app. Each **page** in APEX is like a room with a specific purpose - living room (dashboard), office (reports), kitchen (data entry forms). The **Page Designer** is your visual design studio where you drag-and-drop furniture, arrange layouts, and customize everything without needing architectural skills.

**Real-World Analogy: Interior Design App**

Think of tools like RoomSketcher or IKEA's room planner:
- **Left Panel**: Your furniture catalog (available components: tables, chairs, lamps)
- **Center Panel**: The room layout where you arrange everything visually
- **Right Panel**: Property inspector (dimensions, colors, materials for selected item)

APEX Page Designer works exactly the same way, but for building web application pages instead of rooms.

**Vodacom's Journey: The "One Page That Changed Everything"**

Let's look at how Vodacom transformed their most problematic screen - the Project Status Dashboard.

**The Old Way (Microsoft Access):**

Vodacom had an Access form called "ProjectDashboard" that was a nightmare:
- Built in Design View with pixel-perfect positioning (if you moved one field, everything broke)
- Required VBA code for every button click (500+ lines of code)
- No mobile access (desktop only, 1024×768 resolution hardcoded)
- Slow performance (3-7 seconds to load)
- Crashed when multiple users accessed simultaneously
- No search functionality (had to scroll through 5,300 projects)

**The Developer Experience:**
- Sarah (developer) spent 2 weeks building original form
- Every change request took hours:
  - "Add a search box" = 4 hours (repositioning, VBA code, testing)
  - "Change field order" = 2 hours (break everything, fix everything)
  - "Make it work on mobile" = "Not possible without complete rebuild"

**The User Experience:**
- Maria (project manager) had to be in office to check project status
- Weekend work? Drive to office to access dashboard
- Field visit to client? Call office for project info
- Load time: 5 seconds minimum, often 10+ with timeout errors

**The APEX Transformation:**

Sarah learned APEX and rebuilt the dashboard page in **4 hours** using Page Designer:

**What she did:**
1. Created new blank page in APEX
2. Opened Page Designer (visual interface)
3. Dragged "Interactive Report" region onto page
4. Pointed it at PROJECTS table
5. Dragged "Chart" region below report
6. Added 3 pie charts (by status, by client, by manager)
7. Added search box (1 click, no code)
8. Added "Add Project" button (1 click, linked to form)
9. Customized colors to match Vodacom brand
10. Published

**Total time: 4 hours vs 2 weeks (original Access development)**

**What they got:**
- ✅ Mobile-responsive (works on phone, tablet, desktop automatically)
- ✅ Fast (0.3 seconds load time)
- ✅ Searchable (built-in search, filter, sort)
- ✅ Multi-user (250 employees access simultaneously, no crashes)
- ✅ Real-time (data updates immediately, no refresh needed)
- ✅ Professional UI (looks modern, not 1990s)
- ✅ Easy to change (drag-drop to rearrange, no code breaks)

**The "Magic" of Page Designer**

Here's what makes it revolutionary for non-programmers:

**Traditional Web Development:**
```
To add a search box to a page:
1. Write HTML for input field (10 lines)
2. Write CSS for styling (20 lines)
3. Write JavaScript for search logic (50 lines)
4. Write backend API endpoint (30 lines)
5. Write SQL query with WHERE clause (15 lines)
6. Test on different browsers (2 hours)
7. Make it responsive for mobile (30 lines CSS)
Total: 155+ lines of code, 6-8 hours
```

**APEX Page Designer:**
```
To add a search box:
1. Click report region
2. Check "Show Search Bar" checkbox
Done. 5 seconds. Zero code.
```

**Real Example: Vodacom's "Add Chart" Request**

**Friday 3 PM:**
- Boss: "Can we add a pie chart showing projects by status?"
- Sarah (traditional developer): "Sure, I'll have it ready next week" (needs to research charting libraries, write code, test)
- Sarah (APEX developer): "Give me 2 minutes"

**Sarah's Page Designer Steps:**
1. Open page in Page Designer
2. Right-click → Create Region
3. Type: Chart
4. Chart Type: Pie
5. Paste SQL:
   ```sql
   SELECT status AS label, COUNT(*) AS value
   FROM projects GROUP BY status
   ```
6. Click "Apply Changes"
7. Run page

**Result:** Professional interactive pie chart, 2 minutes, zero code

**Boss's reaction:** "Wait, you already did it? How?"

**The Three-Panel Magic**

Page Designer has three synchronized panels that work together:

**Left Panel - The Component Tree (Your Blueprint)**
```
Page 1: Dashboard
├─ Region: Welcome Message [📝 Static HTML]
├─ Region: Project Statistics [📊 Chart]
├─ Region: Recent Projects [📋 Report]
│   ├─ Column: Project Name
│   ├─ Column: Status
│   └─ Column: Client
├─ Region: Quick Actions [🎯 Buttons]
│   ├─ Button: Add Project
│   └─ Button: Export Report
└─ Process: Load User Preferences [⚙️ PL/SQL]
```

Click any item in the tree, and the right panel shows its properties. Change happens instantly in center preview.

**Center Panel - The Visual Canvas (WYSIWYG)**

Shows exactly what users will see. Drag regions to reorder. Click to select. No guessing.

**Right Panel - The Property Inspector (The Details)**

Select "Region: Project Statistics" in tree → Right panel shows:
- Name: Project Statistics
- Type: Chart (dropdown with 50+ types)
- Chart Type: Pie
- SQL Query: [text editor]
- Colors: [color picker]
- 100+ other properties

Change any property, click "Apply Changes" → Center panel updates immediately

**Vodacom's Productivity Gains**

After adopting Page Designer, here's what changed:

| Task | Before (Access) | After (APEX Page Designer) | Time Saved |
|------|----------------|---------------------------|------------|
| Build new dashboard page | 2 weeks | 4 hours | 95% |
| Add search functionality | 4 hours | 5 seconds | 99.9% |
| Add chart to page | 8 hours | 2 minutes | 99.6% |
| Rearrange page layout | 3 hours | 5 minutes | 97% |
| Make page mobile-responsive | 40 hours | 0 (automatic) | 100% |
| Change field labels | 30 minutes | 30 seconds | 98% |
| Add data validation | 2 hours | 5 minutes | 96% |
| Debug page errors | 4 hours | 30 minutes | 87% |

**Annual Development Time Saved:**
- Before: 520 hours/year on page maintenance
- After: 52 hours/year
- **Saved: 468 hours = 11.7 weeks = $46,800 (@$100/hr)**

**The Learning Curve**

**Sarah's experience:**
- **Day 1**: "This looks complicated with three panels"
- **Day 2**: "Oh, I see - tree shows structure, properties let me customize"
- **Week 1**: "I just built a complex form in 20 minutes that would've taken me 2 days in Access"
- **Month 1**: "I'm more productive than I've ever been. I actually enjoy development now."

**Why It Works for Non-Programmers:**

1. **Visual, Not Code**: You see what you're building, not code
2. **Guided**: Dropdown lists show available options, no memorization
3. **Forgiving**: Drag-drop can be undone, nothing breaks permanently
4. **Helpful**: Every property has help text explaining what it does
5. **Discoverable**: Browse component types, try them, see results immediately

**The Bottom Line**

Page Designer transformed Vodacom from "development is slow and painful" to "we can implement user requests in minutes." Their backlog of 40+ feature requests (accumulated over 2 years) was completed in 3 weeks using Page Designer.

**CEO's quote:** "APEX Page Designer is like going from building houses with hand tools to having prefab modules and power tools. The end result is better, faster, and cheaper. Why did we wait so long?"

In the next sections, we'll dive into exactly how to use Page Designer's three panels, what each component type does, and how to build professional pages without writing a single line of code (unless you want to customize further).

### Intermediate Explanation

Page Designer is APEX's integrated development environment (IDE) for building pages. Introduced in APEX 5.0 (2015), it replaced the old multi-screen page editing workflow with a unified, three-panel interface that dramatically improved developer productivity.

**The Three-Panel Architecture**

```
┌───────────────────────────────────────────────────────────────────┐
│                        Page Designer                              │
├───────────────┬──────────────────────────┬─────────────────────────┤
│               │                          │                         │
│  LEFT PANEL   │      CENTER PANEL        │    RIGHT PANEL          │
│  Rendering    │      Layout              │    Property Editor      │
│  Tree         │      (WYSIWYG)           │                         │
│               │                          │                         │
│  □ Page 1     │  ┌──────────────────┐   │  Identification         │
│   ├ Regions   │  │ Welcome Banner   │   │  ├ Name: Welcome       │
│   │ ├ Welcome │  ├──────────────────┤   │  ├ Type: Static        │
│   │ ├ KPIs    │  │ ┌──┐ ┌──┐ ┌──┐  │   │  └ Title: Welcome!    │
│   │ └ Report  │  │ │85│ │42│ │1M│  │   │                         │
│   ├ Items     │  │ └──┘ └──┘ └──┘  │   │  Source                 │
│   └ Buttons   │  ├──────────────────┤   │  ├ Type: HTML          │
│               │  │ Recent Projects  │   │  └ HTML: <h2>...       │
│  Click any    │  │ [table with...   │   │                         │
│  component ══>│  │  project data]   │   │  Layout                 │
│  Properties   │  └──────────────────┘   │  ├ Sequence: 10        │
│  appear in ══════════════════════════>  │  ├ Position: Body      │
│  right panel  │                          │  └ Template: Hero      │
│               │  ◄══ Visual preview      │                         │
│  ◄══ Structure│       of your page       │  ◄══ Edit properties   │
│      visible  │                          │      and see changes   │
└───────────────┴──────────────────────────┴─────────────────────────┘
        │                    │                         │
        └────────────────────┴─────────────────────────┘
                    All 3 panels stay synchronized
```

**🎓 See It in Action:**
- **Tutorial**: [Build a Movies Watchlist](https://apex.oracle.com/go/movies-lab) - Hands-on with Page Designer (2 hours, Intermediate)
- **Tutorial**: [Smart Project Management](https://apex.oracle.com/go/poc-lab) - Complex page layouts with AI (2 hours, Intermediate)
- **Documentation**: [Page Designer Guide](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/managing-pages-in-page-designer.html)

**1. Left Panel - Rendering Tree (Component Hierarchy)**

This panel shows the complete structural hierarchy of your page in an expandable tree format:

```
📄 Page 1: Dashboard
  ├─ 🎨 Page Rendering
  │   ├─ Pre-Rendering
  │   │   └─ Before Header
  │   │       └─ Computation: Set User Department
  │   ├─ Content Body
  │   │   ├─ Region: Welcome Banner [Position 1]
  │   │   │   └─ Static Content
  │   │   ├─ Region: KPI Cards [Position 2]
  │   │   │   ├─ Sub-Region: Total Projects
  │   │   │   ├─ Sub-Region: Active Clients
  │   │   │   └─ Sub-Region: Revenue YTD
  │   │   ├─ Region: Project List [Position 3]
  │   │   │   ├─ Column: PROJECT_NAME
  │   │   │   ├─ Column: STATUS
  │   │   │   ├─ Column: CLIENT_NAME
  │   │   │   └─ Button: Edit
  │   │   └─ Region: Activity Chart [Position 4]
  │   │       └─ Series 1: Projects by Month
  │   └─ Dialogs
  │       └─ Region: Edit Project Form
  │           ├─ Item: P1_PROJECT_ID (Hidden)
  │           ├─ Item: P1_PROJECT_NAME (Text)
  │           ├─ Item: P1_START_DATE (Date Picker)
  │           ├─ Button: Save
  │           └─ Button: Cancel
  ├─ ⚙️ Page Processing
  │   ├─ Validations
  │   │   └─ Validation: End Date After Start Date
  │   ├─ Processing
  │   │   ├─ Process: Save Project
  │   │   └─ Process: Send Notification Email
  │   └─ Branches
  │       └─ Branch: Return to Dashboard
  └─ 🔧 Shared Components
      ├─ Dynamic Actions
      │   ├─ DA: Refresh Chart on Status Change
      │   └─ DA: Show/Hide Budget Field
      ├─ Computations
      │   └─ Compute: Calculate Project Duration
      └─ Server-side Conditions
```

**Key Features:**
- **Drag-and-drop reordering**: Change sequence without re-numbering
- **Copy/paste/duplicate**: Right-click any component
- **Multi-select**: Shift+Click or Ctrl+Click for bulk operations
- **Filter view**: Show only regions, only items, etc.
- **Search**: Ctrl+F to find components by name

**2. Center Panel - Layout (WYSIWYG Preview)**

Visual representation of page layout with grid-based positioning:

```
┌─────────────────────────────────────────────────────────────────┐
│ [Vodacom Logo]        Dashboard             [User: Sarah ▾]    │ ← Header
├─────────────────────────────────────────────────────────────────┤
│ ☰ Menu  │                                                        │
├─────────┤  ┌──────────────────────────────────────────────────┐ │
│ 🏠 Home │  │  Welcome, Sarah! You have 12 active projects     │ │ ← Breadcrumb Bar
│ 📊 Dash │  └──────────────────────────────────────────────────┘ │
│ 📁 Proj │  ┌──────┐  ┌──────┐  ┌──────┐  ┌──────┐            │ │
│ 👥 Team │  │  85  │  │  42  │  │ 1.2M │  │  94% │            │ │ ← Region: KPI Cards
│ 📋 Tasks│  │Proj. │  │Clien.│  │ Rev. │  │Util. │            │ │   (4 sub-regions)
│ ⚙️ Set. │  └──────┘  └──────┘  └──────┘  └──────┘            │ │
├─────────┤  ┌──────────────────────────────────────────────────┐ │
│         │  │ Recent Projects          [Search] [+Add Project] │ │ ← Region: Project List
│         │  ├────────┬────────┬──────────┬────────┬───────────┤ │   (Interactive Report)
│         │  │ Name   │ Status │ Client   │ Manager│ Budget    │ │
│         │  ├────────┼────────┼──────────┼────────┼───────────┤ │
│         │  │ Proj A │ Active │ Acme     │ John   │ $500K  ✎ │ │
│         │  │ Proj B │ Hold   │ Global   │ Maria  │ $300K  ✎ │ │
│         │  │ Proj C │ Active │ FastCo   │ David  │ $750K  ✎ │ │
│         │  └────────┴────────┴──────────┴────────┴───────────┘ │
│         │  ┌──────────────────────────────────────────────────┐ │
│         │  │ Project Activity (Last 6 Months)                 │ │ ← Region: Chart
│         │  │  [Bar Chart: Projects completed per month]       │ │
│         │  └──────────────────────────────────────────────────┘ │
└─────────┴──────────────────────────────────────────────────────┘
```

**Grid System:**
- 12-column responsive grid (Bootstrap-based)
- Regions can span 1-12 columns
- Automatic responsive breakpoints:
  - Desktop (>992px): 12 columns
  - Tablet (768-992px): Adjusted layout
  - Mobile (<768px): Stacked (single column)

**Layout Controls:**
- **Column Span**: How wide (1-12 columns)
- **New Row**: Force region to new line
- **Column Start**: Begin at specific column
- **Position**: Absolute positioning for advanced layouts

**3. Right Panel - Property Editor (Configuration)**

Context-sensitive properties for selected component. Changes are organized into logical groups:

**Example: Region Properties (Interactive Report)**

```
Identification
├─ Name: Recent Projects
├─ Type: Interactive Report
├─ Title: Recent Projects (can include HTML)
└─ Static ID: recent_projects (for CSS/JS targeting)

Source
├─ Type: SQL Query
├─ SQL Query: [SQL Editor with syntax highlighting]
│     SELECT p.project_id,
│            p.project_name,
│            p.status,
│            c.client_name,
│            e.first_name || ' ' || e.last_name AS manager
│     FROM vodacom_projects p
│     JOIN vodacom_clients c ON p.client_id = c.client_id
│     JOIN vodacom_employees e ON p.manager_id = e.employee_id
│     WHERE p.is_active = 'Y'
│     ORDER BY p.start_date DESC
├─ Page Items to Submit: (items needed by query)
└─ Remote Server: (for REST data sources)

Layout
├─ Sequence: 30 (display order)
├─ Parent Region: (for sub-regions)
├─ Position: Content Body
├─ Template: Standard
├─ Template Options: [Dialog for styling options]
│     ├─ General: Default Padding
│     ├─ Header: Visible, Center Aligned
│     ├─ Body Height: Auto
│     └─ Accent: None
└─ CSS Classes: custom-report-style

Appearance
├─ Template: Standard
├─ Icon: fa-table
└─ CSS Classes: (custom styling)

Advanced
├─ Region Display Selector: Yes
├─ Static ID: recent_projects
├─ Lazy Loading: No
├─ Component Signature: (for declarative export)
└─ Browser Caching: No Cache

Server-side Condition
├─ Type: Item is NOT NULL
├─ Item: P1_SHOW_PROJECTS
└─ Execute: Once

Configuration (Read Only)
├─ Build Option: (feature toggle)
└─ Authorization Scheme: Must Not Be Public User

Attributes (Interactive Report-Specific)
├─ Pagination: Row Ranges 1-50
├─ Toolbar: Yes
│   ├─ Show Search Bar: Yes
│   ├─ Show Select Columns: Yes
│   ├─ Show Filter: Yes
│   ├─ Show Actions Menu: Yes
│   ├─ Show Download Options: CSV, HTML, PDF
│   └─ Show Help: Yes
├─ Performance: Lazy Load Report: No
├─ Messages: No Data Found: "No projects match your criteria"
├─ Pagination Type: Row Ranges
├─ Number of Rows: 50
└─ Maximum Report Width: 100%
```

**Property Editor Features:**
- **Inline Help**: Hover over any property label for tooltip
- **Smart Defaults**: Most properties pre-configured optimally
- **Go To**: Jump to referenced components
- **SQL Workshop**: Test queries in SQL Workshop without leaving
- **Validation**: Real-time validation of SQL, LOVs, etc.

**Synchronized Interaction Flow**

All three panels stay synchronized:

```
Action in ANY panel → Updates ALL panels

Example Flow:
1. Click "Region: Recent Projects" in Left Tree
   → Center panel highlights that region
   → Right panel shows region properties

2. Change "Title" in Right Panel to "Active Projects"
   → Left tree updates name
   → Center panel updates region header immediately

3. Drag region in Center Panel to different position
   → Left tree updates sequence number
   → Right panel shows new Sequence value

4. Right-click in Left Tree → Duplicate
   → New region appears in Center Panel
   → Properties shown in Right Panel
```

**Page Component Types**

**Regions** (Content Containers):

| Type | Purpose | Vodacom Use Case | Complexity |
|------|---------|-------------------|------------|
| **Interactive Report** | Searchable, filterable data table | Employee directory, project list | Low |
| **Interactive Grid** | Editable spreadsheet interface | Timesheet entry, task assignments | Medium |
| **Classic Report** | Fixed-format report | Invoices, printed reports | Low |
| **Form** | Data entry for single record | Edit employee, add project | Low |
| **Chart** | Data visualization | Revenue by month, projects by status | Low |
| **Calendar** | Date-based data display | Project timeline, employee schedules | Medium |
| **Map** | Geographic data | Client locations, site maps | Medium |
| **Tree** | Hierarchical data | Org chart, folder structure | Medium |
| **List** | Menu, navigation | Sidebar navigation, action buttons | Low |
| **Static Content** | HTML/Markdown | Welcome messages, instructions | Low |
| **Dynamic Content** | PL/SQL-generated HTML | Complex custom layouts | High |
| **PL/SQL Function Body** | Programmatic output | Custom reports, badges | High |
| **Cards** | Tile-based layout | Product gallery, team members | Low |
| **Breadcrumb** | Navigation trail | Home > Projects > Edit | Low |
| **Plugin Region** | Custom components | Gantt chart, Kanban board | Variable |

**Items** (Input/Output Fields):

| Type | Description | Example | Validation |
|------|-------------|---------|------------|
| **Text Field** | Single-line text | Name, Email | Max Length, Pattern |
| **Textarea** | Multi-line text | Description, Notes | Max Length |
| **Number Field** | Numeric input | Budget, Quantity | Min/Max, Format |
| **Date Picker** | Calendar date selector | Start Date, Hire Date | Min/Max Date |
| **Select List** | Dropdown (single) | Status, Department | LOV |
| **Checkbox** | Yes/No toggle | Is Active, Approved | Boolean |
| **Radio Group** | Single choice from options | Priority: Low/Med/High | Static LOV |
| **Switch** | Toggle (on/off) | Enable Notifications | Boolean |
| **Shuttle** | Move items between lists | Assign roles, select features | LOV |
| **Popup LOV** | Searchable modal select | Select Employee (from 1000s) | LOV |
| **File Browse** | File upload | Upload Document, Profile Pic | File Type, Size |
| **Rich Text Editor** | WYSIWYG HTML | Email body, formatted notes | None |
| **Hidden** | Store value, not visible | Record ID, Session state | None |
| **Display Only** | Show value, not editable | Created Date, Record Owner | None |
| **Password** | Masked text | Password, PIN | Strength |

**Buttons**:

| Position | Purpose | Behavior |
|----------|---------|----------|
| **Region Header** | Primary actions | Create, Export, Download |
| **Region Footer** | Secondary actions | Refresh, Reset Filters |
| **Form Actions** | Submit/Cancel | Save, Delete, Cancel |
| **Region Buttons** | Row-level actions | Edit (in reports), Select |
| **Dialog Buttons** | Modal actions | OK, Cancel, Apply |

**Processes** (Server-side Logic):

| Type | When Executed | Purpose |
|------|---------------|---------|
| **Form Automatic DML** | After Submit | Insert/Update/Delete form data |
| **Execute Code** | After Submit or On Load | Custom PL/SQL logic |
| **Send Email** | After Submit | Notifications |
| **Close Dialog** | After Submit | Close modal form |
| **Invoke API** | On Load or After Submit | Call REST APIs |
| **Execute Legacy PL/SQL** | After Submit | Call existing procedures |

**Dynamic Actions** (Client-side Behavior):

| Event | Action | Example |
|-------|--------|---------|
| **Change** | Show/Hide, Enable/Disable | If Status=Closed, hide Edit button |
| **Click** | Submit, Refresh, Alert | Refresh chart when button clicked |
| **Page Load** | Execute JavaScript, Set Value | Initialize maps, load preferences |
| **Selection Change** | Refresh, Set Value | Update detail report when master row selected |
| **Before Page Submit** | Validate, Confirm | "Are you sure?" dialog |

**Page Rendering and Processing Order**

Understanding execution order is critical for debugging:

**Rendering Order (When Page Loads):**

```
USER REQUESTS PAGE
        ↓
┌─────────────────────┐
│ Before Header       │ ← Computations, Processes run first
│ - Set variables     │
│ - Load preferences  │
└─────────────────────┘
        ↓
┌─────────────────────┐
│ Authorization       │ ← Check if user can access page
│ - Page-level        │
│ - Region-level      │
└─────────────────────┘
        ↓
┌─────────────────────┐
│ Regions Render      │ ← Execute SQL, fetch data
│ (Sequence Order)    │
│ 1. Welcome (10)     │
│ 2. KPIs (20)        │
│ 3. Report (30)      │
└─────────────────────┘
        ↓
┌─────────────────────┐
│ Items Render        │ ← Fetch session state, apply defaults
│ - Text fields       │
│ - Dropdowns         │
│ - Date pickers      │
└─────────────────────┘
        ↓
┌─────────────────────┐
│ Buttons Render      │ ← Apply authorization
└─────────────────────┘
        ↓
┌─────────────────────┐
│ Dynamic Actions     │ ← Bind JavaScript events
│ - Show/Hide         │
│ - AJAX refresh      │
└─────────────────────┘
        ↓
┌─────────────────────┐
│ After Footer        │ ← Final processes
└─────────────────────┘
        ↓
   PAGE DISPLAYED
```

**🎓 Deep Dive:**
- **Documentation**: [Understanding Page Rendering](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/understanding-page-rendering-and-processing.html)
- **Debug Mode**: Enable debug to see exact execution timing and SQL statements

**Rendering Order (When Page Loads):**

```
1. Before Header
   └─ Computations
   └─ Processes

2. Authorization Scheme Evaluation
   └─ Check if user can access page

3. Region Authorization
   └─ Check which regions user can see

4. Regions Render (Sequence Order)
   ├─ Execute SQL Query
   ├─ Apply Template
   ├─ Render Items
   └─ Generate HTML

5. Items Render
   ├─ Fetch session state values
   ├─ Apply default values
   └─ Apply format masks

6. Buttons Render
   └─ Apply authorization schemes

7. Dynamic Actions Bind
   └─ Attach JavaScript event handlers

8. After Footer
   └─ Processes
   └─ Computations
```

**Processing Order (When User Submits):**

```
1. Validations (Stop if any fail)
   ├─ Item-level validations
   ├─ Page-level validations
   └─ Return error messages to page

2. Processes (Execute in Sequence Order)
   ├─ Before Submit processes
   ├─ After Submit processes
   │   ├─ DML (Insert/Update/Delete)
   │   ├─ Execute Code
   │   ├─ Send Email
   │   └─ API calls
   └─ After Processing processes

3. Branches (First valid branch fires)
   ├─ Evaluate conditions
   ├─ Navigate to target page
   └─ Clear cache if specified
```

**Vodacom's Real-World Page Designer Usage**

**Time Breakdown for Common Tasks:**

| Task | Traditional Code | Page Designer | Time Saved |
|------|-----------------|---------------|------------|
| Create new blank page | 15 min | 10 sec | 98.9% |
| Add interactive report | 2 hours | 2 min | 98.3% |
| Add form with 10 fields | 4 hours | 5 min | 97.9% |
| Add chart region | 3 hours | 3 min | 98.3% |
| Add button with validation | 45 min | 2 min | 95.6% |
| Create master-detail page | 8 hours | 15 min | 96.9% |
| Add dynamic behavior | 2 hours | 5 min | 95.8% |
| Reorder page regions | 30 min | 30 sec | 98.3% |
| Change field labels | 20 min | 1 min | 95.0% |
| Add conditional display | 1 hour | 3 min | 95.0% |

**Productivity Metrics:**
- **Average page build time**: 30 minutes (vs 8 hours traditional)
- **Pages built per week**: 10-15 (vs 1-2 traditional)
- **Maintenance time**: 70% reduction
- **Bugs introduced**: 60% reduction (less manual code)

**Best Practices from Vodacom's Experience:**

✅ **DO:**
- Use descriptive names (P1_PROJECT_NAME not P1_X)
- Organize regions logically (sequence 10, 20, 30 - allows inserting between)
- Comment complex SQL queries
- Test on mobile view regularly
- Use templates consistently
- Leverage shared components (don't duplicate LOVs)

❌ **DON'T:**
- Hardcode values (use application items/substitution strings)
- Overuse dynamic actions (can slow page)
- Create massive SQL queries (use views instead)
- Ignore authorization schemes (always secure pages)
- Skip naming conventions
- Copy-paste without reviewing properties

In the Advanced Explanation section next, we'll cover performance optimization, debugging techniques, and advanced customization patterns.

### Advanced Explanation

Page Designer uses a **component-based architecture** with execution order:

**Page Rendering (When Loading):**
```
Before Header Computations
↓
Authorization Checks
↓
Regions Render (in sequence order)
  ├── Execute SQL query
  ├── Apply templates
  └── Generate HTML
↓
Items Render
↓
Dynamic Actions Bind (client-side)
↓
After Footer Processes
```

**Page Processing (When Submitting):**
```
After Submit:
  ├── Validations (stop if fail)
  ├── Processes (in order)
  ├── Branches (first valid fires)
  └── Return to page or redirect
```

**Performance Optimization:**
- Lazy loading for regions
- AJAX refresh for specific components
- Page caching (rarely changing data)
- SQL query result cache

---

## Labs / Practicals

### Lab 1: Simple - Add and Configure Page Regions

**Objective:** Use Page Designer to add regions to Vodacom dashboard.

**Step 1: Open Page in Page Designer**
1. Navigate to application
2. Click page number (e.g., Page 1 - Home)
3. Page Designer opens automatically

**Step 2: Add Static Content Region**
```
Right Panel → Create Region
  Name: Welcome Message
  Type: Static Content
  Position: Content Body
  Template: Hero
  Source: 
    <h2>Welcome to Vodacom Project Manager</h2>
    <p>Track projects, manage teams, deliver success.</p>
```

**Step 3: Add Interactive Report Region**
```
Create Region
  Name: Recent Projects
  Type: Interactive Report
  Source:
    SELECT project_name, status, start_date, 
           client_name, project_manager
    FROM vw_project_dashboard
    WHERE ROWNUM <= 10
    ORDER BY start_date DESC;
```

**Step 4: Add Chart Region**
```
Create Region
  Name: Projects by Status
  Type: Chart
  Chart Type: Pie
  Source:
    SELECT status AS label,
           COUNT(*) AS value
    FROM vodacom_projects
    GROUP BY status;
```

**Expected Output:**
- Three regions visible on page
- Chart displays pie chart
- Report shows recent projects

---

### Lab 2: Intermediate - Create Interactive Form with Validations

**Objective:** Build employee form with business rules.

**Step 1: Create Form Page**
```
Create Page → Form → Form on Table
  Table: VODACOM_EMPLOYEES
  Primary Key: EMPLOYEE_ID
  Page Number: 10
  Page Name: Edit Employee
```

**Step 2: Add Validation - Email Format**
```
Create Validation
  Name: Valid Email Format
  Type: Item is valid email address
  Item: P10_EMAIL
  Error Message: Please enter a valid email address.
```

**Step 3: Add Validation - Salary Range**
```
Create Validation
  Name: Salary Within Range
  Type: PL/SQL Function Returning Boolean
  Validation Code:
    RETURN :P10_SALARY BETWEEN 30000 AND 300000;
  Error Message: Salary must be between $30,000 and $300,000.
```

**Step 4: Add Process - Audit Trail**
```
Create Process (After Submit)
  Name: Log Employee Change
  Type: Execute Code
  PL/SQL Code:
    INSERT INTO audit_log (table_name, record_id, action, changed_by)
    VALUES ('EMPLOYEES', :P10_EMPLOYEE_ID, 'UPDATE', :APP_USER);
```

---

### Lab 3: Advanced - Dynamic Actions for UX Enhancement

**Objective:** Add client-side interactivity without page refresh.

**Step 1: Show/Hide Regions Based on Selection**
```
Create Dynamic Action
  Event: Change
  Item: P1_VIEW_TYPE (radio group: Summary/Detailed)
  
  True Action 1:
    Action: Show
    Affected Elements: Region - Detailed View
    Condition: Value = 'Detailed'
  
  True Action 2:
    Action: Hide
    Affected Elements: Region - Summary View
```

**Step 2: Auto-Calculate Budget Remaining**
```
Create Dynamic Action
  Event: Change
  Items: P5_BUDGET, P5_ACTUAL_COST
  
  True Action:
    Action: Set Value
    Set Type: JavaScript Expression
    JavaScript: 
      parseFloat($v('P5_BUDGET')) - parseFloat($v('P5_ACTUAL_COST'))
    Items to Set: P5_BUDGET_REMAINING
```

**Step 3: AJAX Refresh on Filter Change**
```
Create Dynamic Action
  Event: Change
  Item: P1_DEPARTMENT_FILTER
  
  True Action:
    Action: Refresh
    Affected Elements: Region - Employee Report
```

---

## Real-World Practical

### Vodacom Scenario: Build Project Dashboard with KPIs

**Requirements:**
1. Executive dashboard showing:
   - Active projects count (card)
   - Total budget vs actual (gauge chart)
   - Timeline (Gantt chart region)
   - Top 5 overbudget projects (report)
2. Filters: Date range, department, status
3. Auto-refresh every 5 minutes
4. Drill-down to project details

**Implementation:**
- Use Page Designer to create 8 regions
- Configure cascading LOVs for filters
- Set up dynamic actions for filter changes
- Add AJAX refresh for real-time updates

---

## Assessment

### MCQs

**Q1:** What are the three panels in Page Designer?

A) Header, Body, Footer  
B) Page Structure, Layout, Properties  
C) SQL, JavaScript, CSS  
D) Development, Test, Production  

**Answer: B**

**Q2:** Which component type executes on form submission?

A) Region  
B) Dynamic Action  
C) Process  
D) Validation  

**Answer: C (Processes run after submit; Validations check first)**

**Q3:** How do you refresh a report region without reloading the entire page?

A) Use a Branch  
B) Create a Dynamic Action with Refresh action  
C) Write JavaScript console.log()  
D) Restart the application  

**Answer: B**

### Short Answer

**Q1:** Explain the difference between a Process and a Dynamic Action in APEX.

**Answer:** 
- **Process**: Server-side PL/SQL code that runs when page submits (e.g., save data to database, send email). Requires full page refresh.
- **Dynamic Action**: Client-side JavaScript behavior triggered by events (click, change, load). Runs in browser without page refresh, used for UX enhancements like show/hide, AJAX updates.

**Q2:** Vodacom wants to prevent users from saving a project with end_date before start_date. How would you implement this?

**Answer:** Create a Validation:
- Type: PL/SQL Function Returning Boolean
- Code: `RETURN :P5_END_DATE >= :P5_START_DATE;`
- Error Message: "End date must be after start date."
- Execute: After Submit, before processing

### Practical Challenge

**Project:** Build Vodacom Timesheet Entry Page

**Requirements:**
- Form to enter: Date, Project, Task, Hours, Description
- Validations: Hours 0-24, Date not in future
- Dynamic Action: Load tasks based on selected project
- Process: Save to database and calculate project totals
- Success message with total hours this week

**Deliverables:**
- Page export
- Screenshots showing validations working
- Test data

---

## PowerPoint Slides

### Slide 1: Managing Pages and Page Designer
**Vodacom Corp Training - Lesson 03**

### Slide 2: Page Designer Interface
**Three Synchronized Panels**

**Left**: Page Structure (tree view)  
**Center**: Layout (visual preview)  
**Right**: Properties (configuration)

**Benefit**: See code and design simultaneously

### Slide 3: Page Components
- **Regions**: Content containers
- **Items**: Input/output fields
- **Buttons**: Actions
- **Processes**: Server logic
- **Validations**: Data checks
- **Dynamic Actions**: Client behavior

### Slide 4: Page Execution Flow
**Rendering:** Load data → Display  
**Processing:** Validate → Save → Branch

**Order matters!** Set sequence numbers

### Slide 5: Dynamic Actions
**Client-Side Magic**

No page refresh needed:
- Show/Hide regions
- Calculate values
- AJAX refresh
- Call JavaScript

**Better UX, faster app**

### Slide 6: Best Practices
✅ Name components clearly  
✅ Use regions to organize  
✅ Add help text to items  
✅ Test validations thoroughly  
✅ Minimize page processes  
✅ Use AJAX for real-time updates  

### Slide 7: Vodacom Dashboard
**Built with Page Designer**

- 5 regions (KPIs, charts, reports)
- Cascading filters
- Auto-refresh every 5 minutes
- Mobile-responsive

**Created in 2 hours!**

### Slide 8: Lab Preview
**Lab 1**: Add regions to dashboard  
**Lab 2**: Create form with validations  
**Lab 3**: Dynamic actions for UX

**Challenge**: Timesheet entry page

### Slide 9: Next Lesson
**Lesson 04: Reports and Forms**

Interactive Reports, Classic Reports, Form types, Master-Detail

### Slide 10: Q&A
**Questions?**

Practice: Open Page Designer and explore!

