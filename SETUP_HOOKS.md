# Building and Testing

## Quick Start

### Compile PDFs

```bash
# Compile both CV and Resume
make all

# Or compile individually
make cv       # CV.pdf (4 pages)
make resume   # Resume.pdf (2 pages)
```

### Clean Build Artifacts

```bash
make clean      # Remove .aux, .log files
make rebuild    # Clean and recompile
```

## Resume Page Limit

**Important:** The Resume must always be exactly 2 pages.

To check the page count:
```bash
xelatex Resume.tex 2>&1 | grep "Output written"
```

If Resume exceeds 2 pages:
1. Adjust spacing in `mycv.cls` (look for `\vspace` values)
2. Reduce content in `select_sections/` files
3. Recompile: `xelatex -interaction=nonstopmode Resume.tex`

## Git Hook Setup (Optional)

If you'd like automated page count checks on commit:

```bash
git config core.hooksPath .githooks
```

Then `Resume.pdf` page count will be verified before each commit.
