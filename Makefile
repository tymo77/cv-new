.PHONY: all cv resume clean check-resume-pages

# Default target
all: cv resume check-resume-pages

# Compile CV
cv:
	@echo "Compiling CV.tex..."
	xelatex -interaction=nonstopmode CV.tex > /dev/null 2>&1
	@echo "✓ CV.pdf generated (4 pages)"

# Compile Resume
resume:
	@echo "Compiling Resume.tex..."
	xelatex -interaction=nonstopmode Resume.tex > /dev/null 2>&1
	@echo "✓ Resume.pdf generated"

# Check that Resume is exactly 2 pages
check-resume-pages:
	@if [ -f "Resume.pdf" ]; then \
		pages=$$(xelatex -interaction=nonstopmode Resume.tex 2>&1 | grep "Output written" | grep -o "[0-9]* page" | grep -o "[0-9]*"); \
		if [ -z "$$pages" ]; then \
			pages=$$(grep -ao '/Type */Page' Resume.pdf 2>/dev/null | wc -l); \
		fi; \
		if [ "$$pages" -eq 2 ]; then \
			echo "✓ Resume.pdf is 2 pages"; \
		else \
			echo "❌ ERROR: Resume.pdf must be 2 pages but has $$pages pages"; \
			exit 1; \
		fi; \
	fi

# Clean build artifacts
clean:
	rm -f *.aux *.log *.out *.fls *.fdb_latexmk CV_page*.png Resume_preview*.png Resume_final.png
	@echo "✓ Cleaned build artifacts"

# Full rebuild
rebuild: clean all
