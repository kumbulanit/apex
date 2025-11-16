# Oracle APEX Installation & Deployment - Comprehensive Guide

## Executive Summary

Oracle APEX (Application Express) is a low-code development platform that runs on Oracle Database. It uses a simple 3-tier architecture consisting of: Browser → Web Server (ORDS) → Database (APEX Engine). APEX is a **no-cost feature** included with all editions of Oracle Database.

---

## Table of Contents

1. [Available Deployment Options](#available-deployment-options)
2. [Operating System Compatibility](#operating-system-compatibility)
3. [Installation Architecture](#installation-architecture)
4. [On-Premises Installation Steps](#on-premises-installation-steps-detailed)
5. [Best Operating System Recommendation](#best-operating-system-recommendation)
6. [Full Development APEX System Setup](#full-development-apex-system-setup-recommended-configuration)
7. [Installation Options Comparison](#installation-options-comparison-table)
8. [Quick Start Recommendations](#quick-start-recommendations-by-use-case)
9. [Additional Resources](#additional-resources)

---

## Available Deployment Options

### 1. Free APEX Workspace (apex.oracle.com) ⭐ **RECOMMENDED FOR BEGINNERS**

**Best for**: Evaluation, learning, prototyping

**Setup time**: Minutes (instant access)

**Cost**: Completely free, no credit card required

**Features**:
- No installation or configuration needed
- Early access to upcoming APEX releases
- Fully hosted and managed by Oracle
- Ideal for developers learning APEX

**Limitations**: 
- Demo/evaluation purposes only
- Production/sensitive data prohibited

**Getting Started**: Sign up at https://apex.oracle.com/

---

### 2. Oracle Autonomous Database (Cloud) ⭐ **RECOMMENDED FOR PRODUCTION**

**Best for**: Production applications, enterprise deployments

**Deployment Options**:
- **Autonomous Transaction Processing (ATP)** - Optimized for OLTP workloads
- **Autonomous Data Warehouse (ADW)** - Optimized for analytics

**Cost**: 
- **Two Always Free environments** included
- Each with 1 OCPU and ~20GB storage
- One-click upgrade for more resources

**Features**:
- APEX pre-configured and ready to use
- Automatic monitoring, backups, patching, and upgrades
- Highly available with Auto Scale
- Available in 50+ global regions
- Compliant with FedRAMP, HIPAA, SOC 1-3, PCI
- No limits on apps, users, or developers

**Getting Started**: Oracle Cloud Infrastructure (OCI) console

---

### 3. On-Premises Installation ⭐ **RECOMMENDED FOR FULL CONTROL**

**Best for**: Organizations requiring full control, air-gapped environments

**Requirements**:
- Oracle Database (any edition: XE, SE, EE, or 23ai Free)
- Compatible OS: **Linux, Unix, Windows**
- Oracle REST Data Services (ORDS) or Embedded PL/SQL Gateway (EPG)

**Features**:
- Deploy APEX in your data center
- Full control over upgrades, patching, backups, tuning
- No limits on apps, users, or developers
- Build locally and deploy to cloud (or vice versa)

**Installation Components**:
1. Oracle Database
2. APEX software (download from apex.oracle.com)
3. Web server layer (ORDS recommended)

---

### 4. Third-Party Cloud Providers

APEX can run anywhere Oracle Database runs:
- **Amazon Web Services (AWS)** - Oracle Database on EC2 or RDS
- **Microsoft Azure** - Oracle Database on Azure VMs
- **Google Cloud Platform (GCP)** - Oracle Database on Compute Engine
- **Full portability**: Develop on Windows on-premises, deploy to Linux in cloud (or vice versa)

---

### 5. Oracle VM VirtualBox (Local Development)

**Best for**: Local development, testing, training

**What's Included**:
- Oracle Database 23ai Free
- Oracle APEX (pre-configured)
- Oracle ORDS
- Oracle SQLcl
- Oracle Linux OS

**Download**: Oracle Database 23ai Free VirtualBox Appliance

**Platform**: Runs on Windows, macOS, Linux (via VirtualBox)

---

## Operating System Compatibility

### Supported Operating Systems (for On-Premises Installation)

#### Linux (Recommended for Production) ✅

- Oracle Linux 7.x, 8.x, 9.x
- Red Hat Enterprise Linux (RHEL) 7.x, 8.x, 9.x
- CentOS 7.x, 8.x
- Ubuntu 18.04, 20.04, 22.04
- SUSE Linux Enterprise Server (SLES) 12, 15

#### Unix

- Oracle Solaris (SPARC and x86-64)
- AIX (IBM Power Systems)
- HP-UX (Itanium)

#### Windows

- Windows Server 2016, 2019, 2022
- Windows 10, 11 (for development only)

---

## Installation Architecture

### APEX Architecture Overview

Oracle APEX uses a **simple 3-tier architecture** where requests are sent from the browser, through a web server, to the database. All processing, data manipulation, and business logic is executed in the database.

**Request Flow:**
1. **User Request** → Browser sends HTTP request
2. **Web Server (ORDS)** → Receives and forwards request to database
3. **APEX Engine (Database)** → Processes request using metadata
4. **Response** → Results sent back through ORDS to browser

This architecture guarantees **zero latency data access**, top performance, and scalability out of the box.

### The Oracle RAD Stack (Required Components)

The Oracle RAD stack is an inclusive technology stack based on three core components:

1. **R** - **REST Data Services (ORDS)**
   - Java application enabling REST APIs for Oracle Database
   - Handles all HTTP/HTTPS communication
   - Manages connection pooling to database
   - No-cost feature of Oracle Database

2. **A** - **APEX (Application Express)**
   - Oracle Database's native low-code development platform
   - Metadata-driven architecture (no code generation)
   - All application metadata stored in database tables
   - Enables building scalable, secure enterprise apps

3. **D** - **Database (Oracle Database)**
   - Most complete, integrated, and secure database solution
   - Any scale deployment supported
   - Makes APEX apps enterprise-ready from day one
   - All editions supported (XE, SE, EE, Free)

### Metadata-Driven Architecture

When you create or extend an application, Oracle APEX creates or modifies the **metadata stored in database tables**. When the application runs, the APEX engine reads this metadata and displays the requested page or processes submissions.

**Key Benefits:**
- **No file-based compilation** required
- **No code generation** - pure metadata interpretation
- **Direct data manipulation** in database for maximum efficiency
- **Single API call** invokes all processing based on metadata
- **Session state management** handled transparently in database

### Stateless Access & Scalability

APEX is vastly scalable and can support **tens of thousands of concurrent users** due to how it manages database requests:

- **Connection Pooling**: API calls use standard Oracle database connection pool
- **Efficient Resource Usage**: Once request is processed, connection returns to pool
- **Inactive Sessions**: User sessions are inactive when not processing requests (no database resources consumed)
- **Session State**: Stored in browser cache after authentication, sent with each request
- **Zero Latency**: Data processing happens directly in database where data resides

This stateless architecture ensures optimal resource utilization and horizontal scalability.

### Two Web Server Options

#### Option 1: ORDS (Oracle REST Data Services) ⭐ **RECOMMENDED**

- Java-based web server
- Modern, scalable, production-ready
- Supports RESTful web services
- Enables developers with SQL skills to develop REST APIs
- Can be deployed on:
  - Standalone (using embedded Jetty)
  - Apache Tomcat
  - Oracle WebLogic Server
  - Any Java EE application server
- **Recommended for all production deployments**

#### Option 2: EPG (Embedded PL/SQL Gateway)

- Built into Oracle Database (XML DB component)
- No separate installation required
- Suitable for development/testing only
- Limited scalability and features
- **Not recommended for production**

---

## On-Premises Installation Steps (Detailed)

### Prerequisites

1. Oracle Database installed (11.2.0.4 or later recommended)
2. Java JDK 11 or later (for ORDS)
3. Minimum 2GB RAM (4GB+ recommended)
4. Sufficient disk space for database and APEX images (~1GB)

### Step-by-Step Installation Process

#### Phase 1: Download APEX Software

```bash
# Download from apex.oracle.com/download
# Extract the zip file
unzip apex_24.2.zip
cd apex
```

#### Phase 2: Install APEX into Oracle Database

**On Linux/Unix/Mac:**

```bash
# Connect to database as SYSDBA
sqlplus sys as sysdba

# Run APEX installation script (choose one based on your needs):

# Full development environment (includes sample apps)
@apexins.sql SYSAUX SYSAUX TEMP /i/

# Runtime only (production - no development tools)
@apxrtins.sql SYSAUX SYSAUX TEMP /i/

# This will take 10-30 minutes depending on system
```

**On Windows:**

```cmd
REM Connect to database as SYSDBA
sqlplus sys as sysdba

REM Run installation
@apexins.sql SYSAUX SYSAUX TEMP /i/
```

**Installation Script Parameters Explained:**
- **SYSAUX** (1st parameter): Tablespace for APEX application metadata
- **SYSAUX** (2nd parameter): Tablespace for APEX files (images, CSS, JavaScript)
- **TEMP** (3rd parameter): Temporary tablespace
- **/i/** (4th parameter): Virtual directory for images

#### Phase 3: Configure APEX

```sql
-- Change APEX admin password
@apxchpwd.sql

-- Set up APEX RESTful Services
@apex_rest_config.sql

-- Load APEX images (if using EPG)
@apex_epg_config.sql /path/to/apex
```

#### Phase 4: Install and Configure ORDS

**Linux/Unix/Mac:**

```bash
# Download ORDS from oracle.com
unzip ords-latest.zip
cd ords

# Configure ORDS (interactive)
java -jar ords.war install

# Or configure via command line
java -jar ords.war install advanced

# Configuration will prompt for:
# - Database hostname
# - Database port
# - Database service name
# - Database username (APEX_PUBLIC_USER)
# - APEX static resources location

# Start ORDS standalone
java -jar ords.war serve

# Access APEX at: http://localhost:8080/ords
```

**Windows:**

```cmd
REM Extract ORDS
unzip ords-latest.zip
cd ords

REM Configure and start
java -jar ords.war install
java -jar ords.war serve
```

#### Phase 5: Configure Static Files (Optional but Recommended)

```bash
# Copy APEX images directory to ORDS configuration
cp -r /path/to/apex/images /path/to/ords/config/ords/standalone/doc_root/i/

# Or configure web server (Apache/Nginx) to serve static files
```

#### Phase 6: Access APEX

```
# Default URLs:
http://localhost:8080/ords           # ORDS homepage
http://localhost:8080/ords/apex      # APEX login page

# Default credentials:
Workspace: INTERNAL
Username: ADMIN
Password: <password set during apxchpwd.sql>
```

---

## Best Operating System Recommendation

### 🏆 Recommended: Oracle Linux 8.x or 9.x

**Reasons:**

1. **Optimized for Oracle Products**: Native support and optimization
2. **Free**: No licensing costs (even for production)
3. **Unbreakable Enterprise Kernel (UEK)**: Enhanced performance
4. **Security**: Regular security updates, SELinux support
5. **Support**: Oracle support available if needed
6. **Compatibility**: 100% RHEL-compatible
7. **Long-term Support**: Extended lifecycle
8. **Docker/Container Support**: Excellent containerization support

**Alternative Strong Options:**
- **Ubuntu Server 22.04 LTS**: Great for teams familiar with Debian ecosystem
- **Red Hat Enterprise Linux 8/9**: If you already have RHEL licensing
- **Windows Server 2022**: If Windows expertise exists and infrastructure is Windows-based

---

## Full Development APEX System Setup (Recommended Configuration)

### Ideal Development Environment Configuration

#### Hardware Requirements

- **CPU**: 4+ cores (8+ recommended)
- **RAM**: 8GB minimum (16GB+ recommended)
- **Disk**: 50GB+ SSD (100GB+ for production)
- **Network**: Stable internet connection

#### Software Stack

1. **Operating System**: Oracle Linux 9.x
2. **Database**: Oracle Database 23ai (latest free version) or Enterprise Edition
3. **APEX**: Version 24.2 (latest)
4. **ORDS**: Latest version (bundled with APEX downloads)
5. **Java**: OpenJDK 17 or Oracle JDK 17+
6. **Version Control**: Git for application export/import
7. **Editor**: VS Code with Oracle extensions (optional)

#### Complete Development Setup Script (Oracle Linux)

```bash
#!/bin/bash
# Full APEX Development Environment Setup

# 1. Install prerequisites
sudo dnf install -y oracle-database-preinstall-23ai
sudo dnf install -y java-17-openjdk java-17-openjdk-devel
sudo dnf install -y git wget unzip

# 2. Install Oracle Database 23ai Free
# Download from oracle.com and install
sudo dnf -y install oracle-database-free-23ai

# 3. Configure database
sudo /etc/init.d/oracle-free-23ai configure

# 4. Download and install APEX
cd /tmp
wget https://download.oracle.com/otn_software/apex/apex_24.2.zip
unzip apex_24.2.zip
cd apex

# 5. Install APEX as SYSDBA
export ORACLE_SID=FREE
export ORACLE_HOME=/opt/oracle/product/23ai/dbhomeFree
$ORACLE_HOME/bin/sqlplus / as sysdba << EOF
@apexins.sql SYSAUX SYSAUX TEMP /i/
@apex_rest_config.sql
@apxchpwd.sql
exit;
EOF

# 6. Download and configure ORDS
cd /opt/oracle
wget https://download.oracle.com/otn_software/java/ords/ords-latest.zip
unzip ords-latest.zip -d ords
cd ords

# 7. Configure ORDS
java -jar ords.war install advanced

# 8. Start ORDS as a service
sudo tee /etc/systemd/system/ords.service > /dev/null << 'EOF'
[Unit]
Description=Oracle REST Data Services
After=network.target

[Service]
Type=simple
User=oracle
ExecStart=/usr/bin/java -jar /opt/oracle/ords/ords.war serve
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable ords
sudo systemctl start ords

echo "APEX Development Environment Ready!"
echo "Access APEX at: http://localhost:8080/ords"
```

### Ubuntu/Debian Setup Script

```bash
#!/bin/bash
# APEX Development Environment Setup for Ubuntu

# 1. Install prerequisites
sudo apt update
sudo apt install -y alien libaio1 unzip wget openjdk-17-jdk git

# 2. Download Oracle Database 23ai Free (RPM)
cd /tmp
wget https://download.oracle.com/otn-pub/otn_software/db-free/oracle-database-free-23ai-1.0-1.el8.x86_64.rpm

# 3. Convert RPM to DEB and install
sudo alien --scripts -d oracle-database-free-23ai-1.0-1.el8.x86_64.rpm
sudo dpkg -i oracle-database-free-23ai*.deb

# 4. Configure database
sudo /etc/init.d/oracle-free-23ai configure

# 5. Download and install APEX
cd /tmp
wget https://download.oracle.com/otn_software/apex/apex_24.2.zip
unzip apex_24.2.zip
cd apex

# 6. Install APEX
export ORACLE_SID=FREE
export ORACLE_HOME=/opt/oracle/product/23ai/dbhomeFree
sudo -u oracle $ORACLE_HOME/bin/sqlplus / as sysdba << EOF
@apexins.sql SYSAUX SYSAUX TEMP /i/
@apex_rest_config.sql
@apxchpwd.sql
exit;
EOF

# 7. Setup ORDS (same as Oracle Linux script above)
cd /opt/oracle
sudo wget https://download.oracle.com/otn_software/java/ords/ords-latest.zip
sudo unzip ords-latest.zip -d ords
cd ords
sudo -u oracle java -jar ords.war install advanced

echo "APEX Development Environment Ready!"
```

### Windows PowerShell Setup Script

```powershell
# APEX Development Environment Setup for Windows

# 1. Download and Install Oracle Database
# Download Oracle Database 21c XE from oracle.com
# Run the installer: OracleXE213_Win64.zip

# 2. Download Java JDK 17
# Download from adoptium.net or oracle.com
# Install and set JAVA_HOME

# 3. Download APEX
Invoke-WebRequest -Uri "https://download.oracle.com/otn_software/apex/apex_24.2.zip" -OutFile "apex_24.2.zip"
Expand-Archive -Path "apex_24.2.zip" -DestinationPath "C:\apex"

# 4. Install APEX
cd C:\apex\apex
sqlplus sys/password@XE as sysdba @apexins.sql SYSAUX SYSAUX TEMP /i/

# 5. Configure APEX
sqlplus sys/password@XE as sysdba @apex_rest_config.sql
sqlplus sys/password@XE as sysdba @apxchpwd.sql

# 6. Download and Configure ORDS
Invoke-WebRequest -Uri "https://download.oracle.com/otn_software/java/ords/ords-latest.zip" -OutFile "ords.zip"
Expand-Archive -Path "ords.zip" -DestinationPath "C:\ords"

cd C:\ords
java -jar ords.war install advanced

# 7. Start ORDS
java -jar ords.war serve

Write-Host "APEX Development Environment Ready!"
Write-Host "Access APEX at: http://localhost:8080/ords"
```

---

## Installation Options Comparison Table

| Feature | Free Workspace | Cloud (Autonomous) | On-Premises | VM VirtualBox |
|---------|---------------|-------------------|-------------|---------------|
| **Setup Time** | < 5 minutes | 10-30 minutes | 2-4 hours | 30-60 minutes |
| **Cost** | Free | Free tier + paid | License + infrastructure | Free |
| **Production Use** | ❌ No | ✅ Yes | ✅ Yes | ❌ No |
| **Full Control** | ❌ No | ⚠️ Limited | ✅ Yes | ✅ Yes (local) |
| **Maintenance** | Oracle managed | Oracle managed | Self-managed | Self-managed |
| **Scalability** | Limited | Auto-scale | Manual | Limited |
| **Backup/Recovery** | Oracle managed | Automatic | Manual | Manual |
| **Security Updates** | Automatic | Automatic | Manual | Manual |
| **Custom DB Config** | ❌ No | ⚠️ Limited | ✅ Yes | ✅ Yes |
| **Internet Required** | ✅ Yes | ✅ Yes | ❌ No | ❌ No |
| **Best For** | Learning | Production | Enterprise | Development |

---

## Quick Start Recommendations by Use Case

### Learning APEX
**→ Free Workspace (apex.oracle.com)**
- Instant access
- No installation
- Perfect for tutorials and training

### Building Production Apps
**→ Oracle Autonomous Database (Cloud)**
- Zero administration
- Auto-scaling
- Built-in security and backups

### Enterprise/Air-Gapped Environments
**→ On-Premises (Oracle Linux)**
- Full control
- Data sovereignty
- Custom configurations

### Local Development
**→ VM VirtualBox or Docker**
- Isolated environment
- Easy to reset
- No cloud costs

### Proof of Concept
**→ Free Workspace or VM VirtualBox**
- Quick setup
- Low commitment
- Easy demonstration

---

## Docker Installation (Alternative Method)

### Using Official Oracle Container Registry

```bash
# 1. Login to Oracle Container Registry
docker login container-registry.oracle.com

# 2. Pull Oracle Database with APEX
docker pull container-registry.oracle.com/database/free:latest

# 3. Run the container
docker run -d \
  --name oracle-apex \
  -p 1521:1521 \
  -p 5500:5500 \
  -e ORACLE_PWD=YourPassword123 \
  container-registry.oracle.com/database/free:latest

# 4. Wait for database to be ready (check logs)
docker logs -f oracle-apex

# 5. Access APEX (once ready)
# https://localhost:5500/ords
```

### Custom Docker Compose Setup

Create `docker-compose.yml`:

```yaml
version: '3.8'

services:
  oracle-db:
    image: container-registry.oracle.com/database/free:latest
    container_name: apex-database
    ports:
      - "1521:1521"
      - "5500:5500"
    environment:
      - ORACLE_PWD=YourPassword123
      - ORACLE_CHARACTERSET=AL32UTF8
    volumes:
      - oracle-data:/opt/oracle/oradata
    restart: unless-stopped

volumes:
  oracle-data:
```

Run with:
```bash
docker-compose up -d
```

---

## Post-Installation Configuration

### Create Your First Workspace

```sql
-- Connect as APEX ADMIN
-- Navigate to: http://localhost:8080/ords/apex_admin

-- Or via SQL:
BEGIN
    APEX_INSTANCE_ADMIN.ADD_WORKSPACE(
        p_workspace_id   => null,
        p_workspace      => 'MY_WORKSPACE',
        p_primary_schema => 'MY_SCHEMA'
    );
    
    APEX_UTIL.SET_WORKSPACE(p_workspace => 'MY_WORKSPACE');
    
    APEX_UTIL.CREATE_USER(
        p_user_name                    => 'DEVELOPER',
        p_email_address                => 'developer@company.com',
        p_web_password                 => 'SecurePassword123',
        p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
        p_change_password_on_first_use => 'N'
    );
END;
/
```

### Configure Email Settings (Optional)

```sql
BEGIN
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'SMTP_HOST_ADDRESS',
        p_value     => 'smtp.company.com'
    );
    
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'SMTP_HOST_PORT',
        p_value     => '587'
    );
    
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'SMTP_USERNAME',
        p_value     => 'apex@company.com'
    );
    
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'SMTP_PASSWORD',
        p_value     => 'email_password'
    );
END;
/
```

### Enable Network Services (for External API Calls)

```sql
-- Allow APEX to make external HTTP requests
BEGIN
    DBMS_NETWORK_ACL_ADMIN.APPEND_HOST_ACE(
        host       => '*',
        ace        => xs$ace_type(
            privilege_list => xs$name_list('connect','resolve'),
            principal_name => 'APEX_230200',
            principal_type => xs_acl.ptype_db
        )
    );
END;
/
```

### AppDev as a Service (Self-Service Workspace Provisioning)

One of the key benefits of APEX's metadata-driven and database architecture is its ability to provide a **fully self-service, automated application development platform**.

#### Self-Service Capabilities

APEX provides **email provisioning** to allow anyone in your organization to sign up for their own hosted workspace (development environment):

- Sign-up wizard for automated provisioning
- Users can be up and running in minutes
- Each tenant gets their own fully isolated workspace
- Developers can work independently on their applications

#### IT Governance Benefits

The development environment is professionally managed by IT, ensuring:

- **Data Protection**: Everything is within the database and properly backed up
- **Performance Monitoring**: IT can readily monitor app performance and data access
- **Resource Management**: Workspaces can be assigned to Consumer Groups for priority management
- **Integrated Monitoring**: Full instrumentation allows administrators to review activity and detect trends

#### Collaboration Model

APEX fosters better working relationships between IT and departments:

- **Consistent Tooling**: IT can easily help departments using SQL and PL/SQL
- **Low-Level Extensions**: IT can extend apps with JavaScript, HTML, and CSS as needed
- **Direct Data Access**: Departments get trusted access to corporate data or RESTful Web Services
- **Better than Shadow IT**: Departments build their own apps while staying within IT's purview

#### Enable Self-Service Provisioning

```sql
-- Enable workspace provisioning
BEGIN
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'WORKSPACE_PROVISION_TYPE',
        p_value     => 'EMAIL'
    );
    
    -- Set provisioning email settings
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'ADMIN_EMAIL',
        p_value     => 'apex-admin@company.com'
    );
    
    -- Enable approval workflow (optional)
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'WORKSPACE_PROVISION_APPROVAL',
        p_value     => 'Y'
    );
END;
/
```

---

## Troubleshooting Common Issues

### Issue 1: Cannot Connect to ORDS

**Symptoms**: Browser cannot reach http://localhost:8080/ords

**Solutions**:
```bash
# Check if ORDS is running
ps aux | grep ords

# Check ORDS logs
cat /path/to/ords/logs/ords.log

# Verify port is not blocked
sudo netstat -tulpn | grep 8080

# Check firewall
sudo firewall-cmd --list-all
sudo firewall-cmd --add-port=8080/tcp --permanent
sudo firewall-cmd --reload
```

### Issue 2: APEX Images Not Loading

**Symptoms**: APEX interface shows broken images/no styling

**Solutions**:
```bash
# Ensure images are in correct location
ls -la /path/to/ords/config/ords/standalone/doc_root/i/

# Copy images if missing
cp -r /path/to/apex/images/* /path/to/ords/config/ords/standalone/doc_root/i/

# Verify APEX_IMAGES setting
SELECT * FROM apex_instance_admin WHERE parameter_name = 'IMAGE_PREFIX';

# Should be: /i/
```

### Issue 3: Database Connection Failures

**Symptoms**: ORDS cannot connect to database

**Solutions**:
```sql
-- Check listener status
lsnrctl status

-- Verify APEX_PUBLIC_USER
SELECT username, account_status FROM dba_users WHERE username = 'APEX_PUBLIC_USER';

-- Unlock if necessary
ALTER USER APEX_PUBLIC_USER ACCOUNT UNLOCK;
ALTER USER APEX_PUBLIC_USER IDENTIFIED BY new_password;

-- Update ORDS connection
java -jar ords.war config set db.password
```

### Issue 4: ORA-12154 TNS Error

**Symptoms**: Cannot resolve service name

**Solutions**:
```bash
# Check tnsnames.ora
cat $ORACLE_HOME/network/admin/tnsnames.ora

# Set environment variables
export ORACLE_HOME=/opt/oracle/product/23ai/dbhomeFree
export ORACLE_SID=FREE
export PATH=$ORACLE_HOME/bin:$PATH

# Test connection
sqlplus sys/password@localhost:1521/FREE as sysdba
```

---

## Performance Tuning

### Database Configuration

```sql
-- Increase shared pool
ALTER SYSTEM SET shared_pool_size=1G SCOPE=BOTH;

-- Increase PGA
ALTER SYSTEM SET pga_aggregate_target=2G SCOPE=BOTH;

-- Enable result cache
ALTER SYSTEM SET result_cache_mode=FORCE SCOPE=BOTH;
ALTER SYSTEM SET result_cache_max_size=512M SCOPE=BOTH;

-- Gather statistics
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('APEX_230200');
```

### ORDS Configuration

Edit `ords/config/ords/conf/apex.xml`:

```xml
<pool>
  <entry key="db.connectionType">basic</entry>
  <entry key="db.hostname">localhost</entry>
  <entry key="db.port">1521</entry>
  <entry key="db.servicename">FREE</entry>
  <entry key="db.username">APEX_PUBLIC_USER</entry>
  
  <!-- Connection Pool Settings -->
  <entry key="jdbc.InitialLimit">10</entry>
  <entry key="jdbc.MinLimit">10</entry>
  <entry key="jdbc.MaxLimit">50</entry>
  <entry key="jdbc.MaxStatementsLimit">20</entry>
</pool>
```

Start ORDS with more memory:

```bash
java -Xmx2G -jar ords.war serve
```

---

## Security Best Practices

### 1. Change Default Passwords

```sql
-- Change APEX ADMIN password
@apxchpwd.sql

-- Change APEX_PUBLIC_USER password
ALTER USER APEX_PUBLIC_USER IDENTIFIED BY new_secure_password;

-- Update ORDS configuration
java -jar ords.war config set db.password
```

### 2. Enable HTTPS

Using ORDS standalone with SSL:

```bash
# Generate keystore
keytool -genkey -keyalg RSA -alias apex -keystore keystore.jks -storepass password -keysize 2048

# Configure ORDS for HTTPS
java -jar ords.war standalone --https-port 8443 --https-keystore keystore.jks
```

### 3. Restrict Access

```sql
-- Limit login attempts
BEGIN
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'FAILED_LOGIN_ATTEMPTS_LOCKOUT',
        p_value     => '5'
    );
END;
/

-- Set session timeout
BEGIN
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'SESSION_TIMEOUT',
        p_value     => '3600'  -- 1 hour
    );
END;
/
```

### 4. Enable Audit Logging

```sql
-- Enable activity logging
BEGIN
    APEX_INSTANCE_ADMIN.SET_PARAMETER(
        p_parameter => 'ENABLE_ACTIVITY_LOGGING',
        p_value     => 'Y'
    );
END;
/
```

---

## Backup and Recovery

### Database Backup

```bash
# Full database backup (RMAN)
rman target /
BACKUP DATABASE PLUS ARCHIVELOG;
EXIT;

# Export APEX schemas
expdp system/password SCHEMAS=APEX_230200,APEX_PUBLIC_USER \
  DIRECTORY=DATA_PUMP_DIR DUMPFILE=apex_backup.dmp LOGFILE=apex_backup.log
```

### APEX Application Export

```sql
-- Export all applications in workspace
BEGIN
    FOR app IN (SELECT application_id FROM apex_applications) LOOP
        APEX_EXPORT.GET_APPLICATION(
            p_application_id => app.application_id,
            p_split          => 'Y'
        );
    END LOOP;
END;
/
```

### Automated Backup Script

```bash
#!/bin/bash
# apex_backup.sh

BACKUP_DIR="/backup/apex"
DATE=$(date +%Y%m%d_%H%M%S)

# Database backup
export ORACLE_SID=FREE
export ORACLE_HOME=/opt/oracle/product/23ai/dbhomeFree

rman target / << EOF
BACKUP DATABASE PLUS ARCHIVELOG;
DELETE NOPROMPT OBSOLETE;
EXIT;
EOF

# APEX workspace backup
sqlplus -s sys/password as sysdba << EOF
EXEC APEX_EXPORT.WORKSPACE(p_workspace => 'MY_WORKSPACE');
EXIT;
EOF

# Compress and archive
tar -czf ${BACKUP_DIR}/apex_backup_${DATE}.tar.gz /path/to/backups

echo "Backup completed: apex_backup_${DATE}.tar.gz"
```

---

## Upgrading APEX

### Upgrade Process

```bash
# 1. Backup current APEX installation
expdp system/password SCHEMAS=APEX_230200 DIRECTORY=DATA_PUMP_DIR DUMPFILE=apex_pre_upgrade.dmp

# 2. Download new APEX version
cd /tmp
unzip apex_24.2.zip

# 3. Run upgrade script
cd apex
sqlplus sys as sysdba
@apexins.sql SYSAUX SYSAUX TEMP /i/

# 4. Upgrade ORDS (if needed)
cd /path/to/ords
java -jar ords.war install --upgrade

# 5. Verify upgrade
SELECT * FROM apex_release;
```

---

## Development Lifecycle & Deployment

### Moving Applications Between Environments (Dev/Test/Prod)

Oracle APEX contains utilities and features to support professional development lifecycles across multiple environments.

#### Export/Import Method

Use Export/Import to move your application from Development to Test or from Test to Production:

```sql
-- Export application (via SQL*Plus or SQLcl)
-- Method 1: Using APEX_EXPORT API
BEGIN
    APEX_EXPORT.GET_APPLICATION(
        p_application_id => 100,
        p_split          => 'N',  -- Y for split files
        p_with_date      => 'N',
        p_with_ir_public_reports => 'Y',
        p_with_comments  => 'Y'
    );
END;
/

-- Method 2: Command line export (SQLcl)
-- apex export -applicationid 100 -split
```

**Import application:**

```sql
-- Import using SQL*Plus
@f100.sql

-- Or use APEX Application Import UI
-- Navigate to: App Builder > Import > Drag and drop SQL file
```

#### Command-Line Automation

Export/Import tasks can be fully automated using SQLcl or PL/SQL API:

```bash
#!/bin/bash
# Automated export script

export ORACLE_HOME=/opt/oracle/product/23ai/dbhomeFree
export PATH=$ORACLE_HOME/bin:$PATH

# Export application using SQLcl
sql developer/password@localhost:1521/FREE << EOF
apex export -applicationid 100 -workspaceid 1234567890 -split
exit;
EOF

echo "Application exported successfully"
```

#### CI/CD Integration

Use operating system or Continuous Integration/Continuous Deployment (CI/CD) jobs to automatically move applications between platforms:

**Example: Jenkins Pipeline**

```groovy
pipeline {
    agent any
    
    stages {
        stage('Export from Dev') {
            steps {
                sh '''
                    sql dev_user/dev_pass@dev_db << EOF
                    apex export -applicationid 100 -split
                    exit;
                    EOF
                '''
            }
        }
        
        stage('Import to Test') {
            steps {
                sh '''
                    sql test_user/test_pass@test_db << EOF
                    @f100.sql
                    exit;
                    EOF
                '''
            }
        }
        
        stage('Run Tests') {
            steps {
                sh './run_apex_tests.sh'
            }
        }
    }
}
```

**Example: GitHub Actions**

```yaml
name: APEX Deployment

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v2
    
    - name: Install SQLcl
      run: |
        wget https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip
        unzip sqlcl-latest.zip
    
    - name: Export APEX App
      run: |
        ./sqlcl/bin/sql ${{ secrets.DB_USER }}/${{ secrets.DB_PASS }}@${{ secrets.DB_HOST }} << EOF
        apex export -applicationid 100 -split
        exit;
        EOF
    
    - name: Commit to repo
      run: |
        git add .
        git commit -m "Auto-export APEX app"
        git push
```

### Version Control Integration

APEX is a development platform on a central instance. Integration with version control looks different but is absolutely achievable:

#### Export and Split Applications

Each application export can be **split into individual components**:

```bash
# Export with split option
apex export -applicationid 100 -split

# This creates:
# - application/
#   - pages/
#   - shared_components/
#   - security/
#   - ui/
#   - etc.
```

Components are then checked into version control, making it easy to:
- Detect which component changed when
- Review changes in pull requests
- Track history of individual pages or components
- Merge changes from multiple developers

#### Automated Version Control Integration

Use CI jobs to automatically export applications nightly and check into version control:

```bash
#!/bin/bash
# Nightly export and commit script

# Export application
cd /apex-repo
sql apex_user/password@prod_db << EOF
apex export -applicationid 100 -workspaceid 1234567890 -split
exit;
EOF

# Check for changes
if [[ `git status --porcelain` ]]; then
    # Commit changes
    git add .
    git commit -m "Auto-export: $(date +%Y-%m-%d)"
    git push origin main
    
    echo "Changes committed to version control"
else
    echo "No changes detected"
fi
```

#### Version Control as Application Archive

Once application exports are checked into version control, they can be used as an archive:

- **Recovery**: Restore apps if developers accidentally delete or break something
- **Rollback**: Easily revert to previous working versions
- **Audit Trail**: Complete history of all changes
- **Branching**: Support feature branches and parallel development

**Recovery example:**

```bash
# Restore application from git history
git checkout HEAD~5 -- application/f100.sql

# Import the recovered version
sql sys/password@db as sysdba @application/f100.sql
```

### Best Practices for Application Deployment

1. **Use Workspaces for Isolation**: Separate Dev, Test, and Prod workspaces
2. **Version Your Applications**: Maintain version numbers in application properties
3. **Document Changes**: Use application change log or CHANGELOG.md
4. **Test Before Production**: Always deploy to test environment first
5. **Backup Before Deployment**: Export current production app before importing new version
6. **Use Supporting Objects**: Export/import database objects (tables, packages) separately
7. **Manage Dependencies**: Document and track external dependencies (APIs, files, etc.)
8. **Automate Where Possible**: Use scripts and CI/CD for consistency
9. **Track Database Changes**: Use version control for PL/SQL packages and schema changes
10. **Communicate Deployments**: Notify users of scheduled deployments and downtime

---

## Additional Resources

### Official Documentation
- **Main Documentation**: https://apex.oracle.com/en/learn/documentation/
- **Installation Guide**: https://docs.oracle.com/en/database/oracle/application-express/24.2/htmig/
- **API Reference**: https://docs.oracle.com/en/database/oracle/application-express/24.2/aeapi/
- **JavaScript API**: https://docs.oracle.com/en/database/oracle/application-express/24.2/aexjs/

### Learning Resources
- **Tutorials**: https://apex.oracle.com/en/learn/tutorials/
- **Training**: https://apex.oracle.com/en/learn/training/
- **YouTube Channel**: https://www.youtube.com/c/oracleapex
- **Office Hours**: https://apex.oracle.com/en/community/office-hours/

### Community
- **Forums**: https://apex.oracle.com/en/community/forums/
- **Blog**: https://apex.oracle.com/en/community/blog/
- **Twitter**: @oracleapex (#orclapex)
- **LinkedIn**: Oracle APEX Group

### Downloads
- **APEX Download**: https://apex.oracle.com/download
- **ORDS Download**: https://www.oracle.com/database/technologies/appdev/rest.html
- **Database Download**: https://www.oracle.com/database/technologies/oracle-database-software-downloads.html
- **VirtualBox Appliance**: https://www.oracle.com/database/technologies/databaseappdev-vm.html

### Third-Party Books
- "Expert Oracle Application Express" by Doug Gault
- "Oracle APEX Best Practices" by Alex Nuijten, Dimitri Gielis
- "Beginning Oracle Application Express 5" by Doug Gault

---

## Key Takeaways

1. **APEX is FREE** - No additional licensing beyond Oracle Database
2. **Platform Agnostic** - Runs on Linux, Unix, Windows
3. **Cloud or On-Premises** - Deploy anywhere Oracle Database runs
4. **Oracle Linux is Best** - Optimized, free, and fully supported
5. **ORDS is Recommended** - Modern, scalable web server layer
6. **Quick Start Available** - Free workspace in minutes for learning
7. **Production Ready** - Autonomous Database for zero-admin production apps
8. **No Limits** - Unlimited apps, users, and developers
9. **Fully Portable** - Build anywhere, deploy everywhere
10. **Enterprise Grade** - Used by thousands of organizations worldwide

---

## Version History

- **November 2025**: Initial comprehensive guide for APEX 24.2
- Based on official Oracle APEX documentation
- Covers all major deployment options and operating systems

---

## Support and Contact

For technical support:
- **Oracle Support**: https://support.oracle.com
- **Community Forums**: https://apex.oracle.com/en/community/forums/
- **GitHub Issues**: For community tools and utilities

---

*This guide is maintained as part of the APEX training course materials. For updates and corrections, please refer to the official Oracle APEX documentation.*
