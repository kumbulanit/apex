# Vodacom APEX Training - Quick Start Guide

## ✅ What's Ready to Use NOW

### 1. Database Setup (COMPLETE)
**File:** `labs/setup-sample-data-vodacom.sql`

**How to Use:**
1. Log into APEX workspace as administrator
2. Go to: SQL Workshop → SQL Scripts
3. Click "Upload" → select `setup-sample-data-vodacom.sql`
4. Click "Run"
5. Wait 2-3 minutes for completion
6. Verify: You should see 13 tables starting with `VODACOM_`

**What You Get:**
- 13 fully populated tables with 100+ sample records
- Departments: Customer Service, Network Ops, Sales, VodaPay, etc.
- 29 employees with South African names
- 20+ customers (individuals, businesses, government)
- 15 mobile numbers with balances (data, airtime, SMS)
- 22 data packages (daily, weekly, monthly bundles)
- Network towers across SA provinces
- Support tickets, sales records, invoices

---

### 2. Lab 01 (COMPLETE)
**File:** `labs/lab-01-introduction-vodacom.md`

**Duration:** 60 minutes  
**Level:** Beginner

**What Students Learn:**
- Navigate APEX workspace (VODACOM_DEV)
- Create customer and department tables
- Insert Vodacom sample data
- Query customers with mobile numbers
- Create customer service view
- Use Object Browser and SQL Commands

**Key Exercises:**
- ✅ Exercise 1.1: Log in and explore APEX
- ✅ Exercise 1.2: Navigate SQL Workshop
- ✅ Exercise 2.1: Create VODACOM_DEPARTMENTS table
- ✅ Exercise 2.2: Create VODACOM_CUSTOMERS table
- ✅ Exercise 2.3: Insert sample data (departments, customers)
- ✅ Exercise 3.1: Use Data Workshop (edit customer records)
- ✅ Exercise 3.2: Create V_CUSTOMER_SERVICE_VIEW
- ✅ Exercise 3.3: Create VODACOM_MOBILE_NUMBERS table (advanced)
- ✅ Exercise 4.1: Explore App Builder

**Challenge Exercises:**
- Create DATA_PACKAGES table
- Write business intelligence queries
- Create is_upgrade_eligible function

---

## 📊 Current Status

### ✅ Completed (Phase 1 - 30%)
- [x] Vodacom database schema (13 tables)
- [x] Comprehensive sample data (telecom-specific)
- [x] Lab 01 fully transformed

### ⏸️ Pending (Phase 2-4 - 70%)
- [ ] Lab 02: Creating Applications
- [ ] Lab 03: Pages and Page Designer
- [ ] Lab 04: Reports and Forms
- [ ] Lab 05: Controls and Navigation
- [ ] Lab 06: Security and Performance
- [ ] Lab 07: Deploying Applications
- [ ] Assessment 01-02 updates
- [ ] README and documentation updates

---

## 🎯 Quick Start for Trainers

### Option A: Use Only Completed Materials (Today)

**Teach Lab 01 with Vodacom context:**
1. Students create `VODACOM_DEV` workspace
2. Run `setup-sample-data-vodacom.sql`
3. Follow `lab-01-introduction-vodacom.md`
4. Students learn SQL basics with customer/mobile number data

**For Labs 02-07:**
- Use original TechNova versions
- Explain: "We'll use sample project data for these exercises"
- OR: Wait for transformation to complete

### Option B: Complete Transformation First (Recommended)

**Continue transformation:**
1. Transform Lab 02 next (Customer Portal Application)
2. Transform Lab 03 (Operations Dashboard)
3. Continue through Labs 04-07
4. Update assessments
5. Deliver full Vodacom course

---

## 📁 File Structure

```
apex/
├── labs/
│   ├── setup-sample-data.sql              (original - TechNova)
│   ├── setup-sample-data-vodacom.sql      ✅ NEW - USE THIS
│   ├── lab-01-introduction.md             (original - TechNova)
│   ├── lab-01-introduction-vodacom.md     ✅ NEW - USE THIS
│   ├── lab-02-creating-applications.md    ⏸️ needs transformation
│   ├── lab-03-pages-and-page-designer.md  ⏸️ needs transformation
│   ├── lab-04-reports-and-forms.md        ⏸️ needs transformation
│   ├── lab-05-controls-and-navigation.md  ⏸️ needs transformation
│   ├── lab-06-security-and-performance.md ⏸️ needs transformation
│   └── lab-07-deploying-applications.md   ⏸️ needs transformation
├── assessments/
│   ├── assessment-01.md                   ⏸️ needs updates
│   └── assessment-02.md                   ⏸️ needs updates
├── VODACOM-TRANSFORMATION-REPORT.md       ✅ Detailed progress report
└── VODACOM-QUICK-START.md                 ✅ This file
```

