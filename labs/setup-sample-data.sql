-- ============================================================================
-- TechNova Corp Sample Database Setup Script
-- Oracle APEX Training Course
-- ============================================================================
-- This script creates the complete TechNova database schema with sample data
-- for all hands-on labs throughout the training course.
--
-- INSTRUCTIONS:
-- 1. Log into your APEX workspace as the workspace administrator
-- 2. Navigate to SQL Workshop > SQL Scripts
-- 3. Click "Upload" and upload this file
-- 4. Click "Run" to execute the script
-- 5. Verify all tables were created successfully (check for errors)
--
-- ESTIMATED TIME: 2-3 minutes
-- ============================================================================

-- Clean up existing objects (if re-running script)
BEGIN
    FOR rec IN (SELECT table_name FROM user_tables WHERE table_name IN (
        'EMPLOYEES', 'CLIENTS', 'PROJECTS', 'TASKS', 'TIMESHEETS', 
        'DEPARTMENTS', 'ROLES', 'PROJECT_ASSIGNMENTS', 'EXPENSES',
        'AUDIT_LOG', 'CLIENT_CONTACTS', 'INVOICES', 'INVOICE_ITEMS'
    )) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || rec.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/

-- ============================================================================
-- DEPARTMENTS TABLE
-- ============================================================================
CREATE TABLE departments (
    department_id     NUMBER PRIMARY KEY,
    department_name   VARCHAR2(100) NOT NULL UNIQUE,
    manager_id        NUMBER,
    budget            NUMBER(12,2),
    location          VARCHAR2(100),
    created_date      DATE DEFAULT SYSDATE,
    created_by        VARCHAR2(100) DEFAULT USER,
    modified_date     DATE,
    modified_by       VARCHAR2(100)
);

CREATE SEQUENCE departments_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER departments_bir
BEFORE INSERT ON departments
FOR EACH ROW
BEGIN
    IF :NEW.department_id IS NULL THEN
        SELECT departments_seq.NEXTVAL INTO :NEW.department_id FROM DUAL;
    END IF;
END;
/

COMMENT ON TABLE departments IS 'TechNova organizational departments';

-- ============================================================================
-- ROLES TABLE
-- ============================================================================
CREATE TABLE roles (
    role_id          NUMBER PRIMARY KEY,
    role_name        VARCHAR2(50) NOT NULL UNIQUE,
    description      VARCHAR2(500),
    hourly_rate      NUMBER(8,2),
    is_billable      VARCHAR2(1) DEFAULT 'Y' CHECK (is_billable IN ('Y','N')),
    created_date     DATE DEFAULT SYSDATE
);

CREATE SEQUENCE roles_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER roles_bir
BEFORE INSERT ON roles
FOR EACH ROW
BEGIN
    IF :NEW.role_id IS NULL THEN
        SELECT roles_seq.NEXTVAL INTO :NEW.role_id FROM DUAL;
    END IF;
END;
/

COMMENT ON TABLE roles IS 'Employee roles and billing rates';

