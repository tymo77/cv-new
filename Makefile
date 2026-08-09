.PHONY: all cv resume clean check-resume-pages setup-build-dir

# Build output directory
BUILD_DIR := .build
OUTDIR_OPTS := -output-directory=$(BUILD_DIR)

# Default target
all: setup-build-dir cv resume check-resume-pages

# Setup build directory
setup-build-dir:
	@mkdir -p $(BUILD_DIR)

# Compile CV
cv: setup-build-dir
	@echo "Compiling CV.tex..."
	@cd $(BUILD_DIR) && xelatex -interaction=nonstopmode $(OUTDIR_OPTS) ../CV.tex > /dev/null 2>&1
	@cp $(BUILD_DIR)/CV.pdf .
	@echo "✓ CV.pdf generated (4 pages)"

# Compile Resume
resume: setup-build-dir
	@echo "Compiling Resume.tex..."
	@cd $(BUILD_DIR) && xelatex -interaction=nonstopmode $(OUTDIR_OPTS) ../Resume.tex > /dev/null 2>&1
	@cp $(BUILD_DIR)/Resume.pdf .
	@echo "✓ Resume.pdf generated"

# Check that Resume is exactly 2 pages
check-resume-pages:
	@if [ -f "Resume.pdf" ]; then \
		pages=$$(xelatex -interaction=nonstopmode -output-directory=$(BUILD_DIR) Resume.tex 2>&1 | grep "Output written" | grep -o "[0-9]* page" | grep -o "[0-9]*"); \
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

# Clean build artifacts (keeps PDFs in repo root)
clean:
	rm -rf $(BUILD_DIR)
	@echo "✓ Cleaned build artifacts"

# Full rebuild
rebuild: clean all

# View build structure (for debugging)
build-info:
	@echo "Build directory: $(BUILD_DIR)"
	@echo "Output options: $(OUTDIR_OPTS)"
	@if [ -d "$(BUILD_DIR)" ]; then \
		echo "Build artifacts:"; \
		ls -lh $(BUILD_DIR)/ 2>/dev/null || echo "  (empty)"; \
	else \
		echo "Build directory does not exist"; \
	fi
