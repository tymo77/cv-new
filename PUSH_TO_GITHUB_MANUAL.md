# Manual GitHub Push Instructions

Due to filesystem permission restrictions in the build environment, you'll need to push the project to GitHub manually from your local machine.

## Files Ready for Push

All the following files in `/Users/tylermorrison/projects/cv-new/` are ready to push:

**Source Files:**
- `CV.tex` - Full CV (4 pages, no photo)
- `Resume.tex` - 2-page resume (no photo)
- `mycv.cls` - Custom CV class with updated spacing
- `fontawesome.sty` - FontAwesome styling
- `fonts/` - All font files
- `sections/` - All CV sections
- `select_sections/` - Resume sections
- `images/` - Image files (photos still included for reference)

**Build & Configuration:**
- `Makefile` - Compilation automation
- `.githooks/pre-commit-check-resume-pages` - Bash hook for page verification
- `.githooks/pre-commit-check-resume-pages.py` - Python hook for page verification

**Documentation:**
- `README.md` - Existing project readme
- `SETUP_HOOKS.md` - Setup guide
- `GITHUB_SETUP.md` - GitHub configuration instructions
- `CHANGES.md` - Detailed changelog
- `.gitignore` - Git ignore rules

**Generated PDFs:**
- `CV.pdf` - Final compiled CV (201 KB)
- `Resume.pdf` - Final compiled Resume (202 KB)

## Step-by-Step Push Instructions

### Option 1: Using GitHub CLI (Recommended)

If you have `gh` installed and authenticated:

```bash
cd ~/projects/cv-new
gh repo create cv-new --source=. --remote=origin --push
```

That's it! Your repo will be created and pushed automatically.

### Option 2: Manual Git Push

**Step 1: Initialize Git**
```bash
cd ~/projects/cv-new
git init
git config user.email "tymo77@gmail.com"
git config user.name "Tyler Morrison"
```

**Step 2: Add All Files**
```bash
git add .
```

**Step 3: Create Initial Commit**
```bash
git commit -m "Initial commit: Remove photo and fix layout

- Removed photo from CV.tex and Resume.tex
- Fixed overlapping text in Experience section
- Adjusted spacing throughout document
- CV: 4 pages (full academic CV)
- Resume: 2 pages (enforced with hooks)
- Added Makefile for easy compilation
- Added pre-commit hooks for page validation
- Comprehensive build documentation"
```

**Step 4: Create GitHub Repository**

Go to https://github.com/new and create a new repository named `cv-new`

**Step 5: Add Remote and Push**
```bash
# Use your actual GitHub username here
git remote add origin https://github.com/tymo77/cv-new.git
git branch -M main
git push -u origin main
```

**Step 6: Configure Git Hooks** (Optional but recommended)
```bash
git config core.hooksPath .githooks
```

Now every time you try to commit a change that affects `Resume.pdf`, the hook will verify it's still 2 pages.

### Option 3: Using SSH (if configured)

```bash
cd ~/projects/cv-new
git init
git config user.email "tymo77@gmail.com"
git config user.name "Tyler Morrison"
git add .
git commit -m "Initial commit: Remove photo and fix layout..."
git remote add origin git@github.com:tymo77/cv-new.git
git branch -M main
git push -u origin main
git config core.hooksPath .githooks
```

## What Happens Next

Once pushed:

1. **GitHub Repository**: Your CV will be available at https://github.com/tymo77/cv-new
2. **Built PDFs**: CV.pdf and Resume.pdf will be in the repository
3. **Easy Updates**: Future changes can be pushed with:
   ```bash
   git add CV.tex Resume.tex mycv.cls
   git commit -m "Description of changes"
   git push
   ```

## Building Locally

After cloning or pulling updates:

```bash
# Build both CVs
make all

# Or individually
make cv        # Build CV.pdf (4 pages)
make resume    # Build Resume.pdf (2 pages)

# Verify Resume is 2 pages
make check-resume-pages

# Clean build artifacts
make clean

# Full rebuild
make rebuild
```

## Important Notes

### Resume Must Stay 2 Pages

The Resume is enforced to always be 2 pages. If it grows beyond 2 pages:

1. Edit spacing in `mycv.cls`
2. Or reduce content in `select_sections/` files
3. Recompile: `xelatex -interaction=nonstopmode Resume.tex`
4. Verify: `make check-resume-pages`

### PDFs in Git

By default, `.gitignore` is configured to NOT track PDF files. If you want to track them:

1. Edit `.gitignore` and remove or comment out `*.pdf`
2. Run: `git add CV.pdf Resume.pdf`
3. Commit and push

Recommended: Keep PDFs tracked so they're always available in GitHub.

## Troubleshooting

### Authentication Issues

If `git push` fails with authentication errors:

```bash
# Try HTTPS (will prompt for personal access token)
git remote set-url origin https://github.com/tymo77/cv-new.git
git push -u origin main

# Or setup SSH
git remote set-url origin git@github.com:tymo77/cv-new.git
git push -u origin main
```

### Push Fails - Repository Doesn't Exist

Make sure you created the repository on GitHub first:
https://github.com/new

### Large File Warnings

If you get warnings about large files, ignore them. The PDFs are about 200KB each which is fine for GitHub.

### Credential Caching

To avoid entering credentials repeatedly:

```bash
# For HTTPS
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

# For SSH (recommended)
# Setup SSH keys on GitHub (https://github.com/settings/keys)
```

## Next Steps

1. Push to GitHub using one of the options above
2. Verify the repository at https://github.com/tymo77/cv-new
3. Share the link with employers, collaborators, etc.
4. For any changes: `git add .`, `git commit -m "..."`, `git push`

## Questions?

If you run into issues, check:
- GitHub CLI: `gh auth status` (needs `gh auth login`)
- Git config: `git config -l` (shows current configuration)
- SSH setup: `ssh -T git@github.com` (tests GitHub SSH connection)
