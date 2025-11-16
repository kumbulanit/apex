# Lab 03: Pages and Page Designer

**Duration:** 120 minutes  
**Difficulty:** Intermediate  
**Prerequisites:** Completed Lab 02 (Employee Management System created)

## Learning Objectives

By the end of this lab, you will be able to:
1. Navigate and use Page Designer's three-panel interface
2. Create and customize different page types
3. Add and configure regions, items, and buttons
4. Use Dynamic Actions for interactive behavior
5. Understand page rendering and processing order
6. Customize page templates and appearance

---

## Lab Scenario

**🎯 Building the Enterprise Call Center Application - Lab 3 of 7**

You're building the **Network Operations Center** module for Vodacom's call center application. This sophisticated dashboard will be used by network engineers to monitor:

**What You're Building This Lab:**
- **Network KPIs Dashboard** - 15,000 cell towers, uptime metrics
- **Incident Management Grid** - Real-time outage tracking
- **Performance Charts** - Network health by region
- **Quick Incident Logging** - Fast problem reporting

**How This Fits the Complete Application:**
```
Vodacom Enterprise Call Center Application
├── Customer Management (Labs 1-2)
├── Call Center Operations (Labs 4-5)
├── 📡 Network Operations Center (Lab 3) ← YOU ARE HERE
├── Package & Billing (Lab 4)
├── Security & Performance (Lab 6)
└── Production Deployment (Lab 7)
```

You'll master Page Designer's three-panel interface to build production-quality enterprise dashboards.

---

## Part 1: Understanding Page Designer Interface (20 minutes)

### Exercise 1.1: Explore Page Designer

**Steps:**

1. **Open Existing Page in Page Designer**
   - From App Builder, click to open your **Employee Management System**
   - **What you'll see:** A list of pages with numbers (1, 2, 3, etc.)
   - **What to click:** Click on page **1** (Home/Dashboard)
   - **What happens:** Page Designer opens (may take 2-3 seconds to load)
   - **What you'll see:** A screen split into THREE vertical panels

   ```
   📸 SCREENSHOT PLACEHOLDER: Page Designer with three panels visible
   ```

   **🗺️ Page Designer Layout:**
   ```
   ┌────────────┴─────────────────┴────────────────┐
   │  LEFT PANEL  │ CENTER PANEL  │ RIGHT PANEL  │
   │             │               │              │
   │ Rendering   │   Layout      │  Property    │
   │ Tree        │   (Visual)    │  Editor      │
   │             │               │              │
   │ ┌───Page 1  │  ┌───────┐  │ Name: [...]  │
   │ ├─Regions  │  │Region1│  │ Type: [...]  │
   │ │ ├─Chart │  │-------│  │ Title:[...]  │
   │ │ └─Items │  └───────┘  │              │
   │ └─Process  │               │              │
   └─────────────┴─────────────────┴────────────────┘
   ```

2. **Explore Left Panel (Rendering Tree)**
   - **What it is:** A hierarchical tree view of ALL page components
   - **Where to look:** Left side of screen (takes up ~25% of width)
   - **What to do:**
     - Click the small arrow (►) next to **Page 1: Dashboard** to expand
     - Click arrow next to **Regions** folder to expand
     - **What you'll see:** List of regions (Dashboard charts you created)
     - Click on each region name to select it
   - **What happens:** 
     - Center panel highlights that region
     - Right panel shows its properties

   ```
   📸 SCREENSHOT PLACEHOLDER: Rendering Tree expanded showing regions
   ```

   **🔍 Left Panel Structure:**
   ```
   └── Page 1: Dashboard
       ├── Pre-Rendering           (runs before page loads)
       ├── ▼ Regions              (visible page content)
       │   ├── Employees by Dept   (your bar chart)
       │   └── Employee Status     (your pie chart)
       ├── ► Items                (form fields, buttons)
       ├── ► Buttons              (action buttons)
       ├── Processing              (runs on submit)
       ├── ► Processes            (background operations)
       └── Dynamic Actions         (client-side logic)
   ```

