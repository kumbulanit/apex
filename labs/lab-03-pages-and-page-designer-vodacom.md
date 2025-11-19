# Lab 03: Pages and Page Designer

**Duration:** 120 minutes  
**Difficulty:** Intermediate  
**Prerequisites:** Completed Lab 02 (Customer Portal created)

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

Your Vodacom Customer Service Portal needs enhancement. The Operations Manager, Thabo Molefe, wants a sophisticated Network Operations Dashboard that displays:
- Key Performance Indicators (KPIs) for network health
- Interactive network issues list with inline editing
- Tower status charts showing infrastructure health
- Quick-add functionality for network incidents
- Real-time customer impact metrics

You'll use Page Designer to build this complex operations page from scratch.

---

## Part 1: Understanding Page Designer Interface (20 minutes)

### Exercise 1.1: Explore Page Designer

**Steps:**

1. **Open Existing Page in Page Designer**
   - From App Builder, open your **Vodacom Customer Portal**
   - Click on page **1** (Operations Dashboard)
   - You're now in Page Designer with three panels visible

2. **Explore Left Panel (Rendering Tree)**
   - Expand **Page 1: Operations Dashboard**
   - Expand **Regions** folder
   - Click on each region to see it highlight in center panel
   - Notice the hierarchy: Page → Regions → Items/Buttons
   - See regions like "Key Performance Indicators", "Customers by Province"

3. **Explore Center Panel (Layout)**
   - This shows visual preview of your Vodacom dashboard
   - Try dragging a region to a different position
   - Notice how the left panel updates automatically
   - Preview shows customer charts and VodaPay KPIs

4. **Explore Right Panel (Property Editor)**
   - Click on **Page 1** in the left tree
   - Right panel shows page-level properties:
     - Identification
     - Security
     - Advanced
   - Click on **Key Performance Indicators** region in the left tree
   - Right panel now shows region properties
   - Change the **Title** to "Vodacom Operations Metrics" and see it update

5. **Test Synchronization**
   - In Left Panel: Click "Customers by Province" region
   - In Center Panel: The region highlights with customer data
   - In Right Panel: Properties appear showing SQL source
   - All three panels stay synchronized!

---

## Part 2: Create Network Operations Dashboard Page (40 minutes)

### Exercise 2.1: Create Blank Page

1. **Create New Page**
   - Click the **Page Finder** dropdown (top left)
   - Click **+ Create Page**
   - Select: **Blank Page**
   - Page Number: `10` (or next available)
   - Name: `Network Operations Center`
   - Page Mode: `Normal`
   - Breadcrumb: `Breadcrumb` → Entry: `Network Operations`
   - Click **Create Page**

2. **Configure Page Properties**
   - In Page Designer, ensure **Page 10** is selected in left tree
   - Right Panel → **Identification**
     - Title: `Network Operations Center`
   - Right Panel → **Appearance**
     - Page Template: `Standard`
   - Right Panel → **CSS**
     - Inline CSS:
       ```css
       .kpi-card {
           text-align: center;
           padding: 20px;
           border-radius: 8px;
           box-shadow: 0 2px 4px rgba(0,0,0,0.1);
       }
       .kpi-value {
           font-size: 3em;
           font-weight: bold;
           color: #E60000; /* Vodacom red */
       }
       .kpi-label {
           font-size: 1.2em;
           color: #333;
           margin-top: 10px;
       }
       .tower-status-critical {
           color: #d32f2f;
           font-weight: bold;
       }
       .tower-status-operational {
           color: #388e3c;
       }
       ```

### Exercise 2.2: Add Network KPI Cards Region

1. **Create KPI Container Region**
   - Right-click **Content Body** in left panel
   - Select **Create Region**
   - Identification:
     - Title: `Network Performance Indicators`
     - Type: `Static Content`
   - Layout:
     - Sequence: `10`
     - Position: `Content Body`
   - Appearance:
     - Template: `Hero`
     - CSS Classes: `kpi-container`

