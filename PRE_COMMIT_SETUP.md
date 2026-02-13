# Pre-Commit Hooks Setup Guide

This guide will help you set up pre-commit hooks on your local machine for the CICD_k8s project.

## What Are Pre-Commit Hooks?

Pre-commit hooks automatically check your code **before** you commit it. They catch issues like:
- Syntax errors
- Formatting problems
- Large files
- Exposed secrets/passwords
- Dockerfile issues

## Prerequisites

- **Git** installed
- **Python 3.6+** installed
- **Node.js** installed (for npm tests)
- **Ubuntu/Linux** system (or WSL on Windows)

## Installation Steps

### Method 1: Automated Setup (Recommended)

```bash
# 1. Clone the repository (if not already done)
git clone https://github.com/Princekalyan44/CICD_k8s.git
cd CICD_k8s

# 2. Make the setup script executable
chmod +x setup-precommit.sh

# 3. Run the setup script
./setup-precommit.sh
```

The script will:
- ✅ Install pre-commit framework
- ✅ Install all hook dependencies
- ✅ Configure git hooks
- ✅ Run initial validation

### Method 2: Manual Setup

```bash
# 1. Install pre-commit
pip3 install pre-commit --user

# 2. Add to PATH (if needed)
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# 3. Verify installation
pre-commit --version

# 4. Install hooks in your repository
cd CICD_k8s
pre-commit install

# 5. Create secrets baseline
echo '{}' > .secrets.baseline

# 6. Install hook dependencies
pre-commit install-hooks

# 7. Test the setup
pre-commit run --all-files
```

## Configured Hooks

Our pre-commit configuration includes:

### General Checks
- **Trailing whitespace removal**
- **End of file fixer**
- **YAML syntax validation**
- **JSON syntax validation**
- **Large file detection** (>500KB)
- **Private key detection**
- **Merge conflict markers check**

### Docker Checks
- **Hadolint**: Dockerfile linting and best practices

### Security Checks
- **Secret detection**: Prevents committing passwords, API keys, tokens

### Node.js Checks
- **npm test**: Runs your test suite
- **package.json validation**: Ensures valid JSON syntax

## Usage

### Automatic (Default Behavior)

Pre-commit hooks run automatically when you commit:

```bash
git add .
git commit -m "Added new feature"
# Hooks run automatically here!
```

### Manual Execution

Run checks manually without committing:

```bash
# Check all files
pre-commit run --all-files

# Check specific files
pre-commit run --files app.js Dockerfile

# Run specific hook
pre-commit run trailing-whitespace --all-files
```

### Skip Hooks (Use Sparingly)

If you need to bypass hooks:

```bash
git commit --no-verify -m "Emergency fix"
```

⚠️ **Warning**: Skipping hooks is not recommended as issues will be caught in CI/CD pipeline anyway.

## Common Workflows

### Making Changes

```bash
# 1. Make your code changes
vim app.js

# 2. Stage changes
git add app.js

# 3. Commit (hooks run automatically)
git commit -m "Updated user input validation"

# If hooks fail:
# - Fix the issues shown
# - Stage fixed files: git add .
# - Try commit again
```

### Expected Output

```
Remove trailing whitespace...................Passed
Fix end of files............................Passed
Check YAML syntax...........................Passed
Check JSON syntax...........................Passed
Check for large files.......................Passed
Detect private keys.........................Passed
Lint Dockerfile.............................Passed
Detect secrets..............................Passed
Run npm tests...............................Passed
```

## Troubleshooting

### Issue: "pre-commit: command not found"

```bash
# Add to PATH
export PATH="$HOME/.local/bin:$PATH"
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### Issue: "detect-secrets not found"

```bash
pip3 install detect-secrets --user
```

### Issue: "hadolint not found"

```bash
# The hook will auto-download hadolint
# Or install manually:
wget -O /usr/local/bin/hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
chmod +x /usr/local/bin/hadolint
```

### Issue: Hooks failing on valid code

```bash
# Update hooks to latest versions
pre-commit autoupdate

# Clean and reinstall
pre-commit clean
pre-commit install-hooks
```

### Issue: Slow hook execution

```bash
# Only check changed files
pre-commit run --files $(git diff --cached --name-only)

# Skip slow hooks temporarily
SKIP=npm-test git commit -m "Quick fix"
```

## Updating Hooks

```bash
# Update all hooks to latest versions
pre-commit autoupdate

# Reinstall after updates
pre-commit install-hooks
```

## Uninstalling

```bash
# Remove pre-commit hooks
pre-commit uninstall

# Remove pre-commit package
pip3 uninstall pre-commit
```

## Integration with CI/CD

Our GitHub Actions pipeline runs the same checks:
- If you pass pre-commit locally, you'll likely pass CI/CD
- Pre-commit catches issues in **seconds** vs CI/CD in **minutes**
- Saves time and keeps your commit history clean

## Best Practices

1. ✅ **Always run pre-commit** before pushing
2. ✅ **Fix issues immediately** don't skip hooks
3. ✅ **Update hooks regularly** with `pre-commit autoupdate`
4. ✅ **Add project-specific checks** as needed
5. ❌ **Don't commit large files** (>500KB)
6. ❌ **Don't commit secrets** (use environment variables)

## Additional Resources

- [Pre-commit Documentation](https://pre-commit.com/)
- [Available Hooks](https://pre-commit.com/hooks.html)
- [Hadolint Rules](https://github.com/hadolint/hadolint)
- [Detect Secrets Guide](https://github.com/Yelp/detect-secrets)

## Need Help?

If you encounter issues:
1. Check this documentation
2. Run `pre-commit run --all-files` for detailed error messages
3. Review the `.pre-commit-config.yaml` file
4. Check CI/CD logs for similar failures

---

**Happy Coding! 🚀**
