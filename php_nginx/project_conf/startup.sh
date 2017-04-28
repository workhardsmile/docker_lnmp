#!/bin/sh

crond
php-fpm &
/usr/bin/supervisord -c /data/web/conf/supervisor.conf
nginx -g "daemon off;"