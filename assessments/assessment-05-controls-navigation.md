# Assessment 05: Controls and Navigation

**Duration:** 40 minutes  
**Total Points:** 100 points  
**Passing Score:** 70%  
**Prerequisites:** Completed Lab 05 (Vodacom Portal Navigation and Controls)

---

## Part A: Multiple Choice Questions (40 points - 2 points each)

**1. The Navigation Menu in APEX applications typically appears:**
- [ ] A) At the bottom of pages
- [ ] B) In the sidebar or top navigation bar
- [ ] C) In pop-up windows only
- [ ] D) Cannot be customized

**2. Breadcrumbs in APEX show:**
- [ ] A) User's password
- [ ] B) Navigation path/hierarchy to current page
- [ ] C) Database size
- [ ] D) Server logs

**3. A Navigation Bar in APEX is best used for:**
- [ ] A) Main menu items only
- [ ] B) Global actions (logout, profile, settings)
- [ ] C) Database queries
- [ ] D) Report filtering

**4. Which Shared Component stores the navigation menu structure?**
- [ ] A) Pages
- [ ] B) Lists
- [ ] C) Regions
- [ ] D) Processes

**5. A button can trigger which of the following actions?**
- [ ] A) Submit page
- [ ] B) Redirect to URL
- [ ] C) Execute Dynamic Action
- [ ] D) All of the above

**6. Hot buttons in APEX are styled to:**
- [ ] A) Be invisible
- [ ] B) Stand out as primary actions (bold/colored)
- [ ] C) Delete data
- [ ] D) Slow down the page

**7. Conditional display for navigation items allows:**
- [ ] A) Showing menu items based on user role
- [ ] B) Deleting the database
- [ ] C) Creating new workspaces
- [ ] D) Changing application ID

**8. A List Entry in APEX can link to:**
- [ ] A) Another page in the application
- [ ] B) External URL
- [ ] C) Custom PL/SQL code
- [ ] D) All of the above

**9. The Tabs region type displays:**
- [ ] A) Database tables
- [ ] B) Tabbed interface for organizing content
- [ ] C) User credentials
- [ ] D) Server logs

**10. Badge values in navigation show:**
- [ ] A) User's age
- [ ] B) Count or notification (e.g., "5 new items")
- [ ] C) Application version
- [ ] D) Database size

**11. What is the purpose of authorization schemes in navigation?**
- [ ] A) Encrypt data
- [ ] B) Control who sees menu items
- [ ] C) Speed up queries
- [ ] D) Change colors

**12. A Tree region in APEX displays:**
- [ ] A) Plant taxonomy
- [ ] B) Hierarchical data with parent-child relationships
- [ ] C) Only flat lists
- [ ] D) Images only

**13. The "Current" indicator in navigation menus:**
- [ ] A) Shows the current date
- [ ] B) Highlights the active page
- [ ] C) Displays system time
- [ ] D) Shows database status

**14. Select List items are best used when:**
- [ ] A) User needs to choose from predefined options
- [ ] B) Free text entry is needed
- [ ] C) Displaying images
- [ ] D) Running reports

**15. A Radio Group differs from a Checkbox because:**
- [ ] A) Radio allows one selection, Checkbox allows multiple
- [ ] B) They are identical
- [ ] C) Radio groups require JavaScript
- [ ] D) Checkboxes are slower

**16. The Popup LOV (List of Values) provides:**
- [ ] A) No functionality
- [ ] B) Modal search dialog with filtering
- [ ] C) Automatic data deletion
- [ ] D) User authentication

**17. In Vodacom's Customer Portal, which control type is best for Province selection?**
- [ ] A) Free text entry
- [ ] B) Select List (Gauteng, Western Cape, KZN)
- [ ] C) Date Picker
- [ ] D) File Upload

**18. Date Picker control allows:**
- [ ] A) Text entry only
- [ ] B) Calendar popup for date selection
- [ ] C) Numeric entry only
- [ ] D) Image upload

**19. A Switch control (toggle) is ideal for:**
- [ ] A) Multi-option selection
- [ ] B) Binary choices (Yes/No, Active/Inactive)
- [ ] C) Date selection
- [ ] D) File uploads

**20. Navigation menu icons (Font APEX icons) improve:**
- [ ] A) Database performance
- [ ] B) Visual recognition and user experience
- [ ] C) Query speed
- [ ] D) Data security

---

## Part B: True/False Questions (20 points - 2 points each)

**21. Breadcrumbs automatically update based on page hierarchy.**
- [ ] True
- [ ] False

**22. You can have multiple navigation menus in one application.**
- [ ] True
- [ ] False

**23. Buttons must always submit the page to perform actions.**
- [ ] True
- [ ] False

**24. Navigation Bar items appear on every page by default.**
- [ ] True
- [ ] False

**25. List entries can have conditional display based on user role.**
- [ ] True
- [ ] False

