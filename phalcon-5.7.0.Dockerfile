FROM php:8.3-fpm-alpine

# https://pecl.php.net/package/redis
# https://pecl.php.net/package/memcached
# https://pecl.php.net/package/yaml
# https://pecl.php.net/package/apcu
# https://pecl.php.net/package/xdebug
ENV PHALCON_VERSION=5.7.0 REDIS_VERSION=6.0.2 MEMCACHED_VERSION=3.2.0 YAML_VERSION=2.2.3 APCU_VERSION=5.1.23 XDEBUG_VERSION=3.3.2 TZ=America/Los_Angeles \
    ZEPHIR_PARSER_VERSION=1.6.0 IGBINARY_VERSION=3.2.15 PSR_VERSION=1.2.0 MSGPACK_VERSION=2.2.0 EVENT_VERSION=3.1.3 EV_VERSION=1.1.5
# https://pecl.php.net/package/zephir_parser
# https://pecl.php.net/package/igbinary
# 
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
    docker-php-ext-install opcache && \
    docker-php-ext-install posix && \
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

# 移除了 memcache （注意要删除两处）
# docker build -f phalcon-5.7.0.Dockerfile  -t authus/phalcon:5.7.0 .