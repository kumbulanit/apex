# Developing Applications with Oracle Application Express (APEX) Training Course

**Comprehensive Training for Vodacom Developers**

---

## 📋 Course Overview

This beginner-level Oracle APEX training course is specifically designed for **Vodacom**, South Africa's leading cellular network provider. All lessons, labs, and practicals use Vodacom's real-world scenarios including customer management, network operations, VodaPay integration, and billing systems.

**Duration:** 21 hours (7 lessons × 3 hours each)  
**Level:** Beginner  
**Prerequisites:** Basic SQL knowledge, familiarity with Oracle Database  
**Company Theme:** Vodacom - Cellular network provider serving 45+ million customers across South Africa with mobile, data, and VodaPay services

---

## 🎯 Learning Objectives

By the end of this course, you will be able to:

✅ Install and configure Oracle APEX development environment  
✅ Create data-driven web applications using low-code techniques  
✅ Build interactive reports, forms, and dashboards  
✅ Implement navigation, security, and user management  
✅ Optimize application performance  
✅ Deploy applications from development to production  
✅ Apply best practices for enterprise APEX development  

---

## 📚 Course Structure

Each lesson includes:
- **Theory**: Layman → Intermediate → Advanced explanations
- **Labs**: 3 difficulty levels (Simple, Intermediate, Advanced)
- **Real-World Practical**: TechNova Corp business scenario
- **Assessment**: MCQs, short answers, and practical challenges
- **PowerPoint Slides**: 10-15 slides summarizing key concepts

---

## 📖 Lesson Contents

### [Lesson 01: Introduction and Getting Started with Oracle APEX](lessons/01-introduction-and-getting-started.md)

**Topics Covered:**
- What is Oracle APEX and why use it?
- APEX architecture (browser, ORDS, database)
- Installation and configuration
- Workspace creation and management
- Development environment setup
- Multi-environment strategy (DEV/TEST/PROD)

**Labs:**
- ✨ **Simple**: Install APEX and access workspace
- 🔧 **Intermediate**: Explore development environment and create sample tables
- 🚀 **Advanced**: Set up multi-environment workspace strategy with CI/CD scripts

**Real-World Scenario:** Migrating TechNova's legacy Access database (50,000+ records) to Oracle APEX

**Key TechNova Use Case:** Setting up development environments for the project management system migration

---

### [Lesson 02: Creating Applications in Oracle APEX](lessons/02-creating-applications.md)

**Topics Covered:**
- Application creation methods (Wizard, from File, Blueprints)
- Application architecture and components
- Pages, regions, shared components
- Master-detail relationships
- Application properties and settings

**Labs:**
- ✨ **Simple**: Create Employee Manager using wizard
- 🔧 **Intermediate**: Create Client Portal from Excel spreadsheet
- 🚀 **Advanced**: Build multi-table Project Manager with master-detail

**Real-World Scenario:** Building a customer-facing portal for TechNova clients to view project status and download invoices

**Key TechNova Use Case:** Rapid application development replacing 6-month traditional development with 2-week APEX implementation

---

### [Lesson 03: Managing Pages and Page Designer](lessons/03-pages-and-page-designer.md)

**Topics Covered:**
- Page Designer interface (3-panel layout)
- Page components (regions, items, buttons, processes)
- Page execution flow (rendering vs processing)
- Dynamic actions for client-side interactivity
- Validations and computations
- AJAX partial page refresh

**Labs:**
- ✨ **Simple**: Add regions to dashboard (static content, reports, charts)
- 🔧 **Intermediate**: Create interactive form with validations
- 🚀 **Advanced**: Implement dynamic actions for enhanced UX

**Real-World Scenario:** Building TechNova's executive dashboard with KPIs, filters, and auto-refresh

**Key TechNova Use Case:** Project dashboard showing active projects, budget utilization, and timeline views

---

### [Lesson 04: Building Reports and Forms](lessons/04-reports-and-forms.md)

**Topics Covered:**
- Report types (Interactive Report, Interactive Grid, Classic, Faceted Search)
- Form types (Standard, Modal Dialog, Master-Detail)
- Inline editing with Interactive Grid
- Conditional formatting
- Download options (CSV, PDF, Excel)
- Search and filter functionality

