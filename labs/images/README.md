# Lab Images Directory

This directory contains screenshots and visual aids for the Oracle APEX training labs.

## 📁 Directory Structure

```
images/
├── README.md (this file)
├── lab-01/          # Lab 01 screenshots
├── lab-02/          # Lab 02 screenshots
├── lab-03/          # Lab 03 screenshots
├── lab-04/          # Lab 04 screenshots
├── lab-05/          # Lab 05 screenshots
├── lab-06/          # Lab 06 screenshots
├── lab-07/          # Lab 07 screenshots
└── common/          # Shared screenshots across labs
```

## 🖼️ Image Naming Convention

Use descriptive, lowercase names with hyphens:

**Format:** `lab-XX-step-YY-description.png`

**Examples:**
- `lab-01-step-01-apex-login.png`
- `lab-01-step-02-workspace-signin.png`
- `lab-01-step-03-apex-home.png`
- `lab-02-step-01-create-app-wizard.png`

## 📸 Recommended Screenshots for Each Lab

### Lab 01 - Introduction
- [ ] `lab-01-step-01-apex-login.png` - APEX login page
- [ ] `lab-01-step-02-workspace-signin.png` - Workspace credentials screen
- [ ] `lab-01-step-03-apex-home.png` - APEX home dashboard
- [ ] `lab-01-step-04-sql-workshop.png` - SQL Workshop home
- [ ] `lab-01-step-05-object-browser-empty.png` - Object Browser (no tables)
- [ ] `lab-01-step-06-create-table-menu.png` - Create dropdown menu
- [ ] `lab-01-step-07-create-table-dialog.png` - Create Table dialog
- [ ] `lab-01-step-08-table-columns.png` - Table columns view
- [ ] `lab-01-step-09-sql-commands.png` - SQL Commands interface
- [ ] `lab-01-step-10-insert-data.png` - INSERT statement example

### Lab 02 - Creating Applications
- [ ] `lab-02-step-01-app-builder-home.png` - App Builder home
- [ ] `lab-02-step-02-create-button.png` - Create button location
- [ ] `lab-02-step-03-new-app-option.png` - New Application option
- [ ] `lab-02-step-04-app-wizard-name.png` - Application name screen
- [ ] `lab-02-step-05-add-page-menu.png` - Add Page dropdown
- [ ] `lab-02-step-06-interactive-report-config.png` - IR configuration
- [ ] `lab-02-step-07-app-structure.png` - Complete app structure
- [ ] `lab-02-step-08-application-home.png` - Application home page
- [ ] `lab-02-step-09-run-button.png` - Run application button
- [ ] `lab-02-step-10-running-app.png` - Running application

### Lab 03 - Pages and Page Designer
- [ ] `lab-03-step-01-page-designer-overview.png` - Page Designer 3-panel view
- [ ] `lab-03-step-02-left-pane.png` - Rendering tree (left pane)
- [ ] `lab-03-step-03-center-pane.png` - Layout view (center pane)
- [ ] `lab-03-step-04-right-pane.png` - Properties (right pane)
- [ ] `lab-03-step-05-create-region.png` - Create region
- [ ] `lab-03-step-06-region-properties.png` - Region properties
- [ ] `lab-03-step-07-add-item.png` - Add page item
- [ ] `lab-03-step-08-item-properties.png` - Item properties

### Lab 04 - Reports and Forms
- [ ] `lab-04-step-01-interactive-report.png` - Interactive Report runtime
- [ ] `lab-04-step-02-ir-actions-menu.png` - Actions menu
- [ ] `lab-04-step-03-ir-filter.png` - Filter dialog
- [ ] `lab-04-step-04-ir-columns.png` - Column selection
- [ ] `lab-04-step-05-form-page.png` - Form page view
- [ ] `lab-04-step-06-form-items.png` - Form items
- [ ] `lab-04-step-07-create-button.png` - Create button on report
- [ ] `lab-04-step-08-modal-dialog.png` - Modal dialog form

### Lab 05 - Controls and Navigation
- [ ] `lab-05-step-01-navigation-menu.png` - Navigation menu editor
- [ ] `lab-05-step-02-add-entry.png` - Add menu entry
- [ ] `lab-05-step-03-lov-config.png` - LOV configuration
- [ ] `lab-05-step-04-button-properties.png` - Button properties
- [ ] `lab-05-step-05-dynamic-action.png` - Dynamic Action setup

### Lab 06 - Security and Performance
- [ ] `lab-06-step-01-authentication-schemes.png` - Authentication schemes
- [ ] `lab-06-step-02-auth-config.png` - Authentication configuration
- [ ] `lab-06-step-03-authorization-schemes.png` - Authorization schemes
- [ ] `lab-06-step-04-access-control.png` - Access Control page
- [ ] `lab-06-step-05-debug-mode.png` - Debug mode enabled