2. **Add Total Active Towers KPI (Sub-Region)**
   - Right-click the **Network Performance Indicators** region
   - Select **Create Sub Region**
   - Identification:
     - Title: (leave blank)
     - Type: `HTML`
   - Source:
     - HTML Code:
       ```html
       <div class="kpi-card">
           <div class="kpi-value">&TOTAL_TOWERS.</div>
           <div class="kpi-label">Active Towers</div>
       </div>
       ```
   - Layout:
     - Column: `Automatic`
     - Column Span: `3` (takes 1/4 of 12-column grid)
     - New Row: `No`

3. **Create Computation for Total Towers**
   - In left panel, expand **Pre-Rendering**
   - Right-click **Before Header**
   - Select **Create Computation**
   - Identification:
     - Item Name: `TOTAL_TOWERS`
   - Computation:
     - Type: `SQL Query (return single value)`
     - SQL Query:
       ```sql
       SELECT COUNT(*)
       FROM vodacom_network_towers
       WHERE status = 'Operational'
       ```

4. **Add Network Issues KPI**
   - Repeat step 2 for Network Issues:
   - HTML Code:
     ```html
     <div class="kpi-card">
         <div class="kpi-value" style="color: #d32f2f;">&ACTIVE_ISSUES.</div>
         <div class="kpi-label">Active Network Issues</div>
     </div>
     ```
   - Column Span: `3`
   - Add computation:
     ```sql
     SELECT COUNT(*)
     FROM vodacom_network_issues
     WHERE status IN ('Open', 'Acknowledged', 'In Progress')
     ```

5. **Add Affected Customers KPI**
   - HTML Code:
     ```html
     <div class="kpi-card">
         <div class="kpi-value" style="color: #FF9800;">&AFFECTED_CUSTOMERS.</div>
         <div class="kpi-label">Affected Customers</div>
     </div>
     ```
   - Column Span: `3`
   - Computation:
     ```sql
     SELECT TO_CHAR(SUM(affected_customers), 'FM999,999')
     FROM vodacom_network_issues
     WHERE status IN ('Open', 'Acknowledged', 'In Progress')
     ```

6. **Add Average Resolution Time KPI**
   - HTML Code:
     ```html
     <div class="kpi-card">
         <div class="kpi-value" style="color: #4CAF50;">&AVG_RESOLUTION.</div>
         <div class="kpi-label">Avg Resolution (hrs)</div>
     </div>
     ```
   - Column Span: `3`
   - Computation:
     ```sql
     SELECT TO_CHAR(ROUND(AVG((resolved_date - reported_date) * 24), 1), 'FM999.9')
     FROM vodacom_network_issues
     WHERE status = 'Resolved'
       AND resolved_date >= SYSDATE - 30
     ```

7. **Save and Run**
   - Click **Save** (top right)
   - Click **Run** to see your Vodacom Network KPIs!

### Exercise 2.3: Add Interactive Grid for Network Issues

1. **Create Interactive Grid Region**
   - Right-click **Content Body** in left panel
   - Select **Create Region**
   - Identification:
     - Title: `Active Network Issues`
     - Type: `Interactive Grid`
   - Source:
     - Type: `SQL Query`
     - SQL Query:
       ```sql
       SELECT ni.issue_id,
              ni.issue_ref,
              ni.issue_type,
              ni.severity,
            CASE 
              WHEN ni.severity = 'Critical' THEN 1
              WHEN ni.severity = 'High' THEN 2
              WHEN ni.severity = 'Medium' THEN 3
              ELSE 4
            END AS severity_rank,
              nt.tower_code,
              nt.tower_name,
              nt.province,
              nt.city,
              ni.affected_customers,
              TO_CHAR(ni.reported_date, 'YYYY-MM-DD HH24:MI') AS reported_date,
                CASE 
                  WHEN ni.status = 'Resolved' THEN ni.resolved_date
                  ELSE CAST(NULL AS TIMESTAMP)
                END AS resolved_date,
              ni.status,
              e.first_name || ' ' || e.last_name AS assigned_technician,
              ni.description
       FROM vodacom_network_issues ni
       LEFT JOIN vodacom_network_towers nt ON ni.tower_id = nt.tower_id
       LEFT JOIN vodacom_employees e ON ni.assigned_to = e.emp_id
       WHERE ni.status IN ('Open', 'Acknowledged', 'In Progress')
       ```
   - Layout:
     - Sequence: `20`
     - Position: `Content Body`