3. **Explore Center Panel (Layout)**
   - **What it is:** Visual preview of your page (WYSIWYG editor)
   - **Where to look:** Middle of screen (takes up ~50% of width)
   - **What you'll see:** A visual representation of your page with boxes/regions
   - **What to try:**
     - Hover over a region → it highlights
     - Click a region → it selects (blue border)
     - Try dragging a region to a different position (click and hold, then move)
   - **What happens:** The left panel (Rendering Tree) updates automatically!

   ```
   📸 SCREENSHOT PLACEHOLDER: Layout view showing draggable regions
   ```

   **💡 Pro Tip:**
   - Grid lines help you position regions
   - Regions snap to grid automatically
   - You can resize regions by dragging edges

4. **Explore Right Panel (Property Editor)**
   - **What it is:** Detailed settings for the selected component
   - **Where to look:** Right side of screen (takes up ~25% of width)
   - **What you'll see:** Form fields organized in collapsible sections
   - **What to try:**
     - Click on **Page 1** in the left tree
     - **What you'll see in right panel:**
       - **Identification** (name, title)
       - **Security** (who can access)
       - **Advanced** (custom CSS, JavaScript)
     - Now click on a **Region** in the left tree
     - **What you'll see:** Different properties!
       - **Identification** (region name, type)
       - **Source** (SQL query for charts/reports)
       - **Appearance** (template, CSS classes)

   ```
   📸 SCREENSHOT PLACEHOLDER: Property Editor showing region properties
   ```

   **🔍 Property Sections (Common):**
   - **Identification**: Name, type, title
   - **Source**: SQL query or static content
   - **Appearance**: Template, CSS classes
   - **Layout**: Position on page
   - **Security**: Who can see this
   - **Advanced**: Custom code

5. **Test Synchronization**
   - **What to do:** Try this workflow to see how panels work together:
   
   **🔄 Synchronization Test:**
   1. In **Left Panel**: Click a region (e.g., "Employees by Dept")
   2. In **Center Panel**: That region highlights with blue border ✅
   3. In **Right Panel**: Properties for that region appear ✅
   4. In **Right Panel**: Change the **Title** property
   5. In **Center Panel**: Title updates immediately! ✨
   
   - **Key concept:** All three panels stay synchronized!
   - **Navigation tip:** You can click in ANY panel to select a component

**📚 Glossary:**
- **Rendering Tree**: Hierarchical list of all page components
- **Layout**: Visual "what you see is what you get" editor
- **Property Editor**: Form to change component settings
- **Region**: A container for content (charts, reports, forms, HTML)
- **Item**: A form field (text box, dropdown, etc.)
- **Process**: Background code that runs when button is clicked

---

## Part 2: Create Project Dashboard Page (40 minutes)

### Exercise 2.1: Create Blank Page

1. **Create New Page**
   - Click the **Page Finder** dropdown (top left)
   - Click **+ Create Page**
   - Select: **Blank Page**
   - Page Number: `10` (or next available)
   - Name: `Project Dashboard`
   - Page Mode: `Normal`
   - Breadcrumb: `Breadcrumb` → Entry: `Project Dashboard`
   - Click **Create Page**

2. **Configure Page Properties**
   - In Page Designer, ensure **Page 10** is selected in left tree
   - Right Panel → **Identification**
     - Title: `Project Dashboard`
   - Right Panel → **Appearance**
     - Page Template: `Standard`
   - Right Panel → **CSS**
     - Inline CSS:
       ```css
       .kpi-card {
           text-align: center;
           padding: 20px;
       }
       .kpi-value {
           font-size: 3em;
           font-weight: bold;
           color: #2196F3;
       }
       .kpi-label {
           font-size: 1.2em;
           color: #666;
       }
       ```

### Exercise 2.2: Add KPI Cards Region

