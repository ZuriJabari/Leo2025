# ✅ LéO Africa Institute - Setup Checklist

Use this checklist to ensure your development environment and deployment are properly configured.

---

## 📋 Local Development Setup

### Initial Setup
- [ ] PHP 8.3+ installed with required extensions
- [ ] Composer 2.x installed
- [ ] Node.js 20.x+ and npm installed
- [ ] MySQL 8.0+ or MariaDB 10.3+ installed
- [ ] Git installed and configured

### Project Setup
- [ ] Repository cloned: `git clone https://github.com/ZuriJabari/Leo2025.git`
- [ ] Dependencies installed: `composer install`
- [ ] NPM packages installed: `npm install`
- [ ] `.env` file created: `cp .env.example .env`
- [ ] Application key generated: `php artisan key:generate`
- [ ] Database configured in `.env`
- [ ] Migrations run: `php artisan migrate`
- [ ] Storage linked: `php artisan storage:link`
- [ ] Assets built: `npm run build`

### Admin Panel
- [ ] Admin user created: `php artisan make:filament-user`
- [ ] Admin panel accessible at `/admin`
- [ ] Can log in successfully

### Testing
- [ ] Development server runs: `php artisan serve`
- [ ] Site loads at `http://localhost:8000`
- [ ] Hot reload works: `npm run dev`
- [ ] No console errors in browser

---

## 🔧 cPanel Hosting Setup

### Database Configuration
- [ ] MySQL database created in cPanel
- [ ] Database user created with strong password
- [ ] User added to database with ALL PRIVILEGES
- [ ] Database credentials saved securely

### FTP/SSH Access
- [ ] FTP account created in cPanel
- [ ] FTP credentials tested and working
- [ ] SSH access enabled (if available)
- [ ] SSH credentials tested (if applicable)

### PHP Configuration
- [ ] PHP version set to 8.3+
- [ ] Required PHP extensions enabled:
  - [ ] mbstring
  - [ ] xml
  - [ ] ctype
  - [ ] json
  - [ ] bcmath
  - [ ] pdo
  - [ ] pdo_mysql
  - [ ] zip
  - [ ] gd
  - [ ] curl

### File Structure
- [ ] Web root identified (usually `public_html`)
- [ ] `.htaccess` configured (if needed)
- [ ] File permissions set correctly

---

## 🚀 GitHub Repository Setup

### Repository Configuration
- [ ] Repository created: `https://github.com/ZuriJabari/Leo2025`
- [ ] Remote added: `git remote add origin https://github.com/ZuriJabari/Leo2025.git`
- [ ] Main branch created and pushed
- [ ] Dev branch created: `git checkout -b dev && git push -u origin dev`

### Branch Protection
- [ ] Main branch protected
- [ ] Pull request reviews required
- [ ] Status checks required before merging

### GitHub Secrets Configured
- [ ] `APP_URL` - Production URL
- [ ] `DB_HOST` - Database host (usually `localhost`)
- [ ] `DB_DATABASE` - Database name
- [ ] `DB_USERNAME` - Database username
- [ ] `DB_PASSWORD` - Database password
- [ ] `FTP_SERVER` - FTP server address
- [ ] `FTP_USERNAME` - FTP username
- [ ] `FTP_PASSWORD` - FTP password
- [ ] `SSH_HOST` - SSH host (optional)
- [ ] `SSH_USERNAME` - SSH username (optional)
- [ ] `SSH_PASSWORD` - SSH password (optional)
- [ ] `SSH_PORT` - SSH port (optional, default 22)

---

## 🌐 Deployment Verification

### First Deployment
- [ ] GitHub Actions workflow runs successfully
- [ ] No errors in workflow logs
- [ ] Files uploaded to cPanel
- [ ] `.env` file configured on server
- [ ] Application key generated on server
- [ ] Migrations run on server
- [ ] Storage linked on server
- [ ] Caches generated on server

### Site Verification
- [ ] Production site loads correctly
- [ ] No 500 errors
- [ ] Assets loading (CSS, JS, images)
- [ ] Admin panel accessible
- [ ] Can log in to admin panel
- [ ] Database connections working

