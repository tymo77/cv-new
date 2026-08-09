# Tyler Morrison - CV & Resume

Professional CV and 2-page resume built with LaTeX, based on [Awesome-CV](https://github.com/posquit0/Awesome-CV).

[![CV](https://img.shields.io/badge/CV-pdf-green.svg)](https://github.com/tymo77/cv-new/raw/main/CV.pdf)
[![Resume](https://img.shields.io/badge/Resume-pdf-blue.svg)](https://github.com/tymo77/cv-new/raw/main/Resume.pdf)

## 📄 Documents

| Document | Pages | Purpose |
|----------|-------|---------|
| **CV.pdf** | 4 | Complete academic & professional CV with all sections |
| **Resume.pdf** | 2 | Condensed professional summary (enforced 2-page limit) |

## 🎯 Quick Start

### Build Documents

```bash
# Build both CV and Resume
make all

# Or build individually
make cv       # Builds CV.pdf (4 pages)
make resume   # Builds Resume.pdf (2 pages)
```

### View the PDFs

- [View CV.pdf](CV.pdf)
- [View Resume.pdf](Resume.pdf)

### Clean Build Artifacts

```bash
make clean      # Remove .aux, .log files
make rebuild    # Clean and recompile
```

## ⚙️ System Requirements

- **LaTeX Distribution**: TeX Live (recommended) or similar
  - macOS: `brew install texlive-full`
  - Linux: `apt-get install texlive-full`
  - Windows: [MiKTeX](https://miktex.org/) or [TeX Live](https://www.tug.org/texlive/)
  
- **Make** (optional, for convenience):
  - macOS: Included with Xcode Command Line Tools
  - Linux: `apt-get install build-essential`
  - Windows: [GNU Make for Windows](http://gnuwin32.sourceforge.net/packages/make.htm)

## 📝 Editing

### Edit CV
```bash
# Main CV file
vim CV.tex

# Edit sections in sections/
vim sections/experience_all.tex
vim sections/education.tex
# ... etc
```

### Edit Resume
```bash
# Main Resume file
vim Resume.tex

# Edit sections in select_sections/
vim select_sections/experience_all.tex
vim select_sections/education.tex
# ... etc
```

### Compile After Editing
```bash
xelatex -interaction=nonstopmode CV.tex
xelatex -interaction=nonstopmode Resume.tex
```

## 🔐 Resume 2-Page Limit (Enforced!)

The Resume is automatically enforced to stay at exactly 2 pages.

**If Resume exceeds 2 pages:**

1. Adjust spacing in `mycv.cls`:
   ```latex
   \vspace{-1.0mm}  # Reduce spacing between entries
   ```

2. Or reduce content in `select_sections/` files

3. Recompile and verify:
   ```bash
   make check-resume-pages
   ```

## 🪝 Git Hooks (Optional)

Automatically verify Resume page count before commits:

```bash
git config core.hooksPath .githooks
```

Then `make check-resume-pages` runs automatically before each commit.

## 📚 Documentation

- [SETUP_HOOKS.md](SETUP_HOOKS.md) - Build and hook setup guide
- [GITHUB_SETUP.md](GITHUB_SETUP.md) - GitHub configuration
- [PUSH_TO_GITHUB_MANUAL.md](PUSH_TO_GITHUB_MANUAL.md) - Manual GitHub push instructions
- [CHANGES.md](CHANGES.md) - Detailed changelog

## 🛠️ Technical Details

### Template

Based on [Awesome-CV](https://github.com/posquit0/Awesome-CV) by posquit0 with custom modifications:

- Removed photo from CV and Resume
- Adjusted spacing to prevent text overlap
- Added Makefile for easy compilation
- Added pre-commit hooks for page limit validation
- Comprehensive documentation

### Font

- **Primary**: Source Sans Pro (modern, clean)
- **Icons**: FontAwesome (for contact info icons)

### Styling

- Custom class: `mycv.cls`
- No colored boxes (clean, professional look)
- Responsive layout

## 📋 Recent Changes

- ✅ Removed photo from both documents
- ✅ Fixed text overlap in Experience section
- ✅ Resume enforced to 2 pages
- ✅ Added Makefile for build automation
- ✅ Added Git hooks for quality checks
- ✅ Comprehensive documentation

See [CHANGES.md](CHANGES.md) for full details.

## 🤝 Contributing

This is a personal CV/Resume repository. Feel free to fork and adapt for your own use!

## 📄 License

The template is based on [Awesome-CV](https://github.com/posquit0/Awesome-CV).

Feel free to take the `.tex` files and modify them to create your own resume. Please don't use this specific CV content for anything else without permission.

## 👋 Contact

For questions about the template or setup, see the documentation files.

---

**Built with TeX Love** ❤️
Made by Tyler Morrison
