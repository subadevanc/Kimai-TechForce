# Stage 1
FROM php:8.1-apache as builder
# ... Install dependencies, clone Kimai, composer install

# Stage 2
FROM php:8.1-apache
COPY --from=builder /var/www/html /var/www/html
RUN useradd -u 1001 kimaiuser && chown -R kimaiuser /var/www/html
USER kimaiuser
EXPOSE 80
HEALTHCHECK CMD curl --fail http://localhost || exit 1
CMD ["apache2-foreground"]
