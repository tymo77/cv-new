# Pushing to GitHub

Due to filesystem permission restrictions in this environment, here are the manual steps to push this project to GitHub:

## Option 1: Using GitHub CLI (Easiest)

```bash
# From the project directory:
cd ~/projects/cv-new

# Create a new repository on GitHub
gh repo create cv-new --source=. --remote=origin --push

# Or if the repo already exists:
gh repo clone <your-username>/cv-new
# Copy the files into it and push
```

## Option 2: Manual git initialization

```bash
cd ~/projects/cv-new

# Initialize git (may require sudo if permissions are restricted)
git init

# Configure user
git config user.email "tymo77@gmail.com"
git config user.name "Tyler Morrison"

# Stage all files
git add .

# Create initial commit
git commit -m "Initial commit: CV and Resume without photo

- Removed photo from both CV.tex and Resume.tex
- Fixed text overlap issues in Experience section by adjusting spacing
- Added Makefile for easy compilation
- Added pre-commit hook for Resume 2-page limit enforcement
- CV: 4 pages (full CV with all sections)
- Resume: 2 pages (condensed professional summary)"

# Add remote and push
git remote add origin https://github.com/<your-username>/cv-new.git
git branch -M main
git push -u origin main
```

## What to push

Make sure these files are included:

- `CV.tex` - Full CV (no photo)
- `Resume.tex` - 2-page resume (no photo)
- `mycv.cls` - Custom CV class with adjusted spacing
- `Makefile` - Build automation
- `SETUP_HOOKS.md` - Setup documentation
- `GITHUB_SETUP.md` - This file
- `.githooks/pre-commit-check-resume-pages*` - Optional page count checks
- All `.tex` files in `sections/` and `select_sections/`
- `fonts/` directory
- `.gitignore`

## .gitignore recommendations

Make sure to ignore build artifacts. Current `.gitignore` should include:

```
*.aux
*.log
*.out
*.fls
*.fdb_latexmk
*.pdf
.DS_Store
```

If you want to track the PDFs, remove `*.pdf` from .gitignore.