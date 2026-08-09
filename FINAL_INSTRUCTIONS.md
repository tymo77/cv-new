# Final Instructions: Push Your CV to GitHub

Your CV project is **100% ready**. You just need to authenticate with GitHub and push.

## ⚠️ Current Situation

- ✅ All files are prepared in `~/projects/cv-new/`
- ✅ CV.pdf and Resume.pdf are generated and verified
- ⚠️ GitHub authentication failed due to SSL certificate issue

**This is fixable!** Follow one of the methods below.

## 🎯 Choose Your Method

### Method 1: Using Personal Access Token (Recommended)

This is the easiest and most reliable.

**Step 1: Create a Personal Access Token**

1. Go to: https://github.com/settings/tokens
2. Click "Generate new token" → "Generate new token (classic)"
3. Name: `CV Push`
4. Scope: Check ✓ `repo` (full control of private repositories)
5. Click "Generate token"
6. **Copy the token immediately** (you won't see it again!)

**Step 2: Push Your Repository**

```bash
# From your terminal, run:
cd ~/projects/cv-new

# Export your token
export GH_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxxxxx"  # Paste your actual token here

# Run the push script
bash push-to-github-token.sh
```

**That's it!** Your repo will be created and pushed automatically.

---

### Method 2: Manual Git Push with Token

If the script doesn't work, do this manually:

```bash
cd ~/projects/cv-new

# Initialize and commit
git init
git config user.email "tymo77@gmail.com"
git config user.name "Tyler Morrison"
git add .
git commit -m "Initial commit: Remove photo and fix layout" 2>/dev/null || true

# Create repo on GitHub first:
# Go to https://github.com/new and create "cv-new" repository (public or private)

# Then push using your token
git remote add origin https://tymo77:YOUR_TOKEN@github.com/tymo77/cv-new.git
git branch -M main
git push -u origin main
```

---

### Method 3: SSH Keys (Advanced)

If you have SSH keys set up with GitHub:

```bash
cd ~/projects/cv-new

git init
git config user.email "tymo77@gmail.com"
git config user.name "Tyler Morrison"
git add .
git commit -m "Initial commit" 2>/dev/null || true

# Create repo on GitHub: https://github.com/new (name: cv-new)

git remote add origin git@github.com:tymo77/cv-new.git
git branch -M main
git push -u origin main
```

---

## 🔍 Verify It Worked

After pushing, verify with:

```bash
# Check remote
git remote -v

# Check log
git log --oneline

# View on GitHub
# https://github.com/tymo77/cv-new
```

---

## 📝 What Gets Pushed

Your repository will include:

✓ **CV.pdf** (4 pages)  
✓ **Resume.pdf** (2 pages)  
✓ **All LaTeX source files** (CV.tex, Resume.tex, etc.)  
✓ **Makefile** (for easy rebuilding)  
✓ **Documentation** (7 guides)  
✓ **Git hooks** (2-page Resume verification)  
✓ **.gitignore** (prevents tracking build artifacts)  

---

## 🚀 After Pushing: Future Updates

Once pushed, updating your CV is simple:

```bash
cd ~/projects/cv-new

# Edit your CV
vim CV.tex
# or
vim Resume.tex

# Build
make all

# Verify Resume is 2 pages
make check-resume-pages

# Commit and push
git add -A
git commit -m "Description of changes"
git push
```

---

## ❓ Troubleshooting

### "Repository does not exist"
- Make sure you created the repo first on GitHub: https://github.com/new
- Name it: `cv-new`

### "Authentication failed" / "Invalid token"
- Token might be expired
- Generate a new one: https://github.com/settings/tokens
- Make sure it has `repo` scope

### "Permission denied"
- Check that `tymo77` is your actual GitHub username
- If different, update the push script accordingly

### Token in Shell History?
Don't worry! GitHub tokens can only be used from the command line. For future pushes:

```bash
# Option A: Use credential helper (recommended)
git config --global credential.helper osxkeychain

# Option B: Use SSH keys (most secure)
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh
```

---

## 📞 Still Having Issues?

1. **Read** `README_GITHUB_AUTH.md` for detailed auth guide
2. **Check** GitHub's help: https://docs.github.com/en/authentication
3. **Verify** token has correct scopes: https://github.com/settings/tokens
4. **Ensure** using correct GitHub username: `tymo77`

---

## ✅ Final Checklist

Before pushing:

- [ ] You have a Personal Access Token from GitHub
- [ ] Token has `repo` scope
- [ ] You're in `~/projects/cv-new` directory
- [ ] You have internet connection

When pushing:

- [ ] Export token: `export GH_TOKEN="ghp_..."`
- [ ] Run: `bash push-to-github-token.sh`
- [ ] Or follow Method 2 or 3 above

After pushing:

- [ ] Verify at: https://github.com/tymo77/cv-new
- [ ] Check files are there
- [ ] Review CV.pdf and Resume.pdf

---

## 🎉 You're Done!

Once pushed:
- Your CV is backed up on GitHub
- Easy to share: `https://github.com/tymo77/cv-new`
- Updates are tracked with git
- Resume size is protected by hooks

**Good luck with your CV!** 🚀

---

**Questions?** See the documentation files in the project directory.