**Labs:**
- ✨ **Simple**: Create Interactive Report for employee directory
- 🔧 **Intermediate**: Build Interactive Grid for bulk assignment updates
- 🚀 **Advanced**: Master-detail form (project with embedded tasks)

**Real-World Scenario:** TechNova Invoice Management System with line items, calculations, and PDF generation

**Key TechNova Use Case:** Employee timesheet entry with project/task cascading and weekly hour calculations

---

### [Lesson 05: Customizing Controls and Navigation](lessons/05-controls-and-navigation.md)

**Topics Covered:**
- Navigation components (menu, breadcrumbs, tabs, lists)
- Item types and LOVs (List of Values)
- Cascading LOVs (dependent dropdowns)
- Custom buttons and dynamic actions
- Computations and validations
- Filter systems and saved preferences

**Labs:**
- ✨ **Simple**: Create hierarchical navigation menu with icons
- 🔧 **Intermediate**: Implement cascading LOVs (project → task)
- 🚀 **Advanced**: Custom button with confirmation and server-side processing

**Real-World Scenario:** TechNova advanced search interface with multiple filters and saved presets

**Key TechNova Use Case:** Project selection filtering tasks, with automatic assignment list updates

---

### [Lesson 06: Application Security and Performance](lessons/06-security-and-performance.md)

**Topics Covered:**
- Authentication schemes (Database, LDAP, OAuth2, SAML)
- Authorization schemes and role-based access control
- Session management and state protection
- SQL injection and XSS prevention
- Performance tuning (SQL optimization, caching, indexing)
- Debug mode and APEX Advisor
- HTTPS and security best practices

**Labs:**
- ✨ **Simple**: Implement LDAP authentication
- 🔧 **Intermediate**: Create authorization schemes for managers
- 🚀 **Advanced**: Performance tuning (optimize slow queries, add indexes, enable caching)

**Real-World Scenario:** TechNova security audit and performance review for SOC 2 compliance

**Key TechNova Use Case:** 3-tier access control (Employee, Manager, Admin) with audit logging; dashboard optimization from 4.2s to 0.3s

---

### [Lesson 07: Deploying Applications](lessons/07-deploying-applications.md)

**Topics Covered:**
- Export and import methods (single file vs split files)
- Version control with Git
- SQLcl for automated deployments
- CI/CD pipelines (GitLab CI, GitHub Actions)
- Environment management (DEV/TEST/PROD)
- Supporting objects deployment
- Rollback strategies
- Health checks and monitoring

**Labs:**
- ✨ **Simple**: Manual export from DEV and import to TEST
- 🔧 **Intermediate**: Automated export script with SQLcl
- 🚀 **Advanced**: Full CI/CD pipeline with automated testing

**Real-World Scenario:** TechNova production deployment with zero downtime, rollback plan, and health checks

**Key TechNova Use Case:** Automated deployment pipeline with Git versioning, automated TEST deployment, and manual PROD approval

---

## 🛠️ Technical Requirements

### Software Required:
- Oracle Database 19c or later (XE, Standard, or Enterprise Edition)
- Oracle APEX 23.1 or later
- Oracle REST Data Services (ORDS) 22.x or later
- Web browser (Chrome, Firefox, Edge)
- SQL Developer or SQLcl (for scripts)
- Git (for version control)

### Hardware Requirements:
- 8GB RAM minimum (16GB recommended)
- 50GB free disk space
- Dual-core processor (Quad-core recommended)

### Optional Tools:
- Visual Studio Code (for editing exported files)
- Postman (for REST API testing)
- Jenkins/GitLab Runner (for CI/CD)

---

## 📂 Repository Structure

```
apex/
├── lessons/
│   ├── 01-introduction-and-getting-started.md
│   ├── 02-creating-applications.md
│   ├── 03-pages-and-page-designer.md
│   ├── 04-reports-and-forms.md
│   ├── 05-controls-and-navigation.md
│   ├── 06-security-and-performance.md
│   └── 07-deploying-applications.md
├── labs/
│   └── (Lab materials and sample data)
├── slides/
│   └── (PowerPoint slide content)
├── assessments/
│   └── (Assessment materials and rubrics)
├── solutions/
│   └── (Solution files for lab exercises)
└── README.md (this file)
```