2. **Configure Interactive Grid Attributes**
   - Select the **Active Network Issues** region
   - Right Panel → Scroll to **Attributes**
   - Editable: `Yes`
   - Edit:
     - Enabled: `Yes`
     - Mode: `Row`
     - Lost Update Type: `Row Values`
   - Add Row: `Yes`
   - Delete Row: `Yes`

3. **Configure Columns**
   - Expand **Active Network Issues** region → Expand **Columns**
   - **ISSUE_ID**:
     - Type: `Hidden`
     - Primary Key: `Yes`
   - **ISSUE_REF**:
     - Heading: `Ref #`
     - Required: `Yes`
     - Width: `120`
   - **ISSUE_TYPE**:
     - Heading: `Issue Type`
     - Type: `Select List`
     - List of Values:
       - Type: `Static Values`
       - Static Values:
         ```
         STATIC:Outage,Outage,Signal Degradation,Signal Degradation,Equipment Failure,Equipment Failure,Connectivity,Connectivity,Maintenance,Maintenance
         ```
   - **SEVERITY**:
     - Heading: `Severity`
     - Type: `Select List`
     - List of Values:
       - Static: `Critical,Critical,High,High,Medium,Medium,Low,Low`
   - **SEVERITY_RANK**:
     - Type: `Hidden`
     - Value Protected: `No`
     - Used to control default sorting inside the grid
   - **TOWER_CODE**:
     - Heading: `Tower`
     - Type: `Text Field` (read-only for now)
   - **STATUS**:
     - Heading: `Status`
     - Type: `Select List`
     - List of Values:
       - Static: `Open,Open,Acknowledged,Acknowledged,In Progress,In Progress,Resolved,Resolved`
   - **ASSIGNED_TECHNICIAN**:
     - Heading: `Technician`
     - Type: `Text Field` (read-only)
   - **AFFECTED_CUSTOMERS**:
     - Heading: `Affected Customers`
     - Format Mask: `999,999,999`
     - Alignment: `Right`

4. **Configure Default Sorting**
   - With the **Active Network Issues** region selected, go to **Attributes → Appearance → Reports → Primary Report**
   - Under **Sort**, add two entries:
     - `SEVERITY_RANK` ascending
     - `REPORTED_DATE` descending
   - This keeps the grid sorted without putting an `ORDER BY` in the SQL source

5. **Add Save Button**
   - Right-click **Active Network Issues** region in left panel
   - Select **Create Button**
   - Identification:
     - Button Name: `SAVE_ISSUES`
     - Label: `Save Changes`
   - Layout:
     - Position: `Right of Interactive Grid Search Bar`
   - Appearance:
     - Button Template: `Text with Icon`
     - Hot: `Yes` (Vodacom red)
     - Icon: `fa-save`

### Exercise 2.4: Add Processing Logic

1. **Create Process to Save Interactive Grid**
   - In left panel, expand **Processing**
   - Right-click **Processing**
   - Select **Create Process**
   - Identification:
     - Name: `Save Network Issues`
     - Type: `Interactive Grid - Automatic Row Processing (DML)`
   - Settings:
     - Region: `Active Network Issues`
     - Editable Region: `Active Network Issues`
   - Server-side Condition:
     - When Button Pressed: `SAVE_ISSUES`

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
     - Success Message: `Network issue updates saved successfully!`
   - Server-side Condition:
     - When Button Pressed: `SAVE_ISSUES`

---

## Part 3: Add Chart Region (30 minutes)

### Exercise 3.1: Create Tower Status Chart

1. **Create Chart Region**
   - Right-click **Content Body**
   - Select **Create Region**
   - Identification:
     - Title: `Towers by Status`
     - Type: `Chart`
   - Source:
     - Type: `SQL Query`
     - SQL Query:
       ```sql
       SELECT status AS label,
              COUNT(*) AS value,
              CASE status
                  WHEN 'Operational' THEN '#4CAF50'
                  WHEN 'Maintenance' THEN '#FF9800'
                  WHEN 'Offline' THEN '#f44336'
                  ELSE '#9E9E9E'
              END AS color
       FROM vodacom_network_towers
       GROUP BY status
       ORDER BY 
           CASE status
               WHEN 'Offline' THEN 1
               WHEN 'Maintenance' THEN 2
               WHEN 'Operational' THEN 3
               ELSE 4
           END
       ```
   - Layout:
     - Sequence: `30`
     - Position: `Content Body`
     - Start New Row: `Yes`
     - Column: `Automatic`
     - Column Span: `6` (half width)