-- ============================================================================
-- EMPLOYEES TABLE
-- ============================================================================
CREATE TABLE employees (
    employee_id       NUMBER PRIMARY KEY,
    first_name        VARCHAR2(50) NOT NULL,
    last_name         VARCHAR2(50) NOT NULL,
    email             VARCHAR2(100) NOT NULL UNIQUE,
    phone             VARCHAR2(20),
    hire_date         DATE NOT NULL,
    department_id     NUMBER,
    role_id           NUMBER,
    manager_id        NUMBER,
    salary            NUMBER(10,2),
    status            VARCHAR2(20) DEFAULT 'Active' 
                      CHECK (status IN ('Active','Inactive','On Leave','Terminated')),
    created_date      DATE DEFAULT SYSDATE,
    created_by        VARCHAR2(100) DEFAULT USER,
    modified_date     DATE,
    modified_by       VARCHAR2(100),
    CONSTRAINT fk_emp_dept FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT fk_emp_role FOREIGN KEY (role_id) REFERENCES roles(role_id),
    CONSTRAINT fk_emp_mgr FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

CREATE SEQUENCE employees_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER employees_bir
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF :NEW.employee_id IS NULL THEN
        SELECT employees_seq.NEXTVAL INTO :NEW.employee_id FROM DUAL;
    END IF;
END;
/

COMMENT ON TABLE employees IS 'TechNova employee master data';

CREATE INDEX idx_emp_dept ON employees(department_id);
CREATE INDEX idx_emp_role ON employees(role_id);
CREATE INDEX idx_emp_status ON employees(status);
CREATE INDEX idx_emp_name ON employees(last_name, first_name);

-- ============================================================================
-- CLIENTS TABLE
-- ============================================================================
CREATE TABLE clients (
    client_id         NUMBER PRIMARY KEY,
    client_name       VARCHAR2(200) NOT NULL,
    industry          VARCHAR2(100),
    contact_person    VARCHAR2(100),
    email             VARCHAR2(100),
    phone             VARCHAR2(20),
    address           VARCHAR2(500),
    city              VARCHAR2(100),
    country           VARCHAR2(100) DEFAULT 'South Africa',
    contract_value    NUMBER(15,2),
    contract_start    DATE,
    contract_end      DATE,
    status            VARCHAR2(20) DEFAULT 'Active' 
                      CHECK (status IN ('Active','Inactive','Prospect','Former')),
    account_manager_id NUMBER,
    created_date      DATE DEFAULT SYSDATE,
    created_by        VARCHAR2(100) DEFAULT USER,
    modified_date     DATE,
    modified_by       VARCHAR2(100),
    CONSTRAINT fk_client_acctmgr FOREIGN KEY (account_manager_id) 
        REFERENCES employees(employee_id)
);

CREATE SEQUENCE clients_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER clients_bir
BEFORE INSERT ON clients
FOR EACH ROW
BEGIN
    IF :NEW.client_id IS NULL THEN
        SELECT clients_seq.NEXTVAL INTO :NEW.client_id FROM DUAL;
    END IF;
END;
/

COMMENT ON TABLE clients IS 'TechNova client organizations';

CREATE INDEX idx_client_status ON clients(status);
CREATE INDEX idx_client_name ON clients(client_name);
CREATE INDEX idx_client_acctmgr ON clients(account_manager_id);

-- ============================================================================
-- CLIENT_CONTACTS TABLE
-- ============================================================================
CREATE TABLE client_contacts (
    contact_id        NUMBER PRIMARY KEY,
    client_id         NUMBER NOT NULL,
    first_name        VARCHAR2(50) NOT NULL,
    last_name         VARCHAR2(50) NOT NULL,
    title             VARCHAR2(100),
    email             VARCHAR2(100),
    phone             VARCHAR2(20),
    mobile            VARCHAR2(20),
    is_primary        VARCHAR2(1) DEFAULT 'N' CHECK (is_primary IN ('Y','N')),
    notes             VARCHAR2(2000),
    created_date      DATE DEFAULT SYSDATE,
    CONSTRAINT fk_contact_client FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE SEQUENCE client_contacts_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER client_contacts_bir
BEFORE INSERT ON client_contacts
FOR EACH ROW
BEGIN
    IF :NEW.contact_id IS NULL THEN
        SELECT client_contacts_seq.NEXTVAL INTO :NEW.contact_id FROM DUAL;
    END IF;
END;
/

CREATE INDEX idx_contact_client ON client_contacts(client_id);

-- ============================================================================
-- PROJECTS TABLE
-- ============================================================================
CREATE TABLE projects (
    project_id        NUMBER PRIMARY KEY,
    project_name      VARCHAR2(200) NOT NULL,
    client_id         NUMBER NOT NULL,
    project_manager_id NUMBER,
    description       VARCHAR2(2000),
    start_date        DATE,
    end_date          DATE,
    budget            NUMBER(15,2),
    actual_cost       NUMBER(15,2),
    status            VARCHAR2(20) DEFAULT 'Planning' 
                      CHECK (status IN ('Planning','In Progress','On Hold','Completed','Cancelled')),
    priority          VARCHAR2(20) DEFAULT 'Medium'
                      CHECK (priority IN ('Low','Medium','High','Critical')),
    created_date      DATE DEFAULT SYSDATE,
    created_by        VARCHAR2(100) DEFAULT USER,
    modified_date     DATE,
    modified_by       VARCHAR2(100),
    CONSTRAINT fk_proj_client FOREIGN KEY (client_id) REFERENCES clients(client_id),
    CONSTRAINT fk_proj_pm FOREIGN KEY (project_manager_id) REFERENCES employees(employee_id)
);

CREATE SEQUENCE projects_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER projects_bir
BEFORE INSERT ON projects
FOR EACH ROW
BEGIN
    IF :NEW.project_id IS NULL THEN
        SELECT projects_seq.NEXTVAL INTO :NEW.project_id FROM DUAL;
    END IF;
END;
/

COMMENT ON TABLE projects IS 'TechNova client projects';

CREATE INDEX idx_proj_client ON projects(client_id);
CREATE INDEX idx_proj_status ON projects(status);
CREATE INDEX idx_proj_pm ON projects(project_manager_id);
CREATE INDEX idx_proj_dates ON projects(start_date, end_date);

-- ============================================================================
-- PROJECT_ASSIGNMENTS TABLE
-- ============================================================================
CREATE TABLE project_assignments (
    assignment_id     NUMBER PRIMARY KEY,
    project_id        NUMBER NOT NULL,
    employee_id       NUMBER NOT NULL,
    assigned_date     DATE DEFAULT SYSDATE,
    allocation_pct    NUMBER(5,2) DEFAULT 100 CHECK (allocation_pct BETWEEN 0 AND 100),
    role_on_project   VARCHAR2(100),
    is_active         VARCHAR2(1) DEFAULT 'Y' CHECK (is_active IN ('Y','N')),
    CONSTRAINT fk_assign_proj FOREIGN KEY (project_id) REFERENCES projects(project_id),
    CONSTRAINT fk_assign_emp FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT uk_proj_emp UNIQUE (project_id, employee_id)
);

CREATE SEQUENCE project_assignments_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER project_assignments_bir
BEFORE INSERT ON project_assignments
FOR EACH ROW
BEGIN
    IF :NEW.assignment_id IS NULL THEN
        SELECT project_assignments_seq.NEXTVAL INTO :NEW.assignment_id FROM DUAL;
    END IF;
END;
/

CREATE INDEX idx_assign_proj ON project_assignments(project_id);
CREATE INDEX idx_assign_emp ON project_assignments(employee_id);

-- ============================================================================
-- TASKS TABLE
-- ============================================================================
CREATE TABLE tasks (
    task_id           NUMBER PRIMARY KEY,
    project_id        NUMBER NOT NULL,
    task_name         VARCHAR2(200) NOT NULL,
    description       VARCHAR2(2000),
    assigned_to       NUMBER,
    start_date        DATE,
    due_date          DATE,
    completion_date   DATE,
    estimated_hours   NUMBER(8,2),
    actual_hours      NUMBER(8,2),
    status            VARCHAR2(20) DEFAULT 'Not Started'
                      CHECK (status IN ('Not Started','In Progress','Blocked','Completed','Cancelled')),
    priority          VARCHAR2(20) DEFAULT 'Medium'
                      CHECK (priority IN ('Low','Medium','High','Critical')),
    parent_task_id    NUMBER,
    created_date      DATE DEFAULT SYSDATE,
    created_by        VARCHAR2(100) DEFAULT USER,
    modified_date     DATE,
    modified_by       VARCHAR2(100),
    CONSTRAINT fk_task_proj FOREIGN KEY (project_id) REFERENCES projects(project_id),
    CONSTRAINT fk_task_emp FOREIGN KEY (assigned_to) REFERENCES employees(employee_id),
    CONSTRAINT fk_task_parent FOREIGN KEY (parent_task_id) REFERENCES tasks(task_id)
);

CREATE SEQUENCE tasks_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER tasks_bir
BEFORE INSERT ON tasks
FOR EACH ROW
BEGIN
    IF :NEW.task_id IS NULL THEN
        SELECT tasks_seq.NEXTVAL INTO :NEW.task_id FROM DUAL;
    END IF;
END;
/

COMMENT ON TABLE tasks IS 'Project tasks and subtasks';

CREATE INDEX idx_task_proj ON tasks(project_id);
CREATE INDEX idx_task_assigned ON tasks(assigned_to);
CREATE INDEX idx_task_status ON tasks(status);
CREATE INDEX idx_task_dates ON tasks(start_date, due_date);

-- ============================================================================
-- TIMESHEETS TABLE
-- ============================================================================
CREATE TABLE timesheets (
    timesheet_id      NUMBER PRIMARY KEY,
    employee_id       NUMBER NOT NULL,
    project_id        NUMBER NOT NULL,
    task_id           NUMBER,
    work_date         DATE NOT NULL,
    hours_worked      NUMBER(5,2) NOT NULL CHECK (hours_worked BETWEEN 0 AND 24),
    description       VARCHAR2(1000),
    is_billable       VARCHAR2(1) DEFAULT 'Y' CHECK (is_billable IN ('Y','N')),
    billing_rate      NUMBER(8,2),
    approval_status   VARCHAR2(20) DEFAULT 'Pending'
                      CHECK (approval_status IN ('Pending','Approved','Rejected')),
    approved_by       NUMBER,
    approved_date     DATE,
    created_date      DATE DEFAULT SYSDATE,
    created_by        VARCHAR2(100) DEFAULT USER,
    CONSTRAINT fk_time_emp FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT fk_time_proj FOREIGN KEY (project_id) REFERENCES projects(project_id),
    CONSTRAINT fk_time_task FOREIGN KEY (task_id) REFERENCES tasks(task_id),
    CONSTRAINT fk_time_approver FOREIGN KEY (approved_by) REFERENCES employees(employee_id),
    CONSTRAINT uk_time_entry UNIQUE (employee_id, project_id, task_id, work_date)
);

CREATE SEQUENCE timesheets_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER timesheets_bir
BEFORE INSERT ON timesheets
FOR EACH ROW
BEGIN
    IF :NEW.timesheet_id IS NULL THEN
        SELECT timesheets_seq.NEXTVAL INTO :NEW.timesheet_id FROM DUAL;
    END IF;
END;
/

COMMENT ON TABLE timesheets IS 'Employee time tracking for projects';

CREATE INDEX idx_time_emp ON timesheets(employee_id);
CREATE INDEX idx_time_proj ON timesheets(project_id);
CREATE INDEX idx_time_date ON timesheets(work_date);
CREATE INDEX idx_time_status ON timesheets(approval_status);

-- ============================================================================
-- EXPENSES TABLE
-- ============================================================================
CREATE TABLE expenses (
    expense_id        NUMBER PRIMARY KEY,
    employee_id       NUMBER NOT NULL,
    project_id        NUMBER,
    expense_date      DATE NOT NULL,
    expense_type      VARCHAR2(50) NOT NULL
                      CHECK (expense_type IN ('Travel','Meals','Accommodation','Software','Hardware','Training','Other')),
    amount            NUMBER(10,2) NOT NULL,
    currency          VARCHAR2(3) DEFAULT 'ZAR',
    description       VARCHAR2(1000),
    receipt_attached  VARCHAR2(1) DEFAULT 'N' CHECK (receipt_attached IN ('Y','N')),
    approval_status   VARCHAR2(20) DEFAULT 'Pending'
                      CHECK (approval_status IN ('Pending','Approved','Rejected','Reimbursed')),
    approved_by       NUMBER,
    approved_date     DATE,
    created_date      DATE DEFAULT SYSDATE,
    CONSTRAINT fk_exp_emp FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT fk_exp_proj FOREIGN KEY (project_id) REFERENCES projects(project_id),
    CONSTRAINT fk_exp_approver FOREIGN KEY (approved_by) REFERENCES employees(employee_id)
);

CREATE SEQUENCE expenses_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER expenses_bir
BEFORE INSERT ON expenses
FOR EACH ROW
BEGIN
    IF :NEW.expense_id IS NULL THEN
        SELECT expenses_seq.NEXTVAL INTO :NEW.expense_id FROM DUAL;
    END IF;
END;
/

CREATE INDEX idx_exp_emp ON expenses(employee_id);
CREATE INDEX idx_exp_proj ON expenses(project_id);
CREATE INDEX idx_exp_date ON expenses(expense_date);
CREATE INDEX idx_exp_status ON expenses(approval_status);

-- ============================================================================
-- INVOICES TABLE
-- ============================================================================
CREATE TABLE invoices (
    invoice_id        NUMBER PRIMARY KEY,
    client_id         NUMBER NOT NULL,
    invoice_number    VARCHAR2(50) NOT NULL UNIQUE,
    invoice_date      DATE NOT NULL,
    due_date          DATE,
    subtotal          NUMBER(15,2),
    tax_amount        NUMBER(15,2),
    total_amount      NUMBER(15,2),
    status            VARCHAR2(20) DEFAULT 'Draft'
                      CHECK (status IN ('Draft','Sent','Paid','Overdue','Cancelled')),
    payment_date      DATE,
    notes             VARCHAR2(2000),
    created_date      DATE DEFAULT SYSDATE,
    created_by        VARCHAR2(100) DEFAULT USER,
    CONSTRAINT fk_inv_client FOREIGN KEY (client_id) REFERENCES clients(client_id)
);

CREATE SEQUENCE invoices_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER invoices_bir
BEFORE INSERT ON invoices
FOR EACH ROW
BEGIN
    IF :NEW.invoice_id IS NULL THEN
        SELECT invoices_seq.NEXTVAL INTO :NEW.invoice_id FROM DUAL;
    END IF;
END;
/

CREATE INDEX idx_inv_client ON invoices(client_id);
CREATE INDEX idx_inv_status ON invoices(status);
CREATE INDEX idx_inv_date ON invoices(invoice_date);

-- ============================================================================
-- INVOICE_ITEMS TABLE
-- ============================================================================
CREATE TABLE invoice_items (
    item_id           NUMBER PRIMARY KEY,
    invoice_id        NUMBER NOT NULL,
    project_id        NUMBER,
    description       VARCHAR2(500) NOT NULL,
    quantity          NUMBER(10,2) DEFAULT 1,
    unit_price        NUMBER(10,2),
    amount            NUMBER(15,2),
    CONSTRAINT fk_invitem_inv FOREIGN KEY (invoice_id) REFERENCES invoices(invoice_id),
    CONSTRAINT fk_invitem_proj FOREIGN KEY (project_id) REFERENCES projects(project_id)
);

CREATE SEQUENCE invoice_items_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER invoice_items_bir
BEFORE INSERT ON invoice_items
FOR EACH ROW
BEGIN
    IF :NEW.item_id IS NULL THEN
        SELECT invoice_items_seq.NEXTVAL INTO :NEW.item_id FROM DUAL;
    END IF;
END;
/

CREATE INDEX idx_invitem_inv ON invoice_items(invoice_id);

-- ============================================================================
-- AUDIT_LOG TABLE
-- ============================================================================
CREATE TABLE audit_log (
    audit_id          NUMBER PRIMARY KEY,
    table_name        VARCHAR2(100) NOT NULL,
    record_id         NUMBER,
    action_type       VARCHAR2(20) NOT NULL CHECK (action_type IN ('INSERT','UPDATE','DELETE')),
    old_values        CLOB,
    new_values        CLOB,
    changed_by        VARCHAR2(100) DEFAULT USER,
    changed_date      TIMESTAMP DEFAULT SYSTIMESTAMP,
    ip_address        VARCHAR2(50),
    session_id        VARCHAR2(100)
);

CREATE SEQUENCE audit_log_seq START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER audit_log_bir
BEFORE INSERT ON audit_log
FOR EACH ROW
BEGIN
    IF :NEW.audit_id IS NULL THEN
        SELECT audit_log_seq.NEXTVAL INTO :NEW.audit_id FROM DUAL;
    END IF;
END;
/

CREATE INDEX idx_audit_table ON audit_log(table_name);
CREATE INDEX idx_audit_date ON audit_log(changed_date);
CREATE INDEX idx_audit_user ON audit_log(changed_by);

-- ============================================================================
-- INSERT SAMPLE DATA - DEPARTMENTS
-- ============================================================================
INSERT INTO departments (department_name, budget, location) VALUES 
('Software Development', 2500000, 'Cape Town');
INSERT INTO departments (department_name, budget, location) VALUES 
('Consulting Services', 1800000, 'Johannesburg');
INSERT INTO departments (department_name, budget, location) VALUES 
('Project Management', 950000, 'Cape Town');
INSERT INTO departments (department_name, budget, location) VALUES 
('IT Operations', 750000, 'Durban');
INSERT INTO departments (department_name, budget, location) VALUES 
('Sales & Marketing', 650000, 'Johannesburg');
INSERT INTO departments (department_name, budget, location) VALUES 
('Human Resources', 450000, 'Cape Town');
INSERT INTO departments (department_name, budget, location) VALUES 
('Finance', 550000, 'Johannesburg');

-- ============================================================================
-- INSERT SAMPLE DATA - ROLES
-- ============================================================================
INSERT INTO roles (role_name, description, hourly_rate, is_billable) VALUES 
('Software Developer', 'Full-stack application development', 950, 'Y');
INSERT INTO roles (role_name, description, hourly_rate, is_billable) VALUES 
('Senior Developer', 'Senior technical lead and architecture', 1350, 'Y');
INSERT INTO roles (role_name, description, hourly_rate, is_billable) VALUES 
('Database Administrator', 'Database design and optimization', 1150, 'Y');
INSERT INTO roles (role_name, description, hourly_rate, is_billable) VALUES 
('Business Analyst', 'Requirements gathering and analysis', 850, 'Y');
INSERT INTO roles (role_name, description, hourly_rate, is_billable) VALUES 
('Project Manager', 'Project planning and execution', 1250, 'Y');
INSERT INTO roles (role_name, description, hourly_rate, is_billable) VALUES 
('UI/UX Designer', 'User interface and experience design', 800, 'Y');
INSERT INTO roles (role_name, description, hourly_rate, is_billable) VALUES 
('Quality Assurance', 'Testing and quality control', 700, 'Y');
INSERT INTO roles (role_name, description, hourly_rate, is_billable) VALUES 
('Technical Support', 'Customer support and troubleshooting', 550, 'N');
INSERT INTO roles (role_name, description, hourly_rate, is_billable) VALUES 
('Account Manager', 'Client relationship management', 900, 'N');

COMMIT;

-- ============================================================================
-- INSERT SAMPLE DATA - EMPLOYEES (50+ employees)
-- ============================================================================
DECLARE
    v_dev_dept NUMBER;
    v_cons_dept NUMBER;
    v_pm_dept NUMBER;
    v_it_dept NUMBER;
    v_sales_dept NUMBER;
    v_hr_dept NUMBER;
    v_finance_dept NUMBER;
BEGIN
    SELECT department_id INTO v_dev_dept FROM departments WHERE department_name = 'Software Development';
    SELECT department_id INTO v_cons_dept FROM departments WHERE department_name = 'Consulting Services';
    SELECT department_id INTO v_pm_dept FROM departments WHERE department_name = 'Project Management';
    SELECT department_id INTO v_it_dept FROM departments WHERE department_name = 'IT Operations';
    SELECT department_id INTO v_sales_dept FROM departments WHERE department_name = 'Sales & Marketing';
    SELECT department_id INTO v_hr_dept FROM departments WHERE department_name = 'Human Resources';
    SELECT department_id INTO v_finance_dept FROM departments WHERE department_name = 'Finance';
    
    -- Management team (Employee IDs 1-3)
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, salary, status)
    VALUES ('Sarah', 'Johnson', 'sarah.johnson@technova.co.za', '+27-21-555-0101', DATE '2015-03-15', v_pm_dept, 5, 145000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, salary, status)
    VALUES ('Michael', 'Chen', 'michael.chen@technova.co.za', '+27-21-555-0102', DATE '2016-07-22', v_dev_dept, 2, 135000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, salary, status)
    VALUES ('Emily', 'Williams', 'emily.williams@technova.co.za', '+27-11-555-0103', DATE '2017-01-10', v_cons_dept, 4, 125000, 'Active');
    
    -- Software Development Team (Employee IDs 4-20)
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('John', 'Smith', 'john.smith@technova.co.za', '+27-21-555-0104', DATE '2018-05-20', v_dev_dept, 1, 2, 95000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Maria', 'Garcia', 'maria.garcia@technova.co.za', '+27-21-555-0105', DATE '2019-09-14', v_dev_dept, 1, 2, 92000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('David', 'Brown', 'david.brown@technova.co.za', '+27-21-555-0106', DATE '2020-02-01', v_dev_dept, 1, 2, 88000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Lisa', 'Anderson', 'lisa.anderson@technova.co.za', '+27-21-555-0107', DATE '2020-06-15', v_dev_dept, 1, 2, 85000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Robert', 'Taylor', 'robert.taylor@technova.co.za', '+27-21-555-0108', DATE '2021-01-20', v_dev_dept, 1, 2, 90000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Daniel', 'Jackson', 'daniel.jackson@technova.co.za', '+27-21-555-0112', DATE '2021-04-10', v_dev_dept, 6, 2, 82000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Jessica', 'Lee', 'jessica.lee@technova.co.za', '+27-21-555-0113', DATE '2021-09-01', v_dev_dept, 7, 2, 75000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Ashley', 'Clark', 'ashley.clark@technova.co.za', '+27-21-555-0115', DATE '2022-05-20', v_dev_dept, 1, 2, 87000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Kevin', 'Patel', 'kevin.patel@technova.co.za', '+27-21-555-0116', DATE '2022-08-10', v_dev_dept, 1, 2, 86000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Sophie', 'van der Merwe', 'sophie.vandermerwe@technova.co.za', '+27-21-555-0117', DATE '2023-01-15', v_dev_dept, 1, 2, 84000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('James', 'Nkosi', 'james.nkosi@technova.co.za', '+27-21-555-0118', DATE '2023-03-20', v_dev_dept, 2, 2, 115000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Priya', 'Naidoo', 'priya.naidoo@technova.co.za', '+27-21-555-0119', DATE '2023-06-01', v_dev_dept, 1, 2, 83000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Thomas', 'de Villiers', 'thomas.devilliers@technova.co.za', '+27-21-555-0120', DATE '2023-09-10', v_dev_dept, 1, 2, 81000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Rachel', 'Botha', 'rachel.botha@technova.co.za', '+27-21-555-0121', DATE '2024-01-05', v_dev_dept, 1, 2, 80000, 'Active');
    
    -- Consulting Services Team (Employee IDs 21-30)
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Jennifer', 'Martinez', 'jennifer.martinez@technova.co.za', '+27-11-555-0109', DATE '2018-11-05', v_cons_dept, 4, 3, 98000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Thabo', 'Molefe', 'thabo.molefe@technova.co.za', '+27-11-555-0122', DATE '2019-04-15', v_cons_dept, 4, 3, 96000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Zanele', 'Khumalo', 'zanele.khumalo@technova.co.za', '+27-11-555-0123', DATE '2020-01-20', v_cons_dept, 4, 3, 94000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Andrew', 'Robertson', 'andrew.robertson@technova.co.za', '+27-11-555-0124', DATE '2020-07-10', v_cons_dept, 4, 3, 92000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Lerato', 'Dlamini', 'lerato.dlamini@technova.co.za', '+27-11-555-0125', DATE '2021-02-15', v_cons_dept, 4, 3, 90000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Peter', 'Kruger', 'peter.kruger@technova.co.za', '+27-11-555-0126', DATE '2021-08-20', v_cons_dept, 4, 3, 89000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Nomsa', 'Zulu', 'nomsa.zulu@technova.co.za', '+27-11-555-0127', DATE '2022-03-01', v_cons_dept, 4, 3, 87000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Willem', 'Erasmus', 'willem.erasmus@technova.co.za', '+27-11-555-0128', DATE '2022-09-15', v_cons_dept, 2, 3, 112000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Ayanda', 'Mthembu', 'ayanda.mthembu@technova.co.za', '+27-11-555-0129', DATE '2023-02-10', v_cons_dept, 4, 3, 86000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Christine', 'Oosthuizen', 'christine.oosthuizen@technova.co.za', '+27-11-555-0130', DATE '2023-07-01', v_cons_dept, 4, 3, 85000, 'Active');
    
    -- Project Management Team (Employee IDs 31-36)
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Christopher', 'White', 'christopher.white@technova.co.za', '+27-21-555-0110', DATE '2019-03-12', v_pm_dept, 5, 1, 115000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Natalie', 'van Rensburg', 'natalie.vanrensburg@technova.co.za', '+27-21-555-0131', DATE '2020-05-18', v_pm_dept, 5, 1, 110000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Sipho', 'Ngwenya', 'sipho.ngwenya@technova.co.za', '+27-21-555-0132', DATE '2021-01-25', v_pm_dept, 5, 1, 108000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Michelle', 'Coetzee', 'michelle.coetzee@technova.co.za', '+27-21-555-0133', DATE '2022-04-12', v_pm_dept, 5, 1, 105000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Kagiso', 'Motsepe', 'kagiso.motsepe@technova.co.za', '+27-21-555-0134', DATE '2023-01-08', v_pm_dept, 5, 1, 103000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Linda', 'Pretorius', 'linda.pretorius@technova.co.za', '+27-21-555-0135', DATE '2023-08-15', v_pm_dept, 5, 1, 102000, 'Active');
    
    -- IT Operations Team (Employee IDs 37-42)
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Amanda', 'Thomas', 'amanda.thomas@technova.co.za', '+27-31-555-0111', DATE '2020-08-22', v_it_dept, 3, 2, 105000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Bongani', 'Sithole', 'bongani.sithole@technova.co.za', '+27-31-555-0136', DATE '2021-03-10', v_it_dept, 3, 37, 98000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Charlene', 'du Plessis', 'charlene.duplessis@technova.co.za', '+27-31-555-0137', DATE '2021-09-15', v_it_dept, 8, 37, 68000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Mandla', 'Ndlovu', 'mandla.ndlovu@technova.co.za', '+27-31-555-0138', DATE '2022-02-20', v_it_dept, 3, 37, 95000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Annemarie', 'Fourie', 'annemarie.fourie@technova.co.za', '+27-31-555-0139', DATE '2022-07-01', v_it_dept, 8, 37, 65000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Sello', 'Mahlangu', 'sello.mahlangu@technova.co.za', '+27-31-555-0140', DATE '2023-03-15', v_it_dept, 3, 37, 93000, 'Active');
    
    -- Sales & Marketing Team (Employee IDs 43-48)
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Matthew', 'Harris', 'matthew.harris@technova.co.za', '+27-11-555-0114', DATE '2022-01-15', v_sales_dept, 9, 1, 95000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Thandeka', 'Bhengu', 'thandeka.bhengu@technova.co.za', '+27-11-555-0141', DATE '2022-06-01', v_sales_dept, 9, 43, 88000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Pieter', 'Steyn', 'pieter.steyn@technova.co.za', '+27-11-555-0142', DATE '2022-11-10', v_sales_dept, 9, 43, 86000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Naledi', 'Mokoena', 'naledi.mokoena@technova.co.za', '+27-11-555-0143', DATE '2023-04-15', v_sales_dept, 9, 43, 84000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Heinrich', 'Muller', 'heinrich.muller@technova.co.za', '+27-11-555-0144', DATE '2023-09-01', v_sales_dept, 9, 43, 82000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Thandi', 'Radebe', 'thandi.radebe@technova.co.za', '+27-11-555-0145', DATE '2024-02-10', v_sales_dept, 9, 43, 80000, 'Active');
    
    -- Human Resources Team (Employee IDs 49-51)
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Samantha', 'Meyer', 'samantha.meyer@technova.co.za', '+27-21-555-0146', DATE '2019-02-01', v_hr_dept, 4, 1, 102000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Lebo', 'Mashaba', 'lebo.mashaba@technova.co.za', '+27-21-555-0147', DATE '2021-06-15', v_hr_dept, 4, 49, 78000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Francois', 'Roux', 'francois.roux@technova.co.za', '+27-21-555-0148', DATE '2023-05-20', v_hr_dept, 4, 49, 75000, 'Active');
    
    -- Finance Team (Employee IDs 52-55)
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Catherine', 'Jacobs', 'catherine.jacobs@technova.co.za', '+27-11-555-0149', DATE '2018-03-10', v_finance_dept, 4, 1, 118000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Mpho', 'Lekota', 'mpho.lekota@technova.co.za', '+27-11-555-0150', DATE '2020-09-05', v_finance_dept, 4, 52, 92000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Johan', 'van Wyk', 'johan.vanwyk@technova.co.za', '+27-11-555-0151', DATE '2022-01-18', v_finance_dept, 4, 52, 88000, 'Active');
    
    INSERT INTO employees (first_name, last_name, email, phone, hire_date, department_id, role_id, manager_id, salary, status)
    VALUES ('Busisiwe', 'Cele', 'busisiwe.cele@technova.co.za', '+27-11-555-0152', DATE '2023-07-22', v_finance_dept, 4, 52, 85000, 'Active');
    
    COMMIT;
