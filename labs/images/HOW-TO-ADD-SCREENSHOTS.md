# How to Add Screenshots to Labs

This guide shows you how to capture and add screenshots to the training labs.

## Quick Start

1. **Capture Screenshot** → 2. **Save to correct folder** → 3. **Reference in lab markdown**

---

## Step-by-Step Instructions

### Step 1: Take the Screenshot

#### On macOS:
- **Cmd + Shift + 4**: Select area to capture
- **Cmd + Shift + 4, then Space**: Capture entire window
- **Cmd + Shift + 5**: Open screenshot toolbar with options

#### On Windows:
- **Windows + Shift + S**: Snipping tool
- **Windows + PrtScn**: Full screen
- **Alt + PrtScn**: Active window

#### Tips for Good Screenshots:
- Use **1920x1080 resolution** or higher
- Capture **full context** (include navigation, breadcrumbs)
- Remove **personal information** (use dummy data)
- Use **light mode** (default APEX theme)
- Crop out **unnecessary browser chrome**

### Step 2: Save the Screenshot

**Naming Convention:** `lab-XX-step-YY-description.png`

**Example:**
```
lab-01-step-05-object-browser-empty.png
lab-02-step-04-app-wizard-name.png
lab-03-step-01-page-designer-overview.png
```

**Save Location:**
```
apex/
└── labs/
    └── images/
        ├── lab-01/     ← Lab 1 screenshots here
        ├── lab-02/     ← Lab 2 screenshots here
        ├── lab-03/     ← Lab 3 screenshots here
        ├── lab-04/
        ├── lab-05/
        ├── lab-06/
        ├── lab-07/
        └── common/     ← Shared screenshots (logos, buttons, etc.)
```

### Step 3: Reference in Lab Markdown

**Basic Image:**
```markdown
![Description](images/lab-01/lab-01-step-05-object-browser-empty.png)
```

**With Caption:**
```markdown
![Object Browser Empty](images/lab-01/lab-01-step-05-object-browser-empty.png)
*Figure 1: Object Browser with no tables*
```

**With Custom Size:**
```markdown
<img src="images/lab-01/lab-01-step-05-object-browser-empty.png" alt="Object Browser" width="800">
```

---

## Complete Example

Here's how to add a screenshot to **Lab 01, Exercise 2.1**:

### 1. Capture the Screenshot
- Navigate to Object Browser in APEX
- Press **Cmd + Shift + 4** (or Windows equivalent)
- Select the entire Object Browser area
- Screenshot is saved to Desktop

### 2. Rename and Move
```bash
# Move from Desktop to correct folder
mv ~/Desktop/Screenshot*.png ~/Desktop/apex/labs/images/lab-01/lab-01-step-05-object-browser-empty.png
```

### 3. Add to Lab Markdown

**In `lab-01-introduction-vodacom.md`, add:**

```markdown
### Exercise 2.1: Create VODACOM_CUSTOMERS Table

🎯 **Goal:** Create a table to store customer records

📸 **Visual Guide:**

**Navigation Path:**
```
Home → SQL Workshop → Object Browser → Create → Table
```

![Object Browser Empty State](images/lab-01/lab-01-step-05-object-browser-empty.png)
*Figure 1: Object Browser showing no tables initially*

**Step-by-Step:**

① **Navigate to Object Browser**
   - From APEX Home, click **SQL Workshop**
   - Click **Object Browser**
   - You should see an empty list as shown above

② **Start Create Table**
   - Click the **[+ Create ▾]** button (top-right)
   - Select **"Table"** from dropdown

![Create Table Dialog](images/lab-01/lab-01-step-07-create-table-dialog.png)
*Figure 2: Create Table dialog with column configuration*
```

---

## Image Checklist for Each Lab

### Lab 01 - Introduction (10 images needed)
- [ ] `lab-01-step-01-apex-login.png` - Login page
- [ ] `lab-01-step-02-workspace-signin.png` - Workspace credentials
- [ ] `lab-01-step-03-apex-home.png` - Home dashboard
- [ ] `lab-01-step-04-sql-workshop.png` - SQL Workshop home
- [ ] `lab-01-step-05-object-browser-empty.png` - Empty Object Browser
- [ ] `lab-01-step-06-create-menu.png` - Create dropdown menu
- [ ] `lab-01-step-07-create-table-dialog.png` - Create Table dialog
- [ ] `lab-01-step-08-table-columns.png` - Table with columns
- [ ] `lab-01-step-09-sql-commands.png` - SQL Commands interface
- [ ] `lab-01-step-10-data-inserted.png` - Table with data

### Lab 02 - Creating Applications (10 images needed)
- [ ] `lab-02-step-01-app-builder-home.png` - App Builder home
- [ ] `lab-02-step-02-create-button.png` - Create button highlighted
- [ ] `lab-02-step-03-new-app-option.png` - New Application option
- [ ] `lab-02-step-04-app-wizard-name.png` - Name your app
- [ ] `lab-02-step-05-add-page-menu.png` - Add Page dropdown
- [ ] `lab-02-step-06-report-config.png` - Report configuration
- [ ] `lab-02-step-07-app-pages.png` - App with all pages
- [ ] `lab-02-step-08-application-home.png` - Application home page
- [ ] `lab-02-step-09-run-button.png` - Run button location
- [ ] `lab-02-step-10-running-app.png` - Application running

### Lab 03 - Page Designer (8 images needed)
- [ ] `lab-03-step-01-page-designer-full.png` - Full Page Designer view
- [ ] `lab-03-step-02-left-pane.png` - Rendering tree
- [ ] `lab-03-step-03-center-layout.png` - Layout grid
- [ ] `lab-03-step-04-right-properties.png` - Properties pane
- [ ] `lab-03-step-05-create-region.png` - Create region button
- [ ] `lab-03-step-06-region-type.png` - Region type selector
- [ ] `lab-03-step-07-add-item.png` - Add item
- [ ] `lab-03-step-08-save-run.png` - Save and Run buttons

