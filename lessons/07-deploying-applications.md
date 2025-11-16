# Lesson 07: Deploying Applications

## Theory

### Layman's Explanation

**Deployment** is moving your finished application from where you built it (development) to where users actually use it (production). Like publishing a book after writing and editing it, or releasing a movie after filming and post-production.

Think of it as three phases:
1. **Development** (DEV): Your workshop where you build and experiment
2. **Testing** (TEST/UAT): Quality control where you verify everything works
3. **Production** (PROD): The live environment where real users work with real data

The goal: Move your application safely through these phases without breaking anything or losing data.

**Real-World Analogy: Restaurant Opening**

**Development Kitchen (DEV):**
- Chef experiments with recipes
- Tests new dishes
- Makes mistakes, throws away failed attempts
- No customers see this chaos

**Rehearsal Dinner (TEST):**
- Invite friends/family to try menu
- Check timing, portions, presentation
- Find problems before real opening
- Practice with realistic but not critical service

**Grand Opening (PROD):**
- Real customers
- Real money
- Everything must work perfectly
- Can't say "oops, let me start over"

**Vodacom's Deployment Journey: From Chaos to Confidence**

Let's see how Vodacom went from deployment disasters to smooth, automated releases.

**The Old Way (Microsoft Access): "Pray and Deploy"**

**The Horror Story: Friday 5 PM Production Update**

**January 2023, 4:45 PM:**
- **John (Developer):** "I finished the new Project Status Report. I'll copy it to production."
- **Sarah (Manager):** "It's Friday afternoon... can it wait until Monday?"
- **John:** "It's just a report, what could go wrong? 5 minutes max."

**John's "Deployment Process":**

1. **Find Production Database** (10 minutes)
   - Access file on shared drive: `\\fileserver\apps\ProjectManager_PROD.accdb`
   - Three files there: `ProjectManager_PROD.accdb`, `ProjectManager_PROD_old.accdb`, `ProjectManager_PROD_backup_Jan10.accdb`
   - Which is current? No idea. Check file dates.
   - Pick the one modified most recently

2. **Open in Access** (5 minutes)
   - File locked (someone using it)
   - Walk to Maria's desk: "Can you close the database?"
   - Maria: "I'm in the middle of entering timesheets!"
   - John: "It'll just take a minute, I promise"
   - Maria (frustrated): Closes database, loses unsaved work

3. **Import New Report** (3 minutes)
   - Database Design → Import Objects
   - Select new report from DEV database
   - Click Import
   - Warning: "Report name already exists, replace?"
   - John: "Yes" (overwrites production report)

4. **Test Quickly** (30 seconds)
   - Open report, looks fine
   - Close database

5. **Tell Users** (email)
   - "New Project Status Report is live. Enjoy!"

**Total deployment time: 18 minutes**
**Downtime: 18 minutes** (database locked while John worked)

**5:03 PM:**
- **Email from Finance:** "The report is showing $0 for all budgets???"
- **Email from Manager:** "I'm seeing projects from 2019 that should be archived"
- **Email from CEO:** "Why is the client name column blank?"

