# Authenticating with GitHub

Due to SSL certificate verification issues in this environment, we need to use HTTPS with credentials.

## Quick Fix: Generate Personal Access Token

1. Go to: https://github.com/settings/tokens
2. Click "Generate new token"
3. Name it: "CV Push Token"
4. Select scopes: `repo` (full control of private repositories)
5. Click "Generate token"
6. Copy the token (you won't see it again!)

## Option A: Use Token Directly (Simple)

```bash
cd ~/projects/cv-new

# Set your token (replace with your actual token)
export GH_TOKEN="ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Now push
bash create-and-push.sh
```

## Option B: Configure Git Credential Manager

```bash
# Tell git to use osxkeychain (macOS)
git config --global credential.helper osxkeychain

# Or use plain text (less secure but works)
git config --global credential.helper store

# Configure for this repo specifically
cd ~/projects/cv-new
git config credential.helper osxkeychain
```

Then when git asks for credentials:
- Username: your GitHub username (tymo77)
- Password: your Personal Access Token

## Option C: Manual Push with Token

```bash
cd ~/projects/cv-new

# Initialize and commit (if not already done)
git init
git config user.email "tymo77@gmail.com"
git config user.name "Tyler Morrison"
git add .
git commit -m "Initial commit: Remove photo and fix layout" 2>/dev/null || true

# Push with token in URL
git remote add origin https://tymo77:YOUR_TOKEN@github.com/tymo77/cv-new.git
git branch -M main
git push -u origin main
```

## Troubleshooting

### "Permission denied" when pushing
- Make sure token has `repo` scope
- Token might have expired
- Generate a new token

### "fatal: destination repository does not exist"
- Repository hasn't been created yet on GitHub
- Create it first: https://github.com/new
- Or use: `gh repo create cv-new` (requires auth)

### SSL Certificate Error
- This is a system configuration issue
- Workaround: use token-based authentication (options above)
- Or disable SSL verification (not recommended):
  ```bash
  git config --global http.sslVerify false
  ```

## After Pushing

Once the repository is created and pushed:

```bash
# Configure git hooks
git config core.hooksPath .githooks

# Verify it worked
git log --oneline
git remote -v
```

Then you can view at: https://github.com/tymo77/cv-new

## Next Updates

For future pushes, use:

```bash
git add -A
git commit -m "Description of changes"
git push
```

Git will remember your credentials from the first push.