---

## 🔍 What Changed from TechNova to Vodacom

### Business Context
- **FROM:** 250 employees, project management, consulting
- **TO:** 45M customers, mobile network, payments, devices

### Database
- **FROM:** Employees, projects, timesheets, invoices
- **TO:** Customers, mobile numbers, packages, transactions, network towers

### Application Focus
- **FROM:** Employee Time Tracking System
- **TO:** Customer Service Portal & Management System

### Data Examples
- **FROM:** Sarah Johnson (Project Manager), John Smith (Developer)
- **TO:** Palesa Mokoena (Individual customer, Gauteng, VodaPay user)

### Real-World Scenarios
- **FROM:** "Track billable hours on client projects"
- **TO:** "Customer calls asking about data balance, service rep looks up account"

---

## 💡 Teaching Tips

### For Lab 01:
1. **Set Context:** "You're building tools for Vodacom customer service"
2. **Emphasize Scale:** 45 million customers vs 250 employees
3. **Use Real Examples:** 
   - "Customer walks into Vodacom store"
   - "Service rep receives call about VodaPay"
   - "Network ops tracks tower outages"
4. **South African Relevance:**
   - Students recognize SA names, places
   - Vodacom is a company they actually use
   - Makes learning more engaging

### Database Highlights:
- 13 tables covering telecom operations
- 100+ realistic records
- Foreign keys show customer→mobile relationships
- Check constraints enforce business rules
- Indexes prepare for performance discussions

### Common Questions:
**Q:** Why track data in MB?  
**A:** Telecom systems measure usage for billing/capacity planning

**Q:** What's prepaid vs postpaid?  
**A:** Prepaid = pay first, use later. Postpaid = use now, pay at month-end

**Q:** Why so many customer fields?  
**A:** RICA compliance, credit checks, service delivery requirements

---

## 🚀 Next Steps to Complete Course

### Priority 1: Labs 02-04 (Foundation Apps)
**Lab 02:** Create Customer Portal application
- Replace employee forms with customer lookup
- Dashboard: Active customers, transactions, support tickets

**Lab 03:** Build Operations Dashboard
- KPIs: Subscribers, data usage, network uptime, VodaPay transactions
- Charts: Customers by province, package popularity

**Lab 04:** Reports and Forms
- Customer analysis reports
- Subscription management forms
- Billing reports

### Priority 2: Labs 05-07 (Advanced Features)
**Lab 05:** UI Controls
- Package selection dropdowns
- SIM card management
- VodaPay interface

**Lab 06:** Security & Performance
- Customer data privacy
- PCI compliance
- Query optimization for millions of records

**Lab 07:** Deployment
- Deploy customer portal
- Production considerations

### Priority 3: Assessments & Documentation
- Update assessment questions with Vodacom examples
- Revise course README
- Update solution files

---

## 📞 Support & Questions

### If Students Ask:
**"Why did we switch from TechNova to Vodacom?"**
- Vodacom context is more relevant to South African students
- Telecoms industry is a major employer
- Students can relate to real-world scenarios
- Database design principles are the same, just different domain

**"Can I use the old TechNova database?"**
- Yes, for Labs 02-07 until transformation is complete
- Or wait for Vodacom versions
- Learning objectives are identical

**"Will this work with actual Vodacom systems?"**
- This is training data, not production Vodacom systems
- Schema is realistic and follows telecom industry patterns
- Concepts learned apply to real telecom applications

---

## ✨ Vodacom Authenticity Features

### South African Context
- ✅ Realistic SA names (Palesa, Thulani, Mbali, Sipho)
- ✅ All 9 provinces (Gauteng, Western Cape, KZN, etc.)
- ✅ Major cities (Johannesburg, Cape Town, Durban, Pretoria)
- ✅ Authentic postal codes and addresses

### Telecom Accuracy
- ✅ SA mobile format (082, 083, 071, 072, 073)
- ✅ SA ID numbers (13-digit format)
- ✅ Company registration numbers (XXXX/XXXXXX/XX)
- ✅ SIM card numbers (19-digit ICCID)
- ✅ Real package pricing (R25 for 250MB daily, R499 for 5GB monthly)

