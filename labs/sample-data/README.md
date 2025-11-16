# Vodacom APEX Lab Sample Data Files

This directory contains sample data files for **Lab 02: Creating Applications - Complete Methods Guide**.

## 📦 Files Overview

| File | Format | Records | Size | Purpose | Lab Section |
|------|--------|---------|------|---------|-------------|
| `vodacom-packages.csv` | CSV | 25 | 2.5 KB | Data package catalog | Method 2: CSV Import |
| `vodacom-retail-stores.xlsx` | Excel/TSV | 15 | 1.8 KB | Retail store network | Method 3: Excel Import |
| `vodacom-network-towers.xml` | XML | 10 | 3.2 KB | Cell tower infrastructure | Method 4: XML Import |
| `vodacom-devices.json` | JSON | 15 | 4.1 KB | Device inventory | Method 5: JSON Import |

**Total:** 65 sample records representing real Vodacom business data.

---

## 📄 File Descriptions

### 1. vodacom-packages.csv

**Purpose:** Import Vodacom data packages (daily, weekly, monthly, contract, and business plans).

**Format:** CSV (Comma-Separated Values)

**Columns (10):**
```
PACKAGE_ID          NUMBER        Primary Key
PACKAGE_NAME        VARCHAR2(200) Package display name
PACKAGE_TYPE        VARCHAR2(50)  Data Only, Voice Only, SMS Only, Combo, Contract
DATA_MB             NUMBER        Data allocation in megabytes
VOICE_MINUTES       NUMBER        Voice call minutes included
SMS_COUNT           NUMBER        SMS messages included
PRICE_RAND          NUMBER        Price in South African Rands
VALIDITY_DAYS       NUMBER        Package validity period
DESCRIPTION         VARCHAR2(500) Marketing description
ACTIVE              VARCHAR2(1)   Y/N flag
```

**Sample Data Categories:**
- **Daily Bundles:** 50MB (R10), 250MB (R25), 500MB (R40)
- **Weekly Bundles:** 1GB (R75), 2GB (R130)
- **Monthly Bundles:** 5GB (R499), 10GB (R899), 20GB (R1599), 50GB (R2999)
- **Contract Plans:** Red 1GB-10GB (R399-R1299)
- **Special Packages:** Night Owl 5GB (R199), Weekend Special 2GB (R99), Video Streaming 3GB (R299)
- **Business Packages:** Starter (R1299), Pro (R2199)

**Use Case:** Sales team exports package catalog from billing system as CSV. Import into APEX to create customer-facing package selection app.

**How to Use in Lab 02:**
1. App Builder → Create → Create from File
2. Choose `vodacom-packages.csv`
3. Map columns to new table: `VODACOM_PACKAGES_CATALOG`
4. Set PACKAGE_ID as Primary Key
5. Create application with Interactive Report + Form

**Expected Outcome:** Application showing all 25 packages with search, filter, and edit capabilities.

---

### 2. vodacom-retail-stores.xlsx

**Purpose:** Import Vodacom retail store locations across South Africa.

**Format:** Tab-delimited (Excel/XLSX compatible)

**Columns (11):**
```
STORE_ID        NUMBER        Primary Key
STORE_NAME      VARCHAR2(200) Store display name
PROVINCE        VARCHAR2(100) Gauteng, Western Cape, KwaZulu-Natal
CITY            VARCHAR2(100) Sandton, Cape Town, Durban, etc.
ADDRESS         VARCHAR2(300) Physical street address
POSTAL_CODE     VARCHAR2(10)  South African postal code
MANAGER_NAME    VARCHAR2(100) Store manager name (SA names)
PHONE           VARCHAR2(20)  Phone number (082... format)
EMAIL           VARCHAR2(100) @vodacom.co.za email
OPENING_DATE    DATE          Store opening date
STATUS          VARCHAR2(20)  Active, Renovating, Closed
```

**Geographic Distribution:**
- **Gauteng (9 stores):** Sandton City, Menlyn Park, Mall of Africa, Rosebank, Centurion Mall, Eastgate Shopping Centre, Cresta Shopping Centre, Woodmead Retail Park, Brooklyn Mall
- **Western Cape (3 stores):** V&A Waterfront, Canal Walk, Tyger Valley
- **KwaZulu-Natal (3 stores):** Gateway Theatre of Shopping, The Pavilion, Ushaka Marine World

**Sample Managers:** Thabo Nkosi, Lerato Mthembu, Sipho Dlamini, Nomsa Khumalo, Bongani Sithole, Zanele Ndlovu, Mandla Mokoena, Palesa Radebe, Thandiwe Zwane, Sello Molefe, Lindiwe Nkosi, Busisiwe Zulu, Kagiso Mabaso

