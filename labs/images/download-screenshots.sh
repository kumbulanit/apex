#!/bin/bash

# Download Oracle APEX 23.1 Documentation Screenshots
# This script downloads common screenshots from Oracle documentation

echo "🎯 Downloading Oracle APEX 23.1 Screenshots..."
echo ""

# Create directories if they don't exist
mkdir -p images/{lab-01,lab-02,lab-03,lab-04,lab-05,lab-06,lab-07,common}

BASE_URL="https://docs.oracle.com/en/database/oracle/apex/23.1/htmdb/img"

# Common screenshots
echo "📥 Downloading common screenshots..."
cd images/common

curl -L -s -o apex-logo.png "${BASE_URL}/apex_logo.png" 2>/dev/null && echo "✓ apex-logo.png" || echo "⚠ apex-logo.png (not found)"
curl -L -s -o apex-home.png "${BASE_URL}/apex_home.png" 2>/dev/null && echo "✓ apex-home.png" || echo "⚠ apex-home.png (not found)"
curl -L -s -o workspace-signin.png "${BASE_URL}/workspace_signin.png" 2>/dev/null && echo "✓ workspace-signin.png" || echo "⚠ workspace-signin.png (not found)"
curl -L -s -o sign-in.png "${BASE_URL}/sign_in.png" 2>/dev/null && echo "✓ sign-in.png" || echo "⚠ sign-in.png (not found)"

cd ../..

# Lab 01 - SQL Workshop & Object Browser
echo ""
echo "📥 Downloading Lab 01 screenshots..."
cd images/lab-01

curl -L -s -o lab-01-step-04-sql-workshop.png "${BASE_URL}/sql_workshop.png" 2>/dev/null && echo "✓ SQL Workshop" || echo "⚠ SQL Workshop (not found)"
curl -L -s -o lab-01-step-05-object-browser.png "${BASE_URL}/object_browser.png" 2>/dev/null && echo "✓ Object Browser" || echo "⚠ Object Browser (not found)"
curl -L -s -o lab-01-step-07-create-table.png "${BASE_URL}/create_table.png" 2>/dev/null && echo "✓ Create Table" || echo "⚠ Create Table (not found)"
curl -L -s -o lab-01-step-09-sql-commands.png "${BASE_URL}/sql_commands.png" 2>/dev/null && echo "✓ SQL Commands" || echo "⚠ SQL Commands (not found)"

cd ../..

# Lab 02 - App Builder
echo ""
echo "📥 Downloading Lab 02 screenshots..."
cd images/lab-02

curl -L -s -o lab-02-step-01-app-builder-home.png "${BASE_URL}/app_builder_home.png" 2>/dev/null && echo "✓ App Builder Home" || echo "⚠ App Builder Home (not found)"
curl -L -s -o lab-02-step-04-app-wizard.png "${BASE_URL}/create_app_wizard.png" 2>/dev/null && echo "✓ Create App Wizard" || echo "⚠ Create App Wizard (not found)"
curl -L -s -o lab-02-step-08-application-home.png "${BASE_URL}/application_home.png" 2>/dev/null && echo "✓ Application Home" || echo "⚠ Application Home (not found)"
curl -L -s -o lab-02-step-03-create-page.png "${BASE_URL}/create_page.png" 2>/dev/null && echo "✓ Create Page" || echo "⚠ Create Page (not found)"

cd ../..

# Lab 03 - Page Designer
echo ""
echo "📥 Downloading Lab 03 screenshots..."
cd images/lab-03

curl -L -s -o lab-03-step-01-page-designer.png "${BASE_URL}/page_designer.png" 2>/dev/null && echo "✓ Page Designer" || echo "⚠ Page Designer (not found)"
curl -L -s -o lab-03-step-02-left-pane.png "${BASE_URL}/pd_left_pane.png" 2>/dev/null && echo "✓ Left Pane" || echo "⚠ Left Pane (not found)"
curl -L -s -o lab-03-step-03-center-pane.png "${BASE_URL}/pd_center_pane.png" 2>/dev/null && echo "✓ Center Pane" || echo "⚠ Center Pane (not found)"
curl -L -s -o lab-03-step-04-right-pane.png "${BASE_URL}/pd_right_pane.png" 2>/dev/null && echo "✓ Right Pane" || echo "⚠ Right Pane (not found)"
curl -L -s -o lab-03-step-05-create-region.png "${BASE_URL}/create_region.png" 2>/dev/null && echo "✓ Create Region" || echo "⚠ Create Region (not found)"