**What Went Wrong:**
- New report used view that didn't exist in PROD (only in DEV)
- Query referenced fields that had different names in PROD
- John tested in DEV (worked fine), assumed PROD identical (wasn't)
- No rollback plan

**5:15 PM:**
- **John (panicking):** Tries to import old report back
- **Access:** "Cannot import, database locked"
- **Why locked?** 50 users trying to run the broken report simultaneously

**5:30 PM:**
- **John:** Kicks everyone off database (all users lose work)
- **John:** Imports old report
- **John:** Realizes he doesn't have old report (overwrote it)
- **John:** Looks for backup...

**6:15 PM:**
- Found backup from January 10 (5 days old)
- Restored report, but now missing 5 days of updates John made
- Report works but is outdated

**Impact:**
- 50 users disrupted (lost work, productivity)
- Finance team couldn't close month (needed accurate report)
- Emergency weekend work to fix properly
- **Cost: $15,000** (50 users × 2 hours lost × $150/hr average)

**CEO's Email (5:47 PM):**
> "Why are we deploying changes at 5 PM on Friday? This is unacceptable. We need a proper deployment process."

**More Problems with Access "Deployment":**

1. **No Version Control**
   - Files named: `ProjectManager.accdb`, `ProjectManager_v2.accdb`, `ProjectManager_final.accdb`, `ProjectManager_final_FINAL.accdb`, `ProjectManager_final_FINAL_v3.accdb`
   - Which is actually final? Nobody knows

2. **No Testing Environment**
   - DEV and PROD are the two choices
   - No TEST/UAT for validation
   - Changes go straight from developer's laptop to production

3. **No Rollback**
   - Once you overwrite something, it's gone
   - Backups are manual, inconsistent
   - Hope you remember to backup before changing

4. **No Tracking**
   - Who deployed what, when?
   - What changed in this release?
   - No documentation

5. **Manual Process**
   - Remember all steps
   - Copy this form, that report, those modules
   - Easy to forget something
   - Human error guaranteed

6. **Downtime Required**
   - Kick everyone off database
   - Make changes
   - Let everyone back
   - 15-30 minutes every deployment

7. **No Coordination**
   - John deploys on Friday
   - Sarah deploys on Monday
   - Changes conflict, database corrupted

**Vodacom's Deployment Failures (2022-2023):**
- **27 failed deployments** in 12 months
- **Average downtime per failure:** 45 minutes
- **Cost per failure:** $11,250 (50 users × 45 min × $300/hr)
- **Total cost:** $303,750/year in deployment disasters
- **User trust:** Shattered ("Every update breaks something")

**The APEX Transformation: "Deploy with Confidence"**

**Vodacom's New Deployment Process:**

**CI/CD Deployment Pipeline:**

```
┌──────────────────────────────────────────────────────────┐
│           APEX CI/CD DEPLOYMENT PIPELINE                 │
├──────────────────────────────────────────────────────────┤
│                                                          │
│  DEVELOPMENT ENVIRONMENT                                 │
│  ┌────────────────────────────────────────────────┐     │
│  │ Developers build features                      │     │
│  │ • Create pages, regions, items                 │     │
│  │ • Write SQL, PL/SQL                            │     │
│  │ • Test locally                                 │     │
│  └────────────────────────────────────────────────┘     │
│              │                                            │
│              ↓ (git commit, git push)                     │
│  ┌────────────────────────────────────────────────┐     │
│  │ GIT REPOSITORY                                 │     │
│  │ • Version control                              │     │
│  │ • Branch: develop                              │     │
│  │ • Automated export runs nightly                │     │
│  └────────────────────────────────────────────────┘     │
│              │                                            │
│              ↓ (CI/CD trigger on commit)                  │
│  ┌────────────────────────────────────────────────┐     │
│  │ BUILD & TEST STAGE                             │     │
│  │ • Export application (SQLcl)                   │     │
│  │ • Run unit tests                               │     │
│  │ • SQL syntax validation                        │     │
│  │ • Security scan                                │     │
│  └────────────────────────────────────────────────┘     │
│              │                                            │
│              ↓ (if all tests pass)                        │
│  TEST ENVIRONMENT                                        │
│  ┌────────────────────────────────────────────────┐     │
│  │ • Automated deployment (weekly)                │     │
│  │ • Import application                           │     │
│  │ • Run smoke tests                              │     │
│  │ • QA team validates                            │     │
│  │ • User acceptance testing (UAT)                │     │
│  └────────────────────────────────────────────────┘     │
│              │                                            │
│              ↓ (manual approval required)                 │
│  ┌────────────────────────────────────────────────┐     │
│  │ APPROVAL GATE                                  │     │
│  │ • Manager approval                             │     │
│  │ • Operations approval                          │     │
│  │ • Change window scheduled                      │     │
│  └────────────────────────────────────────────────┘     │
│              │                                            │
│              ↓ (approved)                                 │
│  PRODUCTION ENVIRONMENT                                  │
│  ┌────────────────────────────────────────────────┐     │
│  │ • Scheduled deployment (Wed 6 AM)              │     │
│  │ • Backup current version                       │     │
│  │ • Import new version                           │     │
│  │ • Run health checks                            │     │
│  │ • Monitor for errors                           │     │
│  │ • Notify users                                 │     │
│  └────────────────────────────────────────────────┘     │
│              │                                            │
│              ├─ SUCCESS → Document and celebrate         │
│              └─ FAILURE → Rollback (30 seconds)          │
│                                                          │
│  Key Benefits:                                           │
│  • Automated: Reduces human error                       │
│  • Tested: Issues caught in TEST, not PROD              │
│  • Auditable: Complete history in Git                   │
│  • Rollback: Instant recovery if needed                 │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

**🎓 Learn More:**
- **Documentation**: [Export/Import Guide](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/exporting-and-importing.html)
- **Documentation**: [Supporting Objects](https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/managing-supporting-objects.html)
- **Tool**: [SQLcl Documentation](https://docs.oracle.com/en/database/oracle/sql-developer-command-line/)

**Environment Strategy:**

```
┌─────────────────────────────────────────────────────────┐
│ DEVELOPMENT (DEV)                                       │
│ Database: vodacom_dev_db                               │
│ APEX Workspace: VODACOM_DEV                            │
│ Purpose: Developers build features, experiment freely   │
│ Users: 3 developers                                     │
│ Data: Fake test data (ok to delete/corrupt)            │
│ Uptime: Not critical (can be down for maintenance)     │
└─────────────────────────────────────────────────────────┘
              │
              │ Deploy to TEST weekly
              ↓
┌─────────────────────────────────────────────────────────┐
│ TESTING / UAT (TEST)                                    │
│ Database: vodacom_test_db                              │
│ APEX Workspace: VODACOM_TEST                           │
│ Purpose: QA team and end-users validate features       │
│ Users: 10 testers + 20 power users                     │
│ Data: Sanitized copy of production data                │
│ Uptime: Important (testing schedules)                  │
└─────────────────────────────────────────────────────────┘
              │
              │ Deploy to PROD bi-weekly (approved releases)
              ↓
┌─────────────────────────────────────────────────────────┐
│ PRODUCTION (PROD)                                       │
│ Database: vodacom_prod_db                              │
│ APEX Workspace: VODACOM_PROD                           │
│ Purpose: Live environment for all users                │
│ Users: 250 employees + 180 clients                     │
│ Data: Real business data (critical)                    │
│ Uptime: Critical (99.9% SLA)                           │
│ Backup: Automated, tested recovery                     │
└─────────────────────────────────────────────────────────┘
```

**The New Process (Automated, Safe, Fast):**

**Step 1: Development (Week 1)**
- Developers build features in DEV
- Test locally
- Commit code to Git repository

**Step 2: Export Application**
```bash
# Automated script runs nightly
cd /opt/apex/exports
sql vodacom_dev_admin/pass@vodacom_dev_db << EOF
  set sqlformat insert
  apex export -applicationid 100 -split -expOriginalIds
  exit
EOF

# Result: Application split into files
f100/
├── application.sql          # App metadata
├── create_application.sql   # Main installer
├── install.sql             # Runs all scripts in order
├── readable/               # Human-readable YAML
├── pages/
│   ├── page_00001.sql     # Home page
│   ├── page_00002.sql     # Projects
│   ├── page_00003.sql     # Employees
│   └── ... (100+ page files)
└── components/
    ├── navigation_menu.sql
    ├── lov.sql
    ├── authorization_schemes.sql
    └── ... (shared components)

# Commit to Git
git add f100/
git commit -m "Export: Added new Project Status Report - Issue #1234"
git push origin develop
```

**Step 3: Deploy to TEST (Weekly, Monday 9 AM)**
```bash
# Automated via CI/CD pipeline (GitLab CI)

deploy_to_test:
  stage: test_deploy
  script:
    # Import application
    - sql vodacom_test_admin/pass@vodacom_test_db @f100/install.sql
    
    # Run smoke tests
    - npm run smoke-tests
    
    # Send notification
    - slack-notify "#testing" "App deployed to TEST. Ready for QA."
  
  only:
    - develop
  
  when: manual  # Requires approval
```

**Step 4: User Acceptance Testing (Week 1-2)**
- QA team tests in TEST environment
- Power users validate business logic
- Log issues in Jira
- Developers fix in DEV, redeploy to TEST

**Step 5: Deploy to PROD (Bi-weekly, Wednesday 6 AM)**
```bash
# Automated via CI/CD, requires 2 approvals (manager + operations)

deploy_to_prod:
  stage: prod_deploy
  script:
    # Pre-deployment checks
    - check_prod_health.sh
    - backup_prod_database.sh
    
    # Import application
    - sql vodacom_prod_admin/$PROD_PASS@vodacom_prod_db @f100/install.sql
    
    # Post-deployment validation
    - run_health_checks.sh
    - run_smoke_tests_prod.sh
    
    # Notify users
    - email_users.sh "Deployment complete. New features: [changelog]"
    - slack-notify "#general" "Production deployed. Version 2.14.3 live."
  
  only:
    - main
  
  when: manual  # Requires explicit approval
  
  environment:
    name: production
    url: https://apex.vodacom.com/prod
```

**The New Friday 5 PM Story:**

**John:** "I finished the new Project Status Report. It's in DEV."

**Process:**
1. John commits code to Git (2 minutes)
2. Automated export runs that night (0 minutes John's time)
3. Monday morning: Auto-deploy to TEST (0 minutes John's time)
4. QA team tests Tuesday-Thursday (John fixes any issues)
5. Wednesday 6 AM: Auto-deploy to PROD (scheduled, automated)

**John's time spent:** 2 minutes  
**User disruption:** Zero (deploy at 6 AM before anyone logs in)  
**Rollback if needed:** 1 command, 30 seconds  
**Audit trail:** Complete (Git commits, deployment logs)

**Deployment Comparison:**

| Metric | Before (Access) | After (APEX) | Improvement |
|--------|----------------|--------------|-------------|
| **Deployment time** | 18 minutes manual | 2 minutes automated | 89% faster |
| **Downtime** | 15-30 minutes | 0 (online deploy) | 100% eliminated |
| **Manual steps** | 12 steps | 1 (click approve) | 92% reduction |
| **Human errors** | 3-5 per deploy | 0 (automated) | 100% eliminated |
| **Rollback time** | 45+ minutes | 30 seconds | 99% faster |
| **Failed deployments/year** | 27 | 1 | 96% reduction |
| **Cost per failure** | $11,250 | $0 (caught in TEST) | 100% savings |
| **Documentation** | None | Automatic (Git) | ∞ better |
| **Audit trail** | None | Complete | ∞ better |
| **User disruption** | High | None | 100% eliminated |

**Annual Savings: $303,750** (avoided deployment disasters)

**Version Control Benefits:**

**Before (Access):**
```
File Explorer:
ProjectManager_final.accdb
ProjectManager_final_v2.accdb
ProjectManager_final_FINAL.accdb
ProjectManager_backup_jan15.accdb
ProjectManager_OLD_DO_NOT_USE.accdb  ← But which one IS current?
```

**After (APEX + Git):**
```
Git History:
commit 7f8a9b2 - Added Project Status Report (2024-01-15)
commit 3c2d1e4 - Fixed budget calculation bug (2024-01-12)
commit 9a1b5f7 - Added client portal features (2024-01-08)
commit 2e4c8d9 - Performance optimization for dashboard (2024-01-05)

Tags:
v2.14.3 - Production release (2024-01-15)
v2.14.2 - Production release (2024-01-08)
v2.14.1 - Production release (2024-01-01)

# Can roll back to ANY previous version instantly:
git checkout v2.14.2
deploy_to_prod.sh
```

**Benefits:**
- ✅ Know exactly what changed, when, by whom
- ✅ Roll back to any previous version in seconds
- ✅ Branch for experiments (won't affect main code)
- ✅ Code review before deployment
- ✅ Automatic backup (Git is distributed)

**Environment-Specific Configuration:**

**Problem:** Production uses different database, email server, file paths than DEV

**Solution:** Substitution strings

```sql
-- Application configuration (set per environment)

DEV:
  APP_EMAIL_FROM = 'dev-noreply@vodacom.com'
  APP_FILE_PATH = '/opt/files/dev/'
  APP_API_URL = 'https://api-dev.vodacom.com'

TEST:
  APP_EMAIL_FROM = 'test-noreply@vodacom.com'
  APP_FILE_PATH = '/opt/files/test/'
  APP_API_URL = 'https://api-test.vodacom.com'

PROD:
  APP_EMAIL_FROM = 'noreply@vodacom.com'
  APP_FILE_PATH = '/opt/files/prod/'
  APP_API_URL = 'https://api.vodacom.com'

-- Application uses substitution strings:
apex_mail.send(
  p_from => '&APP_EMAIL_FROM.',
  p_to => :P1_USER_EMAIL,
  p_subject => 'Project Update',
  p_body => 'Your project has been updated...'
);

-- Automatically uses correct email address per environment
```

**Zero-Downtime Deployment:**

**Old Access:** Users kicked off during deployment

**New APEX:**
```
6:00 AM - Deploy starts
6:00:15 - Import completes (users still on old version)
6:00:30 - Application cache cleared
6:00:45 - Users automatically get new version on next page load

Total disruption: ZERO
Users see: Seamless transition
```

**Rollback Strategy:**

**Scenario:** Deploy to PROD at 6 AM, users report bug at 8 AM

**Old Access:**
1. Panic
2. Find backup (where is it?)
3. Kick everyone off
4. Restore backup
5. Hope it works
6. **Time: 45+ minutes, 250 users disrupted**

**New APEX:**
```bash
# One command rollback
cd /opt/apex/releases
git checkout v2.14.2  # Previous version
./deploy_to_prod.sh

# Time: 30 seconds
# User disruption: None (seamless)
# Data loss: None (database unchanged)
```

**Pre-Production Checklist:**

Automated checks before PROD deployment:

```bash
✓ All tests passing in TEST?
✓ QA sign-off received?
✓ Manager approval obtained?
✓ Database backup completed?
✓ Change window scheduled (if needed)?
✓ Rollback plan documented?
✓ Users notified of upcoming changes?
✓ Support team briefed on new features?
✓ Monitoring alerts configured?
✓ Performance baseline captured?

If ANY check fails → Deployment blocked
```

**Post-Deployment Validation:**

Automated health checks after PROD deployment:

```bash
1. Application accessible? (HTTP 200)
2. Database connection working?
3. Critical pages load < 2 seconds?
4. User authentication working?
5. Background jobs running?
6. Email notifications sending?
7. API integrations responding?
8. Error rate normal (<0.1%)?
9. Memory/CPU usage normal?
10. No errors in logs?

If ANY check fails → Alert sent, consider rollback
```

**The Numbers:**

**Vodacom's Deployment Transformation:**

| Metric | Before | After | Change |
|--------|--------|-------|--------|
| **Deployments per year** | 48 | 26 | Fewer but larger releases |
| **Failed deployments** | 27 (56%) | 1 (4%) | 96% reduction |
| **Average deployment time** | 18 minutes | 2 minutes | 89% faster |
| **Downtime per deployment** | 20 minutes | 0 minutes | 100% eliminated |
| **Annual downtime** | 960 minutes (16 hours) | 0 minutes | 100% eliminated |
| **Rollback capability** | Difficult/slow | Instant | ∞ better |
| **Audit trail** | None | Complete | ∞ better |
| **User disruption** | High | None | 100% eliminated |
| **Developer stress** | Very high | Low | Much happier |
| **Annual cost (failures + downtime)** | $303,750 | $5,000 | 98% reduction |

**Total Annual Savings: $298,750**

**The Bottom Line:**

Deployment is where development meets reality. Poor deployment process means:
- ❌ Broken production systems
- ❌ Data loss
- ❌ User disruption
- ❌ Developer stress
- ❌ Business impact

Professional deployment process means:
- ✅ Safe, tested releases
- ✅ Zero downtime
- ✅ Instant rollback if needed
- ✅ Complete audit trail
- ✅ Confident developers
- ✅ Happy users

**Vodacom's Transformation:**
- **Deployment failures**: 27/year → 1/year (96% reduction)
- **Downtime**: 16 hours/year → 0 hours
- **User disruption**: Eliminated
- **Developer confidence**: "I dread deployments" → "Deployments are boring (in a good way)"
- **Total savings**: $298,750/year

**CEO's quote:** "We went from every deployment being a crisis to deployments being a non-event. That's exactly what they should be - invisible to users, routine for developers, safe for the business."

In the next sections, we'll learn exactly how to export applications, set up CI/CD pipelines, create deployment scripts, and implement rollback strategies.

### Intermediate Explanation

**Deployment Process:**
1. **Export** application from source workspace (DEV)
2. **Version control** (Git) for tracking changes
3. **Import** to target workspace (TEST/PROD)
4. **Testing** in target environment
5. **Go-live** with monitoring

**Export Options:**
- Single file (easy, all-in-one)
- Split files (better for version control, separate pages/components)
- Supporting objects (tables, packages, data)

**Supporting Objects:**
- Database schema (tables, views, sequences)
- PL/SQL packages
- Initial data (lookup tables)
- Install/upgrade scripts

### Advanced Explanation

**Deployment Strategies:**

**1. Manual Export/Import** (Small teams)
- App Builder → Export → Download SQL
- Import in target workspace
- Run supporting object scripts

**2. SQLcl Automation** (CI/CD pipelines)
```bash
sql user/pass@db <<EOF
apex export -applicationid 100 -split
exit
EOF
```

**3. REST API Deployment** (Enterprise)
- APEX REST API for automation
- Integrate with Jenkins/GitLab CI
- Automated testing post-deployment

**Version Management:**
- Application properties → Version
- Track in Git tags
- Rollback capability with previous exports

**Environment Differences:**
- Database connection strings
- File storage paths
- Email server settings
- Use substitution strings for environment-specific values

---

## Labs / Practicals

### Lab 1: Simple - Export and Import Application

**Objective:** Move Vodacom app from DEV to TEST.

**Step 1: Export from DEV**
1. Log into VODACOM_DEV workspace
2. App Builder → Export/Import → Export
3. Select application
4. Export Type: Application
5. File Format: SQL File
6. Click Export
7. Download file: `f100.sql`

**Step 2: Import to TEST**
1. Log into VODACOM_TEST workspace
2. App Builder → Export/Import → Import
3. Upload `f100.sql`
4. Click Import
5. Install application
6. Run and verify

---

### Lab 2: Intermediate - Automated Export with SQLcl

**Objective:** Script-based deployment for Vodacom.

**Create Export Script:**
```bash
#!/bin/bash
# export_apex_app.sh

APP_ID=100
WORKSPACE=VODACOM_DEV
EXPORT_DIR=/opt/apex_exports/$(date +%Y%m%d_%H%M%S)

mkdir -p $EXPORT_DIR
cd $EXPORT_DIR

sql vodacom_dev_data/password@localhost/vodacom_db <<EOF
set sqlformat insert
apex export -applicationid $APP_ID -split
exit
EOF

echo "Application $APP_ID exported to $EXPORT_DIR"

# Commit to Git
git add .
git commit -m "Export app $APP_ID on $(date)"
git push
```

**Run:** `./export_apex_app.sh`

---

### Lab 3: Advanced - Full CI/CD Pipeline

**Objective:** Automated deployment with testing.

**GitLab CI Pipeline (`.gitlab-ci.yml`):**
```yaml
stages:
  - export
  - test
  - deploy

export_dev:
  stage: export
  script:
    - sql vodacom_dev_data/$DB_PASS@$DB_HOST/$DB_SID <<< "apex export -applicationid 100 -split"
    - git add .
    - git commit -m "Auto-export from DEV" || true
  artifacts:
    paths:
      - f100/

test_import:
  stage: test
  script:
    - sql vodacom_test_data/$DB_PASS@$DB_HOST/$DB_SID <<< "apex import f100/install.sql"
    - npm run selenium-tests
  only:
    - main

deploy_prod:
  stage: deploy
  script:
    - sql vodacom_prod_data/$DB_PASS@$DB_HOST/$DB_SID <<< "apex import f100/install.sql"
  when: manual
  only:
    - main
```

**Result:** Push to Git → Auto-export → Auto-deploy to TEST → Manual PROD deployment

---

## Real-World Practical

### Vodacom Production Deployment

**Scenario:** Vodacom's Project Manager app is ready for production launch.

**Requirements:**
1. Zero downtime deployment
2. Rollback plan
3. Database migration scripts
4. Environment-specific configuration
5. Health checks post-deployment

**Implementation:**

**Step 1: Pre-Deployment Checklist**
- [ ] All tests passing
- [ ] Performance benchmarks met
- [ ] Security audit complete
- [ ] Backup current PROD
- [ ] Schedule maintenance window
- [ ] Notify users

**Step 2: Export with Supporting Objects**
```sql
-- Create install script
@apex_export.sql

-- Export supporting objects
CREATE OR REPLACE PACKAGE vodacom_util AS
  FUNCTION get_db_environment RETURN VARCHAR2;
END;
/

-- Environment detection
CREATE OR REPLACE PACKAGE BODY vodacom_util AS
  FUNCTION get_db_environment RETURN VARCHAR2 IS
  BEGIN
    RETURN CASE 
      WHEN SYS_CONTEXT('USERENV', 'DB_NAME') LIKE '%DEV%' THEN 'DEV'
      WHEN SYS_CONTEXT('USERENV', 'DB_NAME') LIKE '%TEST%' THEN 'TEST'
      ELSE 'PROD'
    END;
  END;
END;
/
```

**Step 3: Database Migration**
```sql
-- migration_001_add_columns.sql
ALTER TABLE vodacom_projects 
ADD (priority VARCHAR2(10) DEFAULT 'MEDIUM');

UPDATE vodacom_projects 
SET priority = 'HIGH' 
WHERE budget > 500000;

COMMIT;
```

**Step 4: Deploy to PROD**
1. Import application
2. Run migration scripts
3. Update application substitution strings
4. Clear cache
5. Test critical paths
6. Monitor for errors

**Step 5: Health Checks**
```sql
-- Verify deployment
SELECT application_id, application_name, version
FROM apex_applications
WHERE workspace = 'VODACOM_PROD';

-- Check supporting objects
SELECT object_name, status
FROM user_objects
WHERE status != 'VALID';

-- Test key functionality
SELECT COUNT(*) FROM vodacom_projects;
```

---

## Assessment

### MCQs

**Q1:** What is the recommended way to version control APEX applications?

A) Save exports to USB drive  
B) Export as split files and commit to Git  
C) Email SQL files  
D) No version control needed  

**Answer: B**

**Q2:** When should you use manual deployment approval?

A) Never  
B) Always  
C) For production deployments after automated testing  
D) Only for small applications  

**Answer: C**

### Short Answer

**Q1:** Explain the difference between exporting as single file vs split files.

**Answer:**
- **Single File**: All application components in one SQL file. Easy to deploy (one upload), but difficult to track changes in version control (large diffs).
- **Split Files**: Separate files for each page, component, shared element. Better for Git (see exactly what changed), easier for team collaboration, but more complex to deploy (install.sql runs all).

Vodacom uses split files for team development, single file for emergency hotfixes.

**Q2:** What should be in a deployment checklist for production?

**Answer:**
1. **Pre-Deploy**: Backup current version, run tests, security scan, performance benchmark
2. **Deploy**: Export from tested environment, import to PROD, run migration scripts
3. **Post-Deploy**: Health checks, smoke tests, monitor logs, verify critical functionality
4. **Rollback Plan**: Keep previous version export, document rollback steps, test rollback in TEST first

### Practical Challenge

**Project:** Vodacom Deployment Pipeline

**Requirements:**
1. **Git Repository**
   - Initialize repo for APEX app
   - Create branches: dev, test, main (prod)
   - Export app to split files
   - Commit with meaningful messages

2. **Deployment Scripts**
   - `export.sh` - Export from DEV
   - `deploy_test.sh` - Deploy to TEST
   - `deploy_prod.sh` - Deploy to PROD (with approval)
   - `rollback.sh` - Restore previous version

3. **Documentation**
   - Deployment runbook
   - Rollback procedures
   - Environment configuration guide
   - Troubleshooting steps

4. **Testing**
   - Automated smoke tests
   - Performance benchmarks
   - Security scan

**Deliverables:**
- Git repository with app source
- All deployment scripts (tested)
- README with deployment instructions
- Successful deployment to TEST
- Demo of rollback procedure

---

## PowerPoint Slides

### Slide 1: Deploying Applications
**Vodacom Training - Lesson 07**

### Slide 2: Deployment Workflow
```
DEV → Export → Git → TEST → Verify → PROD
```

**Key Principle:** Never deploy untested code to production!

### Slide 3: Export Options
**Single File** - All-in-one SQL  
✅ Easy deploy  
❌ Hard to track changes  

**Split Files** - Component-by-component  
✅ Git-friendly  
✅ Team collaboration  
❌ More complex deploy  

**Vodacom:** Uses split files

### Slide 4: Supporting Objects
**Include in deployment:**
- Database tables
- Views
- PL/SQL packages
- Sequences
- Lookup data
- Indexes

**Separate from application!**

### Slide 5: SQLcl for Automation
```bash
sql user/pass@db <<EOF
apex export -applicationid 100 -split
apex import install.sql
exit
EOF
```

**Benefits:**
- Scriptable
- CI/CD integration
- No GUI needed

### Slide 6: CI/CD Pipeline
```
Git Push → Auto-Export → Auto-TEST → Manual PROD
```

**Tools:**
- GitLab CI / GitHub Actions
- Jenkins
- SQLcl
- Selenium (testing)

### Slide 7: Environment Management
**DEV** - Active development  
**TEST** - QA validation  
**PROD** - Live users  

**Different:**
- Database connections
- Email servers
- File storage
- API endpoints

**Use substitution strings!**

### Slide 8: Deployment Checklist
**Pre-Deploy:**
✅ Tests passing  
✅ Backup current version  
✅ Schedule window  
✅ Notify users  

**Post-Deploy:**
✅ Health checks  
✅ Smoke tests  
✅ Monitor logs  
✅ Verify critical paths  

### Slide 9: Rollback Strategy
**Always have a rollback plan!**

1. Keep previous version export
2. Document rollback steps
3. Test in TEST environment
4. Execute quickly if needed

**Vodacom:** 5-minute rollback capability

### Slide 10: Best Practices
✅ Use version control (Git)  
✅ Automate exports  
✅ Test in TEST before PROD  
✅ Manual approval for PROD  
✅ Document everything  
✅ Monitor after deployment  
✅ Have rollback plan  
✅ Communicate with users  

---

## Course Summary

**Congratulations!** You've completed the Oracle APEX Development Training Course.

### What You Learned:
1. ✅ APEX architecture and setup
2. ✅ Application creation methods
3. ✅ Page Designer and components
4. ✅ Reports and forms
5. ✅ Navigation and controls
6. ✅ Security and performance
7. ✅ Deployment strategies

### Vodacom Success Story:
- Migrated from Access to APEX in 6 weeks
- 50+ concurrent users supported
- Mobile-responsive interface
- Integrated with ERP via REST APIs
- SOC 2 compliant
- Sub-2-second page loads

### Next Steps:
- Build real applications
- Explore APEX plugins
- Join APEX community
- Oracle APEX certification

**Keep building! 🚀**