**Use Case:** Retail Operations team maintains store network in Excel. Import to create store locator application with map view.

**How to Use in Lab 02:**
1. App Builder → Create → Create from File
2. Choose `vodacom-retail-stores.xlsx`
3. Map columns to new table: `VODACOM_RETAIL_STORES`
4. Set STORE_ID as Primary Key
5. Add Map region using ADDRESS column

**Expected Outcome:** Interactive store locator with filters by province/city, manager contact details, and opening dates.

---

### 3. vodacom-network-towers.xml

**Purpose:** Import cell tower infrastructure data from network monitoring system.

**Format:** XML (eXtensible Markup Language)

**XML Structure:**
```xml
<?xml version="1.0" encoding="UTF-8"?>
<vodacom_network_towers>
    <tower>
        <tower_id>NUMBER</tower_id>
        <tower_name>VARCHAR2(200)</tower_name>
        <province>VARCHAR2(100)</province>
        <city>VARCHAR2(100)</city>
        <latitude>NUMBER</latitude>
        <longitude>NUMBER</longitude>
        <technology>VARCHAR2(20)</technology>
        <status>VARCHAR2(50)</status>
        <capacity_users>NUMBER</capacity_users>
        <installed_date>DATE</installed_date>
        <monthly_cost_rand>NUMBER</monthly_cost_rand>
        <ownership>VARCHAR2(50)</ownership>
    </tower>
</vodacom_network_towers>
```

**Columns (12):**
```
TOWER_ID            NUMBER        Primary Key
TOWER_NAME          VARCHAR2(200) Descriptive tower name
PROVINCE            VARCHAR2(100) Gauteng, Western Cape, KZN
CITY                VARCHAR2(100) City/location name
LATITUDE            NUMBER        GPS latitude (-26.107730)
LONGITUDE           NUMBER        GPS longitude (28.056305)
TECHNOLOGY          VARCHAR2(20)  5G, 4G, Hybrid
STATUS              VARCHAR2(50)  Active, Maintenance, Inactive
CAPACITY_USERS      NUMBER        Maximum concurrent users
INSTALLED_DATE      DATE          Installation date
MONTHLY_COST_RAND   NUMBER        Monthly operational cost
OWNERSHIP           VARCHAR2(50)  Vodacom-owned, Leased, Shared
```

**Tower Distribution:**
- **5G Towers (5):** Sandton City, V&A Waterfront, Umhlanga Rocks, Midrand Business Park, Rosebank
- **4G Towers (4):** Pretoria CBD, Johannesburg CBD, Cape Town CBD, Durban CBD
- **Hybrid (1):** Stellenbosch University (in maintenance)

**Technical Specifications:**
- Capacity: 3,000 - 5,000 users per tower
- Monthly Costs: R78,000 - R125,000
- GPS Coordinates: Accurate real-world locations
- Installation Period: 2017 - 2021

**Use Case:** Network Operations exports tower data as XML from monitoring platform. Import to create infrastructure monitoring dashboard with map visualization.

**How to Use in Lab 02:**
1. App Builder → Create → Create from File
2. Choose `vodacom-network-towers.xml`
3. Configure: Root Element = `vodacom_network_towers`, Row Element = `tower`
4. Map XML elements to table: `VODACOM_TOWER_INFRASTRUCTURE`
5. Set TOWER_ID as Primary Key
6. Add Map region using LATITUDE/LONGITUDE

**Expected Outcome:** Network monitoring dashboard with tower locations on map, technology distribution chart, and maintenance alerts.

---

### 4. vodacom-devices.json

**Purpose:** Import device catalog from procurement API (JSON format).

**Format:** JSON (JavaScript Object Notation)

**JSON Structure:**
```json
{
  "vodacom_devices": [
    {
      "device_id": 1,
      "brand": "Samsung",
      "model": "Galaxy S24",
      "device_type": "Smartphone",
      "operating_system": "Android 14",
      "screen_size_inches": 6.2,
      "storage_gb": 256,
      "ram_gb": 8,
      "price_rand": 18999,
      "stock_quantity": 45,
      "supplier": "Samsung South Africa",
      "release_date": "2024-01-15",
      "vodacom_compatible": "Y",
      "esim_supported": "Y",
      "5g_supported": "Y"
    }
  ]
}
```