### Business Operations
- ✅ Prepaid, postpaid, contract categories
- ✅ VodaPay mobile payment system
- ✅ Network infrastructure (cell towers with GPS coordinates)
- ✅ Customer support tickets
- ✅ Sales records (devices, contracts)
- ✅ Billing and invoicing

---

## 📋 Validation Checklist

### Before Starting Lab 01:
- [ ] Workspace `VODACOM_DEV` created
- [ ] `setup-sample-data-vodacom.sql` uploaded to SQL Scripts
- [ ] Script executed successfully (check for errors)
- [ ] Verify 13 tables created: 
  ```sql
  SELECT COUNT(*) FROM user_tables WHERE table_name LIKE 'VODACOM_%';
  -- Should return: 13
  ```

### After Completing Lab 01:
- [ ] Students can query VODACOM_CUSTOMERS table
- [ ] Students can see mobile numbers with balances
- [ ] V_CUSTOMER_SERVICE_VIEW created successfully
- [ ] Students understand foreign key relationships
- [ ] Students can insert new customers using Object Browser

### Validation Query:
```sql
SELECT 'Departments' AS table_name, COUNT(*) AS records FROM vodacom_departments
UNION ALL
SELECT 'Employees', COUNT(*) FROM vodacom_employees
UNION ALL
SELECT 'Customers', COUNT(*) FROM vodacom_customers
UNION ALL
SELECT 'Mobile Numbers', COUNT(*) FROM vodacom_mobile_numbers
UNION ALL
SELECT 'Packages', COUNT(*) FROM vodacom_packages
UNION ALL
SELECT 'Transactions', COUNT(*) FROM vodacom_transactions
UNION ALL
SELECT 'Network Towers', COUNT(*) FROM vodacom_network_towers
UNION ALL
SELECT 'Support Tickets', COUNT(*) FROM vodacom_customer_support
UNION ALL
SELECT 'Sales', COUNT(*) FROM vodacom_sales
UNION ALL
SELECT 'VodaPay Accounts', COUNT(*) FROM vodacom_vodapay_accounts
UNION ALL
SELECT 'Invoices', COUNT(*) FROM vodacom_invoices;
```

**Expected Results:**
- Departments: 8
- Employees: 29
- Customers: 20+
- Mobile Numbers: 15
- Packages: 22
- Transactions: 15
- Network Towers: 12
- Support Tickets: 10
- Sales: 10
- VodaPay Accounts: 9
- Invoices: 6

---

## 🎓 Learning Outcomes

### After Lab 01, Students Can:
1. ✅ Navigate APEX workspace confidently
2. ✅ Create tables with identity columns and constraints
3. ✅ Implement foreign key relationships
4. ✅ Insert data using SQL and PL/SQL
5. ✅ Create views for simplified querying
6. ✅ Use Object Browser to manage database objects
7. ✅ Write JOIN queries across multiple tables
8. ✅ Understand telecom database design
9. ✅ Work with South African data formats

### Technical Skills Gained:
- SQL DDL (CREATE TABLE, CREATE INDEX, CREATE VIEW)
- SQL DML (INSERT, SELECT, JOIN)
- Database constraints (PK, FK, CHECK, UNIQUE)
- Performance optimization (indexes)
- Data modeling (one-to-many relationships)

### Business Knowledge:
- Telecom customer management
- Prepaid vs postpaid models
- Mobile payment systems (VodaPay)
- Network infrastructure basics
- Customer service operations

---

## 📝 Summary

**What You Have Now:**
- ✅ Complete Vodacom database (13 tables, 100+ records)
- ✅ Lab 01 fully transformed for Vodacom context
- ✅ Ready to teach immediately
- ✅ Authentic South African telecom scenarios

**What's Pending:**
- ⏸️ Labs 02-07 (can use originals or wait for transformation)
- ⏸️ Assessments (mostly usable as-is, short answers need updates)

**Recommendation:**
- **Start teaching Lab 01** with Vodacom materials NOW
- **Transform Labs 02-04** before continuing (high priority)
- **Labs 05-07** can use original TechNova versions with minor adjustments

---

**Ready to teach?** Start with `lab-01-introduction-vodacom.md` and `setup-sample-data-vodacom.sql`!

**Questions?** Refer to `VODACOM-TRANSFORMATION-REPORT.md` for detailed technical information.

**Good luck with your Vodacom APEX training! 🚀**