**26. Tabs regions require separate pages for each tab.**
- [ ] True
- [ ] False

**27. Badge values in navigation are always hardcoded and cannot be dynamic.**
- [ ] True
- [ ] False

**28. Authorization schemes can restrict navigation menu visibility.**
- [ ] True
- [ ] False

**29. All input controls (Select List, Radio, Checkbox) can use LOVs.**
- [ ] True
- [ ] False

**30. Navigation menus are stored in Shared Components for reuse across pages.**
- [ ] True
- [ ] False

---

## Part C: Component Matching (10 points - 1 point each)

**Match each navigation/control component with its best use case:**

**Components:**
31. Navigation Menu  
32. Breadcrumb  
33. Navigation Bar  
34. Button  
35. Select List  
36. Radio Group  
37. Checkbox  
38. Popup LOV  
39. Tree  
40. Tabs  

**Use Cases:**
A. Primary app navigation (Home, Customers, Reports)  
B. Show hierarchical path (Home > Customers > Edit Customer)  
C. Global actions (Logout, Profile, Help)  
D. Submit form or trigger action  
E. Choose one option from dropdown list  
F. Choose one option with visible buttons  
G. Multiple selections allowed  
H. Search large dataset with filtering  
I. Display hierarchical organizational structure  
J. Organize content in tabbed panels  

**Your Answers:**
31. ___  32. ___  33. ___  34. ___  35. ___  
36. ___  37. ___  38. ___  39. ___  40. ___

---

## Part D: Short Answer Questions (15 points - 5 points each)

**41. Explain the difference between a Navigation Menu and a Navigation Bar in APEX. Provide examples of what items belong in each for Vodacom's Customer Portal.**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**42. Describe three ways authorization schemes improve navigation security and user experience. Use Vodacom business scenarios (call center agents vs. managers).**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

**43. When would you use a Select List versus a Radio Group versus Checkboxes? Provide a Vodacom example for each.**

```
Your answer:
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
_____________________________________________________________________________
```

---

## Part E: Practical Exercise (15 points)

**44. Design Navigation for Vodacom Call Center Application**

You're designing navigation for a Vodacom call center application used by agents and managers.

**User Roles:**
- **Agent**: Handles calls, looks up customers, logs issues
- **Manager**: Views reports, manages agents, approves escalations
- **Admin**: System configuration, user management

**Requirements:**

**Part 1: Navigation Menu (5 points)**

Design the main navigation menu with authorization:

| Menu Item | Icon | Target Page | Visible To (Roles) |
|-----------|------|-------------|-------------------|
| Dashboard | fa-dashboard | Page 1 | _______________ |
| ___________ | _______ | ________ | _______________ |
| ___________ | _______ | ________ | _______________ |
| ___________ | _______ | ________ | _______________ |
| ___________ | _______ | ________ | _______________ |
| ___________ | _______ | ________ | _______________ |

**Part 2: Navigation Bar Items (3 points)**

Design global navigation bar items:

| Item | Icon | Action | Visible To |
|------|------|--------|------------|
| _______ | _______ | _____________ | __________ |
| _______ | _______ | _____________ | __________ |
| _______ | _______ | _____________ | __________ |

**Part 3: Breadcrumb Structure (3 points)**

Design breadcrumb hierarchy for customer management:

```
Home > ___________ > ___________ > ___________
Home > ___________ > ___________ > ___________
Home > ___________ > ___________ > ___________
```

**Part 4: Dynamic Badge Implementation (4 points)**

Implement dynamic badges showing counts. Write the SQL query for each:

**Badge 1: Pending Calls**
```sql
-- Show count of calls awaiting agent response
-- Display on: "My Queue" menu item





```

**Badge 2: Escalated Issues**
```sql
-- Show count of escalated issues for manager review
-- Display on: "Escalations" menu item (Managers only)





```

---

## Answer Key (For Instructor Use Only)

### Part A: Multiple Choice
1. B  2. B  3. B  4. B  5. D  6. B  7. A  8. D  9. B  10. B
11. B  12. B  13. B  14. A  15. A  16. B  17. B  18. B  19. B  20. B

### Part B: True/False
21. True  22. True  23. False  24. True  25. True
26. False  27. False  28. True  29. True  30. True

### Part C: Component Matching
31. A  32. B  33. C  34. D  35. E
36. F  37. G  38. H  39. I  40. J

### Part D: Short Answer (Sample Answers)

**41. Navigation Menu vs Navigation Bar:**

**Navigation Menu:**
- Primary app navigation, hierarchical structure
- Sidebar or top horizontal menu
- Changes per application area
- **Vodacom examples**: 
  - Home (dashboard)
  - Customers (search, add, manage)
  - Packages (view, activate)
  - Reports (call stats, revenue)
  - Network (tower status, coverage maps)

