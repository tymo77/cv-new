# Quick Push to GitHub

## TL;DR

```bash
# Open a NEW terminal (separate shell) and run:
bash ~/projects/cv-new/gh-push.sh
```

That's it! Everything else is automatic.

## What the Script Does

The `gh-push.sh` script automates everything:

1. ✓ Checks GitHub CLI is installed
2. ✓ Checks authentication (prompts if needed)
3. ✓ Initializes git repository
4. ✓ Stages all files
5. ✓ Creates comprehensive commit
6. ✓ Creates cv-new repository on GitHub
7. ✓ Pushes all files
8. ✓ Configures git hooks

## Result

Your CV will be published at:
- **Repository**: https://github.com/tymo77/cv-new
- **CV PDF**: https://github.com/tymo77/cv-new/blob/main/CV.pdf
- **Resume PDF**: https://github.com/tymo77/cv-new/blob/main/Resume.pdf

## Troubleshooting

### "gh: command not found"
Install GitHub CLI: https://cli.github.com

### "Not authenticated with GitHub"
The script will prompt you to log in. Or run manually:
```bash
gh auth login
```

### "SSL certificate error"
Try in a different terminal. Or use Personal Access Token:
```bash
export GH_TOKEN="your_token_here"
bash ~/projects/cv-new/gh-push.sh
```

### Repository already exists
The script will ask if you want to push to existing repo. Choose yes.

## After Pushing

### View on GitHub
https://github.com/tymo77/cv-new

### Future Updates
```bash
cd ~/projects/cv-new

# Edit files
vim CV.tex

# Rebuild
make all

# Commit and push
git add -A
git commit -m "Updated CV with new experience"
git push
```

### Configure Credential Caching (optional)
To avoid entering credentials each time:

**macOS:**
```bash
git config --global credential.helper osxkeychain
```

**Linux:**
```bash
git config --global credential.helper cache
```

**Windows:**
```bash
git config --global credential.helper wincred
```

## One More Thing

Make sure you run the script from a **separate shell/terminal**, not from Claude Code. This ensures proper interaction with GitHub authentication.

---

**Questions?** See the full documentation in `FINAL_INSTRUCTIONS.md`
