#!/usr/bin/env python3
"""
Push CV project to GitHub
Handles git initialization, commits, and GitHub push
"""

import os
import sys
import subprocess
from pathlib import Path

def run_command(cmd, check=True, capture_output=False):
    """Run a shell command"""
    try:
        if capture_output:
            result = subprocess.run(cmd, shell=True, check=check, capture_output=True, text=True)
            return result.stdout.strip()
        else:
            result = subprocess.run(cmd, shell=True, check=check)
            return result.returncode == 0
    except subprocess.CalledProcessError as e:
        if check:
            print(f"❌ Command failed: {cmd}")
            print(f"   Error: {e}")
            return False
        return False

def main():
    print("════════════════════════════════════════════════════════════════")
    print("🚀 CV Project - GitHub Push Script")
    print("════════════════════════════════════════════════════════════════")
    print()

    # Check we're in the right directory
    if not Path("CV.tex").exists() or not Path("Resume.tex").exists():
        print("❌ ERROR: CV.tex and Resume.tex not found!")
        print("   Please run this script from the cv-new directory")
        sys.exit(1)

    # Step 1: Initialize git
    print("📋 Step 1: Initializing git repository...")
    if not Path(".git").exists():
        if not run_command("git init"):
            print("⚠️  Could not initialize git with standard method")
            print("   Trying alternative initialization...")
            # Try to initialize with explicit config
            run_command("git init --initial-branch=main", check=False)
        if Path(".git").exists():
            print("✓ Git repository initialized")
        else:
            print("⚠️  Git initialization may have issues due to permissions")
            print("   Attempting to continue...")
    else:
        print("✓ Git repository already exists")

    # Step 2: Configure git
    print()
    print("📋 Step 2: Configuring git user...")
    run_command('git config user.email "tymo77@gmail.com"', check=False)
    run_command('git config user.name "Tyler Morrison"', check=False)
    print("✓ Git user configured")

    # Step 3: Show status
    print()
    print("📋 Step 3: Current git status:")
    print()
    run_command("git status", check=False)
    print()

    # Step 4: Stage files
    print("📋 Step 4: Staging files...")
    run_command("git add .", check=False)
    print("✓ Files staged")

    # Step 5: Show what will be committed
    print()
    print("📋 Step 5: Files to be committed:")
    print()
    files = run_command("git diff --cached --name-only", capture_output=True, check=False)
    file_list = files.split('\n') if files else []
    for f in file_list[:20]:
        if f:
            print(f"  + {f}")
    if len(file_list) > 20:
        print(f"  ... and {len(file_list) - 20} more files")
    print()

    # Step 6: Create commit
    print("📋 Step 6: Creating commit...")
    commit_msg = """Initial commit: Remove photo and fix layout

- Removed photo from CV.tex and Resume.tex
- Fixed overlapping text in Experience section
- Adjusted spacing throughout document (mycv.cls)
- CV: 4 pages (full academic CV with all sections)
- Resume: 2 pages (condensed professional summary - enforced!)
- Added Makefile for easy compilation
- Added pre-commit hooks for Resume page limit verification
- Comprehensive documentation for build and GitHub setup"""

    if run_command(f'git commit -m "{commit_msg}"', check=False):
        print("✓ Commit created")
    else:
        print("⚠️  Commit may have failed (possibly no changes to commit)")

    # Step 7: Setup remote and push
    print()
    print("📋 Step 7: Pushing to GitHub...")
    print()

    # Try GitHub CLI first
    if subprocess.run("which gh", shell=True, capture_output=True).returncode == 0:
        print("✓ GitHub CLI found")

        # Check auth
        auth_status = subprocess.run("gh auth status", shell=True, capture_output=True, text=True)
        if auth_status.returncode == 0:
            print("✓ GitHub CLI authenticated")
            print()
            print("Creating repository and pushing...")
            if run_command("gh repo create cv-new --source=. --remote=origin --push", check=False):
                print()
                print("✅ Successfully pushed to GitHub!")
                print("   Repository URL: https://github.com/tymo77/cv-new")
            else:
                print("⚠️  gh repo create failed")
                print("   Trying manual push...")
                setup_manual_push()
        else:
            print("⚠️  GitHub CLI not authenticated")
            print("   Run: gh auth login")
            setup_manual_push()
    else:
        print("GitHub CLI not found. Using manual setup...")
        setup_manual_push()

    # Step 8: Configure hooks
    print()
    print("📋 Step 8: Setting up pre-commit hooks...")
    run_command("git config core.hooksPath .githooks", check=False)
    print("✓ Pre-commit hooks configured")

    print()
    print("════════════════════════════════════════════════════════════════")
    print("✅ COMPLETE!")
    print("════════════════════════════════════════════════════════════════")
    print()
    print("📚 Next steps:")
    print("   1. Verify your repo on GitHub: https://github.com/tymo77/cv-new")
    print("   2. To build locally: make all")
    print("   3. To check Resume pages: make check-resume-pages")
    print()
    print("📖 Documentation:")
    print("   - SETUP_HOOKS.md - Build and hook setup")
    print("   - GITHUB_SETUP.md - GitHub configuration")
    print("   - CHANGES.md - Detailed change log")
    print()

def setup_manual_push():
    """Setup manual GitHub push"""
    print()
    github_user = input("Enter your GitHub username (default: tymo77): ").strip() or "tymo77"

    repo_url = f"https://github.com/{github_user}/cv-new.git"

    print()
    print(f"Setting remote to: {repo_url}")

    run_command(f'git remote add origin "{repo_url}"', check=False)
    run_command("git remote set-url origin " + repo_url, check=False)
    run_command("git branch -M main", check=False)

    print()
    print("Attempting to push...")
    if run_command("git push -u origin main", check=False):
        print()
        print("✅ Successfully pushed to GitHub!")
        print(f"   Repository URL: https://github.com/{github_user}/cv-new")
    else:
        print()
        print("⚠️  Push may have failed. Try:")
        print("   git push -u origin main")

if __name__ == "__main__":
    main()
