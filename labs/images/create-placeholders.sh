#!/bin/bash

# Create placeholder images for all labs
# These are SVG placeholders that can be replaced with real screenshots later

echo "🎨 Creating placeholder images..."
echo ""

# Function to create SVG placeholder
create_placeholder() {
    local filename=$1
    local width=$2
    local height=$3
    local text=$4
    
    cat > "$filename" << EOF
<svg width="$width" height="$height" xmlns="http://www.w3.org/2000/svg">
  <rect width="100%" height="100%" fill="#f0f0f0"/>
  <rect x="2" y="2" width="$(($width-4))" height="$(($height-4))" fill="white" stroke="#cccccc" stroke-width="2"/>
  <text x="50%" y="50%" font-family="Arial, sans-serif" font-size="18" fill="#666666" text-anchor="middle" dominant-baseline="middle">
    $text
  </text>
  <text x="50%" y="60%" font-family="Arial, sans-serif" font-size="12" fill="#999999" text-anchor="middle" dominant-baseline="middle">
    Replace with actual screenshot
  </text>
</svg>
EOF
    echo "✓ Created: $filename"
}

# Lab 01 placeholders
echo "📁 Lab 01..."
cd images/lab-01
create_placeholder "lab-01-step-01-apex-login.svg" 800 600 "APEX Login Page"
create_placeholder "lab-01-step-02-workspace-signin.svg" 800 600 "Workspace Sign In"
create_placeholder "lab-01-step-03-apex-home.svg" 1200 800 "APEX Home Dashboard"
create_placeholder "lab-01-step-04-sql-workshop.svg" 1200 800 "SQL Workshop Home"
create_placeholder "lab-01-step-05-object-browser-empty.svg" 1200 800 "Object Browser (Empty)"
create_placeholder "lab-01-step-06-create-menu.svg" 400 300 "Create Menu Dropdown"
create_placeholder "lab-01-step-07-create-table-dialog.svg" 800 600 "Create Table Dialog"
create_placeholder "lab-01-step-08-table-columns.svg" 1200 800 "Table Columns View"
create_placeholder "lab-01-step-09-sql-commands.svg" 1200 800 "SQL Commands Interface"
create_placeholder "lab-01-step-10-data-inserted.svg" 1200 600 "Table with Sample Data"

# Lab 02 placeholders
echo "📁 Lab 02..."
cd ../lab-02
create_placeholder "lab-02-step-01-app-builder-home.svg" 1200 800 "App Builder Home"
create_placeholder "lab-02-step-02-create-button.svg" 400 200 "Create Button"
create_placeholder "lab-02-step-03-new-app-option.svg" 600 400 "New Application Option"
create_placeholder "lab-02-step-04-app-wizard-name.svg" 800 600 "Name Your Application"
create_placeholder "lab-02-step-05-add-page-menu.svg" 400 300 "Add Page Menu"
create_placeholder "lab-02-step-06-report-config.svg" 800 600 "Report Configuration"
create_placeholder "lab-02-step-07-app-pages.svg" 1000 600 "Application Pages List"
create_placeholder "lab-02-step-08-application-home.svg" 1200 800 "Application Home Page"
create_placeholder "lab-02-step-09-run-button.svg" 300 150 "Run Button"
create_placeholder "lab-02-step-10-running-app.svg" 1200 800 "Running Application"

# Lab 03 placeholders
echo "📁 Lab 03..."
cd ../lab-03
create_placeholder "lab-03-step-01-page-designer-full.svg" 1400 900 "Page Designer - Full View"
create_placeholder "lab-03-step-02-left-pane.svg" 400 800 "Left Pane (Rendering Tree)"
create_placeholder "lab-03-step-03-center-layout.svg" 800 800 "Center Pane (Layout)"
create_placeholder "lab-03-step-04-right-properties.svg" 400 800 "Right Pane (Properties)"
create_placeholder "lab-03-step-05-create-region.svg" 600 400 "Create Region"
create_placeholder "lab-03-step-06-region-type.svg" 600 400 "Region Type Selector"
create_placeholder "lab-03-step-07-add-item.svg" 600 400 "Add Page Item"
create_placeholder "lab-03-step-08-save-run.svg" 400 200 "Save and Run Buttons"

