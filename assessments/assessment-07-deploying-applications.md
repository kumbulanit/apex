# Assessment 07: Deploying Applications

**Duration:** 45 minutes  
**Total Points:** 100 points  
**Passing Score:** 70%  
**Prerequisites:** Completed Lab 07 (Vodacom Production Deployment)

---

## Part A: Multiple Choice Questions (40 points - 2 points each)

**1. The APEX Export utility creates files in which format?**
- [ ] A) .exe
- [ ] B) .sql
- [ ] C) .pdf
- [ ] D) .jpg

**2. When exporting an application, "Export with Supporting Objects" includes:**
- [ ] A) Only pages
- [ ] B) Tables, sequences, packages, LOVs, themes
- [ ] C) User passwords
- [ ] D) Server configuration

**3. The primary purpose of a deployment checklist is to:**
- [ ] A) Slow down deployment
- [ ] B) Ensure nothing is forgotten and reduce errors
- [ ] C) Generate reports
- [ ] D) Delete old applications

**4. What is the difference between Development and Production environments?**
- [ ] A) No difference
- [ ] B) Dev for testing, Prod for live users
- [ ] C) Prod is slower
- [ ] D) Dev is more secure

**5. Application ID conflicts during import can be resolved by:**
- [ ] A) Deleting the database
- [ ] B) Using "Reuse Application ID" or "Auto Assign New ID"
- [ ] C) Restarting the server
- [ ] D) Waiting 24 hours

**6. The Install Supporting Objects step during import:**
- [ ] A) Is optional but recommended
- [ ] B) Creates database objects (tables, sequences, etc.)
- [ ] C) Should run before application import
- [ ] D) All of the above

**7. Version control (Git, SVN) for APEX applications tracks:**
- [ ] A) User passwords
- [ ] B) Application definition changes over time
- [ ] C) Server hardware
- [ ] D) Network traffic

**8. A UAT (User Acceptance Testing) environment allows:**
- [ ] A) Developers to write code
- [ ] B) End users to test before production
- [ ] C) Database backups only
- [ ] D) No user access

**9. The APEX_INSTANCE_ADMIN workspace provides:**
- [ ] A) No special privileges
- [ ] B) Instance-level administration and monitoring
- [ ] C) Only report viewing
- [ ] D) User application development

**10. Database schemas in APEX workspaces:**
- [ ] A) Must be the same name as workspace
- [ ] B) Can be different from workspace name
- [ ] C) Are not needed
- [ ] D) Are deleted on export

**11. What is the purpose of application substitution strings?**
- [ ] A) Delete code
- [ ] B) Replace hardcoded values (URLs, API keys) per environment
- [ ] C) Create users
- [ ] D) Slow down pages

**12. The Remote Deployment feature in APEX allows:**
- [ ] A) Deleting remote servers
- [ ] B) Deploying apps to other APEX instances via REST APIs
- [ ] C) Only local deployment
- [ ] D) No automation

**13. Pre-deployment testing should include:**
- [ ] A) Functional testing only
- [ ] B) Performance, security, compatibility, user acceptance
- [ ] C) Only checking colors
- [ ] D) No testing needed

**14. The Application Backup utility creates:**
- [ ] A) Physical server backup
- [ ] B) Point-in-time export for recovery
- [ ] C) User list only
- [ ] D) Network diagram

**15. When should you test deployment scripts?**
- [ ] A) Never
- [ ] B) In development environment before production
- [ ] C) Only on production
- [ ] D) After production deployment

**16. What is a rollback plan?**
- [ ] A) Physical exercise routine
- [ ] B) Procedure to revert to previous version if deployment fails
- [ ] C) Marketing strategy
- [ ] D) User training program

**17. Change management in enterprise deployments involves:**
- [ ] A) Random changes without approval
- [ ] B) Documented approval process and change tracking
- [ ] C) No documentation
- [ ] D) Automatic changes

**18. The APEX_MAIL package is used for:**
- [ ] A) Physical mail delivery
- [ ] B) Sending email notifications from applications
- [ ] C) Deleting users
- [ ] D) Database backups

**19. In Vodacom's deployment, why separate Dev, UAT, and Prod environments?**
- [ ] A) It's more expensive
- [ ] B) Prevent untested changes from affecting live users
- [ ] C) No technical reason
- [ ] D) Slows down development

**20. Post-deployment monitoring should track:**
- [ ] A) User activity, errors, performance
- [ ] B) Nothing
- [ ] C) Only user logins
- [ ] D) Office temperature

