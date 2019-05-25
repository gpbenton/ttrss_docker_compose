FROM php:fpm-alpine

RUN apk add --no-cache --virtual .phpextdeps libpng-dev jpeg-dev postgresql-dev curl-dev icu-dev

RUN docker-php-ext-install gd  pdo_pgsql pdo_mysql pgsql curl intl

EXPOSE 9000

