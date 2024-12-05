FROM php:8.3.9-fpm-alpine

ENV TZ=America/Los_Angeles PHALCON_VERSION=5.8.0 REDIS_VERSION=6.1.0 MEMCACHED_VERSION=3.3.0 YAML_VERSION=2.2.4 APCU_VERSION=5.1.24 XDEBUG_VERSION=3.3.2 \
ZEPHIR_PARSER_VERSION=1.6.1 IGBINARY_VERSION=3.2.16 PSR_VERSION=1.2.0 MSGPACK_VERSION=3.0.0 EVENT_VERSION=3.1.4 EV_VERSION=1.2.0 inotify_VERSION=3.0.0
# https://pecl.php.net/package/redis
# https://pecl.php.net/package/memcached
# https://pecl.php.net/package/yaml
# https://pecl.php.net/package/apcu
# https://pecl.php.net/package/xdebug
# https://pecl.php.net/package/zephir_parser
# https://pecl.php.net/package/igbinary
# https://pecl.php.net/package/psr
# https://pecl.php.net/package/msgpack
# https://pecl.php.net/package/event
# https://pecl.php.net/package/ev
# https://pecl.php.net/package/inotify
WORKDIR /tmp

# List of docker-php-extension-install
# https://github.com/mlocati/docker-php-extension-installer
# COPY scripts/install-php-extensions /usr/bin/install-php-extensions
COPY scripts/ /usr/bin/

# List of docker-php-ext-install extension names
# https://gist.github.com/chronon/95911d21928cff786e306c23e7d1d3f3
RUN apk add --no-cache --virtual build-dependencies build-base tzdata autoconf && \
    apk add --no-cache libzip libmemcached mariadb-connector-c yaml libwebp libevent freetype libpng libjpeg-turbo freetype-dev libpng-dev libjpeg-turbo-dev libzip-dev libmemcached-dev libevent-dev openssl-dev zlib-dev mariadb-connector-c-dev yaml-dev libwebp-dev icu-dev libpq-dev linux-headers && \
    apk add --no-cache bash unzip && \
    docker-php-ext-configure gd --with-freetype --with-webp --with-jpeg=/usr/include/ --enable-gd && \
    docker-php-ext-install gd mysqli pdo pdo_mysql pdo_pgsql pcntl sockets bcmath exif intl opcache posix zip && \
    pecl install inotify-${inotify_VERSION}  && \
    pecl install zephir_parser-${ZEPHIR_PARSER_VERSION} && \
    pecl install igbinary-${IGBINARY_VERSION} && \
    pecl install psr-${PSR_VERSION} && \
    pecl install msgpack-${MSGPACK_VERSION} && \
    pecl install event-${EVENT_VERSION} && \
    pecl install ev-${EV_VERSION} && \
    pecl install phalcon-${PHALCON_VERSION} && \
    pecl install redis-${REDIS_VERSION} && \
    pecl install memcached-${MEMCACHED_VERSION} && \
    pecl install yaml-${YAML_VERSION} && \
    pecl install apcu-${APCU_VERSION} && \
    pecl install xdebug-${XDEBUG_VERSION}  && \
    /usr/bin/install-php-extensions soap xmlrpc && \
    # docker-php-ext-enable phalcon && \
    docker-php-ext-enable psr sockets memcached redis ev apcu yaml zephir_parser msgpack igbinary && \
    docker-php-ext-enable event --ini-name zz-event.ini && \
    cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk del --no-cache build-dependencies libzip-dev libmemcached-dev libevent-dev openssl-dev zlib-dev mariadb-connector-c-dev freetype-dev libpng-dev libjpeg-turbo-dev linux-headers && \
    rm -rf /var/cache/apk/* && \
    docker-php-source delete && \
    rm -rf /tmp/* #buildkit

# 添加了 soap, xmlrpc
# 添加了 scripts/*
# 复制 composer.phax 到镜像中
# xdebug 和 phalcon 没有主动激活
# docker build -f phalcon-5.8.0-s5.Dockerfile  -t authus/phalcon:5.8.0-s5 .
