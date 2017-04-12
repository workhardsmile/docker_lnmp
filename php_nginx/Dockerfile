FROM 192.168.29.158:5000/php-nginx-base:latest

MAINTAINER  Frank Wu "gang.wu@istuary.com"

# share log file
RUN mkdir -p /data/web/www/covision && mkdir -p /data/web/log
WORKDIR /data/web/www/covision
VOLUME ["/data/web/log","/data/web/www"]

# php fpm
COPY ./project_conf/php-fpm.conf  /usr/local/etc/php-fpm.conf
COPY ./ssh-jenkins /root/.ssh
#COPY ./covision /data/web/www/covision
#COPY ./project_conf/hellotest.php /data/web/www/covision/public

#RUN chmod -R 0700 /root/.ssh && \
#   && git clone --no-checkout "git@10.0.10.120:OnlineTestSystem/covision.git" /data/web/www/covision && \
#   cd /data/web/www/covision && git pull #&& git checkout $(git tag|sort -r|head -n 1)

#COPY ./project_conf/env /data/web/www/covision/.env
COPY ./startup.sh /startup.sh
RUN chmod +x /startup.sh && \
    chmod -R 0700 /root/.ssh && \
    cp -fr /root/.ssh /home/www-data/.ssh && \
    chown -R www-data.www-data /home/www-data/.ssh
#RUN chown -R www-data.www-data /data/web/www/covision && \
#    cd /data/web/www/covision/ && \
#    chmod 777 storage && \
#    chmod 777 bootstrap/cache && \
#    chmod 777 storage/framework/views

#USER www-data
#RUN cd /data/web/www/covision/ && \
#    composer config -g repo.packagist composer https://packagist.phpcomposer.com && \
#    composer install && \
#    composer dump-autoload && \
#    php artisan key:generate

# nginx
USER  root
COPY  ./project_conf/nginx.conf   /etc/nginx/nginx.conf

EXPOSE 80
CMD ["/startup.sh"]
