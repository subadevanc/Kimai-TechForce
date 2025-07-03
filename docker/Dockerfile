# Stage 1: Build dependencies
FROM php:8.1-cli AS build

WORKDIR /app

# Install dependencies
RUN apt-get update \
 && apt-get install -y unzip git libicu-dev libzip-dev libpng-dev \
 && docker-php-ext-install intl zip pdo pdo_mysql gd

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy app code
COPY . .

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Stage 2: Production image
FROM php:8.1-apache

WORKDIR /var/www/html

# Enable Apache modules
RUN a2enmod rewrite

# Create non-root user
RUN useradd -ms /bin/bash appuser

# Copy built app
COPY --from=build /app /var/www/html

RUN chown -R appuser:appuser /var/www/html

USER appuser

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=5s \
 CMD curl -f http://localhost/ || exit 1
