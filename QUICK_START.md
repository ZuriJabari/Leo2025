# ⚡ Quick Start Guide - LéO Africa Institute

Get up and running in minutes!

---

## 🚀 For Local Development

```bash
# 1. Clone the repository
git clone https://github.com/ZuriJabari/Leo2025.git
cd Leo2025

# 2. Install dependencies
composer install
npm install

# 3. Setup environment
cp .env.example .env
php artisan key:generate

# 4. Configure database in .env
# DB_DATABASE=leo_africa
# DB_USERNAME=your_username
# DB_PASSWORD=your_password

# 5. Run migrations
php artisan migrate

# 6. Create storage link
php artisan storage:link

# 7. Build assets
npm run build

# 8. Create admin user
php artisan make:filament-user

# 9. Start development server
php artisan serve
```

Visit: `http://localhost:8000`  
Admin: `http://localhost:8000/admin`

---

## 🌐 For Production Deployment

### Option 1: Automated (GitHub Actions)

1. **Configure GitHub Secrets** (one-time setup)
   - Go to: `https://github.com/ZuriJabari/Leo2025/settings/secrets/actions`
   - Add all required secrets (see DEPLOYMENT_GUIDE.md)

2. **Deploy**
   ```bash
   git add .
   git commit -m "feat: your changes"
   git push origin main
   ```
   
   GitHub Actions will automatically deploy to cPanel!

### Option 2: Manual Deployment

```bash
# 1. Build deployment package
./deploy.sh

# 2. Upload the generated ZIP to cPanel

# 3. Extract in public_html/

# 4. SSH into server and run:
cd public_html
php artisan key:generate
php artisan migrate --force
php artisan storage:link
php artisan config:cache
php artisan route:cache
php artisan view:cache
chmod -R 755 storage bootstrap/cache
```

---

## 📱 Development Workflow

### Daily Development
```bash
# Start dev server with hot reload
npm run dev

# In another terminal
php artisan serve
```

### Making Changes
```bash
# Create feature branch
git checkout -b feature/my-feature

# Make changes, then commit
git add .
git commit -m "feat: description"

# Push to GitHub
git push origin feature/my-feature

# Create Pull Request on GitHub
# Merge to main when approved
```

### Deploying Updates
```bash
# Merge to main branch
git checkout main
git merge feature/my-feature
git push origin main

# Automatic deployment triggers!
```

---

## 🛠️ Common Commands

### Laravel
```bash
php artisan serve              # Start dev server
php artisan migrate            # Run migrations
php artisan migrate:fresh      # Fresh migrations
php artisan db:seed            # Seed database
php artisan make:model Post    # Create model
php artisan make:controller    # Create controller
php artisan cache:clear        # Clear cache
php artisan config:clear       # Clear config cache
php artisan route:list         # List all routes
```

### Filament
```bash
php artisan make:filament-user              # Create admin user
php artisan make:filament-resource Post     # Create resource
php artisan make:filament-page Settings     # Create page
php artisan make:filament-widget StatsWidget # Create widget
```

### Frontend
```bash
npm run dev        # Development with hot reload
npm run build      # Production build
npm run lint       # Lint code
```

### Deployment
```bash
./deploy.sh                    # Build deployment package
php artisan down               # Enable maintenance mode
php artisan up                 # Disable maintenance mode
php artisan config:cache       # Cache config
php artisan route:cache        # Cache routes
php artisan view:cache         # Cache views
```

---

## 🔍 Troubleshooting

### "500 Internal Server Error"
```bash
# Check logs
tail -f storage/logs/laravel.log

# Clear all caches
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear
```

### "Permission Denied"
```bash
chmod -R 755 storage bootstrap/cache
chown -R www-data:www-data storage bootstrap/cache
```

### "Database Connection Failed"
```bash
# Verify .env settings
# Try DB_HOST=127.0.0.1 instead of localhost
```

### Assets Not Loading
```bash
npm run build
php artisan view:clear
```

---

## 📚 Next Steps

1. ✅ **Read the full documentation**
   - [README.md](README.md) - Project overview
   - [DEPLOYMENT_GUIDE.md](DEPLOYMENT_GUIDE.md) - Detailed deployment
   - [SETUP_CHECKLIST.md](SETUP_CHECKLIST.md) - Verification checklist

2. 🎨 **Customize the design**
   - Edit `resources/css/app.css` for styles
   - Modify brand colors in the design system
   - Update `resources/views/welcome.blade.php`

3. 🔧 **Build your features**
   - Create Filament resources for your content
   - Add custom pages and widgets
   - Implement your business logic

4. 🚀 **Deploy to production**
   - Follow the deployment guide
   - Test thoroughly
   - Monitor for errors

---

## 💡 Pro Tips

- Use `php artisan tinker` for quick testing
- Enable Laravel Debugbar in development: `APP_DEBUG=true`
- Use `php artisan pail` for real-time log monitoring
- Keep dependencies updated: `composer update` and `npm update`
- Always test locally before deploying to production
- Use feature branches for new development
- Write descriptive commit messages

---

## 🎯 Key URLs

- **Local Site**: http://localhost:8000
- **Local Admin**: http://localhost:8000/admin
- **Production Site**: (Your domain)
- **Production Admin**: (Your domain)/admin
- **GitHub Repo**: https://github.com/ZuriJabari/Leo2025
- **GitHub Actions**: https://github.com/ZuriJabari/Leo2025/actions

---

<p align="center">
  <strong>Happy Coding! 🦁</strong>
</p>
