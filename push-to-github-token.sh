#!/bin/bash
# Push to GitHub using Personal Access Token
# Usage: GH_TOKEN="your_token" bash push-to-github-token.sh

set -e

cd "$(dirname "$0")"

echo "════════════════════════════════════════════════════════════════"
echo "🚀 GitHub Push with Token Authentication"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Check for token
if [ -z "$GH_TOKEN" ]; then
    echo "❌ ERROR: GH_TOKEN environment variable not set"
    echo ""
    echo "Usage:"
    echo "  export GH_TOKEN=\"ghp_xxxxxxxxxxxxxxxxxxxxx\""
    echo "  bash push-to-github-token.sh"
    echo ""
    echo "Or one-liner:"
    echo "  GH_TOKEN=\"ghp_xxxxxxxxxxxxxxxxxxxxx\" bash push-to-github-token.sh"
    echo ""
    echo "Get a token from: https://github.com/settings/tokens"
    exit 1
fi

echo "✓ Using Personal Access Token"
echo ""

# Initialize git if needed
echo "📋 Setting up git repository..."
if [ ! -d ".git" ]; then
    git init --initial-branch=main 2>/dev/null || git init 2>/dev/null
    git config user.email "tymo77@gmail.com"
    git config user.name "Tyler Morrison"
    echo "✓ Git initialized"
else
    echo "✓ Git repository exists"
fi

echo ""
echo "📋 Staging files..."
git add -A
echo "✓ Files staged"

echo ""
echo "📋 Creating commit..."
if ! git commit -m "Initial commit: Remove photo and fix layout

- Removed photo from CV.tex and Resume.tex
- Fixed overlapping text in Experience section
- Adjusted spacing throughout document (mycv.cls)
- CV: 4 pages (full academic CV with all sections)
- Resume: 2 pages (condensed professional summary - enforced!)
- Added Makefile for easy compilation
- Added pre-commit hooks for Resume page limit verification
- Comprehensive documentation for build and GitHub setup" 2>/dev/null; then
    echo "ℹ️  No new changes to commit"
fi
echo "✓ Repository ready"

echo ""
echo "📋 Configuring remote..."

# Remove existing remote if it exists
git remote remove origin 2>/dev/null || true

# Add remote with token
REPO_URL="https://tymo77:${GH_TOKEN}@github.com/tymo77/cv-new.git"
git remote add origin "$REPO_URL"

# Ensure we're on main branch
git branch -M main 2>/dev/null || true

echo "✓ Remote configured"

echo ""
echo "📋 Pushing to GitHub..."
echo ""

if git push -u origin main 2>&1 | grep -v "GH_TOKEN\|tymo77:"; then
    echo ""
    echo "✅ SUCCESS! Pushed to GitHub!"
    echo ""
    echo "Repository: https://github.com/tymo77/cv-new"
    echo ""
    echo "Direct links:"
    echo "  • CV: https://github.com/tymo77/cv-new/blob/main/CV.pdf"
    echo "  • Resume: https://github.com/tymo77/cv-new/blob/main/Resume.pdf"
    echo ""

    # Remove token from remote URL for security
    git remote set-url origin "https://github.com/tymo77/cv-new.git"

    echo "📋 Configuring git hooks..."
    git config core.hooksPath .githooks
    echo "✓ Git hooks configured"

    echo ""
    echo "════════════════════════════════════════════════════════════════"
    echo "✨ Complete! Your CV is on GitHub!"
    echo "════════════════════════════════════════════════════════════════"
    echo ""
    echo "Next time you push, git will ask for credentials:"
    echo "  • Username: tymo77"
    echo "  • Password: your Personal Access Token"
    echo ""
    echo "Or set up credential helper:"
    echo "  git config --global credential.helper osxkeychain"
    echo ""
else
    echo ""
    echo "❌ Push failed"
    echo ""
    echo "Possible reasons:"
    echo "  1. Invalid token (expired or wrong scopes)"
    echo "  2. Repository already exists on GitHub"
    echo "  3. Network issues"
    echo ""
    echo "Solutions:"
    echo "  1. Generate new token: https://github.com/settings/tokens"
    echo "  2. Make sure token has 'repo' scope"
    echo "  3. Try again: GH_TOKEN=\"your_token\" bash push-to-github-token.sh"
    exit 1
fi
