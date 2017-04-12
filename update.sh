#!/bin/bash
git pull
[ ! -d "./data/php_nginx/www/covision" ] && git clone "git@10.0.10.120:OnlineTestSystem/covision.git" ./data/php_nginx/www/covision
cd ./data/php_nginx/www/covision
#git pull
#git checkout develop
cp -f ./php_nginx/project_conf/env.example ./data/php_nginx/www/covision/.env
#docker exec -i php_nginx chmod -R 777 storage bootstrap/cache storage/framework/views
#docker exec -i php_nginx chown -R www-data:www-data /data/web/www/covision
docker exec -i --user www-data php_nginx git pull
docker exec -i --user www-data php_nginx git checkout develop
docker exec -i --user www-data php_nginx php artisan key:generate
docker exec -i --user www-data php_nginx php artisan migrate:install
docker exec -i --user www-data php_nginx sh init.sh
#kill -9 $(ps -ef|grep 'queue:work'|grep -v grep|awk '{print $2}')
#docker exec -i --user www-data php_nginx php artisan queue:work --queue=emails &