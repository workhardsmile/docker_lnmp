FROM hub.c.163.com/library/alpine:3.5

MAINTAINER  Frank Wu "gang.wu@istuary.com"

RUN mkdir -p /data/mysql && chmod 0777 /data/mysql && \
    mkdir -p /var/run/mysqld && chmod 0777 /var/run/mysqld
VOLUME ["/data/mysql"]
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh && echo https://mirrors.ustc.edu.cn/alpine/v3.5/main/ > /etc/apk/repositories && \
    apk add --update mysql mysql-client && \
    rm -f /var/cache/apk/*
COPY my.cnf /etc/mysql/my.cnf

EXPOSE 3306
CMD ["/startup.sh"]
