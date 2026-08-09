#!/bin/bash
# One-command GitHub push using gh CLI
# Run this in a separate shell: bash gh-push.sh

set -e

cd "$(dirname "$0")"

echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║           GitHub Push via gh CLI - All in One                 ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Check gh is installed
echo "📋 Checking GitHub CLI..."
if ! command -v gh &> /dev/null; then
    echo "❌ ERROR: 'gh' command not found"
    echo "   Install from: https://cli.github.com"
    exit 1
fi
echo "✓ GitHub CLI found"

# Step 2: Check authentication
echo ""
echo "📋 Checking GitHub authentication..."
if ! gh auth status &> /dev/null 2>&1; then
    echo "⚠️  Not authenticated with GitHub"
    echo ""
    echo "Do you want to log in now? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        echo ""
        echo "Opening GitHub login..."
        echo ""
        gh auth login -p https || {
            echo ""
            echo "❌ Login failed due to SSL issues"
            echo "   Try running in a different terminal or use a Personal Access Token:"
            echo ""
            echo "   export GH_TOKEN='your_token_here'"
            echo "   bash gh-push.sh"
            exit 1
        }
    else
        echo ""
        echo "Authentication required. Try:"
        echo "  gh auth login"
        echo "Then run this script again."
        exit 1
    fi
fi

# Get auth info
AUTH_USER=$(gh auth status 2>&1 | grep "Logged in to" | awk '{print $4}' || echo "unknown")
echo "✓ Authenticated as: $AUTH_USER"

# Step 3: Check if repo exists
echo ""
echo "📋 Checking if repository exists..."
if gh repo view cv-new &> /dev/null; then
    echo "⚠️  Repository 'cv-new' already exists"
    echo ""
    echo "Do you want to push to existing repo? (y/n)"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Aborting."
        exit 0
    fi
    REPO_EXISTS=1
else
    echo "✓ Repository doesn't exist (will create it)"
    REPO_EXISTS=0
fi

# Step 4: Initialize git if needed
echo ""
echo "📋 Setting up git repository..."
if [ ! -d ".git" ]; then
    git init --initial-branch=main 2>/dev/null || git init 2>/dev/null
    git config user.email "tymo77@gmail.com"
    git config user.name "Tyler Morrison"
    echo "✓ Git repository initialized"
else
    echo "✓ Git repository already exists"
fi

# Step 5: Stage and commit
echo ""
echo "📋 Preparing files for commit..."
git add -A

# Check if there are changes
if ! git diff --cached --quiet; then
    echo "✓ Files staged"

    echo ""
    echo "📋 Creating commit..."
    if git commit -m "Initial commit: Remove photo and fix layout

- Removed photo from CV.tex and Resume.tex
- Fixed overlapping text in Experience section
- Adjusted spacing throughout document (mycv.cls)
- CV: 4 pages (full academic CV with all sections)
- Resume: 2 pages (condensed professional summary - enforced!)
- Added Makefile for easy compilation
- Added pre-commit hooks for Resume page limit verification
- Comprehensive documentation for build and GitHub setup" 2>&1 | grep -v "^#"; then
        echo "✓ Commit created"
    else
        echo "ℹ️  No changes to commit"
    fi
else
    echo "ℹ️  No changes to stage"
fi

# Step 6: Create or update repository
echo ""
if [ $REPO_EXISTS -eq 0 ]; then
    echo "📋 Creating repository on GitHub..."
    gh repo create cv-new --source=. --remote=origin --push --public 2>&1 | grep -v "^#" || {
        echo "⚠️  repo create with --push failed, trying alternative method..."

        # Try without source/push
        gh repo create cv-new --public || {
            echo "❌ Failed to create repository"
            exit 1
        }

        # Add remote and push manually
        git remote add origin "https://github.com/tymo77/cv-new.git" 2>/dev/null || \
            git remote set-url origin "https://github.com/tymo77/cv-new.git"

        git branch -M main 2>/dev/null || true

        echo ""
        echo "📋 Pushing to GitHub..."
        git push -u origin main
    }
else
    echo "📋 Pushing to existing repository..."
    git branch -M main 2>/dev/null || true
    git push -u origin main 2>&1 | grep -v "^#"
fi

# Step 7: Configure hooks
echo ""
echo "📋 Setting up git hooks..."
git config core.hooksPath .githooks
echo "✓ Git hooks configured"

# Step 8: Success!
echo ""
echo "╔════════════════════════════════════════════════════════════════╗"
echo "║                  ✅ SUCCESS!                                   ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "🎉 Your CV is now on GitHub!"
echo ""
echo "📚 Repository: https://github.com/tymo77/cv-new"
echo ""
echo "📄 Files:"
echo "   • CV: https://github.com/tymo77/cv-new/blob/main/CV.pdf"
echo "   • Resume: https://github.com/tymo77/cv-new/blob/main/Resume.pdf"
echo ""
echo "🔗 View your repo: https://github.com/tymo77/cv-new"
echo ""
echo "📋 Next time you update:"
echo "   git add -A"
echo "   git commit -m 'Description'"
echo "   git push"
echo ""
