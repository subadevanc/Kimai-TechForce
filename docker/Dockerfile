# Stage 1 - Builder
FROM php:8.2-fpm-alpine AS builder

RUN apk add --no-cache git unzip

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# Clear directory first
RUN rm -rf /var/www/*

RUN git clone https://github.com/kevinpapst/kimai2.git .

RUN composer install --no-interaction

# Stage 2 - Production
FROM php:8.2-fpm-alpine

RUN apk add --no-cache nginx supervisor

# Create non-root user
RUN addgroup -S kimai && adduser -S kimai -G kimai

WORKDIR /var/www
COPY --from=builder /var/www /var/www
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./supervisord.conf /etc/supervisord.conf

RUN chown -R kimai:kimai /var/www

USER kimai

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s \
  CMD wget -q --spider http://localhost || exit 1

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