END;
/

-- ============================================================================
-- INSERT SAMPLE DATA - CLIENTS (30+ clients)
-- ============================================================================
DECLARE
    v_acct_mgr NUMBER;
    v_acct_mgr2 NUMBER;
    v_acct_mgr3 NUMBER;
BEGIN
    SELECT employee_id INTO v_acct_mgr FROM employees WHERE email = 'matthew.harris@technova.co.za';
    SELECT employee_id INTO v_acct_mgr2 FROM employees WHERE email = 'thandeka.bhengu@technova.co.za';
    SELECT employee_id INTO v_acct_mgr3 FROM employees WHERE email = 'pieter.steyn@technova.co.za';
    
    -- Major Clients
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, contract_end, status, account_manager_id)
    VALUES ('FirstBank Holdings', 'Banking & Finance', 'Peter Davies', 'peter.davies@firstbank.co.za', '+27-11-234-5678', 
            'Johannesburg', 4500000, DATE '2023-01-01', DATE '2025-12-31', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, contract_end, status, account_manager_id)
    VALUES ('RetailCorp SA', 'Retail', 'Susan Miller', 'susan.miller@retailcorp.co.za', '+27-21-345-6789',
            'Cape Town', 2800000, DATE '2023-06-01', DATE '2025-05-31', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, contract_end, status, account_manager_id)
    VALUES ('MedHealth Systems', 'Healthcare', 'Dr. James Wilson', 'james.wilson@medhealth.co.za', '+27-31-456-7890',
            'Durban', 1950000, DATE '2024-01-01', DATE '2026-12-31', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, contract_end, status, account_manager_id)
    VALUES ('Manufacturing Solutions Ltd', 'Manufacturing', 'Karen Robinson', 'karen.robinson@mansol.co.za', '+27-11-567-8901',
            'Johannesburg', 3200000, DATE '2023-09-01', DATE '2025-08-31', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, contract_end, status, account_manager_id)
    VALUES ('LogiTrans Africa', 'Logistics', 'Mark Thompson', 'mark.thompson@logitrans.co.za', '+27-21-678-9012',
            'Cape Town', 1650000, DATE '2024-03-01', DATE '2026-02-28', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('TechStart Innovations', 'Technology', 'Linda Martinez', 'linda@techstart.co.za', '+27-21-789-0123',
            'Cape Town', 850000, DATE '2024-06-01', 'Active', v_acct_mgr2);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('EduLearn Academy', 'Education', 'Robert Green', 'robert@edulearn.co.za', '+27-11-890-1234',
            'Johannesburg', 675000, DATE '2024-02-01', 'Active', v_acct_mgr2);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Property Masters', 'Real Estate', 'Nicole Adams', 'nicole@propmasters.co.za', '+27-21-901-2345',
            'Cape Town', 1250000, DATE '2023-11-01', 'Active', v_acct_mgr2);
    
    -- Additional Clients
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, contract_end, status, account_manager_id)
    VALUES ('Global Insurance Group', 'Insurance', 'Thabo Mbeki', 'thabo.mbeki@globalins.co.za', '+27-11-234-9876',
            'Johannesburg', 2100000, DATE '2023-04-01', DATE '2025-03-31', 'Active', v_acct_mgr2);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Mining Corp International', 'Mining', 'Johan Smit', 'johan.smit@miningcorp.co.za', '+27-12-345-6789',
            'Pretoria', 3500000, DATE '2024-01-15', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('FreshFoods Distribution', 'Food & Beverage', 'Maria Pieterse', 'maria@freshfoods.co.za', '+27-21-456-7890',
            'Cape Town', 980000, DATE '2024-05-01', 'Active', v_acct_mgr3);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('TeleCom Solutions', 'Telecommunications', 'Sipho Radebe', 'sipho.radebe@telecom.co.za', '+27-11-567-8901',
            'Johannesburg', 2750000, DATE '2023-08-01', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Energy Power SA', 'Energy', 'Elizabeth van der Walt', 'elizabeth@energypower.co.za', '+27-21-678-9012',
            'Cape Town', 4200000, DATE '2024-02-15', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Construction Dynamics', 'Construction', 'Petrus Botha', 'petrus@constdyn.co.za', '+27-31-789-0123',
            'Durban', 1800000, DATE '2024-04-01', 'Active', v_acct_mgr3);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Legal Associates', 'Legal Services', 'Advocate Mandla Nkosi', 'mandla@legalassoc.co.za', '+27-11-890-1234',
            'Johannesburg', 550000, DATE '2024-07-01', 'Active', v_acct_mgr3);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Media Productions', 'Media & Entertainment', 'Sarah Cohen', 'sarah@mediaprod.co.za', '+27-21-901-2345',
            'Cape Town', 720000, DATE '2024-03-15', 'Active', v_acct_mgr2);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Pharma Plus', 'Pharmaceutical', 'Dr. Priya Naidoo', 'priya@pharmaplus.co.za', '+27-31-012-3456',
            'Durban', 1350000, DATE '2023-10-01', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Auto Dealers Network', 'Automotive', 'Willem de Klerk', 'willem@autodealers.co.za', '+27-12-123-4567',
            'Pretoria', 1150000, DATE '2024-06-10', 'Active', v_acct_mgr3);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Tourism Gateway', 'Tourism & Hospitality', 'Lindiwe Zuma', 'lindiwe@tourismgateway.co.za', '+27-21-234-5678',
            'Cape Town', 890000, DATE '2024-08-01', 'Active', v_acct_mgr2);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Agricultural Solutions', 'Agriculture', 'Hendrik Visser', 'hendrik@agrisol.co.za', '+27-18-345-6789',
            'Mahikeng', 1420000, DATE '2023-12-01', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Sports Management Inc', 'Sports & Recreation', 'Themba Khumalo', 'themba@sportsmgmt.co.za', '+27-11-456-7890',
            'Johannesburg', 675000, DATE '2024-09-01', 'Active', v_acct_mgr3);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Fashion Retail Hub', 'Fashion & Retail', 'Zinhle Dlamini', 'zinhle@fashionhub.co.za', '+27-21-567-8901',
            'Cape Town', 520000, DATE '2024-05-15', 'Active', v_acct_mgr2);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Security Services Pro', 'Security', 'Jan van Vuuren', 'jan@securitypro.co.za', '+27-11-678-9012',
            'Johannesburg', 980000, DATE '2024-04-20', 'Active', v_acct_mgr3);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Financial Advisors Ltd', 'Financial Services', 'Nomvula Mthembu', 'nomvula@finadvisors.co.za', '+27-31-789-0123',
            'Durban', 780000, DATE '2024-07-10', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Water Utilities Board', 'Utilities', 'Chris Nel', 'chris.nel@waterutil.gov.za', '+27-12-890-1234',
            'Pretoria', 2300000, DATE '2023-09-15', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Aviation Services', 'Aviation', 'Fatima Patel', 'fatima@aviationserv.co.za', '+27-11-901-2345',
            'Johannesburg', 3100000, DATE '2024-01-05', 'Active', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Chemical Industries', 'Chemical', 'Andre Fourie', 'andre@chemind.co.za', '+27-31-012-3456',
            'Durban', 1650000, DATE '2024-03-20', 'Active', v_acct_mgr3);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Restaurant Chain Group', 'Food Services', 'Ayanda Mbele', 'ayanda@restchain.co.za', '+27-21-123-4567',
            'Cape Town', 640000, DATE '2024-08-15', 'Active', v_acct_mgr2);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('NonProfit Foundation', 'Non-Profit', 'Thembeka Mabaso', 'thembeka@npfoundation.org.za', '+27-11-234-5678',
            'Johannesburg', 380000, DATE '2024-06-25', 'Active', v_acct_mgr2);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, contract_value, contract_start, status, account_manager_id)
    VALUES ('Event Management Co', 'Events', 'Liezl Pretorius', 'liezl@eventmgt.co.za', '+27-21-345-6789',
            'Cape Town', 425000, DATE '2024-09-10', 'Active', v_acct_mgr3);
    
    -- Prospects
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, status, account_manager_id)
    VALUES ('Future Tech Ventures', 'Technology', 'Innovation Director', 'info@futuretech.co.za', '+27-11-999-8888',
            'Johannesburg', 'Prospect', v_acct_mgr);
    
    INSERT INTO clients (client_name, industry, contact_person, email, phone, city, status, account_manager_id)
    VALUES ('Green Energy Solutions', 'Renewable Energy', 'Sustainability Manager', 'contact@greenenergy.co.za', '+27-21-888-7777',
            'Cape Town', 'Prospect', v_acct_mgr2);
    
    COMMIT;
