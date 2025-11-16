# Lab 04: Reports and Forms

**Duration:** 90 minutes  
**Difficulty:** Intermediate  
**Prerequisites:** Completed Lab 03 (Network Operations Dashboard created)

## Learning Objectives

By the end of this lab, you will be able to:
1. Create and customize Interactive Reports
2. Build Interactive Grids with inline editing
3. Create master-detail forms
4. Add conditional formatting and highlighting
5. Configure report download options
6. Implement search and filter functionality

---

## Lab Scenario

Vodacom's customer service management team needs comprehensive reporting capabilities. They want:
- A detailed customer analysis report with search and export
- A VodaPay transaction entry system with bulk editing
- An invoice management system for billing (master-detail)
- Conditional formatting to highlight billing disputes and high-value customers

---

## Part 1: Advanced Interactive Report (30 minutes)

### Exercise 1.1: Create Customer Analysis Report

1. **Create New Page**
   - App Builder → Your Application
   - Create Page → Report → **Interactive Report**
   - Page Number: `20`
   - Page Name: `Customer Analysis`
   - Breadcrumb: Yes → `Customer Analysis`
   - SQL Query:
     ```sql
     SELECT c.customer_id,
            c.account_number,
            c.first_name || ' ' || c.last_name AS customer_name,
            c.phone,
            c.email,
            c.province,
            c.customer_type,
            c.account_status,
            COUNT(DISTINCT mn.mobile_number) AS total_numbers,
            COUNT(CASE WHEN mn.status = 'Active' THEN 1 END) AS active_numbers,
            SUM(mn.airtime_balance + mn.data_balance_mb * 0.15) AS total_balance,
            CASE WHEN c.vodapay_active = 'Y' THEN 'Yes' ELSE 'No' END AS vodapay_user,
            MAX(t.transaction_date) AS last_transaction_date,
            COUNT(cs.ticket_number) AS support_tickets
     FROM vodacom_customers c
     LEFT JOIN vodacom_mobile_numbers mn ON c.customer_id = mn.customer_id
     LEFT JOIN vodacom_transactions t ON c.customer_id = t.customer_id
     LEFT JOIN vodacom_customer_support cs ON c.customer_id = cs.customer_id
     GROUP BY c.customer_id, c.account_number, c.first_name, c.last_name,
              c.phone, c.email, c.province, c.customer_type, 
              c.account_status, c.vodapay_active
     ORDER BY total_balance DESC NULLS LAST
     ```
   - Click **Create Page**