**Navigation Bar:**
- Global actions, always visible
- Top-right corner typically
- Same across all pages
- **Vodacom examples**:
  - Logout
  - My Profile
  - Notifications (badge count)
  - Help/Support
  - Change Language (English/Afrikaans)

**Key difference**: Menu = app features; Bar = user/system actions

**42. Authorization Schemes for Navigation:**

1. **Role-Based Menu Visibility**:
   - **Scenario**: Managers see "Agent Performance Reports", agents don't
   - **Benefit**: Cleaner UI, users only see relevant options
   - **Security**: Prevents unauthorized access attempts

2. **Feature Access Control**:
   - **Scenario**: Only admins see "User Management" and "System Configuration"
   - **Benefit**: Prevents accidental system changes by agents
   - **Security**: Enforces separation of duties

3. **Context-Sensitive Navigation**:
   - **Scenario**: "Approve Escalation" only visible when there are pending approvals for that manager's team
   - **Benefit**: Dynamic menus reduce clutter
   - **Security**: Users can't approve other teams' escalations

**Implementation**: Create auth schemes (IS_AGENT, IS_MANAGER, IS_ADMIN) using SQL checking user role table, apply to menu items.

**43. Select List vs Radio Group vs Checkboxes:**

**Select List** - One choice from many options (compact):
- **When**: 5+ options, space limited
- **Vodacom example**: Province selection (9 provinces) - dropdown saves space

**Radio Group** - One choice from few options (visible):
- **When**: 2-5 options, all should be visible
- **Vodacom example**: Customer Type selection (Prepaid / Contract) - only 2 options, always visible for context

**Checkboxes** - Multiple selections allowed:
- **When**: User can choose multiple items
- **Vodacom example**: Service subscriptions (Data, Voice, SMS, International, Roaming) - customer can select multiple add-ons

**Key difference**: Select List = one from many (compact); Radio = one from few (visible); Checkbox = multiple allowed

### Part E: Practical Exercise (Sample Solution)

**Part 1: Navigation Menu**

| Menu Item | Icon | Target Page | Visible To |
|-----------|------|-------------|------------|
| Dashboard | fa-dashboard | Page 1 | Agent, Manager, Admin |
| My Queue | fa-phone | Page 10 | Agent, Manager |
| Customer Search | fa-search | Page 20 | Agent, Manager, Admin |
| Package Activation | fa-shopping-cart | Page 30 | Agent, Manager |
| Call Log | fa-list | Page 40 | Agent, Manager |
| Reports | fa-bar-chart | Page 50 | Manager, Admin |
| Agent Management | fa-users | Page 60 | Manager, Admin |
| Escalations | fa-exclamation-triangle | Page 70 | Manager, Admin |
| System Settings | fa-cog | Page 80 | Admin |

**Part 2: Navigation Bar Items**

| Item | Icon | Action | Visible To |
|------|------|--------|------------|
| Notifications | fa-bell | Show notifications page/popup | All |
| Profile | fa-user | Edit user profile | All |
| Help | fa-question-circle | Open help documentation | All |
| Logout | fa-sign-out | End session | All |

**Part 3: Breadcrumb Structure**

```
Home > Customers > Customer Search > Edit Customer
Home > Customers > Customer Details > Mobile Numbers
Home > Packages > Package List > Edit Package
Home > Reports > Agent Performance > Agent Details
Home > Call Log > Call Details > Escalate Issue
```

**Part 4: Dynamic Badge Implementation**

**Badge 1: Pending Calls**
```sql
SELECT COUNT(*) AS badge_value
FROM vodacom_calls
WHERE assigned_agent_id = :APP_USER_ID
  AND call_status IN ('Pending', 'In Progress')
  AND callback_required = 'Y'
  AND callback_date <= SYSDATE;
```

**Badge 2: Escalated Issues**
```sql
SELECT COUNT(*) AS badge_value
FROM vodacom_escalations e
JOIN vodacom_agents a ON e.escalated_to_manager_id = a.manager_id
WHERE a.manager_id = :APP_USER_ID
  AND e.escalation_status = 'Pending Review'
  AND e.priority IN ('High', 'Critical');
```

---

## Grading Rubric

| Section | Points | Criteria |
|---------|--------|----------|
| Part A (MC) | 40 | 2 points per correct answer |
| Part B (T/F) | 20 | 2 points per correct answer |
| Part C (Matching) | 10 | 1 point per correct match |
| Part D (Short Answer) | 15 | 5 points each - Clear explanations with Vodacom examples |
| Part E (Practical) | 15 | Menu (5 pts), Nav Bar (3 pts), Breadcrumbs (3 pts), SQL (4 pts) |
| **TOTAL** | **100** | Pass = 70+ points |

---

**Student Name:** ______________________________  
**Date:** ______________  
**Score:** ______ / 100  
**Pass/Fail:** __________

**Instructor Notes:**
