初始化：
---------------------------
```
git clone git@10.0.10.120:OnlineTestSystem/covision-container.git
cd covision-container
#$1:是否重启container, $2:是否执行init_es，$3:是否执行db_seed
sh update.sh 1 1 1
#设置域名，参照./php_nginx/project_conf/nginx-sites.conf
docker exec -i --user www-data php_nginx sed -i "s/[a-z.]*\.covision\.com/www.covision.com/g" .env
```
后面更新：
---------------------------
```
# 更新代码并执行必要命令
cd covision-container 
sh update.sh
```
> 项目路径： ./data/php_nginx/www/covision

其他命令：
---------------------------
####1. 清除Container进程
```
docker-compose stop 
docker stop $(docker ps -a -q)|xargs dcoker rm
```
####2. 本地构建镜像
```
# 全部构建
docker-compose build -f docker-compose-registry-source.yml
# 选择构建
docker-compose build -f docker-compose-registry-source.yml php_nginx
```
####3.本地镜像启动
```
docker-compose up -f docker-compose-registry-source.yml -d
docker-compose up -f docker-compose-registry-source.yml -d php_nginx
```
####4. 其他命令
```
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

