FROM hub.c.163.com/library/alpine:edge

MAINTAINER  Frank Wu "gang.wu@istuary.com"

RUN echo -e "https://mirror.tuna.tsinghua.edu.cn/alpine/edge/main\n\
https://mirror.tuna.tsinghua.edu.cn/alpine/edge/community\n\
https://mirror.tuna.tsinghua.edu.cn/alpine/edge/testing" > /etc/apk/repositories && \
    apk update && \
    apk add --no-cache --update mongodb && \
    rm /usr/bin/mongosniff /usr/bin/mongoperf && \
    rm -f /var/cache/apk/*

RUN mkdir -p /data/db && chmod 0777 /data/db
VOLUME ["/data/db"]

EXPOSE 27017
CMD ["mongod"]