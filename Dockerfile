FROM php:7.4-apache

MAINTAINER Callum Jones <cj@icj.me>

ENV ZENPHOTO_VERSION 1.5.6
ENV ZENPHOTO_URL "https://github.com/zenphoto/zenphoto/archive/v$ZENPHOTO_VERSION.zip"

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        curl \
        libcurl4 \
        libcurl4-openssl-dev \
        unzip \
        libtidy-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install curl \
    && docker-php-ext-install tidy \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install mysqli
RUN curl -o zenphoto.zip -L $ZENPHOTO_URL && unzip zenphoto.zip -d /tmp/ && mv /tmp/zenphoto-$ZENPHOTO_VERSION/* /var/www/html/ 

RUN ls /var/www/html
RUN chown -R www-data:www-data /var/www/html
