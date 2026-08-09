#!/bin/bash
# Push CV project to GitHub
# This script initializes git, commits changes, and pushes to GitHub

set -e  # Exit on any error

echo "════════════════════════════════════════════════════════════════"
echo "🚀 CV Project - GitHub Push Script"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Check if we're in the right directory
if [ ! -f "CV.tex" ] || [ ! -f "Resume.tex" ]; then
    echo "❌ ERROR: CV.tex and Resume.tex not found!"
    echo "   Please run this script from the cv-new directory"
    exit 1
fi

# Step 1: Initialize git if needed
echo "📋 Step 1: Initializing git repository..."
if [ ! -d ".git" ]; then
    if ! git init 2>/dev/null; then
        echo "⚠️  Could not create .git directory (permission issue)"
        echo "   Attempting to remove stale .git and retry..."
        rm -rf .git 2>/dev/null || true
        git init || {
            echo "❌ Failed to initialize git. You may need to run with elevated privileges."
            echo "   Try: sudo bash $0"
            exit 1
        }
    fi
    echo "✓ Git repository initialized"
else
    echo "✓ Git repository already exists"
fi

# Step 2: Configure git user
echo ""
echo "📋 Step 2: Configuring git user..."
git config user.email "tymo77@gmail.com"
git config user.name "Tyler Morrison"
echo "✓ Git user configured"

# Step 3: Check git status
echo ""
echo "📋 Step 3: Checking git status..."
echo ""
git status
echo ""

# Step 4: Stage all files
echo "📋 Step 4: Staging files..."
git add .
echo "✓ Files staged"

# Step 5: Show what will be committed
echo ""
echo "📋 Step 5: Files to be committed:"
echo ""
git diff --cached --name-only | head -20
if [ $(git diff --cached --name-only | wc -l) -gt 20 ]; then
    echo "... and $(( $(git diff --cached --name-only | wc -l) - 20 )) more files"
fi
echo ""

# Step 6: Create commit
echo "📋 Step 6: Creating commit..."
git commit -m "Initial commit: Remove photo and fix layout

- Removed photo from CV.tex and Resume.tex
- Fixed overlapping text in Experience section
- Adjusted spacing throughout document (mycv.cls)
- CV: 4 pages (full academic CV with all sections)
- Resume: 2 pages (condensed professional summary - enforced!)
- Added Makefile for easy compilation
- Added pre-commit hooks for Resume page limit verification
- Comprehensive documentation for build and GitHub setup"

echo "✓ Commit created"

# Step 7: Get remote URL
echo ""
echo "📋 Step 7: Setting up GitHub remote..."
echo ""
echo "You have two options:"
echo ""
echo "Option A: Using GitHub CLI (easiest)"
echo "  $ gh repo create cv-new --source=. --remote=origin --push"
echo ""
echo "Option B: Manual setup (if gh is not working)"
echo "  $ git remote add origin https://github.com/tymo77/cv-new.git"
echo "  $ git branch -M main"
echo "  $ git push -u origin main"
echo ""
echo "────────────────────────────────────────────────────────────────"
echo ""

# Try GitHub CLI first
if command -v gh &> /dev/null; then
    echo "GitHub CLI found. Attempting to create repo and push..."
    echo ""

    # Check auth status
    if gh auth status &> /dev/null; then
        echo "✓ GitHub CLI authenticated"
        echo ""
        echo "Creating repository and pushing..."
        gh repo create cv-new --source=. --remote=origin --push
        echo ""
        echo "✅ Successfully pushed to GitHub!"
        echo ""
        echo "Repository URL: https://github.com/tymo77/cv-new"
    else
        echo "⚠️  GitHub CLI found but not authenticated"
        echo "   Run: gh auth login"
        echo ""
        echo "Falling back to manual setup..."
        read -p "Enter your GitHub username (default: tymo77): " github_user
        github_user=${github_user:-tymo77}

        git remote add origin "https://github.com/${github_user}/cv-new.git"
        git branch -M main

        echo ""
        echo "Attempting to push..."
        if git push -u origin main; then
            echo ""
            echo "✅ Successfully pushed to GitHub!"
            echo "Repository URL: https://github.com/${github_user}/cv-new"
        else
            echo ""
            echo "❌ Push failed. You may need to:"
            echo "   1. Authenticate: gh auth login"
            echo "   2. Push manually: git push -u origin main"
        fi
    fi
else
    echo "GitHub CLI not found. Using manual setup..."
    echo ""
    read -p "Enter your GitHub username (default: tymo77): " github_user
    github_user=${github_user:-tymo77}

    git remote add origin "https://github.com/${github_user}/cv-new.git" 2>/dev/null || \
        git remote set-url origin "https://github.com/${github_user}/cv-new.git"

    git branch -M main

    echo ""
    echo "Attempting to push..."
    if git push -u origin main; then
        echo ""
        echo "✅ Successfully pushed to GitHub!"
        echo "Repository URL: https://github.com/${github_user}/cv-new"
    else
        echo ""
        echo "❌ Push failed. Try:"
        echo "   git push -u origin main"
    fi
fi

# Step 8: Setup pre-commit hooks
echo ""
echo "📋 Step 8: Setting up pre-commit hooks..."
git config core.hooksPath .githooks
echo "✓ Pre-commit hooks configured"
echo "  The Resume 2-page limit will be checked before each commit"

echo ""
echo "════════════════════════════════════════════════════════════════"
echo "✅ COMPLETE!"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo "📚 Next steps:"
echo "   1. Verify your repo on GitHub"
echo "   2. Share the repo link: https://github.com/tymo77/cv-new"
echo "   3. To build locally: make all"
echo "   4. To check Resume pages: make check-resume-pages"
echo ""
echo "📖 Documentation:"
echo "   - SETUP_HOOKS.md - Build and hook setup"
echo "   - GITHUB_SETUP.md - GitHub configuration"
echo "   - CHANGES.md - Detailed change log"
echo ""