cd ../..

# Lab 04 - Reports and Forms
echo ""
echo "📥 Downloading Lab 04 screenshots..."
cd images/lab-04

curl -L -s -o lab-04-step-01-interactive-report.png "${BASE_URL}/interactive_report.png" 2>/dev/null && echo "✓ Interactive Report" || echo "⚠ Interactive Report (not found)"
curl -L -s -o lab-04-step-02-ir-actions.png "${BASE_URL}/ir_actions_menu.png" 2>/dev/null && echo "✓ IR Actions" || echo "⚠ IR Actions (not found)"
curl -L -s -o lab-04-step-03-ir-filter.png "${BASE_URL}/ir_filter.png" 2>/dev/null && echo "✓ IR Filter" || echo "⚠ IR Filter (not found)"
curl -L -s -o lab-04-step-05-form-page.png "${BASE_URL}/form_page.png" 2>/dev/null && echo "✓ Form Page" || echo "⚠ Form Page (not found)"
curl -L -s -o lab-04-step-08-modal-dialog.png "${BASE_URL}/modal_dialog.png" 2>/dev/null && echo "✓ Modal Dialog" || echo "⚠ Modal Dialog (not found)"

cd ../..

# Lab 05 - Navigation
echo ""
echo "📥 Downloading Lab 05 screenshots..."
cd images/lab-05

curl -L -s -o lab-05-step-01-nav-menu.png "${BASE_URL}/navigation_menu.png" 2>/dev/null && echo "✓ Navigation Menu" || echo "⚠ Navigation Menu (not found)"
curl -L -s -o lab-05-step-03-lov.png "${BASE_URL}/lov.png" 2>/dev/null && echo "✓ LOV" || echo "⚠ LOV (not found)"
curl -L -s -o lab-05-step-05-dynamic-action.png "${BASE_URL}/dynamic_action.png" 2>/dev/null && echo "✓ Dynamic Action" || echo "⚠ Dynamic Action (not found)"

cd ../..

# Lab 06 - Security
echo ""
echo "📥 Downloading Lab 06 screenshots..."
cd images/lab-06

curl -L -s -o lab-06-step-01-authentication.png "${BASE_URL}/authentication_schemes.png" 2>/dev/null && echo "✓ Authentication" || echo "⚠ Authentication (not found)"
curl -L -s -o lab-06-step-03-authorization.png "${BASE_URL}/authorization_schemes.png" 2>/dev/null && echo "✓ Authorization" || echo "⚠ Authorization (not found)"
curl -L -s -o lab-06-step-04-access-control.png "${BASE_URL}/access_control.png" 2>/dev/null && echo "✓ Access Control" || echo "⚠ Access Control (not found)"

cd ../..

# Lab 07 - Deployment
echo ""
echo "📥 Downloading Lab 07 screenshots..."
cd images/lab-07

curl -L -s -o lab-07-step-02-export-app.png "${BASE_URL}/export_application.png" 2>/dev/null && echo "✓ Export Application" || echo "⚠ Export Application (not found)"
curl -L -s -o lab-07-step-03-import-app.png "${BASE_URL}/import_application.png" 2>/dev/null && echo "✓ Import Application" || echo "⚠ Import Application (not found)"
curl -L -s -o lab-07-step-04-supporting-objects.png "${BASE_URL}/supporting_objects.png" 2>/dev/null && echo "✓ Supporting Objects" || echo "⚠ Supporting Objects (not found)"

cd ../..

echo ""
echo "✅ Download complete!"
echo ""
echo "📊 Summary:"
echo "   - Check images/common/ for shared screenshots"
echo "   - Check images/lab-01/ through images/lab-07/ for lab-specific screenshots"
echo "   - Files marked with ⚠ were not found (Oracle may have different filenames)"
echo ""
echo "💡 Next steps:"
echo "   1. Review downloaded images"
echo "   2. Take custom screenshots for missing images"
echo "   3. Follow naming convention in images/HOW-TO-ADD-SCREENSHOTS.md"
echo ""
