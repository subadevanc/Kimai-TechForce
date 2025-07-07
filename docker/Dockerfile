FROM php:8.2-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    zlib1g-dev \
    && docker-php-ext-install intl zip xml

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set DocumentRoot to /var/www/public
ENV APACHE_DOCUMENT_ROOT /var/www/public

# Update Apache config
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Download Kimai
WORKDIR /var/www
RUN git clone https://github.com/kevinpapst/kimai2.git .

# Install PHP dependencies
RUN composer install --no-interaction

# Fix permissions
RUN chown -R www-data:www-data /var/www