2. **Customize Report Columns**
   - Open Page 20 in Page Designer
   - Select the **Customer Analysis** region
   - Expand **Columns** in left panel
   
   - **CUSTOMER_NAME**:
     - Heading: `Customer Name`
     - Type: `Link`
     - Target:
       - Page: `21` (we'll create this)
       - Set Items: `P21_CUSTOMER_ID` → `#CUSTOMER_ID#`
       - Link Text: `#CUSTOMER_NAME#`
   
   - **TOTAL_BALANCE**:
     - Heading: `Total Balance (R)`
     - Type: `Plain Text`
     - Format Mask: `FML999G999G999G990D00`
     - Alignment: `Right`
   
   - **LAST_TRANSACTION_DATE**:
     - Heading: `Last Transaction`
     - Type: `Plain Text`
     - Format Mask: `DD-MON-YYYY HH24:MI`

3. **Add Conditional Highlighting**
   - Select **Customer Analysis** region
   - Right Panel → **Attributes** → Scroll to **Highlighting**
   - Click **Add Highlighting** (+ button)
   
   - **Highlight 1: High Value Customers**
     - Name: `High Value Customers`
     - Sequence: `10`
     - Condition Type: `Column Value`
     - Column: `TOTAL_BALANCE`
     - Operator: `>`
     - Expression 1: `500`
     - Background Color: `#E8F5E9` (light green)
     - Text Color: `#2E7D32` (dark green)
   
   - **Highlight 2: Suspended Accounts**
     - Name: `Suspended Accounts`
     - Sequence: `20`
     - Column: `ACCOUNT_STATUS`
     - Operator: `=`
     - Expression 1: `Suspended`
     - Background Color: `#FFEBEE` (light red)
     - Text Color: `#C62828` (dark red)
   
   - **Highlight 3: VodaPay Users**
     - Name: `VodaPay Active`
     - Sequence: `30`
     - Column: `VODAPAY_USER`
     - Operator: `=`
     - Expression 1: `Yes`
     - Background Color: `#FFF3E0` (light orange - Vodacom VodaPay color)
     - Text Color: `#E65100` (dark orange)

4. **Configure Download Options**
   - Select **Customer Analysis** region
   - Right Panel → **Attributes**
   - Download:
     - Formats Available: `CSV, HTML, Excel, PDF`
     - Filename: `vodacom_customer_analysis`
     - CSV Export Enabled: `Yes`
     - PDF Export Enabled: `Yes`

5. **Add Computed Column for Actions**
   - In **Columns**, click **Add Column** (+ button)
   - Column Type: `Link Column`
   - Heading: `Actions`
   - HTML Expression:
     ```html
     <button type="button" class="t-Button t-Button--simple t-Button--hot" 
             onclick="apex.navigation.redirect('f?p=&APP_ID.:21:&SESSION.::NO::P21_CUSTOMER_ID:#CUSTOMER_ID#');">
       <span class="fa fa-edit"></span> Edit
     </button>
     <button type="button" class="t-Button t-Button--simple" 
             onclick="apex.navigation.redirect('f?p=&APP_ID.:22:&SESSION.::NO::P22_CUSTOMER_ID:#CUSTOMER_ID#');">
       <span class="fa fa-mobile"></span> Numbers
     </button>
     <button type="button" class="t-Button t-Button--simple" 
             onclick="apex.navigation.redirect('f?p=&APP_ID.:23:&SESSION.::NO::P23_CUSTOMER_ID:#CUSTOMER_ID#');">
       <span class="fa fa-credit-card"></span> VodaPay
     </button>
     ```

### Exercise 1.2: Add Search Region

1. **Create Search Region**
   - Right-click **Content Body**
   - Create Region
   - Title: `Customer Search Filters`
   - Type: `Static Content`
   - Template: `Collapsible`
   - Sequence: `5` (appears above report)

2. **Add Search Items**
   - Create Item: `P20_SEARCH_NAME`
     - Type: `Text Field`
     - Label: `Customer Name`
     - Placeholder: `Enter name or account number...`
   
   - Create Item: `P20_SEARCH_PROVINCE`
     - Type: `Select List`
     - Label: `Province`
     - List of Values:
       - Type: `SQL Query`
       - SQL:
         ```sql
         SELECT DISTINCT province AS d, province AS r
         FROM vodacom_customers
         ORDER BY province
         ```
     - Display Null Value: `Yes`
     - Null Display Value: `- All Provinces -`
   
   - Create Item: `P20_CUSTOMER_TYPE`
     - Type: `Checkbox Group`
     - Label: `Customer Type`
     - List of Values:
       - Static: `Individual,Individual,Business,Business,Corporate,Corporate,Government,Government`
     - Number of Columns: `4`
   
   - Create Item: `P20_VODAPAY_STATUS`
     - Type: `Radio Group`
     - Label: `VodaPay Status`
     - List of Values:
       - Static: `All,ALL,VodaPay Users Only,Y,Non-VodaPay,N`
     - Default: `ALL`
     - Number of Columns: `3`
   
   - Create Item: `P20_MIN_BALANCE`
     - Type: `Number Field`
     - Label: `Minimum Balance`
     - Format Mask: `FML999G999`

3. **Add Apply Filter Button**
   - Create Button: `APPLY_FILTER`
   - Label: `Apply Filters`
   - Position: `Next`
   - Hot: `Yes`
   - Icon: `fa-search`

4. **Update Report Query**
   - Select **Customer Analysis** region
   - Modify SQL Query:
     ```sql
     SELECT c.customer_id,
            c.account_number,
            c.first_name || ' ' || c.last_name AS customer_name,
            c.phone,
            c.email,
            c.province,
            c.customer_type,
            c.account_status,
            COUNT(DISTINCT mn.mobile_number) AS total_numbers,
            COUNT(CASE WHEN mn.status = 'Active' THEN 1 END) AS active_numbers,
            SUM(mn.airtime_balance + mn.data_balance_mb * 0.15) AS total_balance,
            CASE WHEN c.vodapay_active = 'Y' THEN 'Yes' ELSE 'No' END AS vodapay_user,
            MAX(t.transaction_date) AS last_transaction_date,
            COUNT(cs.ticket_number) AS support_tickets
     FROM vodacom_customers c
     LEFT JOIN vodacom_mobile_numbers mn ON c.customer_id = mn.customer_id
     LEFT JOIN vodacom_transactions t ON c.customer_id = t.customer_id
     LEFT JOIN vodacom_customer_support cs ON c.customer_id = cs.customer_id
     WHERE (:P20_SEARCH_NAME IS NULL OR 
            UPPER(c.first_name || ' ' || c.last_name) LIKE '%' || UPPER(:P20_SEARCH_NAME) || '%' OR
            c.account_number LIKE '%' || :P20_SEARCH_NAME || '%')
       AND (:P20_SEARCH_PROVINCE IS NULL OR c.province = :P20_SEARCH_PROVINCE)
       AND (:P20_VODAPAY_STATUS = 'ALL' OR c.vodapay_active = :P20_VODAPAY_STATUS)
     GROUP BY c.customer_id, c.account_number, c.first_name, c.last_name,
              c.phone, c.email, c.province, c.customer_type, 
              c.account_status, c.vodapay_active
     HAVING (:P20_MIN_BALANCE IS NULL OR 
             SUM(mn.airtime_balance + mn.data_balance_mb * 0.15) >= :P20_MIN_BALANCE)
        AND (:P20_CUSTOMER_TYPE IS NULL OR 
             INSTR(':' || :P20_CUSTOMER_TYPE || ':', ':' || c.customer_type || ':') > 0)
     ORDER BY total_balance DESC NULLS LAST
     ```
   - Page Items to Submit: `P20_SEARCH_NAME,P20_SEARCH_PROVINCE,P20_CUSTOMER_TYPE,P20_VODAPAY_STATUS,P20_MIN_BALANCE`

---

## Part 2: Interactive Grid with Bulk Editing (25 minutes)

### Exercise 2.1: Create VodaPay Transaction Entry Grid

1. **Create New Page**
   - Create Page → Report → **Interactive Grid**
   - Page Number: `25`
   - Page Name: `VodaPay Transaction Reconciliation`
   - Include Form Page: `No`
   - SQL Query:
     ```sql
     SELECT t.transaction_id,
            c.account_number,
            c.first_name || ' ' || c.last_name AS customer_name,
            vp.vodapay_account_number,
            t.transaction_date,
            t.transaction_type,
            t.amount,
            t.status,
            t.package_id,
            p.package_name,
            t.description,
            c.customer_id
     FROM vodacom_transactions t
     JOIN vodacom_customers c ON t.customer_id = c.customer_id
     LEFT JOIN vodacom_vodapay_accounts vp ON c.customer_id = vp.customer_id
     LEFT JOIN vodacom_packages p ON t.package_id = p.package_id
     WHERE t.transaction_date >= TRUNC(SYSDATE) - 30
       AND t.transaction_type LIKE '%VodaPay%'
     ORDER BY t.transaction_date DESC
     ```

2. **Configure Grid for Editing**
   - Select **VodaPay Transaction Reconciliation** region
   - Attributes:
     - Editable: `Yes`
     - Edit → Enabled: `Yes`
     - Edit → Mode: `Row`
     - Add Row: `Yes`
     - Delete Row: `Yes`
     - Pagination → Type: `Page`
     - Pagination → Rows per Page: `50`

3. **Configure Columns**
   - **TRANSACTION_ID**:
     - Type: `Hidden`
     - Primary Key: `Yes`
   
   - **CUSTOMER_ID**:
     - Type: `Popup LOV`
     - Heading: `Customer`
     - Required: `Yes`
     - List of Values:
       - Type: `SQL Query`
       - SQL:
         ```sql
         SELECT account_number || ' - ' || first_name || ' ' || last_name AS d,
                customer_id AS r
         FROM vodacom_customers
         WHERE account_status = 'Active'
           AND vodapay_active = 'Y'
         ORDER BY last_name, first_name
         ```
   
   - **TRANSACTION_DATE**:
     - Type: `Date Picker`
     - Required: `Yes`
     - Default:
       - Type: `Expression`
       - PL/SQL Expression: `SYSTIMESTAMP`
     - Format Mask: `YYYY-MM-DD HH24:MI`
   
   - **TRANSACTION_TYPE**:
     - Type: `Select List`
     - Heading: `Type`
     - Required: `Yes`
     - List of Values:
       - Static: `VodaPay Load,VodaPay Load,VodaPay Transfer,VodaPay Transfer,VodaPay Payment,VodaPay Payment,VodaPay Withdrawal,VodaPay Withdrawal`
   
   - **AMOUNT**:
     - Type: `Number Field`
     - Heading: `Amount (R)`
     - Required: `Yes`
     - Format Mask: `FML999G999G990D00`
     - Validation:
       - Type: `Item is greater than`
       - Item is greater than: `0`
   
   - **STATUS**:
     - Type: `Select List`
     - Heading: `Status`
     - Required: `Yes`
     - List of Values:
       - Static: `Pending,Pending,Completed,Completed,Failed,Failed,Reversed,Reversed`
     - Default: `Pending`
   
   - **PACKAGE_ID**:
     - Type: `Popup LOV`
     - Heading: `Package`
     - List of Values:
       - SQL:
         ```sql
         SELECT package_name || ' (R' || price || ')' AS d,
                package_id AS r
         FROM vodacom_packages
         WHERE is_active = 'Y'
         ORDER BY package_name
         ```

4. **Add Save Button**
   - Create Button: `SAVE_TRANSACTIONS`
   - Label: `Save All Changes`
   - Position: `Right of Interactive Grid Search Bar`
   - Hot: `Yes`
   - Icon: `fa-save`

5. **Add Process**
   - Create Process:
     - Name: `Process VodaPay Transactions`
     - Type: `Interactive Grid - Automatic Row Processing (DML)`
     - Editable Region: `VodaPay Transaction Reconciliation`
     - When Button Pressed: `SAVE_TRANSACTIONS`
     - Success Message: `VodaPay transactions saved successfully!`

---

## Part 3: Master-Detail Form (35 minutes)

### Exercise 3.1: Create Invoice Master-Detail

1. **Create Master Page (Invoice Header)**
   - Create Page → Form → **Form**
   - Page Number: `30`
   - Page Name: `Invoice Details`
   - Table Name: `VODACOM_INVOICES`
   - Primary Key Column: `INVOICE_ID`
   - Click **Create Page**

2. **Enhance Master Form**
   - Open Page 30 in Page Designer
   - Modify Items:
   
   - **P30_CUSTOMER_ID**:
     - Type: `Popup LOV`
     - List of Values:
       - SQL:
         ```sql
         SELECT account_number || ' - ' || first_name || ' ' || last_name AS d,
                customer_id AS r
         FROM vodacom_customers
         WHERE account_status IN ('Active', 'Suspended')
         ORDER BY last_name, first_name
         ```
   
   - **P30_INVOICE_DATE**:
     - Default Type: `Expression`
     - PL/SQL Expression: `TRUNC(SYSDATE)`
     - Format Mask: `YYYY-MM-DD`
   
   - **P30_DUE_DATE**:
     - Default Type: `Expression`
     - PL/SQL Expression: `TRUNC(SYSDATE) + 30`
     - Format Mask: `YYYY-MM-DD`
   
   - **P30_BILLING_PERIOD**:
     - Type: `Select List`
     - List of Values:
       - Static: `Monthly,Monthly,Quarterly,Quarterly,Annual,Annual`
     - Default: `Monthly`
   
   - **P30_STATUS**:
     - Type: `Select List`
     - List of Values:
       - Static: `Draft,Draft,Generated,Generated,Sent,Sent,Paid,Paid,Overdue,Overdue,Disputed,Disputed,Cancelled,Cancelled`
     - Default: `Draft`
   
   - **P30_TOTAL_AMOUNT**:
     - Type: `Display Only`
     - Format Mask: `FML999G999G999G990D00`
     - Appearance → CSS Classes: `apex-item-display-only u-bold vodacom-amount`

3. **Create Detail Region (Invoice Line Items)**
   - Right-click **Content Body**
   - Create Region
   - Title: `Invoice Line Items`
   - Type: `Interactive Grid`
   - Sequence: `20` (after form items)
   - SQL Query:
     ```sql
     SELECT li.line_item_id,
            li.invoice_id,
            li.item_type,
            li.description,
            li.quantity,
            li.unit_price,
            li.quantity * li.unit_price AS line_total,
            li.tax_amount,
            (li.quantity * li.unit_price) + NVL(li.tax_amount, 0) AS total_with_tax
     FROM vodacom_invoice_items li
     WHERE li.invoice_id = :P30_INVOICE_ID
     ORDER BY li.line_item_id
     ```
   - Page Items to Submit: `P30_INVOICE_ID`

4. **Configure Detail Grid**
   - Attributes:
     - Editable: `Yes`
     - Add Row: `Yes`
     - Delete Row: `Yes`
   
   - **LINE_ITEM_ID**:
     - Type: `Hidden`
     - Primary Key: `Yes`
   
   - **INVOICE_ID**:
     - Type: `Hidden`
     - Default:
       - Type: `Item`
       - Item: `P30_INVOICE_ID`
   
   - **ITEM_TYPE**:
     - Type: `Select List`
     - Heading: `Type`
     - Required: `Yes`
     - List of Values:
       - Static: `Airtime,Airtime,Data,Data,SMS,SMS,Voice,Voice,VodaPay Fee,VodaPay Fee,Device,Device,Service Fee,Service Fee`
   
   - **DESCRIPTION**:
     - Required: `Yes`
     - Width: `250`
   
   - **QUANTITY**:
     - Type: `Number Field`
     - Required: `Yes`
     - Default: `1`
     - Format Mask: `999G999`
   
   - **UNIT_PRICE**:
     - Type: `Number Field`
     - Heading: `Unit Price (R)`
     - Required: `Yes`
     - Format Mask: `FML999G999G990D00`
   
   - **LINE_TOTAL**:
     - Type: `Display Only`
     - Heading: `Subtotal (R)`
     - Format Mask: `FML999G999G990D00`
   
   - **TAX_AMOUNT**:
     - Type: `Number Field`
     - Heading: `VAT (R)`
     - Format Mask: `FML999G990D00`
     - Default: `0`
   
   - **TOTAL_WITH_TAX**:
     - Type: `Display Only`
     - Heading: `Total (R)`
     - Format Mask: `FML999G999G990D00`

5. **Add Calculate Total Button**
   - Create Button: `CALCULATE_TOTAL`
   - Label: `Calculate Invoice Total`
   - Position: `Below Region`
   - Icon: `fa-calculator`
   - Hot: `Yes`

6. **Add Dynamic Action to Calculate**
   - Create Dynamic Action on `CALCULATE_TOTAL` button
   - Event: `Click`
   - True Action:
     - Action: `Execute Server-side Code`
     - PL/SQL:
       ```sql
       DECLARE
         v_total NUMBER;
         v_vat NUMBER;
       BEGIN
         SELECT SUM((quantity * unit_price) + NVL(tax_amount, 0))
         INTO v_total
         FROM vodacom_invoice_items
         WHERE invoice_id = :P30_INVOICE_ID;
         
         :P30_TOTAL_AMOUNT := NVL(v_total, 0);
         
         UPDATE vodacom_invoices
         SET total_amount = NVL(v_total, 0),
             updated_date = SYSTIMESTAMP
         WHERE invoice_id = :P30_INVOICE_ID;
       END;
       ```
     - Items to Submit: `P30_INVOICE_ID`
     - Items to Return: `P30_TOTAL_AMOUNT`
   - Add Success Message:
     - Action: `Show`
     - Message: `Invoice total calculated: R &P30_TOTAL_AMOUNT.`

7. **Add Process for Line Items**
   - Create Process:
     - Name: `Save Invoice Line Items`
     - Type: `Interactive Grid - Automatic Row Processing (DML)`
     - Editable Region: `Invoice Line Items`
     - Success Message: `Invoice line items saved successfully!`

8. **Create Invoice List Page**
   - Create Page → Report → Interactive Report
   - Page Number: `29`
   - Page Name: `Customer Invoices`
   - SQL Query:
     ```sql
     SELECT i.invoice_id,
            i.invoice_number,
            c.account_number,
            c.first_name || ' ' || c.last_name AS customer_name,
            i.invoice_date,
            i.due_date,
            i.billing_period,
            i.status,
            i.total_amount,
            CASE
              WHEN i.status = 'Paid' THEN 'u-success'
              WHEN i.status = 'Overdue' THEN 'u-danger'
              WHEN i.status = 'Disputed' THEN 'u-warning'
              WHEN i.status = 'Sent' THEN 'u-normal'
              ELSE 'u-color-1'
            END AS status_class,
            CASE 
              WHEN i.status = 'Overdue' THEN TRUNC(SYSDATE - i.due_date)
              ELSE NULL
            END AS days_overdue
     FROM vodacom_invoices i
     JOIN vodacom_customers c ON i.customer_id = c.customer_id
     ORDER BY i.invoice_date DESC
     ```
   - Link Column: `INVOICE_NUMBER`
   - Target Page: `30`
   - Set Item: `P30_INVOICE_ID` → `#INVOICE_ID#`

---

## Challenge Exercises

### Challenge 1: Add Revenue Aggregations to Customer Report
- Add control break on `PROVINCE`
- Show sum of `TOTAL_BALANCE` per province
- Add grand total at bottom
- Calculate percentage of total by province

### Challenge 2: Create Email Invoice Functionality
- Add "Send Invoice via SMS" button on page 30
- Create process to generate PDF invoice
- Send SMS notification with payment link
- Log sent invoices in audit table

### Challenge 3: Implement Data Usage Reporting
- Create new report showing data consumption by package
- Add chart showing peak usage times
- Highlight customers nearing data limits (upsell opportunity)
- Export to Excel for network capacity planning

---

## Verification Checklist

- [ ] Page 20 (Customer Analysis) displays with Vodacom filters
- [ ] Highlighting works (green for high-value, red for suspended, orange for VodaPay)
- [ ] Download buttons work (CSV, PDF, Excel)
- [ ] Search filters update the report correctly
- [ ] Page 25 (VodaPay Transactions) allows inline editing
- [ ] Transaction grid saves bulk changes
- [ ] Page 30 (Invoice Details) shows master form
- [ ] Line items grid allows adding/editing rows
- [ ] Calculate Total button updates invoice amount
- [ ] Page 29 (Invoice List) links to detail page
- [ ] Status colors match Vodacom branding

---

## Key Takeaways

1. **Interactive Reports are for display**: Read-only, powerful search/filter for customer data
2. **Interactive Grids are for editing**: Spreadsheet-like VodaPay transaction entry
3. **Master-Detail keeps billing data together**: One invoice form, related line items below
4. **Conditional highlighting draws attention**: Color-code suspended accounts, VodaPay users
5. **LOVs prevent data entry errors**: Dropdowns ensure valid customer and package selection
6. **Automatic DML processing simplifies saves**: No manual INSERT/UPDATE for transactions
7. **Dynamic Actions calculate on-the-fly**: Real-time invoice totals without page refresh
8. **Vodacom-specific formatting**: Use brand colors and telecom terminology throughout

---

## Real-World Impact for Vodacom

This reporting system enables:
- **Customer service excellence**: Agents quickly find customer data and history
- **VodaPay reconciliation**: Finance team tracks payment transactions efficiently
- **Billing accuracy**: Invoice master-detail ensures correct charges
- **Revenue visibility**: Management sees high-value customers at a glance
- **Dispute management**: Highlighted disputed invoices get priority attention

**Business Value:**
- 60% faster customer lookup times
- 95% billing accuracy (up from 87%)
- R8.5M in recovered overdue payments
- 40% reduction in billing disputes

---

## Next Steps

Lab 05 will cover Controls and Navigation for Vodacom:
- Navigation menus for customer service vs. operations teams
- Cascading LOVs for address entry (Province → City → Suburb)
- Dynamic item behavior for smart forms
- Custom buttons for VodaPay actions

**Estimated Time for Lab 05:** 90 minutes
