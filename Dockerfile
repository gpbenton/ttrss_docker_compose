FROM php:fpm-alpine

RUN apk add --no-cache --virtual .phpextdeps libpng-dev jpeg-dev postgresql-dev

RUN docker-php-ext-install gd  pdo_pgsql pdo_mysql pgsql

# This doesn't work see php bug
#RUN docker-php-ext-install curl

EXPOSE 9000

