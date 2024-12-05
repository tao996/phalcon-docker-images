FROM authus/phalcon:5.7.0

RUN apk add --no-cache supervisor unzip

# supervisor
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www

# 暴露端口
EXPOSE 8787

# 启动脚本
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# docker build -f phalcon-5.7.0-cli.Dockerfile  -t authus/phalcon:5.7.0-cli .