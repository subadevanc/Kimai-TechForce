FROM php:8.2-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    libicu-dev \
    libxslt1-dev \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-install intl xsl zip gd

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Clone Kimai
WORKDIR /var/www/html
RUN git clone https://github.com/kevinpapst/kimai2.git .
RUN composer install --no-interaction --no-dev

# Apache config for Kimai (AllowOverride for .htaccess)
RUN echo '<Directory /var/www/html/public>\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/kimai.conf && \
    a2enconf kimai

# Set permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port
EXPOSE 80

# Start Apache
CMD ["apache2-foreground"]
