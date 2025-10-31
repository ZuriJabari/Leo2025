#!/bin/bash

###############################################################################
# LéO Africa Institute - Manual Deployment Script
# This script builds and packages the Laravel application for cPanel deployment
###############################################################################

set -e

echo "🚀 LéO Africa Institute - Deployment Builder"
echo "=============================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
PACKAGE_NAME="leo-africa-laravel-${TIMESTAMP}.zip"
DEPLOY_DIR="deployment-package"

echo -e "${BLUE}📦 Step 1: Installing Composer dependencies...${NC}"
composer install --no-dev --optimize-autoloader --no-interaction --prefer-dist

echo ""
echo -e "${BLUE}📦 Step 2: Installing NPM dependencies...${NC}"
npm ci

echo ""
echo -e "${BLUE}🏗️  Step 3: Building frontend assets...${NC}"
npm run build

echo ""
echo -e "${BLUE}🗂️  Step 4: Creating deployment package...${NC}"

# Clean up old deployment directory
rm -rf ${DEPLOY_DIR}
mkdir -p ${DEPLOY_DIR}

# Copy files excluding unnecessary items
rsync -av --progress \
      --exclude='.git' \
      --exclude='node_modules' \
      --exclude='tests' \
      --exclude='.github' \
      --exclude='storage/logs/*' \
      --exclude='storage/framework/cache/*' \
      --exclude='storage/framework/sessions/*' \
      --exclude='storage/framework/views/*' \
      --exclude='.env' \
      --exclude='.env.example' \
      --exclude='phpunit.xml' \
      --exclude='deploy.sh' \
      ./ ${DEPLOY_DIR}/

echo ""
echo -e "${YELLOW}⚠️  Please create .env file for production${NC}"
echo "Creating template .env in deployment package..."

cat > ${DEPLOY_DIR}/.env << 'EOF'
APP_NAME="LéO Africa Institute"
APP_ENV=production
APP_KEY=
APP_DEBUG=false
APP_TIMEZONE=UTC
APP_URL=https://yourdomain.com

APP_LOCALE=en
APP_FALLBACK_LOCALE=en
APP_FAKER_LOCALE=en_US

APP_MAINTENANCE_DRIVER=file
APP_MAINTENANCE_STORE=database

BCRYPT_ROUNDS=12

LOG_CHANNEL=stack
LOG_STACK=single
LOG_DEPRECATIONS_CHANNEL=null
LOG_LEVEL=error

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=your_database_name
DB_USERNAME=your_database_user
DB_PASSWORD=your_database_password

SESSION_DRIVER=database
SESSION_LIFETIME=120
SESSION_ENCRYPT=false
SESSION_PATH=/
SESSION_DOMAIN=null

BROADCAST_CONNECTION=log
FILESYSTEM_DISK=local
QUEUE_CONNECTION=database

CACHE_STORE=database
CACHE_PREFIX=

MEMCACHED_HOST=127.0.0.1

REDIS_CLIENT=phpredis
REDIS_HOST=127.0.0.1
REDIS_PASSWORD=null
REDIS_PORT=6379

MAIL_MAILER=log
MAIL_HOST=127.0.0.1
MAIL_PORT=2525
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS="hello@example.com"
MAIL_FROM_NAME="${APP_NAME}"

AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
AWS_DEFAULT_REGION=us-east-1
AWS_BUCKET=
AWS_USE_PATH_STYLE_ENDPOINT=false

VITE_APP_NAME="${APP_NAME}"
EOF

echo ""
echo -e "${BLUE}📦 Step 5: Creating ZIP archive...${NC}"
cd ${DEPLOY_DIR}
zip -r ../${PACKAGE_NAME} . -x "*.git*" "*.DS_Store" "*Thumbs.db" > /dev/null
cd ..

echo ""
echo -e "${GREEN}✅ Deployment package created successfully!${NC}"
echo ""
echo "📦 Package: ${PACKAGE_NAME}"
echo "📊 Size: $(du -h ${PACKAGE_NAME} | cut -f1)"
echo ""
echo -e "${YELLOW}📋 Next Steps:${NC}"
echo "1. Extract ${PACKAGE_NAME} on your cPanel server"
echo "2. Update the .env file with your production credentials"
echo "3. Run: php artisan key:generate"
echo "4. Run: php artisan migrate --force"
echo "5. Run: php artisan storage:link"
echo "6. Run: php artisan config:cache"
echo "7. Run: php artisan route:cache"
echo "8. Run: php artisan view:cache"
echo "9. Set permissions: chmod -R 755 storage bootstrap/cache"
echo ""
echo -e "${GREEN}🎉 Ready to deploy!${NC}"
