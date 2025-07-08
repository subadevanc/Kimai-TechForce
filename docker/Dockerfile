# Stage 0 - Composer
FROM composer:2 AS composer

# Stage 1 - Build and runtime
FROM php:8.2-apache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# ✅ Set DocumentRoot to /public
RUN sed -i 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libxml2-dev \
    libxslt-dev \
    libzip-dev \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install intl zip xml xsl gd pdo_mysql

# Set working directory
WORKDIR /var/www/html

# Clone Kimai
RUN rm -rf /var/www/html/* && git clone https://github.com/kevinpapst/kimai2.git .

# Copy Composer from first stage
COPY --from=composer /usr/bin/composer /usr/bin/composer

# Increase memory limit
ENV COMPOSER_MEMORY_LIMIT=-1

# Install PHP dependencies
RUN composer install --no-interaction --no-dev

# Set permissions
RUN chown -R www-data:www-data /var/www/html/var

EXPOSE 80
