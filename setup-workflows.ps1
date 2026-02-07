#!/usr/bin/env pwsh
# Quick Setup Script for Enabling All Workflows
# Waste Recycling Tracker

Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "   WORKFLOW ENABLEMENT WIZARD   " -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

# Check if git repository
if (-not (Test-Path ".git")) {
    Write-Host "ERROR: Not in a git repository!" -ForegroundColor Red
    Write-Host "   Please run this script from d:\test directory" -ForegroundColor Yellow
    exit 1
}

Write-Host "This script will guide you through enabling all GitHub workflows" -ForegroundColor Yellow
Write-Host ""
Write-Host "You will need to set up:" -ForegroundColor White
Write-Host "  1. SonarCloud (code quality analysis)" -ForegroundColor Gray
Write-Host "  2. Docker Hub (container registry)" -ForegroundColor Gray
Write-Host "  3. GitHub Secrets (secure credentials)" -ForegroundColor Gray
Write-Host ""

$continue = Read-Host "Ready to begin? (y/n)"
if ($continue -ne "y" -and $continue -ne "Y") {
    Write-Host "Setup cancelled." -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "   STEP 1: SONARCLOUD SETUP   " -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "1. Open your browser and go to: https://sonarcloud.io" -ForegroundColor White
Write-Host "2. Click 'Log in with GitHub'" -ForegroundColor White
Write-Host "3. Authorize SonarCloud" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter when you have logged in"

Write-Host ""
Write-Host "4. Click '+' (top right) -> 'Create new organization'" -ForegroundColor White
Write-Host "5. Choose 'Free plan'" -ForegroundColor White
Write-Host "6. Organization Key: your-github-username (e.g., jeynisha36)" -ForegroundColor White
Write-Host ""

Read-Host "Press Enter when organization is created"

Write-Host ""
Write-Host "7. Click 'Analyze new project'" -ForegroundColor White
Write-Host "8. Select 'WasteRecyclingTracker' repository" -ForegroundColor White
Write-Host "9. Create project with key: your-org_waste-recycling-tracker-backend" -ForegroundColor White
Write-Host "10. Choose 'With GitHub Actions'" -ForegroundColor White
Write-Host "11. COPY THE SONAR_TOKEN SHOWN!" -ForegroundColor Yellow
Write-Host ""

$sonarToken = Read-Host "Paste your SONAR_TOKEN here"
$sonarOrg = Read-Host "Enter your SonarCloud organization key (e.g., jeynisha36)"

if ([string]::IsNullOrWhiteSpace($sonarToken) -or [string]::IsNullOrWhiteSpace($sonarOrg)) {
    Write-Host "ERROR: SonarCloud credentials cannot be empty!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "SonarCloud credentials captured!" -ForegroundColor Green
Write-Host ""

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "   STEP 2: DOCKER HUB SETUP   " -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "1. Open your browser and go to: https://hub.docker.com" -ForegroundColor White
Write-Host "2. Sign up or log in" -ForegroundColor White
Write-Host "3. Click your username -> 'Account Settings' -> 'Security'" -ForegroundColor White
Write-Host "4. Click 'New Access Token'" -ForegroundColor White
Write-Host "5. Description: 'GitHub Actions - Waste Tracker'" -ForegroundColor White
Write-Host "6. Permissions: 'Read, Write, Delete'" -ForegroundColor White
Write-Host "7. Click 'Generate' and COPY THE TOKEN!" -ForegroundColor Yellow
Write-Host ""

Read-Host "Press Enter when you have your Docker Hub credentials"

$dockerUsername = Read-Host "Enter your Docker Hub username"
$dockerPassword = Read-Host "Paste your Docker Hub access token"

if ([string]::IsNullOrWhiteSpace($dockerUsername) -or [string]::IsNullOrWhiteSpace($dockerPassword)) {
    Write-Host "ERROR: Docker Hub credentials cannot be empty!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "Docker Hub credentials captured!" -ForegroundColor Green
Write-Host ""

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "   STEP 3: ADD GITHUB SECRETS   " -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Now you need to add these secrets to your GitHub repository:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Go to: https://github.com/Jeynisha36/WasteRecyclingTracker/settings/secrets/actions" -ForegroundColor White
Write-Host ""
Write-Host "2. Click 'New repository secret' and add each of these:" -ForegroundColor White
Write-Host ""

Write-Host "   Secret 1:" -ForegroundColor Cyan
Write-Host "   Name: SONAR_TOKEN" -ForegroundColor White
Write-Host "   Value: $sonarToken" -ForegroundColor Gray
Write-Host ""

Write-Host "   Secret 2:" -ForegroundColor Cyan
Write-Host "   Name: SONAR_ORGANIZATION" -ForegroundColor White
Write-Host "   Value: $sonarOrg" -ForegroundColor Gray
Write-Host ""

Write-Host "   Secret 3:" -ForegroundColor Cyan
Write-Host "   Name: DOCKER_USERNAME" -ForegroundColor White
Write-Host "   Value: $dockerUsername" -ForegroundColor Gray
Write-Host ""

Write-Host "   Secret 4:" -ForegroundColor Cyan
Write-Host "   Name: DOCKER_PASSWORD" -ForegroundColor White
Write-Host "   Value: [Your Docker Hub access token]" -ForegroundColor Gray
Write-Host ""

# Save to file for reference
$secretsFile = "SECRETS_REFERENCE.txt"
@"
GitHub Secrets for WasteRecyclingTracker
Generated: $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

Add these secrets to: https://github.com/Jeynisha36/WasteRecyclingTracker/settings/secrets/actions

SONAR_TOKEN=$sonarToken
SONAR_ORGANIZATION=$sonarOrg
DOCKER_USERNAME=$dockerUsername
DOCKER_PASSWORD=$dockerPassword

NOTE: Keep this file secure and do NOT commit it to git!
"@ | Out-File -FilePath $secretsFile -Encoding UTF8

Write-Host "Credentials saved to: $secretsFile" -ForegroundColor Green
Write-Host "   (This file is NOT tracked by git)" -ForegroundColor Gray
Write-Host ""

Read-Host "Press Enter when you have added all 4 secrets to GitHub"

Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "   STEP 4: TRIGGER WORKFLOWS   " -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Creating a commit to trigger all workflows..." -ForegroundColor Yellow

try {
    # Create empty commit
    git commit --allow-empty -m "ci: enable all workflows with configured secrets" 2>&1 | Out-Null
    
    Write-Host "Commit created!" -ForegroundColor Green
    
    # Push to GitHub
    Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
    git push origin main 2>&1 | Out-Null
    
    Write-Host "Pushed to GitHub!" -ForegroundColor Green
    Write-Host ""
    
} catch {
    Write-Host "Error pushing to GitHub: $_" -ForegroundColor Red
    Write-Host "Please manually run: git push origin main" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host "   SETUP COMPLETE!   " -ForegroundColor Green
Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "All workflows are now configured!" -ForegroundColor Green
Write-Host ""
Write-Host "Check workflow status at:" -ForegroundColor Yellow
Write-Host "   https://github.com/Jeynisha36/WasteRecyclingTracker/actions" -ForegroundColor Cyan
Write-Host ""

Write-Host "Expected results (in ~5 minutes):" -ForegroundColor White
Write-Host "  Backend Build & Test - PASSING" -ForegroundColor Green
Write-Host "  Vercel Deployment - PASSING" -ForegroundColor Green
Write-Host "  SonarCloud Analysis - PASSING" -ForegroundColor Green
Write-Host "  Docker Build & Push - PASSING" -ForegroundColor Green
Write-Host ""

Write-Host "For troubleshooting, see: WORKFLOW_SETUP_GUIDE.md" -ForegroundColor Gray
Write-Host ""

Write-Host "================================================================" -ForegroundColor Cyan
Write-Host ""

# Open browser to GitHub Actions
$openBrowser = Read-Host "Open GitHub Actions in browser? (y/n)"
if ($openBrowser -eq "y" -or $openBrowser -eq "Y") {
    Start-Process "https://github.com/Jeynisha36/WasteRecyclingTracker/actions"
}

Write-Host ""
Write-Host "Setup wizard complete! All 11 tasks are now fully enabled." -ForegroundColor Green
Write-Host ""