2. **Configure Chart Attributes**
   - Select **Towers by Status** region
   - Right Panel → **Attributes**
   - Chart Type: `Donut`
   - Settings:
     - Show Legend: `Yes`
     - Legend Position: `Right`
     - Show Value: `Yes`
     - Show Label: `Yes`
   - Appearance:
     - Height: `400`

3. **Add Issues by Severity Chart**
   - Create another chart region (similar to above)
   - Title: `Issues by Severity`
   - SQL Query:
     ```sql
     SELECT severity AS label,
            COUNT(*) AS value,
            CASE severity
                WHEN 'Critical' THEN '#d32f2f'
                WHEN 'High' THEN '#f57c00'
                WHEN 'Medium' THEN '#fbc02d'
                WHEN 'Low' THEN '#388e3c'
                ELSE '#757575'
            END AS color
     FROM vodacom_network_issues
     WHERE status IN ('Open', 'Acknowledged', 'In Progress')
     GROUP BY severity
     ORDER BY 
         CASE severity
             WHEN 'Critical' THEN 1
             WHEN 'High' THEN 2
             WHEN 'Medium' THEN 3
             WHEN 'Low' THEN 4
             ELSE 5
         END
     ```
   - Layout:
     - Column Span: `6` (places it next to first chart)
     - Start New Row: `No`
   - Chart Type: `Bar`

4. **Add Tower Technology Distribution Chart**
   - Create another chart region
   - Title: `Tower Technology Distribution`
   - SQL Query:
     ```sql
     SELECT tower_type || ' (' || province || ')' AS label,
            COUNT(*) AS value
     FROM vodacom_network_towers
     WHERE status = 'Operational'
     GROUP BY tower_type, province
     ORDER BY tower_type DESC, province
     ```
   - Layout:
     - Start New Row: `Yes`
     - Column Span: `12` (full width)
   - Chart Type: `Bar`
   - Orientation: `Horizontal`

---

## Part 4: Add Dynamic Actions (30 minutes)

### Exercise 4.1: Auto-Refresh Charts on Grid Save

1. **Create Dynamic Action**
   - Right-click **SAVE_ISSUES** button in left panel
   - Select **Create Dynamic Action**
   - Identification:
     - Name: `Refresh Dashboard After Save`
   - When:
     - Event: `Click`
     - Selection Type: `Button`
     - Button: `SAVE_ISSUES`

2. **Add Refresh Actions**
   - Under the Dynamic Action, right-click **True** actions
   - Select **Create TRUE Action**
   - Identification:
     - Action: `Refresh`
   - Affected Elements:
     - Selection Type: `Region`
     - Region: `Towers by Status`
   
   - Click **Add Action** (the + button on True)
   - Add second action:
     - Action: `Refresh`
     - Region: `Issues by Severity`
   
   - Add third action:
     - Action: `Refresh`
     - Region: `Network Performance Indicators`
   
   - Add fourth action:
     - Action: `Refresh`
     - Region: `Tower Technology Distribution`

### Exercise 4.2: Add Confirmation Dialog for Delete

1. **Create Dynamic Action on Grid**
   - Right-click **Active Network Issues** Interactive Grid region
   - Select **Create Dynamic Action**
   - Identification:
     - Name: `Confirm Delete Issue`
   - When:
     - Event: `Row Delete`
     - Selection Type: `Region`
     - Region: `Active Network Issues`

2. **Add Confirm Action**
   - Right-click **True** actions
   - Select **Create TRUE Action**
   - Identification:
     - Action: `Confirm`
   - Settings:
     - Title: `Delete Network Issue?`
     - Message: `Are you sure you want to delete this network issue? This action cannot be undone and may affect reporting.`
     - Style: `Danger`
     - Button Set: `Yes/No`

### Exercise 4.3: Add Quick Report Dialog for Critical Issues

1. **Create Button for Quick Report**
   - Right-click **Active Network Issues** region
   - Select **Create Button**
   - Identification:
     - Button Name: `REPORT_ISSUE`
     - Label: `Report Critical Issue`
   - Layout:
     - Position: `Next`
   - Appearance:
     - Icon: `fa-exclamation-triangle`
     - Hot: `Yes`
     - CSS Classes: `critical-issue-btn`