1. **Create KPI Container Region**
   - Right-click **Content Body** in left panel
   - Select **Create Region**
   - Identification:
     - Title: `Key Performance Indicators`
     - Type: `Static Content`
   - Layout:
     - Sequence: `10`
     - Position: `Content Body`
   - Appearance:
     - Template: `Hero`
     - CSS Classes: `kpi-container`

2. **Add Total Projects KPI (Sub-Region)**
   - Right-click the **Key Performance Indicators** region
   - Select **Create Sub Region**
   - Identification:
     - Title: (leave blank)
     - Type: `HTML`
   - Source:
     - HTML Code:
       ```html
       <div class="kpi-card">
           <div class="kpi-value">&TOTAL_PROJECTS.</div>
           <div class="kpi-label">Total Projects</div>
       </div>
       ```
   - Layout:
     - Column: `Automatic`
     - Column Span: `3` (takes 1/4 of 12-column grid)
     - New Row: `No`

3. **Create Computation for Total Projects**
   - In left panel, expand **Pre-Rendering**
   - Right-click **Before Header**
   - Select **Create Computation**
   - Identification:
     - Item Name: `TOTAL_PROJECTS`
   - Computation:
     - Type: `SQL Query (return single value)`
     - SQL Query:
       ```sql
       SELECT COUNT(*)
       FROM technova_projects
       WHERE is_active = 'Y'
       ```

4. **Add Active Projects KPI**
   - Repeat step 2 for Active Projects:
   - HTML Code:
     ```html
     <div class="kpi-card">
         <div class="kpi-value" style="color: #4CAF50;">&ACTIVE_PROJECTS.</div>
         <div class="kpi-label">Active Projects</div>
     </div>
     ```
   - Column Span: `3`
   - Add computation:
     ```sql
     SELECT COUNT(*)
     FROM technova_projects
     WHERE status = 'Active'
       AND is_active = 'Y'
     ```

5. **Add Budget KPI**
   - HTML Code:
     ```html
     <div class="kpi-card">
         <div class="kpi-value" style="color: #FF9800;">R &TOTAL_BUDGET.</div>
         <div class="kpi-label">Total Budget</div>
     </div>
     ```
   - Column Span: `3`
   - Computation:
     ```sql
     SELECT TO_CHAR(SUM(budget), 'FM999,999,999')
     FROM technova_projects
     WHERE is_active = 'Y'
     ```

6. **Add Completion Rate KPI**
   - HTML Code:
     ```html
     <div class="kpi-card">
         <div class="kpi-value" style="color: #9C27B0;">&COMPLETION_RATE.%</div>
         <div class="kpi-label">Completion Rate</div>
     </div>
     ```
   - Column Span: `3`
   - Computation:
     ```sql
     SELECT ROUND(
         (COUNT(CASE WHEN status = 'Completed' THEN 1 END) * 100.0) / 
         NULLIF(COUNT(*), 0)
     )
     FROM technova_projects
     WHERE is_active = 'Y'
     ```

7. **Save and Run**
   - Click **Save** (top right)
   - Click **Run** to see your KPIs!

### Exercise 2.3: Add Interactive Grid for Projects

1. **Create Interactive Grid Region**
   - Right-click **Content Body** in left panel
   - Select **Create Region**
   - Identification:
     - Title: `Projects`
     - Type: `Interactive Grid`
   - Source:
     - Type: `SQL Query`
     - SQL Query:
       ```sql
       SELECT p.project_id,
              p.project_name,
              c.company_name AS client,
              e.first_name || ' ' || e.last_name AS project_manager,
              p.status,
              TO_CHAR(p.start_date, 'YYYY-MM-DD') AS start_date,
              TO_CHAR(p.end_date, 'YYYY-MM-DD') AS end_date,
              p.budget,
              p.description
       FROM technova_projects p
       LEFT JOIN technova_clients c ON p.client_id = c.client_id
       LEFT JOIN technova_employees e ON p.project_manager = e.emp_id
       WHERE p.is_active = 'Y'
       ORDER BY p.start_date DESC
       ```
   - Layout:
     - Sequence: `20`
     - Position: `Content Body`

