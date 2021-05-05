FROM php:7.1-buster

RUN apt-get -y update && \
    apt-get -y install --no-install-recommends \
        zlib1g-dev \
        libxml2-dev \
        libmcrypt-dev \
        libcurl4-openssl-dev \
        unzip \
    && docker-php-ext-install -j"$(nproc)" mcrypt soap zip intl \
    && pecl install xdebug-2.9.8 \
    && docker-php-ext-enable xdebug \
    && apt-get -y clean

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/bin/composer

WORKDIR /root/php
