FROM 192.168.29.158:5000/php-nginx-alpine:no-code

MAINTAINER  Frank Wu "gang.wu@istuary.com"

RUN echo -e "http://mirrors.aliyun.com/alpine/v3.5/main\n\
http://mirrors.aliyun.com/alpine/v3.5/community" > /etc/apk/repositories
COPY ./startup.sh /startup.sh
RUN chmod +x /startup.sh &&\
    apk add  --update busybox-suid &&\
    apk add --update py-pip &&\
    pip install supervisor &&\
    echo "* * * * * /usr/local/bin/php /data/web/www/covision/artisan schedule:run >> /dev/null 2>&1">/etc/crontabs/www-data &&\
    chmod 0600 /etc/crontabs/www-data

# share file
RUN mkdir -p /data/web/www/covision && mkdir -p /data/web/conf && mkdir -p /data/web/log
WORKDIR /data/web/www/covision
VOLUME ["/data/web/log","/data/web/www", "/data/web/conf"]

COPY ./php-fpm.conf  /usr/local/etc/php-fpm.conf
COPY ./nginx.conf   /etc/nginx/nginx.conf
COPY ./nginx-sites.conf /data/web/conf/nginx-sites.conf
COPY ./supervisor.conf /data/web/conf/supervisor.conf

EXPOSE 80 443
CMD ["/startup.sh"]