2. **Configure Interactive Grid Attributes**
   - Select the **Projects** region
   - Right Panel → Scroll to **Attributes**
   - Editable: `Yes`
   - Edit:
     - Enabled: `Yes`
     - Mode: `Row`
     - Lost Update Type: `Row Values`
   - Add Row: `Yes`
   - Delete Row: `Yes`

3. **Configure Columns**
   - Expand **Projects** region → Expand **Columns**
   - **PROJECT_ID**:
     - Type: `Hidden`
     - Primary Key: `Yes`
   - **PROJECT_NAME**:
     - Heading: `Project Name`
     - Required: `Yes`
     - Width: `200`
   - **CLIENT**:
     - Heading: `Client`
     - Type: `Text Field` (read-only)
   - **PROJECT_MANAGER**:
     - Heading: `Manager`
   - **STATUS**:
     - Heading: `Status`
     - Type: `Select List`
     - List of Values:
       - Type: `Static Values`
       - Static Values:
         ```
         STATIC:Not Started,Not Started,In Progress,In Progress,On Hold,On Hold,Completed,Completed,Cancelled,Cancelled
         ```
   - **START_DATE**, **END_DATE**:
     - Type: `Date Picker`
     - Format Mask: `YYYY-MM-DD`
   - **BUDGET**:
     - Heading: `Budget`
     - Format Mask: `FML999G999G999G999G990D00`

4. **Add Save Button**
   - Right-click **Projects** region in left panel
   - Select **Create Button**
   - Identification:
     - Button Name: `SAVE_GRID`
     - Label: `Save Changes`
   - Layout:
     - Position: `Right of Interactive Grid Search Bar`
   - Appearance:
     - Button Template: `Text with Icon`
     - Hot: `Yes` (makes it blue/prominent)
     - Icon: `fa-save`

### Exercise 2.4: Add Processing Logic

1. **Create Process to Save Interactive Grid**
   - In left panel, expand **Processing**
   - Right-click **Processing**
   - Select **Create Process**
   - Identification:
     - Name: `Save Interactive Grid`
     - Type: `Interactive Grid - Automatic Row Processing (DML)`
   - Settings:
     - Region: `Projects`
     - Editable Region: `Projects`
   - Server-side Condition:
     - When Button Pressed: `SAVE_GRID`

2. **Add Success Message**
   - Right-click **Processing**
   - Select **Create Process**
   - Identification:
     - Name: `Show Success Message`
     - Type: `Execute Code`
   - Source → PL/SQL Code:
     ```sql
     apex_application.g_print_success_messages := TRUE;
     ```
   - Success Message:
     - Success Message: `Project changes saved successfully!`
   - Server-side Condition:
     - When Button Pressed: `SAVE_GRID`

---

## Part 3: Add Chart Region (30 minutes)

### Exercise 3.1: Create Status Chart

1. **Create Chart Region**
   - Right-click **Content Body**
   - Select **Create Region**
   - Identification:
     - Title: `Projects by Status`
     - Type: `Chart`
   - Source:
     - Type: `SQL Query`
     - SQL Query:
       ```sql
       SELECT status AS label,
              COUNT(*) AS value
       FROM technova_projects
       WHERE is_active = 'Y'
       GROUP BY status
       ORDER BY COUNT(*) DESC
       ```
   - Layout:
     - Sequence: `30`
     - Position: `Content Body`
     - Start New Row: `Yes`
     - Column: `Automatic`
     - Column Span: `6` (half width)

2. **Configure Chart Attributes**
   - Select **Projects by Status** region
   - Right Panel → **Attributes**
   - Chart Type: `Donut`
   - Settings:
     - Show Legend: `Yes`
     - Legend Position: `Right`
     - Show Value: `Yes`
     - Show Label: `Yes`
   - Appearance:
     - Height: `400`