---

## 🏢 Vodacom Case Study

### Company Background:
Vodacom is South Africa's leading cellular network provider with 45+ million customers across all 9 provinces. They provide mobile voice, data, SMS services, VodaPay (mobile payments), device sales, and enterprise solutions.

### Current Challenges:
- **Legacy Systems**: Aging customer service systems with scalability issues
- **Customer Scale**: 45 million customers requiring real-time access
- **Multi-Channel**: Call centers, retail stores, self-service portals, mobile apps
- **Network Operations**: Manage 15,000+ cell towers (2G/3G/4G/5G)
- **VodaPay Integration**: Mobile payment system requiring secure transactions
- **POPIA Compliance**: South African data protection regulations

### APEX Solution Benefits:
✅ **Web-based**: Accessible from call centers, stores, field technicians  
✅ **Massive Scale**: Supports 1,000+ concurrent agents  
✅ **Fast Development**: 2-week APEX implementation vs 6-month traditional development  
✅ **Mobile-Responsive**: Field technicians access network data on mobile  
✅ **Integration**: RESTful APIs for VodaPay, billing, network management systems  
✅ **Performance**: Sub-second queries across 45M+ customer records  
✅ **Cost-Effective**: Included with Oracle Database license  

### Applications Built:
1. **Customer Service Portal** - Search customers, manage accounts, view transactions
2. **Package Management** - Data bundles, voice plans, promotional offers
3. **Network Operations Dashboard** - Monitor towers, track outages, SLA compliance
4. **VodaPay Transaction System** - Mobile payments, wallet management
5. **Billing & Invoicing** - Generate postpaid bills, payment reconciliation
6. **Retail Sales** - In-store device sales, contract management

---

## 🎓 Assessment & Certification

### Assessment Components:
- **Multiple Choice Questions (MCQs)**: Test theoretical knowledge (5 per lesson)
- **Short Answer Questions**: Explain concepts and scenarios (3 per lesson)
- **Practical Challenges**: Hands-on projects applying learned skills (1 per lesson)
- **Final Project**: Build complete TechNova application from requirements

### Grading Criteria:
- Theory & MCQs: 30%
- Lab Exercises: 30%
- Practical Challenges: 30%
- Final Project: 10%

### Passing Grade: 70%

### Certificate: TechNova Oracle APEX Developer

---

## 👥 Target Audience

**Primary Audience:**
- Software developers transitioning to low-code platforms
- Database developers wanting to build web applications
- Business analysts learning application development
- IT professionals supporting Oracle environments

**Job Roles:**
- Application Developer
- Database Developer
- Full-Stack Developer (focusing on Oracle stack)
- Business Application Developer
- DevOps Engineer (deployment focus)

**Experience Level:**
- **Required**: Basic SQL (SELECT, INSERT, UPDATE, DELETE, JOIN)
- **Required**: Understanding of relational databases
- **Helpful**: PL/SQL knowledge
- **Helpful**: Basic HTML/CSS understanding
- **Not Required**: JavaScript or advanced programming

---

## 📅 Suggested Learning Path

### Week 1: Foundations
- **Day 1-2**: Lesson 01 (Introduction, Installation, Setup)
- **Day 3-4**: Lesson 02 (Creating Applications)
- **Day 5**: Practice labs, complete Lab 1 assessments

### Week 2: Building Applications
- **Day 1-2**: Lesson 03 (Pages and Page Designer)
- **Day 3-4**: Lesson 04 (Reports and Forms)
- **Day 5**: Practice labs, complete Lab 2 assessments

### Week 3: Advanced Topics
- **Day 1-2**: Lesson 05 (Controls and Navigation)
- **Day 3-4**: Lesson 06 (Security and Performance)
- **Day 5**: Practice labs, complete Lab 3 assessments

### Week 4: Deployment & Final Project
- **Day 1**: Lesson 07 (Deploying Applications)
- **Day 2-4**: Final Project (build TechNova application)
- **Day 5**: Project presentation and course review

---

## 🔗 Additional Resources