END;
/

-- ============================================================================
-- INSERT SAMPLE DATA - CLIENT CONTACTS (60+ contacts)
-- ============================================================================
DECLARE
    v_client_id NUMBER;
BEGIN
    -- FirstBank Holdings contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'FirstBank Holdings';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Peter Davies', 'CIO', 'peter.davies@firstbank.co.za', '+27-11-234-5678', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Samantha Lee', 'IT Manager', 'samantha.lee@firstbank.co.za', '+27-11-234-5679', 'N');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Michael Naidoo', 'Project Lead', 'michael.naidoo@firstbank.co.za', '+27-11-234-5680', 'N');
    
    -- RetailCorp SA contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'RetailCorp SA';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Susan Miller', 'Operations Director', 'susan.miller@retailcorp.co.za', '+27-21-345-6789', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'John van Wyk', 'Tech Lead', 'john.vw@retailcorp.co.za', '+27-21-345-6790', 'N');
    
    -- MedHealth Systems contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'MedHealth Systems';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Dr. James Wilson', 'CEO', 'james.wilson@medhealth.co.za', '+27-31-456-7890', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Precious Mthembu', 'IT Coordinator', 'precious@medhealth.co.za', '+27-31-456-7891', 'N');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Dr. Ayesha Khan', 'Medical Director', 'ayesha@medhealth.co.za', '+27-31-456-7892', 'N');
    
    -- Manufacturing Solutions Ltd contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Manufacturing Solutions Ltd';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Karen Robinson', 'COO', 'karen.robinson@mansol.co.za', '+27-11-567-8901', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Pieter Botha', 'Systems Analyst', 'pieter.b@mansol.co.za', '+27-11-567-8902', 'N');
    
    -- LogiTrans Africa contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'LogiTrans Africa';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Mark Thompson', 'Logistics Director', 'mark.thompson@logitrans.co.za', '+27-21-678-9012', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Zanele Ndlovu', 'Operations Manager', 'zanele@logitrans.co.za', '+27-21-678-9013', 'N');
    
    -- TechStart Innovations contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'TechStart Innovations';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Linda Martinez', 'CEO', 'linda@techstart.co.za', '+27-21-789-0123', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Thabo Molefe', 'CTO', 'thabo@techstart.co.za', '+27-21-789-0124', 'N');
    
    -- EduLearn Academy contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'EduLearn Academy';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Robert Green', 'Principal', 'robert@edulearn.co.za', '+27-11-890-1234', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Maria da Silva', 'IT Manager', 'maria@edulearn.co.za', '+27-11-890-1235', 'N');
    
    -- Property Masters contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Property Masters';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Nicole Adams', 'Director', 'nicole@propmasters.co.za', '+27-21-901-2345', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Johan Kruger', 'Property Manager', 'johan@propmasters.co.za', '+27-21-901-2346', 'N');
    
    -- Global Insurance Group contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Global Insurance Group';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Thabo Mbeki', 'CFO', 'thabo.mbeki@globalins.co.za', '+27-11-234-9876', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Lerato Moloi', 'Actuarial Head', 'lerato@globalins.co.za', '+27-11-234-9877', 'N');
    
    -- Mining Corp International contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Mining Corp International';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Johan Smit', 'Operations Manager', 'johan.smit@miningcorp.co.za', '+27-12-345-6789', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Mpho Baloyi', 'Mining Engineer', 'mpho@miningcorp.co.za', '+27-12-345-6790', 'N');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Chris Olivier', 'Safety Director', 'chris.o@miningcorp.co.za', '+27-12-345-6791', 'N');
    
    -- FreshFoods Distribution contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'FreshFoods Distribution';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Maria Pieterse', 'Supply Chain Manager', 'maria@freshfoods.co.za', '+27-21-456-7890', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Sipho Dube', 'Warehouse Manager', 'sipho.d@freshfoods.co.za', '+27-21-456-7891', 'N');
    
    -- TeleCom Solutions contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'TeleCom Solutions';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Sipho Radebe', 'CTO', 'sipho.radebe@telecom.co.za', '+27-11-567-8901', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Naledi Motsepe', 'Network Manager', 'naledi@telecom.co.za', '+27-11-567-8902', 'N');
    
    -- Energy Power SA contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Energy Power SA';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Elizabeth van der Walt', 'GM Operations', 'elizabeth@energypower.co.za', '+27-21-678-9012', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Themba Ngubane', 'Plant Manager', 'themba.n@energypower.co.za', '+27-21-678-9013', 'N');
    
    -- Construction Dynamics contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Construction Dynamics';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Petrus Botha', 'Project Director', 'petrus@constdyn.co.za', '+27-31-789-0123', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Busisiwe Khumalo', 'Site Manager', 'busisiwe@constdyn.co.za', '+27-31-789-0124', 'N');
    
    -- Legal Associates contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Legal Associates';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Advocate Mandla Nkosi', 'Senior Partner', 'mandla@legalassoc.co.za', '+27-11-890-1234', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Catherine Wright', 'Practice Manager', 'catherine@legalassoc.co.za', '+27-11-890-1235', 'N');
    
    -- Media Productions contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Media Productions';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Sarah Cohen', 'Producer', 'sarah@mediaprod.co.za', '+27-21-901-2345', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Tshepo Mokoena', 'Creative Director', 'tshepo@mediaprod.co.za', '+27-21-901-2346', 'N');
    
    -- Pharma Plus contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Pharma Plus';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Dr. Priya Naidoo', 'CEO', 'priya@pharmaplus.co.za', '+27-31-012-3456', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Dr. Ahmed Ismail', 'Research Director', 'ahmed@pharmaplus.co.za', '+27-31-012-3457', 'N');
    
    -- Auto Dealers Network contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Auto Dealers Network';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Willem de Klerk', 'Fleet Manager', 'willem@autodealers.co.za', '+27-12-123-4567', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Nomsa Zwane', 'Sales Manager', 'nomsa@autodealers.co.za', '+27-12-123-4568', 'N');
    
    -- Tourism Gateway contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Tourism Gateway';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Lindiwe Zuma', 'MD', 'lindiwe@tourismgateway.co.za', '+27-21-234-5678', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Pierre Rousseau', 'Tour Manager', 'pierre@tourismgateway.co.za', '+27-21-234-5679', 'N');
    
    -- Agricultural Solutions contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Agricultural Solutions';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Hendrik Visser', 'Farm Manager', 'hendrik@agrisol.co.za', '+27-18-345-6789', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Thabiso Molatedi', 'Agronomist', 'thabiso@agrisol.co.za', '+27-18-345-6790', 'N');
    
    -- Sports Management Inc contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Sports Management Inc';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Themba Khumalo', 'Sports Director', 'themba@sportsmgmt.co.za', '+27-11-456-7890', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Stephanie Lombard', 'Events Coordinator', 'stephanie@sportsmgmt.co.za', '+27-11-456-7891', 'N');
    
    -- Fashion Retail Hub contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Fashion Retail Hub';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Zinhle Dlamini', 'Brand Manager', 'zinhle@fashionhub.co.za', '+27-21-567-8901', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Franco Marais', 'Store Manager', 'franco@fashionhub.co.za', '+27-21-567-8902', 'N');
    
    -- Security Services Pro contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Security Services Pro';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Jan van Vuuren', 'Operations Director', 'jan@securitypro.co.za', '+27-11-678-9012', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Sello Madiba', 'Security Chief', 'sello@securitypro.co.za', '+27-11-678-9013', 'N');
    
    -- Financial Advisors Ltd contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Financial Advisors Ltd';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Nomvula Mthembu', 'Senior Advisor', 'nomvula@finadvisors.co.za', '+27-31-789-0123', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Ryan Phillips', 'Wealth Manager', 'ryan@finadvisors.co.za', '+27-31-789-0124', 'N');
    
    -- Water Utilities Board contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Water Utilities Board';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Chris Nel', 'Board Director', 'chris.nel@waterutil.gov.za', '+27-12-890-1234', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Palesa Mofokeng', 'Technical Manager', 'palesa@waterutil.gov.za', '+27-12-890-1235', 'N');
    
    -- Aviation Services contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Aviation Services';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Fatima Patel', 'Operations Manager', 'fatima@aviationserv.co.za', '+27-11-901-2345', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Cobus van Zyl', 'Safety Officer', 'cobus@aviationserv.co.za', '+27-11-901-2346', 'N');
    
    -- Chemical Industries contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Chemical Industries';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Andre Fourie', 'Plant Manager', 'andre@chemind.co.za', '+27-31-012-3456', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Bongi Radebe', 'Quality Assurance', 'bongi@chemind.co.za', '+27-31-012-3457', 'N');
    
    -- Restaurant Chain Group contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Restaurant Chain Group';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Ayanda Mbele', 'Franchise Director', 'ayanda@restchain.co.za', '+27-21-123-4567', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Giuseppe Rossi', 'Head Chef', 'giuseppe@restchain.co.za', '+27-21-123-4568', 'N');
    
    -- NonProfit Foundation contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'NonProfit Foundation';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Thembeka Mabaso', 'Executive Director', 'thembeka@npfoundation.org.za', '+27-11-234-5678', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'David Steenkamp', 'Program Manager', 'david@npfoundation.org.za', '+27-11-234-5679', 'N');
    
    -- Event Management Co contacts
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Event Management Co';
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Liezl Pretorius', 'Event Planner', 'liezl@eventmgt.co.za', '+27-21-345-6789', 'Y');
    INSERT INTO client_contacts (client_id, contact_name, title, email, phone, is_primary) 
    VALUES (v_client_id, 'Kagiso Tau', 'Logistics Manager', 'kagiso@eventmgt.co.za', '+27-21-345-6790', 'N');
    
    COMMIT;
END;
/

-- ============================================================================
-- INSERT SAMPLE DATA - PROJECTS (40+ projects across clients)
-- ============================================================================
DECLARE
    v_client_id NUMBER;
    v_pm_id NUMBER;
    v_pm_id2 NUMBER;
    v_pm_id3 NUMBER;
