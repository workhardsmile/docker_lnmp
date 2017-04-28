#!/bin/bash
tag=develop
restart_docker=false
init_es=false
db_seed=false
[ -n "$1" ] && restart_docker=$1
[ -n "$2" ] && init_es=$2
[ -n "$3" ] && db_seed=$3
[ ! -d "../data/php_nginx/www/covision" ] && git clone "git@10.0.10.120:OnlineTestSystem/covision.git" ../data/php_nginx/www/covision
#mkdir -p ../data/php_nginx/www/covision && cp -fr ./data/php_nginx/www/covision ../data/php_nginx/www/
mkdir -p ../data/elasticsearch/config && cp -fr ./elasticsearch/config/* ../data/elasticsearch/config/
mkdir -p ../data/php_nginx/conf && cp -f ./php_nginx/project_conf/nginx-sites.conf ../data/php_nginx/conf/
mkdir -p ../data/php_nginx/conf && cp -f ./php_nginx/project_conf/supervisor.conf ../data/php_nginx/conf/
if [ "$restart_docker" != "false" ]; then
  docker-compose stop
  docker stop $(docker ps -a -q)|xargs docker rm ; docker rmi $(docker images | grep "^<none>" | awk '{print $3}') -f
  docker-compose up -d php_nginx
fi
registration_name="php_nginx" #"php-nginx-alpine"
container_id=0
while [ "$container_id" = "0" ]
 do
    container_id=$(docker ps|grep "$registration_name"|awk '{print $1}')
    [ "$container_id" = "" ] && container_id=0
 done
echo $container_id
if [ "$init_es" != "false" ]; then
  cp -f ./php_nginx/project_conf/env.example ./../data/php_nginx/www/covision/.env
  #docker exec -i $container_id chmod -R 777 storage bootstrap/cache storage/framework/views
  #docker exec -i $container_id chown -R www-data:www-data /data/web/www/covision
  docker exec -i --user www-data $container_id composer install
  docker exec -i --user www-data $container_id php artisan migrate:install
  docker exec -i --user www-data $container_id php artisan key:generate
  docker exec -i --user www-data $container_id killall -9 php
fi
docker exec -i --user www-data $container_id git checkout $tag
docker exec -i --user www-data $container_id git pull
docker exec -i --user www-data $container_id sh init.sh
if [ "$init_es" != "false" ]; then
  docker exec -i --user www-data $container_id php artisan init:es
fi
if [ "$db_seed" != "false" ]; then
  docker exec -i --user www-data $container_id php artisan db:seed
fi
