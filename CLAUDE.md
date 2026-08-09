# CV Project - Codebase Guide

## Project Overview

Professional CV and 2-page Resume built with LaTeX using the Awesome-CV template. Photo has been removed and layout issues fixed. The repository is optimized for easy maintenance and rebuilding.

**Key facts:**
- CV: 4 pages (full academic CV)
- Resume: 2 pages (condensed professional summary, enforced via git hooks)
- Build system: Makefile with automated artifact management
- Source: LaTeX (.tex files)
- Output: PDF files tracked in git

## Architecture

### File Structure

```
cv-new/
├── CV.tex                    # Full CV source
├── Resume.tex                # 2-page Resume source
├── mycv.cls                  # Custom LaTeX class (Awesome-CV based)
├── CV.pdf                    # Generated output (tracked)
├── Resume.pdf                # Generated output (tracked)
│
├── sections/                 # CV content sections
│   ├── education.tex
│   ├── experience_all.tex
│   ├── articles.tex
│   ├── conferences.tex
│   └── ... (11 files total)
│
├── select_sections/          # Resume content sections (subset of sections/)
│   ├── education.tex
│   ├── experience_all.tex
│   └── ... (7 files total)
│
├── fonts/                    # Custom font files
├── images/                   # Design assets (no photos)
├── .githooks/                # Pre-commit hooks
│   └── pre-commit-check-resume-pages*  # Enforce 2-page Resume
│
├── Makefile                  # Build system
├── .gitignore                # Comprehensive exclusions
├── README.md                 # Public documentation
└── CLAUDE.md                 # This file
```

### Build System Architecture

**Key design: Separate source from build artifacts**

1. LaTeX compilation outputs to `.build/` directory via `-output-directory`
2. PDFs copied from `.build/` to repository root
3. `.build/` directory is git-ignored (not tracked)
4. PDFs in root are tracked (for easy sharing on GitHub)

**Benefits:**
- Clean repository (no temp files)
- Reproducible builds (anyone can run `make all`)
- Faster git operations (smaller history)
- Professional structure

### LaTeX Customization

- **Template:** Awesome-CV (https://github.com/posquit0/Awesome-CV)
- **Class file:** `mycv.cls` (customized with adjusted spacing)
- **Fonts:** Source Sans Pro
- **Icons:** FontAwesome

Changes made to `mycv.cls`:
- Adjusted `\vspace{-1.0mm}` for better spacing without photo
- Added `acvHasPhoto` boolean to handle no-photo layouts properly

## Build System

### Makefile Targets

```bash
make all                  # Build CV and Resume, verify Resume pages
make cv                   # Build CV only
make resume               # Build Resume only
make check-resume-pages   # Verify Resume is exactly 2 pages
make build-info           # Show .build/ directory structure
make clean                # Remove .build/ directory
make rebuild              # Clean + build everything
```

### How It Works

1. `xelatex` compiles `.tex` files with `-output-directory=.build/`
2. PDFs copied from `.build/` to repository root
3. `.build/` contents can be safely deleted anytime
4. `make clean` removes `.build/` (PDFs in root are kept)

## Git Workflow

### Adding/Updating Content

```bash
# 1. Edit source files
vim CV.tex
vim sections/experience_all.tex

# 2. Rebuild locally
make all

# 3. Verify Resume is 2 pages
make check-resume-pages

# 4. Commit changes
git add -A
git commit -m "Update: Added new experience"

# 5. Push to GitHub
git push origin main
```

### Pre-commit Hooks

Git hooks in `.githooks/` automatically verify the Resume stays 2 pages before commits are allowed (if configured with `git config core.hooksPath .githooks`).

This prevents accidental commits of bloated Resumes.

## Key Decisions & Rationale

### Why .build/ directory?

- **Separation of concerns:** Sources stay clean, artifacts isolated
- **Reproducibility:** Fresh builds don't depend on old artifacts
- **Git health:** No build artifact noise in history
- **Professional practice:** Standard in software projects
- **Easy cleanup:** Single `make clean` removes everything

### Why track PDFs?

- **Shareability:** Direct links work from GitHub (https://github.com/tymo77/cv-new/blob/main/CV.pdf)
- **Currency:** PDFs always match latest source in git
- **Convenience:** Users don't need to build locally
- **Verification:** Visual proof that CVs render correctly

### Why remove helper scripts?

- **Focused repo:** Only source files and meaningful output
- **No cruft:** Temporary setup scripts aren't part of the project
- **Clean history:** Doesn't clutter git log
- **Maintainability:** Easier to understand project structure

## Maintenance

### Typical Workflow

1. Update content in `.tex` files
2. Run `make all` to rebuild
3. Verify changes (visual inspection of PDFs)
4. Run `make check-resume-pages` to ensure Resume is 2 pages
5. Commit: `git add -A && git commit -m "description"`
6. Push: `git push origin main`

### If Resume Exceeds 2 Pages

1. Reduce content in `select_sections/` files
2. Rebuild: `make resume`
3. Verify: `make check-resume-pages`
4. Adjust `.gitignore` or Makefile spacing if needed
5. Commit and push

### Customizing Layout

Edit `mycv.cls` to adjust spacing, fonts, or colors. Key variables:
- `\vspace{-1.0mm}` - Entry spacing (smaller = more compact)
- `Source Sans Pro` - Primary font
- Color definitions - If you want to add accent colors

## Important Notes

### Photo Removal

The photo has been removed from both CV.tex and Resume.tex. The layout was adjusted in `mycv.cls` to account for the extra text width when no photo is displayed.

If you want to add a photo back:
1. Uncomment the `\photo` line in CV.tex
2. The layout should automatically adjust (via `acvHasPhoto` boolean)

### Resume 2-Page Limit

This is enforced by git hooks. The Resume MUST stay 2 pages:
- Use `make check-resume-pages` before committing
- If it exceeds 2 pages, reduce content or adjust spacing
- The hook will prevent commits that break this rule

### Text Overlap Fixes

Previous text overlap issues in the Experience section were fixed by adjusting spacing in `mycv.cls`. If you see overlap reappear, check:
- Line spacing values in `mycv.cls`
- Content length in section files
- Font size settings

## Future Extensions

### Adding New Sections

1. Create new file in `sections/CV_name.tex`
2. Add `\input{sections/CV_name.tex}` to CV.tex
3. Optionally add to `select_sections/` for Resume
4. Rebuild: `make all`

### Customizing Colors

Colors are defined in `mycv.cls`. Common customizations:
- Accent color for section headers
- Link colors
- Highlight backgrounds

### Changing Fonts

Update `mycv.cls` font declarations. Current fonts:
- `Source Sans Pro` - Main text
- `FontAwesome` - Icons
- See LaTeX font documentation for alternatives

## Git History

**Two main commits:**

1. `159de25` - Initial commit: Remove photo and fix layout
   - Removed photo from CV and Resume
   - Fixed overlapping text in Experience section
   - Adjusted spacing in mycv.cls
   - Generated clean PDFs

2. `05237a7` - Clean up: Remove helper scripts and build artifacts
   - Removed temporary push scripts
   - Removed preview images
   - Updated .gitignore for proper exclusions
   - Updated Makefile to use .build/ directory
   - Added documentation

## Related Files

- `Makefile` - Self-documenting build system (see comments)
- `README.md` - Public-facing project overview
- `.gitignore` - Comprehensive exclusion patterns
- `.githooks/pre-commit-check-resume-pages*` - Resume 2-page verification

## Questions or Issues

For build system questions: Check Makefile comments  
For LaTeX questions: See mycv.cls or Awesome-CV documentation  
For git workflow: See README.md or run `git log`