BEGIN
    -- Get project managers
    SELECT employee_id INTO v_pm_id FROM employees WHERE email = 'sarah.johnson@technova.co.za';
    SELECT employee_id INTO v_pm_id2 FROM employees WHERE email = 'thabo.moloi@technova.co.za';
    SELECT employee_id INTO v_pm_id3 FROM employees WHERE email = 'sipho.ndlovu@technova.co.za';
    
    -- FirstBank Holdings projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'FirstBank Holdings';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Online Banking Portal Migration', v_client_id, v_pm_id, 
            'Migrate legacy online banking system from Access to APEX', 
            DATE '2024-01-15', DATE '2025-09-30', 1850000, 'In Progress', 'High');
    
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Mobile Banking App Enhancement', v_client_id, v_pm_id2,
            'Add biometric authentication and instant payments',
            DATE '2025-06-01', DATE '2026-03-31', 980000, 'Planning', 'High');
    
    -- RetailCorp SA projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'RetailCorp SA';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Inventory Management System', v_client_id, v_pm_id,
            'Real-time inventory tracking across 150 stores',
            DATE '2024-02-01', DATE '2025-10-31', 980000, 'In Progress', 'High');
    
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, actual_cost, status, priority)
    VALUES ('Point of Sale System Upgrade', v_client_id, v_pm_id3,
            'Upgrade POS terminals to cloud-based system',
            DATE '2023-08-01', DATE '2024-06-30', 1250000, 1198000, 'Completed', 'Critical');
    
    -- MedHealth Systems projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'MedHealth Systems';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Patient Records System', v_client_id, v_pm_id,
            'Electronic health records management system',
            DATE '2024-03-01', DATE '2025-12-31', 1250000, 'In Progress', 'Critical');
    
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Appointment Scheduling Portal', v_client_id, v_pm_id2,
            'Online patient appointment booking and management',
            DATE '2025-09-01', DATE '2026-04-30', 520000, 'Planning', 'Medium');
    
    -- Manufacturing Solutions Ltd projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Manufacturing Solutions Ltd';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Production Scheduling System', v_client_id, v_pm_id,
            'Automated production line scheduling and resource allocation',
            DATE '2024-01-10', DATE '2025-08-15', 750000, 'In Progress', 'High');
    
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Quality Control Dashboard', v_client_id, v_pm_id3,
            'Real-time quality metrics and defect tracking',
            DATE '2025-10-01', DATE '2026-05-31', 425000, 'Planning', 'Medium');
    
    -- LogiTrans Africa projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'LogiTrans Africa';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Fleet Management Dashboard', v_client_id, v_pm_id,
            'Real-time tracking and management of 500+ vehicles',
            DATE '2024-04-01', DATE '2025-11-30', 625000, 'In Progress', 'Medium');
    
    -- TechStart Innovations projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'TechStart Innovations';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, actual_cost, status, priority)
    VALUES ('CRM System Implementation', v_client_id, v_pm_id,
            'Custom CRM for sales and customer service teams',
            DATE '2023-09-01', DATE '2024-03-31', 425000, 398000, 'Completed', 'Medium');
    
    -- EduLearn Academy projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'EduLearn Academy';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Student Portal Development', v_client_id, v_pm_id2,
            'Online learning management and grade tracking',
            DATE '2024-07-01', DATE '2025-06-30', 680000, 'In Progress', 'High');
    
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, actual_cost, status, priority)
    VALUES ('Online Registration System', v_client_id, v_pm_id2,
            'Automated student enrollment and fee payment',
            DATE '2023-10-01', DATE '2024-05-31', 320000, 295000, 'Completed', 'Medium');
    
    -- Property Masters projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Property Masters';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Property Listing Portal', v_client_id, v_pm_id3,
            'Public-facing property search and virtual tours',
            DATE '2024-11-01', DATE '2025-08-31', 550000, 'In Progress', 'High');
    
    -- Global Insurance Group projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Global Insurance Group';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Claims Management System', v_client_id, v_pm_id,
            'Digital claims processing and tracking',
            DATE '2024-05-15', DATE '2025-12-31', 1150000, 'In Progress', 'Critical');
    
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Policy Administration Portal', v_client_id, v_pm_id,
            'Self-service policy management for customers',
            DATE '2025-08-01', DATE '2026-06-30', 780000, 'Planning', 'Medium');
    
    -- Mining Corp International projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Mining Corp International';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Safety Compliance System', v_client_id, v_pm_id2,
            'Mine safety monitoring and incident reporting',
            DATE '2024-02-01', DATE '2025-11-30', 1850000, 'In Progress', 'Critical');
    
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Equipment Maintenance Tracker', v_client_id, v_pm_id3,
            'Predictive maintenance for mining equipment',
            DATE '2025-07-01', DATE '2026-03-31', 920000, 'Planning', 'High');
    
    -- FreshFoods Distribution projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'FreshFoods Distribution';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Cold Chain Management System', v_client_id, v_pm_id3,
            'Temperature monitoring and logistics tracking',
            DATE '2024-06-01', DATE '2025-09-30', 650000, 'In Progress', 'High');
    
    -- TeleCom Solutions projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'TeleCom Solutions';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Network Operations Center Dashboard', v_client_id, v_pm_id,
            'Real-time network monitoring and alerting',
            DATE '2024-03-15', DATE '2025-10-31', 1450000, 'In Progress', 'Critical');
    
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, actual_cost, status, priority)
    VALUES ('Customer Self-Service Portal', v_client_id, v_pm_id2,
            'Online bill payment and service management',
            DATE '2023-07-01', DATE '2024-04-30', 685000, 720000, 'Completed', 'High');
    
    -- Energy Power SA projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Energy Power SA';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Smart Grid Management System', v_client_id, v_pm_id,
            'IoT-based power distribution monitoring',
            DATE '2024-04-01', DATE '2026-03-31', 2850000, 'In Progress', 'Critical');
    
    -- Construction Dynamics projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Construction Dynamics';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Project Management Portal', v_client_id, v_pm_id3,
            'Construction project tracking and resource allocation',
            DATE '2024-08-01', DATE '2025-12-31', 890000, 'In Progress', 'High');
    
    -- Legal Associates projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Legal Associates';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Case Management System', v_client_id, v_pm_id2,
            'Legal case tracking and document management',
            DATE '2024-09-01', DATE '2025-08-31', 420000, 'In Progress', 'Medium');
    
    -- Media Productions projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Media Productions';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Content Management System', v_client_id, v_pm_id3,
            'Digital asset management and production workflow',
            DATE '2024-05-15', DATE '2025-07-31', 580000, 'In Progress', 'High');
    
    -- Pharma Plus projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Pharma Plus';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Clinical Trial Management System', v_client_id, v_pm_id,
            'Patient enrollment and trial data tracking',
            DATE '2024-03-01', DATE '2025-12-31', 1180000, 'In Progress', 'Critical');
    
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Pharmacy Inventory System', v_client_id, v_pm_id2,
            'Drug inventory and expiry tracking',
            DATE '2025-09-01', DATE '2026-05-31', 480000, 'Planning', 'Medium');
    
    -- Auto Dealers Network projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Auto Dealers Network';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Vehicle Sales Portal', v_client_id, v_pm_id3,
            'Online vehicle listings and lead management',
            DATE '2024-07-10', DATE '2025-09-30', 720000, 'In Progress', 'High');
    
    -- Tourism Gateway projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Tourism Gateway';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Online Booking System', v_client_id, v_pm_id2,
            'Tour booking and payment processing',
            DATE '2024-10-01', DATE '2025-11-30', 620000, 'In Progress', 'High');
    
    -- Agricultural Solutions projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Agricultural Solutions';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Farm Management System', v_client_id, v_pm_id,
            'Crop monitoring and yield prediction',
            DATE '2024-01-15', DATE '2025-10-31', 980000, 'In Progress', 'High');
    
    -- Sports Management Inc projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Sports Management Inc';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, actual_cost, status, priority)
    VALUES ('Athlete Management Portal', v_client_id, v_pm_id3,
            'Training schedules and performance analytics',
            DATE '2023-11-01', DATE '2024-08-31', 385000, 360000, 'Completed', 'Medium');
    
    -- Fashion Retail Hub projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Fashion Retail Hub';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('E-Commerce Platform', v_client_id, v_pm_id2,
            'Online fashion store with AR try-on feature',
            DATE '2024-06-15', DATE '2025-12-31', 850000, 'In Progress', 'High');
    
    -- Security Services Pro projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Security Services Pro';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Guard Patrol Management System', v_client_id, v_pm_id3,
            'GPS-based patrol tracking and incident reporting',
            DATE '2024-05-20', DATE '2025-08-31', 580000, 'In Progress', 'Medium');
    
    -- Financial Advisors Ltd projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Financial Advisors Ltd';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Investment Portfolio Dashboard', v_client_id, v_pm_id,
            'Client portfolio tracking and reporting',
            DATE '2024-08-10', DATE '2025-10-31', 550000, 'In Progress', 'High');
    
    -- Water Utilities Board projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Water Utilities Board';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Water Distribution Monitoring', v_client_id, v_pm_id,
            'Smart meter data collection and leak detection',
            DATE '2024-02-15', DATE '2026-01-31', 1950000, 'In Progress', 'Critical');
    
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Customer Billing Portal', v_client_id, v_pm_id2,
            'Online water bill payment and usage tracking',
            DATE '2025-10-01', DATE '2026-07-31', 680000, 'Planning', 'Medium');
    
    -- Aviation Services projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Aviation Services';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Flight Operations Management', v_client_id, v_pm_id,
            'Flight scheduling and crew management',
            DATE '2024-03-05', DATE '2025-12-31', 1680000, 'In Progress', 'Critical');
    
    -- Chemical Industries projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Chemical Industries';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('HAZMAT Tracking System', v_client_id, v_pm_id3,
            'Hazardous materials inventory and compliance',
            DATE '2024-04-20', DATE '2025-11-30', 920000, 'In Progress', 'Critical');
    
    -- Restaurant Chain Group projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Restaurant Chain Group';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Kitchen Management System', v_client_id, v_pm_id2,
            'Order management and inventory control',
            DATE '2024-09-15', DATE '2025-10-31', 480000, 'In Progress', 'High');
    
    -- NonProfit Foundation projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'NonProfit Foundation';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Donor Management System', v_client_id, v_pm_id3,
            'Fundraising tracking and donor relations',
            DATE '2024-07-25', DATE '2025-09-30', 280000, 'In Progress', 'Medium');
    
    -- Event Management Co projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Event Management Co';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Event Booking Platform', v_client_id, v_pm_id2,
            'Venue booking and event planning tools',
            DATE '2024-10-10', DATE '2025-12-31', 390000, 'In Progress', 'Medium');
    
    -- On Hold projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'RetailCorp SA';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, budget, status, priority)
    VALUES ('Loyalty Program App', v_client_id, v_pm_id3,
            'Mobile app for customer rewards program',
            DATE '2024-04-01', 450000, 'On Hold', 'Low');
    
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'MedHealth Systems';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, budget, status, priority)
    VALUES ('Telemedicine Platform', v_client_id, v_pm_id,
            'Virtual consultation and prescription system',
            DATE '2024-05-01', 820000, 'On Hold', 'Medium');
    
    -- Cancelled projects
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'LogiTrans Africa';
    INSERT INTO projects (project_name, client_id, project_manager_id, description, start_date, end_date, budget, status, priority)
    VALUES ('Warehouse Robotics Integration', v_client_id, v_pm_id2,
            'Automated warehouse picking system',
            DATE '2024-01-01', DATE '2024-08-31', 1250000, 'Cancelled', 'High');
    
    COMMIT;
END;
/

-- ============================================================================
-- INSERT SAMPLE DATA - TASKS (150+ tasks across all projects)
-- ============================================================================
DECLARE
    v_project_id NUMBER;
    v_emp_id NUMBER;
    v_parent_task NUMBER;