3. **Add Budget Chart**
   - Create another chart region (similar to above)
   - Title: `Budget by Status`
   - SQL Query:
     ```sql
     SELECT status AS label,
            SUM(budget) AS value
     FROM technova_projects
     WHERE is_active = 'Y'
     GROUP BY status
     ```
   - Layout:
     - Column Span: `6` (places it next to first chart)
     - Start New Row: `No`
   - Chart Type: `Bar`
   - Value Format Mask: `FML999G999G999`

---

## Part 4: Add Dynamic Actions (30 minutes)

### Exercise 4.1: Auto-Refresh Charts on Grid Save

1. **Create Dynamic Action**
   - Right-click **SAVE_GRID** button in left panel
   - Select **Create Dynamic Action**
   - Identification:
     - Name: `Refresh Charts After Save`
   - When:
     - Event: `Click`
     - Selection Type: `Button`
     - Button: `SAVE_GRID`

2. **Add Refresh Action**
   - Under the Dynamic Action, right-click **True** actions
   - Select **Create TRUE Action**
   - Identification:
     - Action: `Refresh`
   - Affected Elements:
     - Selection Type: `Region`
     - Region: `Projects by Status`
   - Click **Add Action** (the + button on True)
   - Add another action:
     - Action: `Refresh`
     - Region: `Budget by Status`
   - Add third action:
     - Action: `Refresh`
     - Region: `Key Performance Indicators`

### Exercise 4.2: Add Confirmation Dialog for Delete

1. **Create Dynamic Action on Grid**
   - Right-click **Projects** Interactive Grid region
   - Select **Create Dynamic Action**
   - Identification:
     - Name: `Confirm Delete`
   - When:
     - Event: `Row Delete`
     - Selection Type: `Region`
     - Region: `Projects`

2. **Add Confirm Action**
   - Right-click **True** actions
   - Select **Create TRUE Action**
   - Identification:
     - Action: `Confirm`
   - Settings:
     - Title: `Delete Project?`
     - Message: `Are you sure you want to delete this project? This action cannot be undone.`
     - Style: `Danger`
     - Button Set: `Yes/No`

### Exercise 4.3: Add Quick Add Dialog

1. **Create Button for Quick Add**
   - Right-click **Projects** region
   - Select **Create Button**
   - Identification:
     - Button Name: `ADD_PROJECT`
     - Label: `Quick Add Project`
   - Layout:
     - Position: `Next`
   - Appearance:
     - Icon: `fa-plus`
     - Hot: `No`

2. **Create Modal Dialog Page**
   - Click **Page Finder** (top left)
   - Click **+ Create Page**
   - Select: **Blank Page**
   - Page Number: `11`
   - Name: `Quick Add Project`
   - Page Mode: `Modal Dialog`
   - Click **Create Page**

3. **Add Form Items to Modal**
   - In Page 11, create region:
     - Title: `Add New Project`
     - Type: `Form`
   - Add Items:
     - `P11_PROJECT_NAME` (Text Field, Required)
     - `P11_CLIENT_ID` (Select List from TECHNOVA_CLIENTS)
     - `P11_PROJECT_MANAGER` (Select List from TECHNOVA_EMPLOYEES)
     - `P11_STATUS` (Select List: Not Started, In Progress, On Hold)
     - `P11_START_DATE` (Date Picker, Required)
     - `P11_BUDGET` (Number Field)

4. **Add Save Process**
   - Create Process:
     - Name: `Insert Project`
     - Type: `Execute Code`
     - PL/SQL:
       ```sql
       INSERT INTO technova_projects (
           project_name, client_id, project_manager,
           status, start_date, budget, is_active
       ) VALUES (
           :P11_PROJECT_NAME,
           :P11_CLIENT_ID,
           :P11_PROJECT_MANAGER,
           :P11_STATUS,
           :P11_START_DATE,
           :P11_BUDGET,
           'Y'
       );
       ```
     - Success Message: `Project created successfully!`

