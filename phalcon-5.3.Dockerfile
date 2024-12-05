FROM authus/php:8.2-fpm

ARG PHALCON_VERSION=5.3.1

WORKDIR /usr/src/php/ext

RUN set -xe && \
        docker-php-source extract && \
        # Install ext-phalcon
        curl -LO https://github.com/phalcon/cphalcon/archive/v${PHALCON_VERSION}.tar.gz && tar xzf v${PHALCON_VERSION}.tar.gz && \
        docker-php-ext-install cphalcon-${PHALCON_VERSION}/build/phalcon && \
        # Remove all temp files
        rm -r v${PHALCON_VERSION}.tar.gz cphalcon-${PHALCON_VERSION} && \
        docker-php-source delete && \
        # disabled the xdebug in production
        mv /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini.disabled


WORKDIR /var/www

# docker build -f phalcon-5.3.Dockerfile -t authus/phalcon:5.3 .

# todo
# https://hub.docker.com/_/php
# 需要处理配置的问题，因为 docker-compose.yaml 可能不支持 config 选项
# 1。 如果为 env('debug') 则自动将 xdebug.ini.disabled 修改为 xdebug.ini，反之禁用
# 2。 搜索指定配置下是否有自定义配置文件，如果没有则修改默认的配置文件