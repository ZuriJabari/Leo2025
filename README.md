# 🦁 LéO Africa Institute Website

<p align="center">
  <strong>A modern, production-ready Laravel + Filament application</strong>
</p>

<p align="center">
  <a href="https://laravel.com"><img src="https://img.shields.io/badge/Laravel-12.x-FF2D20?style=flat&logo=laravel" alt="Laravel"></a>
  <a href="https://filamentphp.com"><img src="https://img.shields.io/badge/Filament-3.x-F59E0B?style=flat" alt="Filament"></a>
  <a href="https://github.com/ZuriJabari/Leo2025"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License"></a>
</p>

---

## 📋 Table of Contents

- [About](#about)
- [Tech Stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Local Development Setup](#local-development-setup)
- [Deployment](#deployment)
- [Project Structure](#project-structure)
- [Development Workflow](#development-workflow)
- [Contributing](#contributing)

---

## 🎯 About

The LéO Africa Institute website is a professional, modern web application built with Laravel and Filament. This project features:

- **🎨 Modern UI/UX** - Built with TailwindCSS and Filament's elegant admin panel
- **🔐 Robust Authentication** - Secure user management with role-based permissions
- **📱 Responsive Design** - Mobile-first, accessible design system
- **🚀 Automated Deployment** - GitHub Actions CI/CD to cPanel
- **📊 Activity Logging** - Complete audit trail with Spatie Activity Log
- **🖼️ Media Management** - Advanced media library with Spatie Media Library
- **⚡ Performance Optimized** - Cached routes, views, and configurations

---

## 🛠️ Tech Stack

### Backend
- **Laravel 12.x** - PHP framework
- **Filament 3.x** - Admin panel and form builder
- **MySQL** - Database
- **Spatie Packages** - Permission, Activity Log, Media Library

### Frontend
- **TailwindCSS 3.x** - Utility-first CSS framework
- **Alpine.js** - Lightweight JavaScript framework
- **Livewire 3.x** - Dynamic interfaces without leaving PHP
- **Vite** - Modern frontend build tool

### Development
- **Laravel Debugbar** - Development debugging
- **Laravel Pint** - Code style fixer
- **PHPUnit** - Testing framework

---

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- **PHP 8.3+** with extensions: `mbstring`, `xml`, `ctype`, `json`, `bcmath`, `pdo`, `mysql`
- **Composer 2.x**
- **Node.js 20.x+** and npm
- **MySQL 8.0+** or MariaDB 10.3+
- **Git**

---

## 🚀 Local Development Setup

### 1. Clone the Repository

```bash
git clone https://github.com/ZuriJabari/Leo2025.git
cd Leo2025
```

### 2. Install Dependencies

```bash
# Install PHP dependencies
composer install

# Install Node dependencies
npm install
```

### 3. Environment Configuration

```bash
# Copy environment file
cp .env.example .env

# Generate application key
php artisan key:generate
```

### 4. Configure Database

Edit `.env` file with your database credentials:

```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=leo_africa
DB_USERNAME=your_username
DB_PASSWORD=your_password
```

### 5. Run Migrations

```bash
# Run database migrations
php artisan migrate

# (Optional) Seed database with sample data
php artisan db:seed
```

### 6. Create Storage Link

```bash
php artisan storage:link
```

### 7. Build Frontend Assets

```bash
# Development build with hot reload
npm run dev

# Production build
npm run build
```

### 8. Start Development Server

```bash
php artisan serve
```

Visit `http://localhost:8000` in your browser.

### 9. Create Admin User

```bash
php artisan make:filament-user
```

Access the admin panel at `http://localhost:8000/admin`

---

## 🌐 Deployment

### Automated Deployment (GitHub Actions)

This project uses GitHub Actions for automated deployment to cPanel.

#### Setup GitHub Secrets

Go to your repository → Settings → Secrets and variables → Actions, and add:

| Secret Name | Description | Example |
|-------------|-------------|---------|
| `APP_URL` | Your production URL | `https://leoafricainstitute.org` |
| `DB_HOST` | Database host | `localhost` |
| `DB_DATABASE` | Database name | `leo_africa_prod` |
| `DB_USERNAME` | Database username | `leo_user` |
| `DB_PASSWORD` | Database password | `your_secure_password` |
| `FTP_SERVER` | cPanel FTP server | `ftp.yourdomain.com` |
| `FTP_USERNAME` | cPanel FTP username | `username@yourdomain.com` |
| `FTP_PASSWORD` | cPanel FTP password | `your_ftp_password` |
| `SSH_HOST` | cPanel SSH host (optional) | `yourdomain.com` |
| `SSH_USERNAME` | cPanel SSH username (optional) | `username` |
| `SSH_PASSWORD` | cPanel SSH password (optional) | `your_ssh_password` |
| `SSH_PORT` | SSH port (optional) | `22` |

#### Deploy

Push to the `main` branch to trigger automatic deployment:

```bash
git add .
git commit -m "feat: your changes"
git push origin main
```

### Manual Deployment

Use the included deployment script:

```bash
./deploy.sh
```

This will:
1. Install production dependencies
2. Build frontend assets
3. Create a deployment package
4. Generate a timestamped ZIP file

Upload the generated ZIP file to your cPanel server and extract it.

#### Post-Deployment Steps on cPanel

```bash
# Navigate to your web directory
cd public_html

# Generate application key (first time only)
php artisan key:generate

# Run migrations
php artisan migrate --force

# Create storage link
php artisan storage:link

# Cache configurations
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Set permissions
chmod -R 755 storage bootstrap/cache
```

---

## 📁 Project Structure

```
Leo2025/
├── app/
│   ├── Filament/          # Filament admin resources
│   ├── Http/              # Controllers, middleware
│   ├── Models/            # Eloquent models
│   └── Providers/         # Service providers
├── config/                # Configuration files
├── database/
│   ├── migrations/        # Database migrations
│   └── seeders/           # Database seeders
├── public/                # Public assets
├── resources/
│   ├── css/               # Stylesheets
│   ├── js/                # JavaScript
│   └── views/             # Blade templates
├── routes/                # Application routes
├── storage/               # Logs, cache, uploads
├── tests/                 # Test files
├── .github/
│   └── workflows/         # CI/CD workflows
├── deploy.sh              # Manual deployment script
└── README.md              # This file
```

---

## 💻 Development Workflow

### Branching Strategy

- `main` - Production branch (protected)
- `dev` - Development branch
- `feature/*` - Feature branches
- `bugfix/*` - Bug fix branches

### Commit Message Convention

Follow conventional commits:

```
feat: add new feature
fix: bug fix
docs: documentation changes
style: code style changes
refactor: code refactoring
test: add tests
chore: maintenance tasks
```

### Code Quality

```bash
# Format code with Laravel Pint
./vendor/bin/pint

# Run tests
php artisan test
```

---

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License.

---

## 🙏 Acknowledgments

- [Laravel](https://laravel.com) - The PHP Framework
- [Filament](https://filamentphp.com) - Admin Panel
- [Spatie](https://spatie.be) - Laravel Packages
- [TailwindCSS](https://tailwindcss.com) - CSS Framework

---

<p align="center">
  Made with ❤️ for LéO Africa Institute
</p>