5. **Link Button to Modal**
   - Go back to Page 10
   - Select **ADD_PROJECT** button
   - Right Panel → **Behavior**
     - Action: `Redirect to Page in this Application`
     - Target: 
       - Page: `11`
       - Clear Session State: `Yes`
       - Advanced:
         - Request: `CREATE`

---

## Part 5: Testing and Refinement (10 minutes)

### Exercise 5.1: Test Your Dashboard

1. **Run the Page**
   - Click **Save**
   - Click **Run** (or press F5)

2. **Test KPIs**
   - Verify all four KPI cards display numbers
   - Check that calculations are correct

3. **Test Interactive Grid**
   - Click on a cell to edit
   - Change a project status
   - Click **Save Changes**
   - Verify charts refresh automatically

4. **Test Quick Add**
   - Click **Quick Add Project**
   - Fill in the form
   - Click **Create**
   - Verify new project appears in grid

5. **Test Delete**
   - Select a row in the grid
   - Press Delete key (or use row action)
   - Verify confirmation dialog appears
   - Test both "Yes" and "No" options

### Exercise 5.2: Debug Using Page Designer

1. **Enable Debug Mode**
   - In Page Designer, click your username (top right)
   - Select **Debug** from dropdown
   - Run the page again

2. **View Debug Output**
   - After page loads, click **View Debug** link (bottom of page)
   - Examine timing:
     - Page rendering time
     - SQL query execution time
     - Region rendering order
   - Look for slow queries or bottlenecks

---

## Challenge Exercises

### Challenge 1: Add Search Functionality
- Add a search region above the Interactive Grid
- Include filters for:
  - Project Name (text search)
  - Status (select list)
  - Date Range (start/end date pickers)
- Create dynamic action to refresh grid on filter change

### Challenge 2: Add Breadcrumb Navigation
- Configure breadcrumb for Page 10
- Add navigation from Dashboard → Projects → Project Details
- Make breadcrumb dynamic based on selected project

### Challenge 3: Create Mobile-Responsive Layout
- Modify regions to stack on mobile devices
- Adjust KPI cards to display 2 per row on tablets
- Test responsiveness using browser developer tools

---

## Verification Checklist

Before completing this lab, verify:
- [ ] Page 10 (Project Dashboard) exists and displays
- [ ] Four KPI cards show correct calculations
- [ ] Interactive Grid displays projects
- [ ] Grid allows inline editing and saves changes
- [ ] Two charts display (status and budget)
- [ ] Charts refresh automatically after grid save
- [ ] Quick Add button opens modal dialog
- [ ] New projects can be created via modal
- [ ] Delete confirmation works
- [ ] Debug mode shows page rendering details

---

## Troubleshooting

**KPIs not displaying:**
- Check computations are in "Before Header" processing point
- Verify SQL queries return single values
- Check item names match substitution strings (&ITEM_NAME.)

**Grid not saving:**
- Verify process type is "Interactive Grid - Automatic Row Processing"
- Check "When Button Pressed" condition
- Ensure PRIMARY_ID column is marked as primary key

**Charts not refreshing:**
- Check dynamic action is on button click event
- Verify region names match in "Affected Elements"
- Ensure charts have unique region names

**Modal not opening:**
- Check button action is "Redirect to Page"
- Verify page 11 is "Modal Dialog" mode
- Check navigation target is configured

---

## Key Takeaways

1. **Page Designer has three synchronized panels**: Rendering Tree, Layout, Property Editor
2. **Regions contain items and buttons**: Hierarchy matters for organization
3. **Computations run before page renders**: Use for calculations displayed on page
4. **Dynamic Actions add interactivity**: Without writing JavaScript
5. **Interactive Grids support inline editing**: With automatic DML processing
6. **Modal dialogs keep context**: User doesn't lose their place
7. **Debug mode reveals timing**: Essential for performance optimization

---

## Next Steps

In Lab 04, you'll learn advanced report and form techniques, including:
- Master-detail forms
- Interactive report customizations
- Conditional formatting
- Download options (PDF, CSV, Excel)

**Estimated Time for Lab 04:** 90 minutes
