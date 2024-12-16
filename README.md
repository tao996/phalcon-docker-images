# Phalcon Docker Image

build your phalcon docker image

1. 扩展目录 `/usr/local/lib/php/extensions/`
2. 配置目录 `/usr/local/etc/php/conf.d`

| Dockerfile | php version | phalcon version | notice |
|---|---|---|---|
| phalcon-5.8.0-s2.Dockerfile| 8.3.9 | 5.8.0 | remove swoole|
| phalcon-5.8.0-s4.Dockerfile| 8.3.9 | 5.8.0 | add soap, swoole, xmlrpc |
| phalcon-5.8.0-s4clis.Dockerfile | 8.3.9 | 5.8.0 | - |

demo of use these images: [phalcon-admin](https://github.com/tao996/phalcon-admin), [quick start with phalcon-admin](https://tao996.github.io/phalcon-admin-docs/#/zh-cn/start)