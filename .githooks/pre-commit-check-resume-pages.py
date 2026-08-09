#!/usr/bin/env python3
"""
Pre-commit hook to enforce Resume.pdf is exactly 2 pages.
Install with: git config core.hooksPath .githooks
"""

import re
import sys
from pathlib import Path

def count_pdf_pages(filepath):
    """Count pages in a PDF file by looking for /Count in the Pages object."""
    try:
        with open(filepath, 'rb') as f:
            pdf_content = f.read()

        # Look for /Count /N where N is the page count (usually in the root Pages object)
        # Pattern: /Count <number>
        count_match = re.search(rb'/Count\s+(\d+)', pdf_content)
        if count_match:
            count = int(count_match.group(1))
            if count > 0:
                return count

        # Fallback: count /Type /Page objects
        pages_match = re.findall(rb'/Type\s*/Page\b', pdf_content)
        return len(pages_match)
    except Exception as e:
        print(f"❌ ERROR: Could not read {filepath}: {e}")
        return None

def main():
    resume_path = Path("Resume.pdf")

    if not resume_path.exists():
        print("✓ Resume.pdf not found (skipping check)")
        return 0

    pages = count_pdf_pages(resume_path)

    if pages is None:
        print("⚠️  WARNING: Could not determine page count for Resume.pdf")
        print("   Skipping check. Install pdfinfo for reliable verification:")
        print("   macOS: brew install poppler")
        print("   Linux: apt-get install poppler-utils")
        return 0

    if pages != 2:
        print(f"❌ ERROR: Resume.pdf must be exactly 2 pages, but it has {pages} pages")
        print("   Please adjust spacing in mycv.cls and recompile with:")
        print("   xelatex -interaction=nonstopmode Resume.tex")
        return 1

    print(f"✓ Resume.pdf check passed: {pages} pages")
    return 0

if __name__ == "__main__":
    sys.exit(main())