BEGIN
    -- Online Banking Portal Migration tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Online Banking Portal Migration';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'john.smith@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Requirements Gathering', 'Document current Access database structure and business rules', 
            v_emp_id, DATE '2024-01-15', DATE '2024-02-15', 120, 125, 'Completed', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Database Schema Design', 'Design normalized Oracle database schema', 
            v_emp_id, DATE '2024-02-16', DATE '2024-03-15', 80, 72, 'Completed', 'High');
    
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'maria.garcia@technova.co.za';
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Data Migration Scripts', 'Create PL/SQL scripts to migrate data from Access', 
            v_emp_id, DATE '2024-03-16', DATE '2024-04-30', 160, 145, 'Completed', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'User Authentication Module', 'Implement AD integration and role-based security', 
            v_emp_id, DATE '2024-05-01', DATE '2024-06-15', 100, 85, 'In Progress', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Transaction Dashboard', 'Build real-time transaction monitoring dashboard', 
            v_emp_id, DATE '2024-06-16', DATE '2024-07-31', 120, 'In Progress', 'High');
    
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'david.brown@technova.co.za';
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Payment Gateway Integration', 'Integrate with payment processing API', 
            v_emp_id, DATE '2024-08-01', DATE '2024-09-15', 90, 'Not Started', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'User Acceptance Testing', 'Coordinate UAT with bank staff', 
            v_emp_id, DATE '2024-09-16', DATE '2024-09-30', 60, 'Not Started', 'Critical');
    
    -- Inventory Management System tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Inventory Management System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'david.brown@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Store Master Data Setup', 'Configure all 150 store locations in system', 
            v_emp_id, DATE '2024-02-01', DATE '2024-02-29', 60, 58, 'Completed', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Stock Level Reports', 'Create Interactive Reports for inventory levels', 
            v_emp_id, DATE '2024-03-01', DATE '2024-04-15', 80, 72, 'In Progress', 'Medium');
    
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'lisa.anderson@technova.co.za';
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Barcode Scanner Integration', 'Integrate with handheld barcode scanners', 
            v_emp_id, DATE '2024-04-16', DATE '2024-06-30', 100, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Reorder Point Automation', 'Automated purchase orders when stock low', 
            v_emp_id, DATE '2024-07-01', DATE '2024-08-31', 85, 'Not Started', 'Medium');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Store Transfer Management', 'Inter-store inventory transfer workflow', 
            v_emp_id, DATE '2024-09-01', DATE '2024-10-15', 70, 'Not Started', 'Medium');
    
    -- Patient Records System tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Patient Records System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'robert.taylor@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'HIPAA Compliance Review', 'Ensure system meets healthcare privacy regulations', 
            v_emp_id, DATE '2024-03-01', DATE '2024-04-15', 90, 95, 'Completed', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Patient Demographics Module', 'Build patient registration and demographics', 
            v_emp_id, DATE '2024-04-16', DATE '2024-06-30', 120, 110, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Medical History Interface', 'Detailed medical history and allergies tracking', 
            v_emp_id, DATE '2024-07-01', DATE '2024-09-15', 150, 'In Progress', 'Critical');
    
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'emily.williams@technova.co.za';
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Prescription Management', 'E-prescription creation and tracking', 
            v_emp_id, DATE '2024-09-16', DATE '2024-11-30', 110, 'Not Started', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Lab Results Integration', 'Interface with laboratory systems', 
            v_emp_id, DATE '2024-12-01', DATE '2025-02-28', 95, 'Not Started', 'Medium');
    
    -- Production Scheduling System tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Production Scheduling System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'kevin.oconnor@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Production Line Mapping', 'Document all production lines and workflows', 
            v_emp_id, DATE '2024-01-10', DATE '2024-02-28', 80, 85, 'Completed', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Capacity Planning Module', 'Resource capacity and utilization tracking', 
            v_emp_id, DATE '2024-03-01', DATE '2024-05-15', 110, 98, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Work Order Management', 'Create and track manufacturing work orders', 
            v_emp_id, DATE '2024-05-16', DATE '2024-07-31', 95, 'In Progress', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Material Requirements Planning', 'MRP calculation and procurement alerts', 
            v_emp_id, DATE '2024-08-01', DATE '2024-08-15', 60, 'Not Started', 'Medium');
    
    -- Fleet Management Dashboard tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Fleet Management Dashboard';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'sophia.martinez@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'GPS Tracker Integration', 'Integrate with vehicle GPS devices', 
            v_emp_id, DATE '2024-04-01', DATE '2024-05-31', 100, 92, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Real-time Map Display', 'Live vehicle tracking on map interface', 
            v_emp_id, DATE '2024-06-01', DATE '2024-08-15', 120, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Maintenance Scheduling', 'Automated vehicle maintenance reminders', 
            v_emp_id, DATE '2024-08-16', DATE '2024-10-31', 80, 'Not Started', 'Medium');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Fuel Consumption Reports', 'Fuel usage analytics and reporting', 
            v_emp_id, DATE '2024-11-01', DATE '2024-11-30', 50, 'Not Started', 'Low');
    
    -- Student Portal Development tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Student Portal Development';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'amanda.jackson@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Student Login System', 'Secure student authentication portal', 
            v_emp_id, DATE '2024-07-01', DATE '2024-08-15', 70, 68, 'Completed', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Course Registration Module', 'Online course selection and enrollment', 
            v_emp_id, DATE '2024-08-16', DATE '2024-10-31', 110, 95, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Grade Management', 'View grades and academic transcripts', 
            v_emp_id, DATE '2024-11-01', DATE '2025-01-31', 90, 'Not Started', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Online Assignment Submission', 'Upload and track assignment submissions', 
            v_emp_id, DATE '2025-02-01', DATE '2025-04-30', 100, 'Not Started', 'Medium');
    
    -- Claims Management System tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Claims Management System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'nathan.du_plessis@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Claims Intake Form', 'Digital claims submission interface', 
            v_emp_id, DATE '2024-05-15', DATE '2024-07-31', 85, 80, 'Completed', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Document Upload System', 'Claim supporting document management', 
            v_emp_id, DATE '2024-08-01', DATE '2024-09-30', 70, 65, 'In Progress', 'Medium');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Claims Workflow Engine', 'Automated routing and approval workflow', 
            v_emp_id, DATE '2024-10-01', DATE '2024-12-31', 130, 'In Progress', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Payment Processing', 'Claim settlement and payment tracking', 
            v_emp_id, DATE '2025-01-01', DATE '2025-03-31', 95, 'Not Started', 'High');
    
    -- Safety Compliance System tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Safety Compliance System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'zandile.khumalo@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Safety Incident Reporting', 'Digital incident capture and classification', 
            v_emp_id, DATE '2024-02-01', DATE '2024-04-30', 95, 88, 'Completed', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Safety Inspection Checklists', 'Digital safety audit forms', 
            v_emp_id, DATE '2024-05-01', DATE '2024-07-31', 80, 75, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'PPE Tracking Module', 'Personal protective equipment inventory', 
            v_emp_id, DATE '2024-08-01', DATE '2024-10-31', 70, 'In Progress', 'Medium');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Safety Training Records', 'Employee safety certification tracking', 
            v_emp_id, DATE '2024-11-01', DATE '2025-01-31', 60, 'Not Started', 'High');
    
    -- Network Operations Center Dashboard tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Network Operations Center Dashboard';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'thandiwe.nkosi@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Network Device Discovery', 'Auto-discover and catalog network devices', 
            v_emp_id, DATE '2024-03-15', DATE '2024-05-31', 110, 105, 'Completed', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Real-time Monitoring', 'Live network performance metrics display', 
            v_emp_id, DATE '2024-06-01', DATE '2024-08-31', 140, 128, 'In Progress', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Alert Management System', 'Network outage alerting and escalation', 
            v_emp_id, DATE '2024-09-01', DATE '2024-11-30', 95, 'In Progress', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Performance Reporting', 'Historical network performance analytics', 
            v_emp_id, DATE '2024-12-01', DATE '2025-02-28', 80, 'Not Started', 'Medium');
    
    -- Smart Grid Management System tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Smart Grid Management System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'lungile.dube@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'IoT Sensor Integration', 'Connect smart meters and sensors', 
            v_emp_id, DATE '2024-04-01', DATE '2024-07-31', 150, 145, 'Completed', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Power Flow Analysis', 'Real-time grid load analysis', 
            v_emp_id, DATE '2024-08-01', DATE '2024-12-31', 180, 165, 'In Progress', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Outage Management', 'Power outage detection and response', 
            v_emp_id, DATE '2025-01-01', DATE '2025-06-30', 140, 'Not Started', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Energy Forecasting', 'Predictive load forecasting models', 
            v_emp_id, DATE '2025-07-01', DATE '2025-12-31', 120, 'Not Started', 'Medium');
    
    -- Add more tasks for other projects (abbreviated for efficiency)
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Case Management System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'jessica.miller@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Case Filing Module', 'Digital case intake and filing', 
            v_emp_id, DATE '2024-09-01', DATE '2024-11-15', 90, 85, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Document Management', 'Legal document storage and versioning', 
            v_emp_id, DATE '2024-11-16', DATE '2025-02-28', 110, 'Not Started', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Court Date Tracking', 'Calendar and deadline management', 
            v_emp_id, DATE '2025-03-01', DATE '2025-05-31', 70, 'Not Started', 'Medium');
    
    -- Clinical Trial Management System tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Clinical Trial Management System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'olivia.williams@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Patient Enrollment', 'Trial participant registration and consent', 
            v_emp_id, DATE '2024-03-01', DATE '2024-06-30', 120, 115, 'Completed', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Data Collection Forms', 'Electronic case report forms (eCRF)', 
            v_emp_id, DATE '2024-07-01', DATE '2024-10-31', 150, 138, 'In Progress', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Adverse Event Reporting', 'Safety monitoring and reporting system', 
            v_emp_id, DATE '2024-11-01', DATE '2025-03-31', 100, 'In Progress', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Regulatory Compliance', 'FDA/EMA compliance documentation', 
            v_emp_id, DATE '2025-04-01', DATE '2025-08-31', 90, 'Not Started', 'High');
    
    -- Water Distribution Monitoring tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Water Distribution Monitoring';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'nomzamo.sithole@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Smart Meter Deployment', 'Install IoT water meters infrastructure', 
            v_emp_id, DATE '2024-02-15', DATE '2024-07-31', 200, 195, 'Completed', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Leak Detection Algorithm', 'AI-based leak identification system', 
            v_emp_id, DATE '2024-08-01', DATE '2024-12-31', 160, 148, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Pressure Monitoring', 'Real-time water pressure analytics', 
            v_emp_id, DATE '2025-01-01', DATE '2025-06-30', 120, 'Not Started', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Water Quality Tracking', 'Quality test results management', 
            v_emp_id, DATE '2025-07-01', DATE '2025-12-31', 100, 'Not Started', 'Medium');
    
    -- Flight Operations Management tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Flight Operations Management';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'kagiso.mokoena@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Flight Scheduling', 'Route and timetable management', 
            v_emp_id, DATE '2024-03-05', DATE '2024-06-30', 130, 125, 'Completed', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Crew Rostering', 'Pilot and cabin crew scheduling', 
            v_emp_id, DATE '2024-07-01', DATE '2024-10-31', 145, 132, 'In Progress', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Maintenance Tracking', 'Aircraft maintenance scheduling', 
            v_emp_id, DATE '2024-11-01', DATE '2025-03-31', 110, 'In Progress', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Flight Reports', 'Operational reporting and analytics', 
            v_emp_id, DATE '2025-04-01', DATE '2025-08-31', 85, 'Not Started', 'Medium');
    
    -- Farm Management System tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Farm Management System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'boitumelo.letsosa@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Field Mapping Module', 'GPS-based field boundary mapping', 
            v_emp_id, DATE '2024-01-15', DATE '2024-04-30', 100, 98, 'Completed', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Crop Planning', 'Planting schedules and crop rotation', 
            v_emp_id, DATE '2024-05-01', DATE '2024-08-31', 120, 110, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Weather Integration', 'Connect to weather forecast APIs', 
            v_emp_id, DATE '2024-09-01', DATE '2024-11-30', 70, 'In Progress', 'Medium');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Yield Prediction', 'AI-based crop yield forecasting', 
            v_emp_id, DATE '2024-12-01', DATE '2025-03-31', 140, 'Not Started', 'High');
    
    -- E-Commerce Platform tasks
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'E-Commerce Platform';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'mpho.ramotswe@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Product Catalog', 'Fashion item catalog and categories', 
            v_emp_id, DATE '2024-06-15', DATE '2024-08-31', 95, 90, 'Completed', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Shopping Cart', 'Cart management and checkout flow', 
            v_emp_id, DATE '2024-09-01', DATE '2024-11-30', 110, 98, 'In Progress', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Payment Gateway', 'Integrate credit card processing', 
            v_emp_id, DATE '2024-12-01', DATE '2025-02-28', 85, 'Not Started', 'Critical');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'AR Try-On Feature', 'Augmented reality virtual fitting room', 
            v_emp_id, DATE '2025-03-01', DATE '2025-08-31', 180, 'Not Started', 'High');
    
    -- Additional tasks for variety across other projects
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Investment Portfolio Dashboard';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'lerato.mokoena@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Portfolio Overview', 'Dashboard with asset allocation', 
            v_emp_id, DATE '2024-08-10', DATE '2024-10-31', 80, 75, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Performance Analytics', 'ROI and performance metrics', 
            v_emp_id, DATE '2024-11-01', DATE '2025-01-31', 90, 'Not Started', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Market Data Integration', 'Real-time stock price feeds', 
            v_emp_id, DATE '2025-02-01', DATE '2025-05-31', 100, 'Not Started', 'Medium');
    
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Online Booking System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'rethabile_mokgatle@technova.co.za';
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, actual_hours, status, priority)
    VALUES (v_project_id, 'Tour Package Catalog', 'Browse available tours and packages', 
            v_emp_id, DATE '2024-10-01', DATE '2024-11-30', 75, 70, 'In Progress', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Booking Calendar', 'Availability and reservation calendar', 
            v_emp_id, DATE '2024-12-01', DATE '2025-02-28', 85, 'Not Started', 'High');
    
    INSERT INTO tasks (project_id, task_name, description, assigned_to, start_date, due_date, estimated_hours, status, priority)
    VALUES (v_project_id, 'Customer Reviews', 'Tour rating and review system', 
            v_emp_id, DATE '2025-03-01', DATE '2025-06-30', 60, 'Not Started', 'Medium');
    
    COMMIT;
END;
/

-- ============================================================================
-- INSERT SAMPLE DATA - PROJECT ASSIGNMENTS (100+ assignments)
-- ============================================================================
DECLARE
    v_project_id NUMBER;
    v_emp_id NUMBER;
    v_counter NUMBER := 0;