# Lab 04 placeholders
echo "📁 Lab 04..."
cd ../lab-04
create_placeholder "lab-04-step-01-report-runtime.svg" 1200 800 "Interactive Report Runtime"
create_placeholder "lab-04-step-02-actions-menu.svg" 400 500 "Actions Menu"
create_placeholder "lab-04-step-03-filter-dialog.svg" 600 400 "Filter Dialog"
create_placeholder "lab-04-step-04-columns-dialog.svg" 600 500 "Column Selection"
create_placeholder "lab-04-step-05-form-view.svg" 1000 700 "Form Page View"
create_placeholder "lab-04-step-06-create-button.svg" 300 150 "Create Button"
create_placeholder "lab-04-step-07-edit-form.svg" 1000 700 "Edit Form with Data"
create_placeholder "lab-04-step-08-modal-form.svg" 800 600 "Modal Dialog Form"

# Lab 05 placeholders
echo "📁 Lab 05..."
cd ../lab-05
create_placeholder "lab-05-step-01-nav-menu.svg" 1000 600 "Navigation Menu Editor"
create_placeholder "lab-05-step-02-add-entry.svg" 600 400 "Add Menu Entry"
create_placeholder "lab-05-step-03-lov-setup.svg" 800 600 "LOV Configuration"
create_placeholder "lab-05-step-04-button-props.svg" 600 500 "Button Properties"
create_placeholder "lab-05-step-05-dynamic-action.svg" 1000 600 "Dynamic Action Setup"

# Lab 06 placeholders
echo "📁 Lab 06..."
cd ../lab-06
create_placeholder "lab-06-step-01-auth-schemes.svg" 1000 600 "Authentication Schemes"
create_placeholder "lab-06-step-02-auth-config.svg" 800 600 "Authentication Configuration"
create_placeholder "lab-06-step-03-authz-schemes.svg" 1000 600 "Authorization Schemes"
create_placeholder "lab-06-step-04-access-control.svg" 1200 800 "Access Control Page"
create_placeholder "lab-06-step-05-debug-mode.svg" 1200 800 "Debug Mode Enabled"

# Lab 07 placeholders
echo "📁 Lab 07..."
cd ../lab-07
create_placeholder "lab-07-step-01-export-menu.svg" 400 300 "Export Menu"
create_placeholder "lab-07-step-02-export-dialog.svg" 800 600 "Export Dialog"
create_placeholder "lab-07-step-03-import-wizard.svg" 1000 700 "Import Wizard"
create_placeholder "lab-07-step-04-install-scripts.svg" 1000 600 "Supporting Objects"

# Common placeholders
echo "📁 Common..."
cd ../common
create_placeholder "apex-logo.svg" 200 100 "Oracle APEX Logo"
create_placeholder "save-button.svg" 150 50 "Save Button"
create_placeholder "cancel-button.svg" 150 50 "Cancel Button"
create_placeholder "success-message.svg" 400 100 "Success Message"
create_placeholder "error-message.svg" 400 100 "Error Message"

cd ../..

echo ""
echo "✅ All placeholder images created!"
echo ""
echo "📊 Summary:"
echo "   - 50 placeholder SVG images created"
echo "   - Images are in images/lab-XX/ directories"
echo "   - Replace placeholders with actual screenshots as you capture them"
echo ""
echo "💡 Next steps:"
echo "   1. Labs will now show placeholder images"
echo "   2. Run ./download-screenshots.sh to get Oracle docs images"
echo "   3. Take custom screenshots following HOW-TO-ADD-SCREENSHOTS.md"
echo "   4. Replace SVG placeholders with PNG screenshots"
echo ""