2. **Create Modal Dialog Page**
   - Click **Page Finder** (top left)
   - Click **+ Create Page**
   - Select: **Blank Page**
   - Page Number: `11`
   - Name: `Report Network Issue`
   - Page Mode: `Modal Dialog`
   - Click **Create Page**

3. **Add Form Items to Modal**
   - In Page 11, create region:
     - Title: `New Network Issue`
     - Type: `Form`
   
   - Add Items:
     - `P11_ISSUE_REF` (Text Field, Auto-generate format: "NI-YYYYMMDD-NNN")
     - `P11_TOWER_ID` (Popup LOV from VODACOM_NETWORK_TOWERS)
       - Display: tower_code || ' - ' || tower_name
       - Return: tower_id
     - `P11_ISSUE_TYPE` (Select List: Outage, Signal Degradation, Equipment Failure, Connectivity)
     - `P11_SEVERITY` (Radio Group: Critical, High, Medium, Low)
       - Default: `Critical`
     - `P11_AFFECTED_CUSTOMERS` (Number Field)
     - `P11_DESCRIPTION` (Textarea, Required)
     - `P11_ASSIGNED_TO` (Select List from VODACOM_EMPLOYEES WHERE job_title LIKE '%Technician%')

4. **Add Save Process**
   - Create Process:
     - Name: `Insert Network Issue`
     - Type: `Execute Code`
     - PL/SQL:
       ```sql
       DECLARE
         v_issue_ref VARCHAR2(50);
       BEGIN
         -- Generate issue reference if not provided
         IF :P11_ISSUE_REF IS NULL THEN
           SELECT 'NI-' || TO_CHAR(SYSDATE, 'YYYYMMDD') || '-' || 
                  LPAD(vodacom_issue_seq.NEXTVAL, 3, '0')
           INTO v_issue_ref
           FROM dual;
         ELSE
           v_issue_ref := :P11_ISSUE_REF;
         END IF;
         
         INSERT INTO vodacom_network_issues (
           issue_ref, tower_id, issue_type, severity,
           affected_customers, description, assigned_to,
           status, reported_date, reported_by
         ) VALUES (
           v_issue_ref,
           :P11_TOWER_ID,
           :P11_ISSUE_TYPE,
           :P11_SEVERITY,
           :P11_AFFECTED_CUSTOMERS,
           :P11_DESCRIPTION,
           :P11_ASSIGNED_TO,
           'Open',
           SYSTIMESTAMP,
           :APP_USER
         );
       END;
       ```
     - Success Message: `Network issue &P11_ISSUE_REF. reported successfully!`

5. **Link Button to Modal**
   - Go back to Page 10
   - Select **REPORT_ISSUE** button
   - Right Panel → **Behavior**
     - Action: `Redirect to Page in this Application`
     - Target: 
       - Page: `11`
       - Clear Session State: `Yes`
       - Advanced:
         - Request: `CREATE`

---

## Part 5: Testing and Refinement (10 minutes)

### Exercise 5.1: Test Your Network Operations Dashboard

1. **Run the Page**
   - Click **Save**
   - Click **Run** (or press F5)

2. **Test KPIs**
   - Verify all four KPI cards display Vodacom network metrics
   - Check that tower counts, issues, and affected customers are correct

3. **Test Interactive Grid**
   - Click on a network issue cell to edit
   - Change issue status from "Open" to "Acknowledged"
   - Click **Save Changes**
   - Verify charts refresh automatically showing updated data

4. **Test Quick Report**
   - Click **Report Critical Issue**
   - Fill in the form:
     - Select a tower
     - Choose "Outage" as issue type
     - Select "Critical" severity
     - Enter affected customers: 5000
     - Description: "Complete network outage in Sandton area"
   - Click **Create**
   - Verify new issue appears in grid
   - Verify KPIs update (Active Issues increased)

5. **Test Delete**
   - Select a resolved issue in the grid
   - Press Delete key (or use row action)
   - Verify confirmation dialog appears with Vodacom-specific message
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
     - SQL query execution time for network issues
     - Region rendering order (KPIs → Grid → Charts)
   - Look for slow queries (should be < 0.5s for Vodacom data)

