# Stage 1
FROM php:8.1-apache AS builder
WORKDIR /var/www/html
RUN apt-get update && apt-get install -y unzip git zip curl libicu-dev libonig-dev libzip-dev \
    && docker-php-ext-install intl pdo pdo_mysql zip
RUN git clone https://github.com/kevinpapst/kimai2.git . \
    && curl -sS https://getcomposer.org/installer | php && php composer.phar install --no-dev

# Stage 2
FROM php:8.1-apache
COPY --from=builder /var/www/html /var/www/html
RUN a2enmod rewrite && useradd -m kimai
USER kimai
HEALTHCHECK --interval=30s CMD curl -f http://localhost || exit 1
EXPOSE 80
CMD ["apache2-foreground"]
