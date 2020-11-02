FROM php:7.4-alpine as builder

RUN mkdir -p /app
WORKDIR /app

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY composer.lock symfony.lock composer.json /app/

RUN composer install --no-dev --no-autoloader --no-scripts

COPY . /app

RUN composer dumpautoload -o -a

FROM php:7.4-alpine as release

COPY --from=builder /app /app

WORKDIR /app
