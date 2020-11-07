FROM php:7.4-alpine as builder

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY composer.lock symfony.lock composer.json /var/www/html/

RUN composer install --no-dev --no-autoloader --no-scripts

COPY . /var/www/html

RUN composer dumpautoload -o -a && \
    composer dump-env prod

FROM php:7.4-apache as release

ENV TZ='GMT' \
    APACHE_DOCUMENT_ROOT='/var/www/html/public'

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf && \
    sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf && \
    a2enmod rewrite

COPY --from=builder /var/www/html /var/www/html

WORKDIR /var/www/html