---

## Part B: True/False Questions (20 points - 2 points each)

**21. You can export and import APEX applications between different APEX versions.**
- [ ] True
- [ ] False

**22. Supporting objects (tables, data) are automatically included in application export.**
- [ ] True
- [ ] False

**23. It's safe to deploy directly to production without testing.**
- [ ] True
- [ ] False

**24. Application substitution strings help manage environment-specific values.**
- [ ] True
- [ ] False

**25. You should back up the production database before deployment.**
- [ ] True
- [ ] False

**26. User accounts and passwords are included in application exports.**
- [ ] True
- [ ] False

**27. The same application can run in multiple workspaces simultaneously.**
- [ ] True
- [ ] False

**28. Deployment should always be done during peak business hours.**
- [ ] True
- [ ] False

**29. Version control helps track who made which changes and when.**
- [ ] True
- [ ] False

**30. Post-deployment validation is optional and not important.**
- [ ] True
- [ ] False

---

## Part C: Deployment Sequencing (10 points)

**Order these deployment steps from 1-10 (first to last):**

___ A. Monitor production for errors  
___ B. Export application from Dev  
___ C. Schedule deployment window  
___ D. Import to UAT for testing  
___ E. Create rollback plan  
___ F. Get UAT sign-off  
___ G. Backup production database  
___ H. Import to Production  
___ I. Run smoke tests on Production  
___ J. Update documentation  

**Your ordered sequence (write step letters in order):**

**1.** ___ → **2.** ___ → **3.** ___ → **4.** ___ → **5.** ___  
**6.** ___ → **7.** ___ → **8.** ___ → **9.** ___ → **10.** ___

---

## Part D: Short Answer Questions (15 points - 5 points each)

**31. Explain the purpose of Dev, UAT, and Production environments in Vodacom's APEX deployment strategy. What happens in each environment?**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**32. What are application substitution strings and why are they critical for multi-environment deployment? Provide two Vodacom examples.**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**33. Describe a comprehensive rollback plan for a failed Vodacom production deployment. What steps would you take?**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

---

## Part E: Practical Deployment Scenario (15 points)

**34. Vodacom Customer Portal Production Deployment**

You're deploying the Vodacom Customer Portal (Application ID 100) to production. The application includes:
- 25 pages
- Database tables: VODACOM_CUSTOMERS, VODACOM_PACKAGES, VODACOM_ACTIVATIONS
- REST API integration to external billing system
- Email notifications
- 500+ concurrent call center agent users

**Part 1: Pre-Deployment Checklist (5 points)**

Create a checklist for this deployment:

**Environment Preparation:**
```
□ _________________________________________________________________________
□ _________________________________________________________________________
□ _________________________________________________________________________
```

**Application Readiness:**
```
□ _________________________________________________________________________
□ _________________________________________________________________________
□ _________________________________________________________________________
```

**Database Preparation:**
```
□ _________________________________________________________________________
□ _________________________________________________________________________
□ _________________________________________________________________________
```

**Part 2: Substitution Strings Configuration (5 points)**

Define substitution strings for environment-specific values:

| Substitution String | Dev Value | UAT Value | Prod Value |
|---------------------|-----------|-----------|------------|
| BILLING_API_URL | ____________ | ____________ | ____________ |
| EMAIL_FROM | ____________ | ____________ | ____________ |
| ____________ | ____________ | ____________ | ____________ |
| ____________ | ____________ | ____________ | ____________ |

**How to use in application:**
```
Example: In REST API endpoint configuration:
&BILLING_API_URL./api/customer
```

**Part 3: Deployment Script (5 points)**

Write the SQL*Plus deployment script commands:

```sql
-- Connect to production database
CONNECT vodacom_prod/password@PROD_DB

-- Your deployment commands:
-- 1. Backup current application




-- 2. Import new application version




-- 3. Install supporting objects




-- 4. Verify deployment




-- 5. Update application substitution strings




```

---

## Part F: Risk Mitigation & Troubleshooting (10 points)

**35. Deployment Risk Assessment (5 points)**

Identify risks and mitigation strategies:

| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|--------|-------------------|
| Application import fails | ______ | ______ | _________________ |
| Database changes break existing data | ______ | ______ | _________________ |
| Users experience downtime | ______ | ______ | _________________ |
| Performance degradation | ______ | ______ | _________________ |

**Probability:** Low / Medium / High  
**Impact:** Low / Medium / High

**36. Troubleshooting Failed Deployment (5 points)**