BEGIN
    -- Online Banking Portal Migration assignments
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Online Banking Portal Migration';
    FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                (SELECT department_id FROM departments WHERE department_name = 'Software Development')
                AND ROWNUM <= 5) LOOP
        v_counter := v_counter + 1;
        INSERT INTO project_assignments (project_id, employee_id, allocation_pct, role_on_project)
        VALUES (v_project_id, emp.employee_id, 75, CASE WHEN v_counter = 1 THEN 'Lead Developer' ELSE 'Developer' END);
    END LOOP;
    
    -- Inventory Management System assignments
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Inventory Management System';
    v_counter := 0;
    FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                (SELECT department_id FROM departments WHERE department_name = 'Software Development')
                AND ROWNUM BETWEEN 6 AND 9) LOOP
        v_counter := v_counter + 1;
        INSERT INTO project_assignments (project_id, employee_id, allocation_pct, role_on_project)
        VALUES (v_project_id, emp.employee_id, 80, 'Developer');
    END LOOP;
    
    -- Patient Records System assignments
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Patient Records System';
    FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                (SELECT department_id FROM departments WHERE department_name = 'Software Development')
                AND ROWNUM BETWEEN 3 AND 7) LOOP
        INSERT INTO project_assignments (project_id, employee_id, allocation_pct, role_on_project)
        VALUES (v_project_id, emp.employee_id, 70, 'Developer');
    END LOOP;
    
    -- Production Scheduling System assignments
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Production Scheduling System';
    FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                (SELECT department_id FROM departments WHERE department_name = 'Consulting Services')
                AND ROWNUM <= 4) LOOP
        INSERT INTO project_assignments (project_id, employee_id, allocation_pct, role_on_project)
        VALUES (v_project_id, emp.employee_id, 60, 'Consultant');
    END LOOP;
    
    -- Fleet Management Dashboard assignments
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Fleet Management Dashboard';
    FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                (SELECT department_id FROM departments WHERE department_name = 'Software Development')
                AND ROWNUM BETWEEN 8 AND 11) LOOP
        INSERT INTO project_assignments (project_id, employee_id, allocation_pct, role_on_project)
        VALUES (v_project_id, emp.employee_id, 65, 'Developer');
    END LOOP;
    
    -- Student Portal Development assignments
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Student Portal Development';
    FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                (SELECT department_id FROM departments WHERE department_name = 'Software Development')
                AND ROWNUM BETWEEN 12 AND 15) LOOP
        INSERT INTO project_assignments (project_id, employee_id, allocation_pct, role_on_project)
        VALUES (v_project_id, emp.employee_id, 75, 'Developer');
    END LOOP;
    
    -- Claims Management System assignments
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Claims Management System';
    FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                (SELECT department_id FROM departments WHERE department_name = 'Software Development')
                AND ROWNUM BETWEEN 4 AND 8) LOOP
        INSERT INTO project_assignments (project_id, employee_id, allocation_pct, role_on_project)
        VALUES (v_project_id, emp.employee_id, 70, 'Developer');
    END LOOP;
    
    -- Safety Compliance System assignments
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Safety Compliance System';
    FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                (SELECT department_id FROM departments WHERE department_name = 'Consulting Services')
                AND ROWNUM BETWEEN 5 AND 8) LOOP
        INSERT INTO project_assignments (project_id, employee_id, allocation_pct, role_on_project)
        VALUES (v_project_id, emp.employee_id, 65, 'Consultant');
    END LOOP;
    
    -- Network Operations Center Dashboard assignments
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Network Operations Center Dashboard';
    FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                (SELECT department_id FROM departments WHERE department_name = 'IT Operations')
                AND ROWNUM <= 4) LOOP
        INSERT INTO project_assignments (project_id, employee_id, allocation_pct, role_on_project)
        VALUES (v_project_id, emp.employee_id, 80, 'Systems Engineer');
    END LOOP;
    
    -- Smart Grid Management System assignments
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Smart Grid Management System';
    FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                (SELECT department_id FROM departments WHERE department_name = 'Software Development')
                AND ROWNUM BETWEEN 9 AND 13) LOOP
        INSERT INTO project_assignments (project_id, employee_id, allocation_pct, role_on_project)
        VALUES (v_project_id, emp.employee_id, 85, 'Developer');
    END LOOP;
    
    -- Add more assignments across other active projects
    FOR proj IN (SELECT project_id FROM projects WHERE status IN ('In Progress','Planning') AND ROWNUM BETWEEN 11 AND 25) LOOP
        FOR emp IN (SELECT employee_id FROM employees WHERE department_id IN 
                    (SELECT department_id FROM departments WHERE department_name IN ('Software Development','Consulting Services'))
                    AND ROWNUM <= 3) LOOP
            INSERT INTO project_assignments (project_id, employee_id, allocation_pct, role_on_project)
            VALUES (proj.project_id, emp.employee_id, ROUND(DBMS_RANDOM.VALUE(50, 85), 0), 
                    CASE WHEN DBMS_RANDOM.VALUE < 0.5 THEN 'Developer' ELSE 'Consultant' END);
        END LOOP;
    END LOOP;
    
    COMMIT;
END;
/

-- ============================================================================
-- INSERT SAMPLE DATA - TIMESHEETS (Last 60 days, 600+ entries)
-- ============================================================================
DECLARE
    v_date DATE := SYSDATE - 60;
    v_project_id NUMBER;
    v_task_id NUMBER;
    v_emp_count NUMBER := 0;
BEGIN
    -- Loop through last 60 days
    FOR i IN 1..60 LOOP
        IF TO_CHAR(v_date, 'DY') NOT IN ('SAT','SUN') THEN
            -- Online Banking Portal Migration timesheets
            SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Online Banking Portal Migration';
            
            FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                        (SELECT department_id FROM departments WHERE department_name = 'Software Development')
                        AND ROWNUM <= 3) LOOP
                
                -- Get a random active task for this project
                BEGIN
                    SELECT task_id INTO v_task_id FROM tasks 
                    WHERE project_id = v_project_id AND status IN ('In Progress','Completed')
                    AND ROWNUM = 1 ORDER BY DBMS_RANDOM.VALUE;
                    
                    INSERT INTO timesheets (employee_id, project_id, task_id, work_date, hours_worked, 
                                           description, is_billable, billing_rate, approval_status)
                    VALUES (emp.employee_id, v_project_id, v_task_id, v_date, 
                           ROUND(DBMS_RANDOM.VALUE(5, 8), 1),
                           'Development work', 'Y', 950, 
                           CASE WHEN v_date < SYSDATE - 7 THEN 'Approved' ELSE 'Pending' END);
                EXCEPTION
                    WHEN NO_DATA_FOUND THEN NULL;
                END;
            END LOOP;
            
            -- Inventory Management System timesheets
            BEGIN
                SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Inventory Management System';
                
                FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                            (SELECT department_id FROM departments WHERE department_name = 'Software Development')
                            AND ROWNUM BETWEEN 4 AND 6) LOOP
                    
                    SELECT task_id INTO v_task_id FROM tasks 
                    WHERE project_id = v_project_id AND status IN ('In Progress','Completed')
                    AND ROWNUM = 1 ORDER BY DBMS_RANDOM.VALUE;
                    
                    INSERT INTO timesheets (employee_id, project_id, task_id, work_date, hours_worked, 
                                           description, is_billable, billing_rate, approval_status)
                    VALUES (emp.employee_id, v_project_id, v_task_id, v_date, 
                           ROUND(DBMS_RANDOM.VALUE(4, 8), 1),
                           'System development', 'Y', 900, 
                           CASE WHEN v_date < SYSDATE - 7 THEN 'Approved' ELSE 'Pending' END);
                END LOOP;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN NULL;
            END;
            
            -- Patient Records System timesheets
            BEGIN
                SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Patient Records System';
                
                FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                            (SELECT department_id FROM departments WHERE department_name = 'Software Development')
                            AND ROWNUM BETWEEN 7 AND 9) LOOP
                    
                    SELECT task_id INTO v_task_id FROM tasks 
                    WHERE project_id = v_project_id AND status IN ('In Progress','Completed')
                    AND ROWNUM = 1 ORDER BY DBMS_RANDOM.VALUE;
                    
                    INSERT INTO timesheets (employee_id, project_id, task_id, work_date, hours_worked, 
                                           description, is_billable, billing_rate, approval_status)
                    VALUES (emp.employee_id, v_project_id, v_task_id, v_date, 
                           ROUND(DBMS_RANDOM.VALUE(5, 8), 1),
                           'Healthcare system development', 'Y', 1050, 
                           CASE WHEN v_date < SYSDATE - 7 THEN 'Approved' ELSE 'Pending' END);
                END LOOP;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN NULL;
            END;
            
            -- Production Scheduling System timesheets
            BEGIN
                SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Production Scheduling System';
                
                FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                            (SELECT department_id FROM departments WHERE department_name = 'Consulting Services')
                            AND ROWNUM <= 3) LOOP
                    
                    SELECT task_id INTO v_task_id FROM tasks 
                    WHERE project_id = v_project_id AND status IN ('In Progress','Completed')
                    AND ROWNUM = 1 ORDER BY DBMS_RANDOM.VALUE;
                    
                    INSERT INTO timesheets (employee_id, project_id, task_id, work_date, hours_worked, 
                                           description, is_billable, billing_rate, approval_status)
                    VALUES (emp.employee_id, v_project_id, v_task_id, v_date, 
                           ROUND(DBMS_RANDOM.VALUE(4, 7), 1),
                           'Consulting services', 'Y', 1200, 
                           CASE WHEN v_date < SYSDATE - 7 THEN 'Approved' ELSE 'Pending' END);
                END LOOP;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN NULL;
            END;
            
            -- Claims Management System timesheets
            BEGIN
                SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Claims Management System';
                
                FOR emp IN (SELECT employee_id FROM employees WHERE department_id = 
                            (SELECT department_id FROM departments WHERE department_name = 'Software Development')
                            AND ROWNUM BETWEEN 10 AND 12) LOOP
                    
                    SELECT task_id INTO v_task_id FROM tasks 
                    WHERE project_id = v_project_id AND status IN ('In Progress','Completed')
                    AND ROWNUM = 1 ORDER BY DBMS_RANDOM.VALUE;
                    
                    INSERT INTO timesheets (employee_id, project_id, task_id, work_date, hours_worked, 
                                           description, is_billable, billing_rate, approval_status)
                    VALUES (emp.employee_id, v_project_id, v_task_id, v_date, 
                           ROUND(DBMS_RANDOM.VALUE(5, 8), 1),
                           'Insurance system development', 'Y', 980, 
                           CASE WHEN v_date < SYSDATE - 7 THEN 'Approved' ELSE 'Pending' END);
                END LOOP;
            EXCEPTION
                WHEN NO_DATA_FOUND THEN NULL;
            END;
            
        END IF;
        
        v_date := v_date + 1;
    END LOOP;
    
    COMMIT;
END;
/

-- ============================================================================
-- INSERT SAMPLE DATA - EXPENSES (60+ expense records)
-- ============================================================================
DECLARE
    v_emp_id NUMBER;
    v_project_id NUMBER;
    v_date DATE;
BEGIN
    -- Travel expenses for various projects
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'john.smith@technova.co.za';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Online Banking Portal Migration';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-05-15', 'Travel', 1250.50, 'Flight to Johannesburg for client meeting', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-05-15', 'Accommodation', 850.00, 'Hotel accommodation (2 nights)', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-05-16', 'Meals', 320.00, 'Client dinner', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-06-10', 'Software', 450.00, 'Development tools license', 'Y', 'Approved');
    
    -- Maria's expenses
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'maria.garcia@technova.co.za';
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-07-20', 'Travel', 980.00, 'Car rental for site visit', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-08-05', 'Training', 1200.00, 'Oracle APEX training course', 'Y', 'Approved');
    
    -- Expenses for Inventory Management System
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Inventory Management System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'david.brown@technova.co.za';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-06-18', 'Travel', 1450.00, 'Flight to Cape Town for store survey', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-06-18', 'Accommodation', 920.00, 'Hotel (3 nights)', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-07-12', 'Hardware', 2500.00, 'Barcode scanners for testing', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-08-22', 'Meals', 280.00, 'Team lunch meeting', 'Y', 'Approved');
    
    -- Patient Records System expenses
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Patient Records System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'robert.taylor@technova.co.za';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-05-22', 'Travel', 1680.00, 'Flight to Durban for hospital meetings', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-05-22', 'Accommodation', 1150.00, 'Hotel (4 nights)', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-06-30', 'Training', 2400.00, 'HIPAA compliance training', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-07-15', 'Software', 850.00, 'Healthcare data encryption tool', 'Y', 'Approved');
    
    -- Production Scheduling System expenses
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Production Scheduling System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'kevin.oconnor@technova.co.za';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-03-10', 'Travel', 890.00, 'Site visit to manufacturing plant', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-04-25', 'Meals', 450.00, 'Client workshop lunch', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-06-08', 'Travel', 720.00, 'Factory floor assessment trip', 'Y', 'Approved');
    
    -- Claims Management System expenses
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Claims Management System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'nathan.du_plessis@technova.co.za';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-07-08', 'Travel', 1120.00, 'Flight for insurance company meetings', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-07-08', 'Accommodation', 780.00, 'Hotel (2 nights)', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-08-15', 'Software', 650.00, 'PDF generation library license', 'Y', 'Approved');
    
    -- Fleet Management expenses
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Fleet Management Dashboard';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'sophia.martinez@technova.co.za';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-05-30', 'Hardware', 3200.00, 'GPS tracking devices for testing', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-07-12', 'Travel', 1050.00, 'Visit to client logistics center', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-08-20', 'Software', 950.00, 'Mapping API subscription', 'Y', 'Approved');
    
    -- Student Portal expenses
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Student Portal Development';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'amanda.jackson@technova.co.za';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-08-05', 'Travel', 850.00, 'Campus visit for requirements gathering', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-09-10', 'Software', 420.00, 'UI/UX design tools', 'Y', 'Approved');
    
    -- Safety Compliance expenses
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Safety Compliance System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'zandile.khumalo@technova.co.za';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-04-15', 'Travel', 1850.00, 'Flight to mining site', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-04-15', 'Accommodation', 1200.00, 'On-site accommodation (4 nights)', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-06-20', 'Training', 1800.00, 'Mine safety regulations workshop', 'Y', 'Approved');
    
    -- Network Operations expenses
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Network Operations Center Dashboard';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'thandiwe.nkosi@technova.co.za';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-06-25', 'Hardware', 4500.00, 'Test server equipment', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-07-30', 'Software', 2200.00, 'Network monitoring tools license', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-08-18', 'Training', 1500.00, 'Network security certification', 'Y', 'Approved');
    
    -- Smart Grid expenses
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Smart Grid Management System';
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'lungile.dube@technova.co.za';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-06-10', 'Hardware', 5800.00, 'IoT sensors for testing', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-07-22', 'Travel', 1650.00, 'Power plant site visit', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-07-22', 'Accommodation', 980.00, 'Hotel (2 nights)', 'Y', 'Approved');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-08-30', 'Training', 2800.00, 'Smart grid technology workshop', 'Y', 'Approved');
    
    -- More recent expenses (pending approval)
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'jessica.miller@technova.co.za';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Case Management System';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-10-15', 'Travel', 1120.00, 'Legal firm consultation', 'Y', 'Pending');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-10-28', 'Software', 650.00, 'Document management plugin', 'Y', 'Pending');
    
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'olivia.williams@technova.co.za';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Clinical Trial Management System';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-10-20', 'Travel', 1450.00, 'Pharmaceutical company meeting', 'Y', 'Pending');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-11-02', 'Training', 2200.00, 'FDA compliance workshop', 'Y', 'Pending');
    
    -- Some rejected expenses
    SELECT employee_id INTO v_emp_id FROM employees WHERE email = 'john.smith@technova.co.za';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Online Banking Portal Migration';
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-09-10', 'Meals', 850.00, 'Team celebration dinner', 'N', 'Rejected');
    
    INSERT INTO expenses (employee_id, project_id, expense_date, expense_type, amount, description, receipt_attached, approval_status)
    VALUES (v_emp_id, v_project_id, DATE '2024-09-15', 'Travel', 3200.00, 'International conference', 'Y', 'Rejected');
    
    COMMIT;