### Performance
- [ ] Config cached: `php artisan config:cache`
- [ ] Routes cached: `php artisan route:cache`
- [ ] Views cached: `php artisan view:cache`
- [ ] File permissions correct: `chmod -R 755 storage bootstrap/cache`

---

## 🔄 Deployment Workflow Test

### Push to Deploy
- [ ] Make a test change locally
- [ ] Commit: `git commit -m "test: deployment workflow"`
- [ ] Push to main: `git push origin main`
- [ ] GitHub Actions triggers automatically
- [ ] Workflow completes successfully
- [ ] Changes appear on live site

### Manual Deployment
- [ ] `./deploy.sh` script runs successfully
- [ ] ZIP file created
- [ ] Can upload to cPanel manually
- [ ] Can extract files on server
- [ ] Post-deployment commands work

---

## 📊 Monitoring & Maintenance

### Error Logging
- [ ] Laravel logs accessible: `storage/logs/laravel.log`
- [ ] Error reporting configured correctly
- [ ] Can view errors in cPanel or via SSH

### Backups
- [ ] Database backup strategy in place
- [ ] File backup strategy in place
- [ ] Backup schedule configured

### Updates
- [ ] Process for updating dependencies documented
- [ ] Process for running migrations documented
- [ ] Rollback procedure documented

---

## 🎨 Frontend Verification

### Design System
- [ ] TailwindCSS compiling correctly
- [ ] Custom colors working
- [ ] Typography styles applied
- [ ] Animations working
- [ ] Responsive design working

### Assets
- [ ] Vite building correctly
- [ ] CSS minified in production
- [ ] JS minified in production
- [ ] No console errors
- [ ] Fast load times

---

## 🔐 Security Checklist

### Environment
- [ ] `.env` not in version control
- [ ] `APP_DEBUG=false` in production
- [ ] `APP_ENV=production` in production
- [ ] Strong `APP_KEY` generated
- [ ] Database credentials secure

### Permissions
- [ ] Storage directory writable (755)
- [ ] Bootstrap/cache writable (755)
- [ ] Other directories read-only where possible
- [ ] `.env` file protected (600)

### Updates
- [ ] Composer dependencies up to date
- [ ] NPM dependencies up to date
- [ ] Laravel security patches applied
- [ ] PHP version supported

---

## 📝 Documentation

### Project Documentation
- [ ] README.md complete and accurate
- [ ] DEPLOYMENT_GUIDE.md reviewed
- [ ] Setup instructions tested
- [ ] Troubleshooting section helpful

### Code Documentation
- [ ] Controllers documented
- [ ] Models documented
- [ ] Complex logic explained
- [ ] API endpoints documented (if applicable)

---

## ✨ Final Checks

### Functionality
- [ ] All features working as expected
- [ ] Forms submitting correctly
- [ ] File uploads working
- [ ] Email sending configured (if needed)
- [ ] Search functionality working (if applicable)

### Performance
- [ ] Page load times acceptable
- [ ] Database queries optimized
- [ ] Images optimized
- [ ] Caching configured

### User Experience
- [ ] Navigation intuitive
- [ ] Mobile responsive
- [ ] Accessibility standards met
- [ ] Browser compatibility tested

---

## 🎉 Ready for Production

Once all items are checked:

1. ✅ Local development environment fully functional
2. ✅ cPanel hosting properly configured
3. ✅ GitHub repository and CI/CD working
4. ✅ Deployment workflow tested and verified
5. ✅ Production site live and stable
6. ✅ Security measures in place
7. ✅ Documentation complete

**You're ready to start building the LéO Africa Institute website! 🚀**

---

## 📞 Need Help?

If you encounter issues:

1. Check the `DEPLOYMENT_GUIDE.md` troubleshooting section
2. Review GitHub Actions logs for deployment errors
3. Check Laravel logs: `storage/logs/laravel.log`
4. Verify all environment variables are set correctly
5. Ensure file permissions are correct

---

<p align="center">
  <strong>Happy Building! 🦁</strong>
</p>
