FROM php:8.3-fpm-alpine

ENV PHALCON_VERSION=5.6.0 REDIS_VERSION=5.3.7 MEMCACHED_VERSION=3.2.0 YAML_VERSION=2.2.2 APCU_VERSION=5.1.22 XDEBUG_VERSION=3.3.1 TZ=America/Los_Angeles
WORKDIR /tmp

# List of docker-php-ext-install extension names
# https://gist.github.com/chronon/95911d21928cff786e306c23e7d1d3f3
RUN apk add --no-cache --virtual build-dependencies build-base tzdata autoconf && \
    apk add --no-cache libzip libmemcached mariadb-connector-c yaml libwebp libevent freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev libzip-dev libmemcached-dev libevent-dev openssl-dev zlib-dev mariadb-connector-c-dev yaml-dev libwebp-dev icu-dev libpq-dev linux-headers && \
    apk add --no-cache bash && \
    docker-php-ext-configure gd --with-freetype --with-webp --with-jpeg=/usr/include/ --enable-gd && \
    docker-php-ext-install gd && \
    docker-php-ext-install mysqli && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install pdo pdo_pgsql && \
    docker-php-ext-install pcntl && \
    docker-php-ext-install sockets && \
    docker-php-ext-install bcmath && \
    docker-php-ext-install exif && \
    docker-php-ext-install intl && \
    pecl install zephir_parser-1.6.0 && \
    pecl install igbinary-3.2.15 && \
    pecl install psr-1.2.0 && \
    pecl install msgpack-2.2.0 && \
    pecl install event-3.1.1 && \
    pecl install ev-1.1.5 && \
    pecl install phalcon-${PHALCON_VERSION} && \
    pecl install redis-${REDIS_VERSION} && \
    pecl install memcached-${MEMCACHED_VERSION} && \
    pecl install yaml-${YAML_VERSION} && \
    pecl install apcu-${APCU_VERSION} && \
    pecl install xdebug-${XDEBUG_VERSION}  && \
    docker-php-ext-install opcache && \
    docker-php-ext-install zip && \
    docker-php-ext-enable phalcon && \
    docker-php-ext-enable psr sockets memcached redis ev apcu yaml zephir_parser msgpack igbinary && \
    docker-php-ext-enable event --ini-name zz-event.ini && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk del --no-cache build-dependencies libzip-dev libmemcached-dev libevent-dev openssl-dev zlib-dev mariadb-connector-c-dev freetype-dev libpng-dev libjpeg-turbo-dev linux-headers && \
    rm -rf /var/cache/apk/* && \
    docker-php-source delete && \
    rm -rf /tmp/* #buildkit

# 移除了 memcache（注意要删除两处）
# docker build -f phalcon-5.6.0.Dockerfile  -t authus/phalcon:5.6.0 .