END;
/

-- ============================================================================
-- INSERT SAMPLE DATA - INVOICES (25+ invoices with line items)
-- ============================================================================
DECLARE
    v_client_id NUMBER;
    v_project_id NUMBER;
    v_invoice_id NUMBER;
    v_total_amount NUMBER;
BEGIN
    -- Invoice 1: FirstBank Holdings - Online Banking Portal Migration
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'FirstBank Holdings';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Online Banking Portal Migration';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-001', DATE '2024-03-31', DATE '2024-04-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Requirements Analysis - 125 hours', 125, 950, 118750);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Database Design - 72 hours', 72, 950, 68400);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Project Management', 1, 15000, 15000);
    
    v_total_amount := 118750 + 68400 + 15000;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 2: FirstBank Holdings - Phase 2
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-002', DATE '2024-06-30', DATE '2024-07-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Data Migration Development - 145 hours', 145, 950, 137750);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Testing & QA - 60 hours', 60, 850, 51000);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Project Management', 1, 12000, 12000);
    
    v_total_amount := 137750 + 51000 + 12000;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 3: RetailCorp SA - Inventory Management
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'RetailCorp SA';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Inventory Management System';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-003', DATE '2024-04-30', DATE '2024-05-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Store Setup & Configuration - 58 hours', 58, 900, 52200);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Master Data Migration', 1, 25000, 25000);
    
    v_total_amount := 52200 + 25000;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 4: MedHealth Systems - Patient Records
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'MedHealth Systems';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Patient Records System';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-004', DATE '2024-05-31', DATE '2024-06-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'HIPAA Compliance Review - 95 hours', 95, 1050, 99750);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Security Assessment', 1, 18000, 18000);
    
    v_total_amount := 99750 + 18000;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 5: MedHealth Systems - Development Phase
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-005', DATE '2024-08-31', DATE '2024-09-30', 0, 'Sent')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Patient Demographics Module - 110 hours', 110, 1050, 115500);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Integration Services - 45 hours', 45, 1200, 54000);
    
    v_total_amount := 115500 + 54000;
    UPDATE invoices SET total_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 6: Manufacturing Solutions - Production Scheduling
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Manufacturing Solutions Ltd';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Production Scheduling System';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-006', DATE '2024-03-31', DATE '2024-04-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Consulting Services - Production Analysis', 85, 1200, 102000);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Process Mapping Workshop', 1, 15000, 15000);
    
    v_total_amount := 102000 + 15000;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 7: Manufacturing Solutions - Development
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-007', DATE '2024-06-30', DATE '2024-07-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Capacity Planning Module - 98 hours', 98, 950, 93100);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Database Development - 55 hours', 55, 950, 52250);
    
    v_total_amount := 93100 + 52250;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 8: Global Insurance Group - Claims Management
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Global Insurance Group';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Claims Management System';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-008', DATE '2024-07-31', DATE '2024-08-31', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Claims Intake Development - 80 hours', 80, 980, 78400);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Document Management - 65 hours', 65, 980, 63700);
    
    v_total_amount := 78400 + 63700;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 9: Mining Corp - Safety Compliance
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Mining Corp International';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Safety Compliance System';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-009', DATE '2024-05-31', DATE '2024-06-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Safety Incident Reporting Module - 88 hours', 88, 1200, 105600);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'On-site Consultation - 32 hours', 32, 1500, 48000);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Safety Training Expenses', 1, 3200, 3200);
    
    v_total_amount := 105600 + 48000 + 3200;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 10: TeleCom Solutions - NOC Dashboard
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'TeleCom Solutions';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Network Operations Center Dashboard';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-010', DATE '2024-06-30', DATE '2024-07-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Network Discovery Development - 105 hours', 105, 1050, 110250);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Testing Infrastructure Setup', 1, 12000, 12000);
    
    v_total_amount := 110250 + 12000;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 11: TeleCom Solutions - Monitoring Phase
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-011', DATE '2024-09-30', DATE '2024-10-30', 0, 'Sent')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Real-time Monitoring Development - 128 hours', 128, 1050, 134400);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Performance Optimization - 42 hours', 42, 1200, 50400);
    
    v_total_amount := 134400 + 50400;
    UPDATE invoices SET total_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 12: Energy Power SA - Smart Grid
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Energy Power SA';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Smart Grid Management System';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-012', DATE '2024-07-31', DATE '2024-08-31', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'IoT Sensor Integration - 145 hours', 145, 1100, 159500);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Hardware & Equipment', 1, 18000, 18000);
    
    v_total_amount := 159500 + 18000;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 13: Energy Power SA - Analysis Phase
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-013', DATE '2024-10-31', DATE '2024-11-30', 0, 'Sent')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Power Flow Analysis Development - 165 hours', 165, 1100, 181500);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Data Analytics Configuration', 1, 22000, 22000);
    
    v_total_amount := 181500 + 22000;
    UPDATE invoices SET total_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 14: EduLearn Academy - Student Portal
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'EduLearn Academy';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Student Portal Development';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-014', DATE '2024-08-31', DATE '2024-09-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Student Login System - 68 hours', 68, 850, 57800);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Course Registration Module - 95 hours', 95, 850, 80750);
    
    v_total_amount := 57800 + 80750;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 15: Water Utilities Board - Water Distribution
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Water Utilities Board';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Water Distribution Monitoring';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-015', DATE '2024-07-31', DATE '2024-08-31', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Smart Meter Infrastructure - 195 hours', 195, 1100, 214500);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'IoT Hardware & Installation', 1, 35000, 35000);
    
    v_total_amount := 214500 + 35000;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 16: Aviation Services - Flight Operations
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Aviation Services';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Flight Operations Management';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-016', DATE '2024-06-30', DATE '2024-07-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Flight Scheduling Module - 125 hours', 125, 1150, 143750);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Aviation Compliance Consulting', 1, 28000, 28000);
    
    v_total_amount := 143750 + 28000;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 17: Agricultural Solutions - Farm Management
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Agricultural Solutions';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Farm Management System';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-017', DATE '2024-05-31', DATE '2024-06-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Field Mapping System - 98 hours', 98, 980, 96040);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'GPS Integration Services', 1, 12000, 12000);
    
    v_total_amount := 96040 + 12000;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 18: Fashion Retail Hub - E-Commerce
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Fashion Retail Hub';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'E-Commerce Platform';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-018', DATE '2024-08-31', DATE '2024-09-30', 0, 'Paid')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Product Catalog Development - 90 hours', 90, 920, 82800);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Shopping Cart Module - 98 hours', 98, 920, 90160);
    
    v_total_amount := 82800 + 90160;
    UPDATE invoices SET total_amount = v_total_amount, paid_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 19: Financial Advisors - Portfolio Dashboard
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Financial Advisors Ltd';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Investment Portfolio Dashboard';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-019', DATE '2024-10-31', DATE '2024-11-30', 0, 'Sent')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Portfolio Overview Dashboard - 75 hours', 75, 1050, 78750);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Financial Data Integration', 1, 15000, 15000);
    
    v_total_amount := 78750 + 15000;
    UPDATE invoices SET total_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Invoice 20: Tourism Gateway - Booking System
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Tourism Gateway';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Online Booking System';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-020', DATE '2024-10-31', DATE '2024-11-30', 0, 'Draft')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Tour Package Catalog - 70 hours', 70, 880, 61600);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'UI/UX Design Services', 1, 18000, 18000);
    
    v_total_amount := 61600 + 18000;
    UPDATE invoices SET total_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    -- Overdue invoices
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Property Masters';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Property Listing Portal';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-021', DATE '2024-09-15', DATE '2024-10-15', 0, 'Overdue')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Property Listing Portal Development - 95 hours', 95, 920, 87400);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Virtual Tour Integration', 1, 22000, 22000);
    
    v_total_amount := 87400 + 22000;
    UPDATE invoices SET total_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    SELECT client_id INTO v_client_id FROM clients WHERE client_name = 'Auto Dealers Network';
    SELECT project_id INTO v_project_id FROM projects WHERE project_name = 'Vehicle Sales Portal';
    
    INSERT INTO invoices (client_id, project_id, invoice_number, invoice_date, due_date, total_amount, status)
    VALUES (v_client_id, v_project_id, 'INV-2024-022', DATE '2024-09-30', DATE '2024-10-30', 0, 'Overdue')
    RETURNING invoice_id INTO v_invoice_id;
    
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Vehicle Listing System - 85 hours', 85, 900, 76500);
    INSERT INTO invoice_items (invoice_id, description, quantity, unit_price, line_total)
    VALUES (v_invoice_id, 'Lead Management Module - 55 hours', 55, 900, 49500);
    
    v_total_amount := 76500 + 49500;
    UPDATE invoices SET total_amount = v_total_amount WHERE invoice_id = v_invoice_id;
    
    COMMIT;
END;
/

-- ============================================================================
-- CREATE VIEWS FOR REPORTING
-- ============================================================================

-- Project Summary View
CREATE OR REPLACE VIEW v_project_summary AS
SELECT 
    p.project_id,
    p.project_name,
    c.client_name,
    pm.first_name || ' ' || pm.last_name AS project_manager,
    p.start_date,
    p.end_date,
    p.budget,
    p.status,
    p.priority,
    COUNT(DISTINCT t.task_id) AS total_tasks,
    SUM(CASE WHEN t.status = 'Completed' THEN 1 ELSE 0 END) AS completed_tasks,
    SUM(t.estimated_hours) AS estimated_hours,
    SUM(NVL(t.actual_hours, 0)) AS actual_hours,
    (SELECT SUM(hours_worked * billing_rate) 
     FROM timesheets ts 
     WHERE ts.project_id = p.project_id) AS billable_amount
FROM projects p
JOIN clients c ON p.client_id = c.client_id
LEFT JOIN employees pm ON p.project_manager_id = pm.employee_id
LEFT JOIN tasks t ON p.project_id = t.project_id
GROUP BY p.project_id, p.project_name, c.client_name, pm.first_name, pm.last_name,
         p.start_date, p.end_date, p.budget, p.status, p.priority;

-- Employee Utilization View
CREATE OR REPLACE VIEW v_employee_utilization AS
SELECT 
    e.employee_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    d.department_name,
    r.role_name,
    COUNT(DISTINCT pa.project_id) AS active_projects,
    SUM(pa.allocation_pct) AS total_allocation,
    (SELECT SUM(hours_worked) 
     FROM timesheets ts 
     WHERE ts.employee_id = e.employee_id 
     AND ts.work_date >= TRUNC(SYSDATE, 'MM')) AS hours_this_month,
    (SELECT COUNT(*) 
     FROM tasks t 
     WHERE t.assigned_to = e.employee_id 
     AND t.status IN ('Not Started','In Progress')) AS active_tasks
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
LEFT JOIN roles r ON e.role_id = r.role_id
LEFT JOIN project_assignments pa ON e.employee_id = pa.employee_id AND pa.is_active = 'Y'
WHERE e.status = 'Active'
GROUP BY e.employee_id, e.first_name, e.last_name, d.department_name, r.role_name;

-- ============================================================================
-- GRANT PERMISSIONS (adjust as needed for your workspace)
-- ============================================================================
-- Note: In APEX workspace, tables are automatically accessible to workspace users
-- If you need specific grants, uncomment and modify:
-- GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO apex_workspace_user;

-- ============================================================================
-- COMPLETION MESSAGE
-- ============================================================================
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('TechNova Sample Database Setup Complete!');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Tables created: 13');
    DBMS_OUTPUT.PUT_LINE('Views created: 2');
    DBMS_OUTPUT.PUT_LINE('Sample data loaded: Yes');
    DBMS_OUTPUT.PUT_LINE(' ');
    DBMS_OUTPUT.PUT_LINE('Next steps:');
    DBMS_OUTPUT.PUT_LINE('1. Verify tables in SQL Workshop > Object Browser');
    DBMS_OUTPUT.PUT_LINE('2. Review sample data in each table');
    DBMS_OUTPUT.PUT_LINE('3. Proceed with Lab exercises');
    DBMS_OUTPUT.PUT_LINE('========================================');
END;
/
