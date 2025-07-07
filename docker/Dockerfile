FROM php:8.2-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libicu-dev \
    libxslt1-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zlib1g-dev \
    && docker-php-ext-install \
        intl \
        zip \
        xsl \
        gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Clone Kimai
RUN git clone https://github.com/kevinpapst/kimai2.git .

# Set correct permissions
RUN chown -R www-data:www-data /var/www/html/var

# Increase Composer memory limit
ENV COMPOSER_MEMORY_LIMIT=-1

# Install PHP dependencies
RUN composer install --no-interaction --no-dev

# Expose port
EXPOSE 80

CMD ["apache2-foreground"]