### Lab 07 - Deploying Applications
- [ ] `lab-07-step-01-export-menu.png` - Export menu location
- [ ] `lab-07-step-02-export-dialog.png` - Export dialog options
- [ ] `lab-07-step-03-import-wizard.png` - Import wizard
- [ ] `lab-07-step-04-supporting-objects.png` - Supporting objects

### Common Screenshots (Shared)
- [ ] `common-apex-logo.png` - Oracle APEX logo
- [ ] `common-workspace-dropdown.png` - Workspace selector
- [ ] `common-user-menu.png` - User menu dropdown
- [ ] `common-save-button.png` - Save button
- [ ] `common-cancel-button.png` - Cancel button
- [ ] `common-success-message.png` - Success notification
- [ ] `common-error-message.png` - Error notification

## 📝 How to Reference Images in Labs

### Markdown Syntax

```markdown
![Alt Text](images/lab-XX/filename.png)
```

### Examples

**Relative path from lab file:**
```markdown
![APEX Login Page](images/lab-01/lab-01-step-01-apex-login.png)
```

**With caption:**
```markdown
![APEX Home Dashboard](images/lab-01/lab-01-step-03-apex-home.png)
*Figure 1: APEX Home Dashboard showing main navigation tiles*
```

**With sizing (if needed):**
```markdown
<img src="images/lab-01/lab-01-step-01-apex-login.png" alt="APEX Login" width="600">
```

## 🎯 Screenshot Guidelines

### What Makes a Good Screenshot

✅ **DO:**
- Capture entire relevant area (full window or focused region)
- Use default APEX theme (Universal Theme - 42)
- Show clear, readable text (minimum 12pt font visible)
- Include context (navigation breadcrumbs, page titles)
- Highlight key areas with red boxes or arrows (if needed)
- Use consistent browser window size (1920x1080 recommended)
- Save as PNG format (better quality than JPG)
- Crop out irrelevant browser chrome (bookmarks bar, etc.)

❌ **DON'T:**
- Include personal information (real emails, names, IDs)
- Capture dark mode (use light mode for consistency)
- Include browser extensions or toolbars
- Use low resolution or blurry images
- Include actual production data
- Show error states unless intentional

### Image Specifications

- **Format:** PNG (preferred) or JPG
- **Resolution:** 1920x1080 or higher
- **File Size:** Keep under 500KB per image (compress if needed)
- **Aspect Ratio:** Maintain native aspect ratio
- **Color:** RGB color space

## 🛠️ Tools for Taking Screenshots

### macOS
- **Command + Shift + 4:** Select area
- **Command + Shift + 4, then Space:** Capture window
- **Command + Shift + 5:** Screenshot toolbar

### Windows
- **Windows + Shift + S:** Snipping tool
- **Windows + PrtScn:** Full screen
- **Alt + PrtScn:** Active window

### Browser Extensions
- **Awesome Screenshot:** Full page capture
- **Nimbus Screenshot:** Annotate screenshots
- **Fireshot:** Webpage screenshots

## 📦 Image Compression

To keep repository size manageable:

```bash
# Install ImageMagick (if not installed)
brew install imagemagick  # macOS
apt-get install imagemagick  # Linux

# Compress PNG images
mogrify -format png -quality 85 -resize 1920x1080\> images/**/*.png

# Or use online tools:
# - TinyPNG.com
# - Compressor.io
# - Squoosh.app
```

## 🔄 Updating Screenshots

When APEX updates or UI changes:

1. Navigate to the specific lab section
2. Take new screenshot following guidelines
3. Save with same filename (overwrites old version)
4. Verify lab markdown still references correctly
5. Commit with descriptive message:
   ```bash
   git add images/lab-XX/
   git commit -m "Update Lab XX screenshots for APEX 23.1"
   ```

## 📋 Screenshot Checklist Template

Use this when creating screenshots for a new lab:

```markdown
## Lab XX Screenshots Checklist

- [ ] Step 1: [Description] - `lab-XX-step-01-name.png`
- [ ] Step 2: [Description] - `lab-XX-step-02-name.png`
- [ ] Step 3: [Description] - `lab-XX-step-03-name.png`
...
- [ ] Verified all images display correctly in markdown
- [ ] Verified all alt text is descriptive
- [ ] Compressed images to reasonable file size
- [ ] Committed to repository
```

## 🚀 Automation Script

To download images from Oracle documentation:

```bash
#!/bin/bash
# download-apex-screenshots.sh

# Create directories
mkdir -p images/{lab-01,lab-02,lab-03,lab-04,lab-05,lab-06,lab-07,common}

# Download common Oracle APEX screenshots
cd images/common
curl -L -O "https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/img/apex_home.png"
curl -L -O "https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/img/object_browser.png"
# Add more as needed

echo "Screenshots downloaded!"
```

## 📚 Additional Resources

- **Oracle APEX Documentation Images:** https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/img/
- **Oracle Learning Library:** https://apexapps.oracle.com/pls/apex/f?p=44785:1
- **Community Examples:** https://apex.oracle.com/pls/apex/f?p=411

---

**Last Updated:** November 16, 2025  
**Maintained by:** Vodacom Training Team
