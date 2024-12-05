FROM php:8.2-fpm-alpine

COPY scripts/* /usr/local/bin/

# php 默认扩展
# Core,ctype,curl,date,dom,fileinfo,filter,ftp,hash,iconv,json,
# libxml,mbstring,mysqlnd,openssl,pcre,PDO,pdo_sqlite,Phar,posix,random,
# readline,Reflection,session,SimpleXML,sodium,SPL,sqlite3,standard,tokenizer,xml,xmlreader,xmlwriter,zlib
# 安装扩展，尽可能添加多的
# https://github.com/mlocati/docker-php-extension-installer
RUN install-php-extensions apcu bcmath calendar exif gd gettext imagick intl mcrypt memcached mongodb pdo_mysql pdo_pgsql redis xdebug xsl yaml zip
# docker build -f php-8.2.Dockerfile  -t authus/php:8.2-fpm .