### Official Oracle Resources:
- **Oracle APEX Website**: https://apex.oracle.com
- **Documentation**: https://docs.oracle.com/en/database/oracle/apex/
- **Free Workspace**: https://apex.oracle.com/en/learn/getting-started/
- **YouTube Channel**: Oracle APEX Official Channel

### Community Resources:
- **Oracle APEX Forum**: https://forums.oracle.com/ords/apexds/domain/dev-community/category/apex
- **Stack Overflow**: Tag `oracle-apex`
- **APEX World**: https://apex.world (Blog aggregator)
- **Reddit**: r/oracle

### Learning Platforms:
- **Oracle University**: Official APEX courses
- **Udemy**: APEX beginner to advanced courses
- **YouTube**: Free tutorials and walkthroughs
- **Oracle APEX App Lab**: https://apex.oracle.com/en/learn/tutorials/

### Books:
- "Expert Oracle Application Express" by Doug Gault et al.
- "Beginning Oracle Application Express 5" by Rick Greenwald
- "Pro Oracle Application Express" by Tim Fox

---

## 💼 Vodacom Training Support

### Internal Support:
- **Email**: apex-training@vodacom.co.za
- **Training Portal**: Internal Vodacom learning platform
- **Office Hours**: Contact your training coordinator

### Lab Environment:
- **Development Database**: vodacom-dev-db.jhb.vodacom.local:1521/VDEV
- **UAT Database**: vodacom-uat-db.jhb.vodacom.local:1521/VUAT
- **Production Database**: vodacom-prod-db.jhb.vodacom.local:1521/VPROD (Johannesburg)
- **DR Database**: vodacom-prod-db.cpt.vodacom.local:1521/VPROD (Cape Town)

### Training Workspaces:
- **Your Personal Workspace**: VODACOM_TRAIN_[YourName]
- **Shared Training Workspace**: VODACOM_TRAINING
- **Sandbox Workspace**: VODACOM_SANDBOX

---

## ✅ Course Completion Checklist

- [ ] Complete all 7 lessons
- [ ] Pass all MCQ assessments (70%+)
- [ ] Submit all lab exercises
- [ ] Complete practical challenges for each lesson
- [ ] Build and submit final project
- [ ] Present final project to team
- [ ] Receive course completion certificate

---

## 📝 Feedback & Continuous Improvement

We value your feedback to improve this course. Please provide feedback on:

- **Content Clarity**: Was the material easy to understand?
- **Lab Relevance**: Were the hands-on exercises practical?
- **TechNova Scenarios**: Did the company case study help learning?
- **Pacing**: Was the course too fast, too slow, or just right?
- **Assessment Difficulty**: Were the challenges appropriate for your level?

**Submit Feedback**: apex-training-feedback@technova.com

---

## 📜 License & Usage

**Copyright © 2025 TechNova Corp**

This training material is proprietary to TechNova Corp and licensed for internal use only. Redistribution or public sharing is prohibited without written permission.

**For External Use**: Contact training@technova.com for licensing options.

---

## 🚀 Getting Started

1. **Clone this repository** or download materials
2. **Set up your development environment** (see Lesson 01)
3. **Start with Lesson 01** and work sequentially
4. **Complete labs as you learn** - hands-on practice is essential
5. **Join the Slack channel** for peer support
6. **Attend office hours** if you need help

---

## 📞 Contact Information

**Course Instructor**: Vodacom APEX Training Team  
**Email**: apex-training@vodacom.co.za  
**Phone**: +27 (0)82 111 APEX  
**Office**: Vodacom HQ, Midrand, Gauteng  

---

## 🎉 Success Stories

> "This course transformed how we build applications. We built the Customer Service Portal for 45 million customers in just 3 weeks!" - *Thabo Nkosi, Senior Developer*

> "The hands-on labs with real Vodacom scenarios made learning practical. I was supporting call centers within a month." - *Nomsa Dlamini, Business Analyst*

> "From zero APEX knowledge to deploying production apps with VodaPay integration in 5 weeks. Outstanding!" - *Sipho Radebe, Full-Stack Developer*

---

**Ready to begin?** Start with [Lesson 01: Introduction and Getting Started →](lessons/01-introduction-and-getting-started.md)

**Happy Learning! 🎓✨**
