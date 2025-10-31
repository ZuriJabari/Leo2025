# 🚀 LéO Africa Institute - Complete Deployment Guide

This comprehensive guide covers everything you need to deploy the LéO Africa Institute website to cPanel hosting.

---

## 📋 Table of Contents

1. [Prerequisites](#prerequisites)
2. [GitHub Repository Setup](#github-repository-setup)
3. [cPanel Preparation](#cpanel-preparation)
4. [Automated Deployment Setup](#automated-deployment-setup)
5. [Manual Deployment](#manual-deployment)
6. [Post-Deployment Configuration](#post-deployment-configuration)
7. [Updating the Live Site](#updating-the-live-site)
8. [Troubleshooting](#troubleshooting)

---

## 🔧 Prerequisites

### Local Machine
- Git installed and configured
- GitHub account with repository access
- SSH client (Terminal on Mac/Linux, PuTTY on Windows)
- FTP client (FileZilla, Cyberduck, or similar)

### cPanel Hosting
- cPanel access credentials
- FTP/SFTP access
- SSH access (optional but recommended)
- MySQL database created
- PHP 8.3+ with required extensions
- Composer installed (or ability to run it)

---

## 📦 GitHub Repository Setup

### 1. Initialize Local Repository

The repository is already initialized. Verify with:

```bash
cd /Users/zuri/Work/LeO2025
git status
```

### 2. Create Development Branch

```bash
# Create and switch to dev branch
git checkout -b dev

# Push dev branch to GitHub
git push -u origin dev

# Switch back to main
git checkout main
```

### 3. Configure GitHub Secrets

Go to: `https://github.com/ZuriJabari/Leo2025/settings/secrets/actions`

Click **"New repository secret"** and add each of the following:

#### Required Secrets

| Secret Name | Description | How to Get It |
|-------------|-------------|---------------|
| `APP_URL` | Production URL | Your domain (e.g., `https://leoafricainstitute.org`) |
| `DB_HOST` | Database host | Usually `localhost` in cPanel |
| `DB_DATABASE` | Database name | From cPanel → MySQL Databases |
| `DB_USERNAME` | Database user | From cPanel → MySQL Databases |
| `DB_PASSWORD` | Database password | Set when creating database user |
| `FTP_SERVER` | FTP server | From cPanel → FTP Accounts (e.g., `ftp.yourdomain.com`) |
| `FTP_USERNAME` | FTP username | From cPanel → FTP Accounts |
| `FTP_PASSWORD` | FTP password | Set when creating FTP account |

#### Optional Secrets (for SSH deployment)

| Secret Name | Description | Default |
|-------------|-------------|---------|
| `SSH_HOST` | SSH hostname | Same as your domain |
| `SSH_USERNAME` | SSH username | Your cPanel username |
| `SSH_PASSWORD` | SSH password | Your cPanel password |
| `SSH_PORT` | SSH port | `22` |

### 4. Protect Main Branch

1. Go to: `https://github.com/ZuriJabari/Leo2025/settings/branches`
2. Click **"Add rule"**
3. Branch name pattern: `main`
4. Enable:
   - ✅ Require pull request reviews before merging
   - ✅ Require status checks to pass before merging
5. Click **"Create"**

---

## 🖥️ cPanel Preparation

### 1. Create MySQL Database

1. Log in to cPanel
2. Navigate to **MySQL Databases**
3. Create a new database:
   - Database name: `leo_africa_prod` (or your choice)
4. Create a database user:
   - Username: `leo_user` (or your choice)
   - Password: Generate a strong password
5. Add user to database with **ALL PRIVILEGES**
6. **Save credentials** - you'll need them for GitHub Secrets

### 2. Create FTP Account

1. In cPanel, navigate to **FTP Accounts**
2. Create a new FTP account:
   - Login: `deploy@yourdomain.com` (or your choice)
   - Password: Generate a strong password
   - Directory: `/public_html` (or your web root)
3. **Save credentials** - you'll need them for GitHub Secrets

### 3. Configure PHP Version

1. In cPanel, navigate to **Select PHP Version** or **MultiPHP Manager**
2. Select **PHP 8.3** or higher
3. Enable required extensions:
   - ✅ mbstring
   - ✅ xml
   - ✅ ctype
   - ✅ json
   - ✅ bcmath
   - ✅ pdo
   - ✅ pdo_mysql
   - ✅ zip
   - ✅ gd
   - ✅ curl

### 4. Set Up .htaccess (if needed)

If your Laravel app is not in the root, you may need to redirect:

Create or edit `/public_html/.htaccess`:

```apache
<IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteRule ^(.*)$ public/$1 [L]
</IfModule>
```

---

## ⚙️ Automated Deployment Setup

### How It Works

1. You push code to the `main` branch
2. GitHub Actions automatically:
   - Installs dependencies
   - Builds frontend assets
   - Creates deployment package
   - Uploads to cPanel via FTP
   - Runs post-deployment commands via SSH (if configured)

### Trigger Deployment

```bash
# Make changes
git add .
git commit -m "feat: initial deployment"

# Push to main branch (triggers deployment)
git push origin main
```

### Monitor Deployment

1. Go to: `https://github.com/ZuriJabari/Leo2025/actions`
2. Click on the latest workflow run
3. Watch the deployment progress
4. Check for any errors

### Download Deployment Package (if needed)

If FTP fails, you can manually download the deployment package:

1. Go to the failed workflow run
2. Scroll to **Artifacts**
3. Download `leo-africa-deployment-package`
4. Extract and upload manually via cPanel File Manager

---

## 🔨 Manual Deployment

If you prefer manual deployment or automated deployment fails:

### 1. Build Locally

```bash
cd /Users/zuri/Work/LeO2025

# Run the deployment script
./deploy.sh
```

This creates a timestamped ZIP file: `leo-africa-laravel-YYYYMMDD-HHMMSS.zip`

### 2. Upload to cPanel

#### Option A: FTP Client

1. Open your FTP client (FileZilla, Cyberduck, etc.)
2. Connect using your FTP credentials
3. Navigate to `/public_html/`
4. Upload the ZIP file
5. Extract using cPanel File Manager

#### Option B: cPanel File Manager

1. Log in to cPanel
2. Navigate to **File Manager**
3. Go to `/public_html/`
4. Click **Upload**
5. Select your ZIP file
6. After upload, right-click → **Extract**

### 3. Configure Environment

1. In cPanel File Manager, navigate to `/public_html/`
2. Edit `.env` file
3. Update with your production credentials:

```env
APP_NAME="LéO Africa Institute"
APP_ENV=production
APP_KEY=
APP_DEBUG=false
APP_URL=https://yourdomain.com

DB_CONNECTION=mysql
DB_HOST=localhost
DB_PORT=3306
DB_DATABASE=leo_africa_prod
DB_USERNAME=leo_user
DB_PASSWORD=your_database_password

# ... other settings
```

4. Save the file

---

## 🔧 Post-Deployment Configuration

### Via SSH (Recommended)

```bash
# Connect to your server
ssh username@yourdomain.com

# Navigate to web directory
cd public_html

# Generate application key (first time only)
php artisan key:generate

# Run database migrations
php artisan migrate --force

# Create symbolic link for storage
php artisan storage:link

# Cache configurations for performance
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Set correct permissions
chmod -R 755 storage bootstrap/cache
```

### Via cPanel Terminal (if SSH not available)

1. In cPanel, open **Terminal**
2. Run the same commands as above

### Via Web Interface (last resort)

If you can't access SSH or Terminal, create a temporary setup script:

1. Create `setup.php` in `/public_html/`:

```php
<?php
// Temporary setup script - DELETE after use!

require __DIR__.'/vendor/autoload.php';

$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);

echo "Running setup commands...\n\n";

// Generate key
$kernel->call('key:generate', ['--force' => true]);
echo "✓ Application key generated\n";

// Run migrations
$kernel->call('migrate', ['--force' => true]);
echo "✓ Migrations completed\n";

// Create storage link
$kernel->call('storage:link');
echo "✓ Storage linked\n";

// Cache configs
$kernel->call('config:cache');
$kernel->call('route:cache');
$kernel->call('view:cache');
echo "✓ Configurations cached\n";

echo "\n✅ Setup complete! DELETE this file now!\n";
```

2. Visit: `https://yourdomain.com/setup.php`
3. **IMPORTANT:** Delete `setup.php` immediately after use!

---

## 🔄 Updating the Live Site

### Method 1: Automated (Recommended)

```bash
# Make your changes locally
git add .
git commit -m "feat: your changes"

# Push to main branch
git push origin main
```

GitHub Actions will automatically deploy to cPanel.

### Method 2: Git Pull on cPanel

If you have SSH access and Git installed on cPanel:

```bash
# SSH into your server
ssh username@yourdomain.com

# Navigate to web directory
cd public_html

# Pull latest changes
git pull origin main

# Install/update dependencies
composer install --no-dev --optimize-autoloader
npm ci && npm run build

# Run migrations
php artisan migrate --force

# Clear and cache
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

### Method 3: Manual Upload

1. Run `./deploy.sh` locally
2. Upload ZIP to cPanel
3. Extract and overwrite files
4. Run post-deployment commands

---

## 🐛 Troubleshooting

### Issue: White Screen / 500 Error

**Solution:**
```bash
# Check Laravel logs
tail -f storage/logs/laravel.log

# Clear all caches
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Regenerate caches
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

### Issue: Permission Denied Errors

**Solution:**
```bash
# Set correct permissions
chmod -R 755 storage bootstrap/cache
chown -R username:username storage bootstrap/cache
```

### Issue: Database Connection Failed

**Solution:**
1. Verify `.env` database credentials
2. Check if database exists in cPanel
3. Verify user has privileges
4. Try `DB_HOST=127.0.0.1` instead of `localhost`

### Issue: Assets Not Loading

**Solution:**
```bash
# Rebuild assets
npm run build

# Clear view cache
php artisan view:clear

# Check public path in .htaccess
```

### Issue: GitHub Actions Deployment Fails

**Solution:**
1. Check GitHub Actions logs for specific error
2. Verify all GitHub Secrets are set correctly
3. Test FTP credentials manually
4. Download artifact and deploy manually

### Issue: Composer/NPM Errors

**Solution:**
```bash
# Clear Composer cache
composer clear-cache
composer install --no-dev --optimize-autoloader

# Clear NPM cache
npm cache clean --force
rm -rf node_modules package-lock.json
npm install
```

---

## 📞 Support Checklist

Before seeking help, verify:

- [ ] PHP version is 8.3+
- [ ] All required PHP extensions are enabled
- [ ] Database credentials are correct
- [ ] File permissions are set correctly (755 for directories, 644 for files)
- [ ] `.env` file exists and is configured
- [ ] `APP_KEY` is generated
- [ ] Storage is linked
- [ ] Migrations have run successfully
- [ ] Caches are cleared and regenerated

---

## 🎯 Quick Reference Commands

### Local Development
```bash
php artisan serve                    # Start dev server
npm run dev                          # Build assets (dev)
php artisan migrate                  # Run migrations
php artisan make:filament-user       # Create admin user
```

### Production Deployment
```bash
./deploy.sh                          # Build deployment package
php artisan migrate --force          # Run migrations (production)
php artisan config:cache             # Cache config
php artisan route:cache              # Cache routes
php artisan view:cache               # Cache views
```

### Maintenance
```bash
php artisan down                     # Enable maintenance mode
php artisan up                       # Disable maintenance mode
php artisan cache:clear              # Clear application cache
php artisan config:clear             # Clear config cache
```

---

<p align="center">
  <strong>🎉 You're all set! Happy deploying!</strong>
</p>