### Lab 04 - Reports and Forms (8 images needed)
- [ ] `lab-04-step-01-report-runtime.png` - Interactive Report running
- [ ] `lab-04-step-02-actions-menu.png` - Actions menu open
- [ ] `lab-04-step-03-filter-dialog.png` - Filter configuration
- [ ] `lab-04-step-04-columns-dialog.png` - Column selection
- [ ] `lab-04-step-05-form-view.png` - Form page
- [ ] `lab-04-step-06-create-button.png` - Create button on report
- [ ] `lab-04-step-07-edit-form.png` - Edit form with data
- [ ] `lab-04-step-08-modal-form.png` - Modal dialog form

### Lab 05 - Controls and Navigation (5 images needed)
- [ ] `lab-05-step-01-nav-menu.png` - Navigation menu editor
- [ ] `lab-05-step-02-add-entry.png` - Add menu entry
- [ ] `lab-05-step-03-lov-setup.png` - LOV configuration
- [ ] `lab-05-step-04-button-props.png` - Button properties
- [ ] `lab-05-step-05-dynamic-action.png` - Dynamic Action

### Lab 06 - Security (5 images needed)
- [ ] `lab-06-step-01-auth-schemes.png` - Authentication schemes
- [ ] `lab-06-step-02-auth-config.png` - Configure authentication
- [ ] `lab-06-step-03-authz-schemes.png` - Authorization schemes
- [ ] `lab-06-step-04-access-control.png` - Access Control page
- [ ] `lab-06-step-05-debug-mode.png` - Debug mode enabled

### Lab 07 - Deployment (4 images needed)
- [ ] `lab-07-step-01-export-menu.png` - Export location
- [ ] `lab-07-step-02-export-dialog.png` - Export options
- [ ] `lab-07-step-03-import-wizard.png` - Import wizard
- [ ] `lab-07-step-04-install-scripts.png` - Supporting objects

---

## Automation Scripts

### Batch Rename Screenshots

If you have multiple screenshots on Desktop:

```bash
#!/bin/bash
# rename-screenshots.sh

LAB_NUM="01"
START_NUM=1

cd ~/Desktop
for file in Screenshot*.png; do
    if [ -f "$file" ]; then
        NEW_NAME="lab-${LAB_NUM}-step-$(printf "%02d" $START_NUM)-description.png"
        mv "$file" "$NEW_NAME"
        echo "Renamed: $file → $NEW_NAME"
        ((START_NUM++))
    fi
done
```

### Move to Correct Folder

```bash
#!/bin/bash
# move-to-labs.sh

LAB_NUM="01"
SOURCE_DIR=~/Desktop
DEST_DIR=~/Desktop/apex/labs/images/lab-${LAB_NUM}

mv ${SOURCE_DIR}/lab-${LAB_NUM}-*.png ${DEST_DIR}/
echo "Moved Lab ${LAB_NUM} screenshots to ${DEST_DIR}"
```

### Compress Images

```bash
#!/bin/bash
# compress-images.sh

cd ~/Desktop/apex/labs/images

# Install ImageMagick first: brew install imagemagick

for img in **/*.png; do
    echo "Compressing $img..."
    mogrify -format png -quality 85 "$img"
done

echo "All images compressed!"
```

---

## Testing Your Images

### 1. Preview in VS Code
- Open the lab markdown file
- Press **Cmd+Shift+V** (Preview)
- Check if images display correctly

### 2. Check File Paths
```bash
# From labs directory
cd ~/Desktop/apex/labs
find . -name "*.png" -type f
```

### 3. Verify Image Sizes
```bash
# Check image file sizes
du -sh images/**/*.png | sort -h

# Images should be under 500KB each
```

### 4. Test Relative Paths

Your lab files are in: `labs/lab-XX-*.md`
Your images are in: `labs/images/lab-XX/*.png`

**Correct relative path:** `images/lab-XX/filename.png`

---

## Common Issues

### Image Not Displaying

**Problem:** `![Alt Text](images/lab-01/screenshot.png)` doesn't show

**Solutions:**
1. Check file exists: `ls images/lab-01/screenshot.png`
2. Check spelling (case-sensitive on Linux)
3. Use correct relative path
4. Verify file extension (`.png` not `.PNG`)

### Image Too Large

**Problem:** Image file is 2MB+

**Solutions:**
1. Compress using ImageMagick
2. Reduce resolution (1920x1080 max)
3. Save as PNG with lower quality
4. Crop unnecessary areas

### Wrong Image Showing

**Problem:** Copied wrong screenshot

**Solutions:**
1. Delete incorrect file: `rm images/lab-01/wrong-image.png`
2. Recapture correct screenshot
3. Save with correct name
4. Refresh markdown preview

---

## Best Practices Summary

✅ **DO:**
- Name files descriptively (`lab-01-step-05-object-browser-empty.png`)
- Save to correct lab folder
- Add captions with figure numbers
- Compress images before committing
- Use consistent screenshot dimensions
- Show full context (navigation, titles)

❌ **DON'T:**
- Use generic names (`screenshot1.png`, `image.png`)
- Mix images between labs
- Include personal/sensitive data
- Save uncompressed 5MB images
- Forget to add alt text
- Capture dark mode (use light theme)

---

## Need Help?

- Check `images/README.md` for detailed guidelines
- See examples in existing lab files
- Ask training team for screenshot templates

---

**Last Updated:** November 16, 2025