The deployment completed, but users report these issues:

**Issue 1:** "Login page not loading"
```
Troubleshooting steps:
1. _________________________________________________________________________
2. _________________________________________________________________________
3. _________________________________________________________________________
```

**Issue 2:** "Customer search returns no results"
```
Troubleshooting steps:
1. _________________________________________________________________________
2. _________________________________________________________________________
3. _________________________________________________________________________
```

---

## Answer Key (For Instructor Use Only)

### Part A: Multiple Choice
1. B  2. B  3. B  4. B  5. B  6. D  7. B  8. B  9. B  10. B
11. B  12. B  13. B  14. B  15. B  16. B  17. B  18. B  19. B  20. A

### Part B: True/False
21. True  22. False  23. False  24. True  25. True
26. False  27. True  28. False  29. True  30. False

### Part C: Deployment Sequencing

**Correct order:**
1. **B** - Export application from Dev
2. **C** - Schedule deployment window
3. **D** - Import to UAT for testing
4. **F** - Get UAT sign-off
5. **E** - Create rollback plan
6. **G** - Backup production database
7. **H** - Import to Production
8. **I** - Run smoke tests on Production
9. **A** - Monitor production for errors
10. **J** - Update documentation

### Part D: Short Answer (Sample Answers)

**31. Dev, UAT, and Production Environments:**

**Development (Dev):**
- Purpose: Developers build features, fix bugs, experiment
- Activities: Coding, unit testing, frequent changes
- Users: Developers, APEX admins
- Data: Test/sample data (fake customers)

**User Acceptance Testing (UAT):**
- Purpose: Business users validate features meet requirements
- Activities: End-to-end testing, workflow validation, performance testing
- Users: Call center agents (testers), managers, business analysts
- Data: Production-like data (anonymized real data)

**Production (Prod):**
- Purpose: Live system serving actual users
- Activities: Real business operations, customer interactions
- Users: All 500+ call center agents, managers
- Data: Real customer data (45M+ customers)

**Why separate?** Prevents untested changes from affecting live users, allows safe experimentation in dev, validates functionality before production release.

**32. Application Substitution Strings:**

**Definition:** Variables that hold environment-specific values, replaced at runtime based on environment.

**Purpose:** 
- Avoid hardcoding URLs, API keys, email addresses
- Single codebase works across all environments
- Change values without modifying application code

**Vodacom Examples:**

1. **BILLING_API_URL**:
   - Dev: `http://dev-billing.vodacom.local`
   - UAT: `http://uat-billing.vodacom.local`
   - Prod: `https://billing.vodacom.co.za`
   - Usage: REST API integration for package activation billing

2. **SUPPORT_EMAIL**:
   - Dev: `apex-dev@vodacom.co.za`
   - UAT: `apex-uat@vodacom.co.za`
   - Prod: `support@vodacom.co.za`
   - Usage: Email notifications for errors, alerts

**33. Rollback Plan:**

**Immediate Actions (if deployment fails):**

1. **Stop Deployment**: Halt import/installation process immediately
2. **Assess Impact**: Determine what was changed (app only? database?)
3. **Restore Application**: Import previously backed-up application version
4. **Restore Database**: If database changes made, restore from pre-deployment backup using:
   ```
   RMAN> RESTORE DATABASE;
   RMAN> RECOVER DATABASE;
   ```
5. **Verify Rollback**: Test critical functions (login, customer search, package activation)
6. **Notify Users**: Send communication that issue resolved, system operational
7. **Post-Mortem**: Analyze what failed, document lessons learned
8. **Fix and Redeploy**: Correct issue in dev, re-test in UAT, schedule new deployment

**Prevention:**
- Always backup before deployment
- Test rollback procedure in UAT
- Have DBA on standby during deployment
- Deploy during low-usage hours (nights/weekends)

### Part E: Practical Deployment (Sample Solution)

**Part 1: Pre-Deployment Checklist**

**Environment Preparation:**
```
□ Schedule deployment window (Saturday 2 AM - 6 AM, low usage)
□ Notify all stakeholders (agents, managers, IT, management)
□ Ensure DBA and APEX admin available during deployment
```

**Application Readiness:**
```
□ Export application from Dev (with supporting objects)
□ Test import in UAT environment successfully
□ Get UAT sign-off from call center manager
□ Verify all pages, reports, forms functional in UAT
□ Performance test: 500 concurrent users simulation passed
```

