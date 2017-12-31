FROM php:5.6-fpm

RUN apt-get update && apt-get install -y libzip-dev

RUN docker-php-ext-install -j$(nproc) zip

