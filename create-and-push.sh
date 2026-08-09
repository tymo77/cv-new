#!/bin/bash
# Create GitHub repo and push using gh CLI
# This script handles authentication and initialization

set -e

cd "$(dirname "$0")"

echo "════════════════════════════════════════════════════════════════"
echo "🚀 Creating GitHub Repo and Pushing"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Check if we have git
if ! command -v git &> /dev/null; then
    echo "❌ git is not installed"
    exit 1
fi

# Check if we have gh
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI (gh) is not installed"
    echo "   Install from: https://cli.github.com/"
    exit 1
fi

echo "📋 Checking GitHub authentication..."
if ! gh auth status &> /dev/null; then
    echo ""
    echo "⚠️  GitHub CLI not authenticated"
    echo "   Please run: gh auth login"
    echo ""
    echo "   Then try again: bash create-and-push.sh"
    exit 1
fi

echo "✓ GitHub CLI authenticated"
echo ""

# Initialize git if needed
echo "📋 Setting up git repository..."
if [ ! -d ".git" ]; then
    echo "Initializing git..."
    git init --initial-branch=main 2>/dev/null || git init 2>/dev/null
    git config user.email "tymo77@gmail.com"
    git config user.name "Tyler Morrison"
    echo "✓ Git initialized"
else
    echo "✓ Git repository already exists"
fi

echo ""
echo "📋 Staging all files..."
git add -A
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
- Comprehensive documentation for build and GitHub setup" 2>/dev/null; then
    echo "✓ Commit created"
else
    echo "ℹ️  Commit already exists or no changes to commit"
fi

echo ""
echo "📋 Creating GitHub repository..."
echo ""

# Try to create and push with gh
if gh repo create cv-new --source=. --remote=origin --push 2>&1; then
    echo ""
    echo "✅ SUCCESS! Repository created and pushed!"
    echo ""
    echo "📚 Repository URL: https://github.com/tymo77/cv-new"
    echo ""
    echo "🔗 Direct links:"
    echo "   CV: https://github.com/tymo77/cv-new/blob/main/CV.pdf"
    echo "   Resume: https://github.com/tymo77/cv-new/blob/main/Resume.pdf"
    echo ""
    echo "📋 Setting up git hooks..."
    git config core.hooksPath .githooks
    echo "✓ Git hooks configured"
    echo ""
    echo "════════════════════════════════════════════════════════════════"
    echo "✨ Project successfully pushed to GitHub!"
    echo "════════════════════════════════════════════════════════════════"
else
    echo ""
    echo "⚠️  'gh repo create' with --push failed"
    echo ""
    echo "Trying alternative approach..."
    echo ""

    # Try creating repo without push first
    if gh repo create cv-new --private 2>/dev/null; then
        echo "✓ Repository created on GitHub"

        # Add remote and push manually
        git remote add origin "https://github.com/tymo77/cv-new.git" 2>/dev/null || \
            git remote set-url origin "https://github.com/tymo77/cv-new.git"

        git branch -M main

        echo ""
        echo "📋 Pushing to GitHub..."
        if git push -u origin main; then
            echo ""
            echo "✅ SUCCESS! Pushed to GitHub!"
            echo ""
            echo "📚 Repository URL: https://github.com/tymo77/cv-new"

            git config core.hooksPath .githooks
            echo "✓ Git hooks configured"
        else
            echo ""
            echo "❌ Push failed"
            echo "   Try manually: git push -u origin main"
            exit 1
        fi
    else
        echo "❌ Could not create repository"
        echo ""
        echo "Possible reasons:"
        echo "  1. GitHub CLI not authenticated (run: gh auth login)"
        echo "  2. Repository 'cv-new' already exists on GitHub"
        echo "  3. GitHub API rate limit exceeded"
        echo ""
        echo "Next steps:"
        echo "  1. Login: gh auth login"
        echo "  2. Verify or delete existing repo: https://github.com/tymo77/cv-new"
        echo "  3. Try again: bash create-and-push.sh"
        exit 1
    fi
fi

echo ""
echo "🎉 All done! Your CV is now on GitHub!"
echo ""
