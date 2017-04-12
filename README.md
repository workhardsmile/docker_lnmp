> 更新container工程

```
# 第一次
git clone git@10.0.10.120:OnlineTestSystem/covision-container.git
# 以后每次更新
cd covision-container 
git pull
```

1、启动容器和更新代码（常用）
---------------------------
```
# 重启container
docker-compose stop
docker-compose up php_nginx -d
# 更新代码并重启queue（每次更新covision项目）
sh update.sh
```
> 项目路径： ./data/php_nginx/www/covision

2、清除Container进程
---------------------------
```
docker-compose stop 
docker stop $(docker ps -a -q)|xargs dcoker rm
```
3、本地构建镜像
---------------------------
```
# 全部构建
docker-compose build -f docker-compose-registry-source.yml
# 选择构建
docker-compose build -f docker-compose-registry-source.yml php_nginx
```
4、本地镜像启动
---------------------------
```
docker-compose up -f docker-compose-registry-source.yml -d
docker-compose up -f docker-compose-registry-source.yml -d php_nginx
```
5、执行一次
---------------------------
```
#本地.env可以不修改APP_URL
cp -f ./php_nginx/project_conf/env.example ./data/php_nginx/www/covision/.env
docker exec -i --user www-data php_nginx composer install
docker exec -i --user www-data php_nginx php artisan migrate:install
docker exec -i --user www-data php_nginx php artisan migrate
docker exec -i --user www-data php_nginx php artisan db:seed
docker exec -i --user www-data php_nginx composer dump-autoload
docker exec -i --user www-data php_nginx php artisan storage:link
docker exec -i --user www-data php_nginx sh init.sh
docker exec -i --user www-data php_nginx php artisan key:generate
docker exec -i --user www-data php_nginx php artisan init:es
```