**Database Preparation:**
```
□ Backup production database (RMAN full backup)
□ Export current production application (backup copy)
□ Verify sufficient tablespace (10 GB free)
□ Review database change scripts (new columns, indexes)
□ Test database scripts in UAT first
```

**Part 2: Substitution Strings**

| Substitution String | Dev Value | UAT Value | Prod Value |
|---------------------|-----------|-----------|------------|
| BILLING_API_URL | http://dev-billing.vodacom.local | http://uat-billing.vodacom.local | https://billing.vodacom.co.za |
| EMAIL_FROM | apex-dev@vodacom.co.za | apex-uat@vodacom.co.za | noreply@vodacom.co.za |
| SUPPORT_PHONE | 082-TEST-001 | 082-TEST-UAT | 082-135-0000 |
| ENVIRONMENT_NAME | DEVELOPMENT | UAT | PRODUCTION |

**Part 3: Deployment Script**

```sql
-- Connect to production database
CONNECT vodacom_prod/password@PROD_DB

-- 1. Backup current application
@apex_export APP_ID=100 BACKUP_DIR=/backup/apex/

-- 2. Import new application version
@apex_install_app_100_v2.sql

-- 3. Install supporting objects
@vodacom_supporting_objects.sql

-- 4. Verify deployment
SELECT application_id, application_name, version, last_updated_by
FROM apex_applications
WHERE application_id = 100;

-- 5. Update application substitution strings
BEGIN
    APEX_UTIL.SET_SUBSTITUTION(
        p_application_id => 100,
        p_name => 'BILLING_API_URL',
        p_value => 'https://billing.vodacom.co.za'
    );
    APEX_UTIL.SET_SUBSTITUTION(
        p_application_id => 100,
        p_name => 'EMAIL_FROM',
        p_value => 'noreply@vodacom.co.za'
    );
    APEX_UTIL.SET_SUBSTITUTION(
        p_application_id => 100,
        p_name => 'ENVIRONMENT_NAME',
        p_value => 'PRODUCTION'
    );
    COMMIT;
END;
/

-- 6. Verify application loads
-- (Manual: Open browser, test login, customer search)
```

### Part F: Risk Mitigation & Troubleshooting

**35. Deployment Risk Assessment**

| Risk | Probability | Impact | Mitigation Strategy |
|------|-------------|--------|-------------------|
| Application import fails | Low | High | Test import in UAT first, validate export file, have rollback ready |
| Database changes break existing data | Medium | Critical | Full database backup, test all scripts in UAT, dry-run in UAT |
| Users experience downtime | Low | High | Deploy during off-hours (2-6 AM Saturday), 4-hour maintenance window |
| Performance degradation | Medium | High | Performance test in UAT (500 users), optimize queries, add indexes |

**36. Troubleshooting Failed Deployment**

**Issue 1: "Login page not loading"**

Troubleshooting steps:
1. Check ORDS status: `systemctl status ords` - ensure ORDS running
2. Check authentication scheme: Shared Components > Authentication - verify scheme configured correctly
3. Check database connection: Test SQL*Plus connection, verify APEX_PUBLIC_USER password
4. Review error logs: Check ORDS logs (`/ords/logs/`), check database alert log
5. Test direct URL: `http://server/ords/r/100/1` - verify routing works

**Issue 2: "Customer search returns no results"**

Troubleshooting steps:
1. Verify data exists: `SELECT COUNT(*) FROM vodacom_customers;` - ensure data not deleted
2. Check query syntax: Review Interactive Report source SQL - verify no syntax errors
3. Check parsing schema: Ensure application parsing schema has SELECT privilege on tables
4. Test query in SQL Workshop: Copy report query, run manually to verify results
5. Check filters: Verify no default filters hiding all records
6. Check synonyms: If using synonyms, verify they point to correct schema

---

## Grading Rubric

| Section | Points | Criteria |
|---------|--------|----------|
| Part A (MC) | 40 | 2 points per correct answer |
| Part B (T/F) | 20 | 2 points per correct answer |
| Part C (Sequencing) | 10 | 1 point per correct step placement |
| Part D (Short Answer) | 15 | 5 points each - Complete explanations with examples |
| Part E (Deployment) | 15 | Checklist (5), Substitution strings (5), Script (5) |
| Part F (Risk & Troubleshooting) | 10 | Risk assessment (5), Troubleshooting (5) |
| **TOTAL** | **100** | Pass = 70+ points |

---

**Student Name:** ______________________________  
**Date:** ______________  
**Score:** ______ / 100  
**Pass/Fail:** __________

**Instructor Notes:**
