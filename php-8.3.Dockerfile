FROM php:8.3-fpm-alpine

COPY scripts/* /usr/local/bin/

# php 默认扩展
# Core,ctype,curl,date,dom,fileinfo,filter,ftp,hash,iconv,json,
# libxml,mbstring,mysqlnd,openssl,pcre,PDO,pdo_sqlite,Phar,posix,random,
# readline,Reflection,session,SimpleXML,sodium,SPL,sqlite3,standard,tokenizer,xml,xmlreader,xmlwriter,zlib
# 安装扩展，尽可能添加多的
# https://github.com/mlocati/docker-php-extension-installer


RUN install-php-extensions apcu bcmath calendar exif gd gettext gmp imagick intl mcrypt memcached mongodb pcntl pdo_mysql pdo_pgsql redis xdebug xsl yaml zip

# RUN install-php-extensions apcu bcmath calendar event exif gd gettext imagick intl mcrypt memcached mongodb pcntl pdo_mysql pdo_pgsql redis sync sysvmsg sysvsem sysvshm xdebug xsl yaml zip
# 添加了 event pcntl sync sysvmsg sysvsem sysvshm 扩展

# docker build -f php-8.3.Dockerfile  -t authus/php:8.3-fpm .

# <b>Warning</b>:  PHP Startup: Unable to load dynamic library 'phalcon.so' 
# (tried: /usr/local/lib/php/extensions/no-debug-non-zts-20230831/phalcon.so 
# (Error relocating /usr/local/lib/php/extensions/no-debug-non-zts-20230831/phalcon.so: fast_add_function: symbol not found), 
# /usr/local/lib/php/extensions/no-debug-non-zts-20230831/phalcon.so.so 
# (Error loading shared library /usr/local/lib/php/extensions/no-debug-non-zts-20230831/phalcon.so.so: No such file or directory)) 
# in <b>Unknown</b> on line <b>0</b><br />
# in <b>Unknown</b> on line <b>0</b><br />

# 扩展目录 /usr/local/lib/php/extensions/no-debug-non-zts-20230831/
# 配置目录 /usr/local/etc/php/conf.d/

# 内部重启 php-fpm : kill -USR2 1
# 别人编译的 https://hub.docker.com/r/zhuzhu/php/tags
# https://hub.docker.com/layers/zhuzhu/php/8.3-fpm-phalcon-5.5.0/images/sha256-8ad8bbb07d272df84b290c899f69aa5e07f79bd53dda6768db252f2f07455a35?context=explore

# 资源 
# [hub php](https://hub.docker.com/_/php), [github docker php](https://github.com/docker-library/php)
# [使用说明](https://github.com/docker-library/docs/tree/master/php#how-to-install-more-php-extensions)
# [第三方扩展](https://github.com/mlocati/docker-php-extension-installer)
# [cphalcon docker](https://github.com/phalcon/cphalcon/blob/master/docker/8.3/Dockerfile)