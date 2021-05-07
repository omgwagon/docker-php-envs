FROM php:7.3-buster

RUN apt-get -y update && \
    apt-get -y install --no-install-recommends \
        zlib1g-dev \
        libxml2-dev \
        libmcrypt-dev \
        libcurl4-openssl-dev \
        libzip-dev \
        unzip \
    && docker-php-ext-install -j"$(nproc)" soap zip intl \
    && pecl install xdebug-3.0.4 \
    && docker-php-ext-enable xdebug \
    && apt-get -y clean

ENV XDEBUG_MODE=develop,coverage,debug

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/bin/composer

WORKDIR /root/php