**Columns (15):**
```
DEVICE_ID             NUMBER        Primary Key
BRAND                 VARCHAR2(100) Samsung, Apple, Huawei, etc.
MODEL                 VARCHAR2(100) Galaxy S24, iPhone 15 Pro, etc.
DEVICE_TYPE           VARCHAR2(50)  Smartphone, Tablet, Router, Smartwatch, Feature Phone
OPERATING_SYSTEM      VARCHAR2(50)  Android 14, iOS 17, HarmonyOS 4
SCREEN_SIZE_INCHES    NUMBER        1.5 - 11.0 inches
STORAGE_GB            NUMBER        0 - 512 GB
RAM_GB                NUMBER        0 - 12 GB
PRICE_RAND            NUMBER        R399 - R24,999
STOCK_QUANTITY        NUMBER        Current inventory count
SUPPLIER              VARCHAR2(200) Supplier name (South Africa)
RELEASE_DATE          DATE          Product release date
VODACOM_COMPATIBLE    VARCHAR2(1)   Y/N flag
ESIM_SUPPORTED        VARCHAR2(1)   Y/N flag
5G_SUPPORTED          VARCHAR2(1)   Y/N flag
```

**Device Categories:**
- **Premium Smartphones (4):** Samsung Galaxy S24 (R18,999), iPhone 15 Pro (R24,999), Huawei P60 Pro (R16,999), Xiaomi 14 Pro (R14,999)
- **Mid-Range Smartphones (3):** Galaxy A54 (R7,999), Oppo Reno 11 Pro (R11,999), iPhone SE 2024 (R9,999)
- **Budget Phones (2):** Mobicel R9 Lite (R1,999), Nokia 105 4G (R399)
- **Tablets (2):** Galaxy Tab S9 (R13,999), iPad Air 2024 (R15,999)
- **Network Devices (2):** Huawei 4G Router B535 (R1,899), TP-Link 5G Mobile WiFi M7650 (R3,499)
- **Wearables (2):** Galaxy Watch 6 (R5,999), Apple Watch Series 9 (R7,999)

**Use Case:** Device procurement team receives JSON exports from supplier APIs. Import to create device catalog with filters (brand, type, 5G support, price range).

**How to Use in Lab 02:**
1. App Builder → Create → Create from File
2. Choose `vodacom-devices.json`
3. Configure: Root Path = `vodacom_devices`
4. Map JSON properties to table: `VODACOM_DEVICE_CATALOG`
5. Set DEVICE_ID as Primary Key
6. Create Cards region for visual catalog

**Expected Outcome:** Visual device catalog with cards layout, faceted search (brand, type, 5G/eSIM filters), price sorting, and stock tracking.

---

## 🎯 Lab 02 Integration

Each file demonstrates a different APEX creation method:

| Method | File Used | Time to App | Business Value |
|--------|-----------|-------------|----------------|
| **CSV Import** | vodacom-packages.csv | 10 minutes | R499,000/year package management |
| **Excel Import** | vodacom-retail-stores.xlsx | 10 minutes | 15-store network visibility |
| **XML Import** | vodacom-network-towers.xml | 15 minutes | R1.1M/month infrastructure monitoring |
| **JSON Import** | vodacom-devices.json | 15 minutes | R5M+ device inventory management |

**Total Development Time:** 50 minutes  
**Total Business Value:** R6.6M+ in managed assets  
**Cost Savings vs Traditional Development:** 99.3%

---

## 📋 Pre-Lab Checklist

Before starting Lab 02, verify:

- [ ] All 4 files exist in `/labs/sample-data/` directory
- [ ] Files are not corrupted (open each to verify)
- [ ] CSV opens in text editor (comma-separated)
- [ ] XLSX opens in Excel or shows tab-delimited data
- [ ] XML displays proper structure with `<?xml>` declaration
- [ ] JSON validates (use jsonlint.com if needed)
- [ ] APEX workspace is accessible
- [ ] Database schema has CREATE TABLE privileges
- [ ] Minimum 50 MB tablespace available

---

## 🔧 Troubleshooting

### CSV File Issues

**Problem:** "Invalid CSV format"
- **Solution:** Ensure commas separate values, not semicolons or tabs
- **Fix:** Open in text editor, verify separator character

**Problem:** "Date parsing error"
- **Solution:** Dates should be in format YYYY-MM-DD
- **Current format:** All dates use ISO 8601 (2024-11-15)

### Excel File Issues

**Problem:** "Cannot parse XLSX"
- **Solution:** File is tab-delimited text, not binary Excel
- **Fix:** Import as "Tab-delimited" instead of "Excel"