---

## Challenge Exercises

### Challenge 1: Add Live Network Monitoring
- Add a refresh region that updates every 30 seconds
- Display real-time tower status changes
- Show live customer impact metrics
- Use Dynamic Action with "Set Value" from SQL query

### Challenge 2: Add SLA Tracking
- Create computed column for SLA compliance
- Highlight issues exceeding SLA in red
- Add SLA breach counter to KPIs
- Calculate: (SYSDATE - reported_date) * 24 > SLA_HOURS

### Challenge 3: Create Mobile-Optimized Layout
- Modify regions to stack vertically on mobile
- Adjust KPI cards to display 2 per row on tablets
- Make Interactive Grid responsive for field technicians
- Test responsiveness using browser developer tools (F12)

---

## Verification Checklist

Before completing this lab, verify:
- [ ] Page 10 (Network Operations Center) exists and displays
- [ ] Four KPI cards show correct Vodacom network metrics
- [ ] Interactive Grid displays active network issues
- [ ] Grid allows inline editing and saves changes
- [ ] Three charts display (tower status, issues severity, technology)
- [ ] Charts refresh automatically after grid save
- [ ] Report Critical Issue button opens modal dialog
- [ ] New network issues can be reported via modal
- [ ] Delete confirmation works with appropriate message
- [ ] Debug mode shows page rendering details under 2 seconds

---

## Troubleshooting

**KPIs not displaying:**
- Check computations are in "Before Header" processing point
- Verify SQL queries return single values
- Check item names match substitution strings (&ITEM_NAME.)
- Ensure VODACOM_NETWORK_ISSUES and VODACOM_NETWORK_TOWERS tables have data

**Grid not saving:**
- Verify process type is "Interactive Grid - Automatic Row Processing"
- Check "When Button Pressed" condition points to SAVE_ISSUES
- Ensure ISSUE_ID column is marked as primary key
- Check table has proper UPDATE privileges

**Charts not refreshing:**
- Check dynamic action is on button click event
- Verify region names match exactly in "Affected Elements"
- Ensure charts have unique region names
- Test SQL queries independently in SQL Workshop

**Modal not opening:**
- Check button action is "Redirect to Page"
- Verify page 11 is set to "Modal Dialog" mode
- Check navigation target page number is correct
- Ensure Clear Session State is enabled

---

## Key Takeaways

1. **Page Designer has three synchronized panels**: Rendering Tree, Layout, Property Editor - essential for Vodacom dashboard development
2. **Regions contain items and buttons**: Hierarchy matters for organizing network operations
3. **Computations run before page renders**: Use for calculating KPIs like affected customers
4. **Dynamic Actions add interactivity**: Refresh charts without page reload for real-time monitoring
5. **Interactive Grids support inline editing**: With automatic DML processing for network issue updates
6. **Modal dialogs keep context**: Technicians don't lose their place when reporting issues
7. **Debug mode reveals timing**: Essential for performance optimization in operational dashboards
8. **Vodacom-specific styling**: Use brand colors (#E60000 red) and telecom terminology

---

## Real-World Impact for Vodacom

This Network Operations Dashboard enables:
- **Real-time visibility**: Operations team sees network health at a glance
- **Faster response**: Critical issues highlighted immediately
- **Better resource allocation**: Assign technicians to high-impact issues
- **SLA compliance**: Track resolution times and customer impact
- **Data-driven decisions**: Charts show trends in tower performance
- **Mobile accessibility**: Field technicians can update status on smartphones

**Business Value:**
- Reduced Mean Time To Repair (MTTR) by 40%
- Improved SLA compliance from 85% to 97%
- Better customer experience during outages
- R2.5M annual savings in operational efficiency

---

## Next Steps

In Lab 04, you'll learn advanced report and form techniques for Vodacom, including:
- Customer service reports with advanced filtering
- VodaPay transaction forms (master-detail)
- Conditional formatting for billing disputes
- Download options for regulatory reports (PDF, CSV, Excel)
- Sales performance dashboards

**Estimated Time for Lab 04:** 90 minutes

**Preview:** Build a comprehensive customer service reporting system with transaction tracking, dispute management, and VodaPay reconciliation forms.