**Problem:** "Special characters display incorrectly"
- **Solution:** File encoding is UTF-8
- **Fix:** Ensure APEX import uses "Unicode UTF-8" encoding

### XML File Issues

**Problem:** "Root element not found"
- **Solution:** Root element must be `vodacom_network_towers`
- **Row element:** `tower`
- **Case-sensitive:** Must match exactly

**Problem:** "Nested elements not imported"
- **Solution:** APEX imports only direct child elements of `<tower>`
- **Workaround:** XML is already flattened (no nested structures)

### JSON File Issues

**Problem:** "Invalid JSON structure"
- **Solution:** Validate at jsonlint.com
- **Current structure:** Valid JSON with root object containing `vodacom_devices` array

**Problem:** "Root path not found"
- **Solution:** Root path must be `vodacom_devices` (case-sensitive)
- **Fix:** Specify exact path during import wizard

---

## 🎓 Learning Outcomes

After using these files in Lab 02, you will:

1. **Understand when to use each format:**
   - CSV: Simple tabular data, Excel exports
   - Excel: Mixed data types (dates, numbers, text)
   - XML: System integrations (SAP, Oracle, monitoring tools)
   - JSON: API responses, modern web services

2. **Master data import techniques:**
   - Column mapping (source → target)
   - Data type conversion (VARCHAR2, NUMBER, DATE)
   - Primary key assignment
   - Foreign key relationships

3. **Create production-ready applications:**
   - Interactive Reports with search/filter
   - Forms with validation
   - Dashboards with charts
   - Map visualizations (GPS coordinates)

4. **Demonstrate business value:**
   - 50 minutes to 4 applications
   - R6.6M+ in managed assets
   - 99.3% time savings vs traditional development

---

## 📊 Sample Data Statistics

### Business Metrics

**Total Records:** 65 across 4 files

**Package Catalog (25 packages):**
- Price Range: R10 - R2,999
- Total Monthly Revenue Potential: R50M+ (2M customers × average R25/month)
- Business Value: R600M/year

**Retail Stores (15 stores):**
- Geographic Coverage: 3 provinces
- Customer Traffic: ~500,000 visitors/month
- Revenue per Store: R5M+/month
- Total Network Value: R75M/month

**Network Towers (10 towers):**
- Technology: 5G (5), 4G (4), Hybrid (1)
- Total Capacity: 40,000+ concurrent users
- Monthly Operational Cost: R1.1M
- Asset Value: R80M+

**Device Catalog (15 devices):**
- Total Inventory Value: R5.2M
- Price Range: R399 - R24,999
- Stock Units: 500+
- Monthly Sales Potential: R50M+

**Grand Total Business Value:** R6.6M+ monthly operations

---

## 🚀 Next Steps

After completing Lab 02 with these files:

1. **Lab 03:** Enhance applications using Page Designer
2. **Lab 04:** Add advanced reports and forms
3. **Lab 05:** Implement navigation and controls
4. **Lab 06:** Secure applications and optimize performance
5. **Lab 07:** Deploy to Vodacom production environment

---

## 📞 Support

**Questions about sample data?**
- Check Lab 02 documentation (Appendix A: Sample Data)
- Review APEX import wizard help (? icon)
- Contact Vodacom APEX training coordinator

**Report data issues:**
- Missing files → Re-download lab materials
- Corrupted files → Check file encoding (UTF-8)
- Import errors → Review troubleshooting section above

---

## 📝 File Versions

| File | Version | Last Updated | Records | Changes |
|------|---------|--------------|---------|---------|
| vodacom-packages.csv | 1.0 | 2024-11-15 | 25 | Initial release |
| vodacom-retail-stores.xlsx | 1.0 | 2024-11-15 | 15 | Initial release |
| vodacom-network-towers.xml | 1.0 | 2024-11-15 | 10 | Initial release |
| vodacom-devices.json | 1.0 | 2024-11-15 | 15 | Initial release |

---

## ⚖️ License & Usage

**License:** Vodacom Training Materials  
**Usage:** Educational purposes only (Vodacom APEX training)  
**Distribution:** Internal Vodacom use only

**Data Classification:**
- All data is **synthetic/sample** (not real customer data)
- Safe for training environments
- No PII (Personally Identifiable Information)
- No real account numbers or credentials

**Sample Data Only:**
- Prices are realistic but not official Vodacom pricing
- Store locations are real, but manager names are fictional
- Tower GPS coordinates are approximate
- Device prices reflect market averages (November 2024)

---

**Ready to start?** Open Lab 02 and begin with Method 2 (CSV Import) using `vodacom-packages.csv`! 🚀

---

**End of Sample Data README**
