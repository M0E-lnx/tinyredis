FROM m0elnx/alpine-x86:latest

MAINTAINER M0E-Lnx

ENV REDIS_USER=redis \
	REDIS_DATA_DIR=/var/lib/redis \
	REDIS_LOG_DIR=/var/log/redis

RUN apk add --no-cache redis bash\
 && sed 's/^daemonize yes/daemonize no/' -i /etc/redis.conf \
 && sed 's/^bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis.conf \
 && sed 's/^# unixsocket /unixsocket /' -i /etc/redis.conf \
 && sed 's/^# unixsocketperm 755/unixsocketperm 777/' -i /etc/redis.conf \
 && sed '/^logfile/d' -i /etc/redis.conf

#	&& sed 's/^daemonize yes/daemonize no/' -i /etc/redis.conf \
#	&& sed 's/# bind 127.0.0.1/bind 0.0.0.0/' -i /etc/redis.conf \
#	&& sed 's/# unixsocket /unixsocket /' -i /etc/redis.conf \
#	&& sed 's/# unixsockerperm 755/unixsocketperm 777/' -i /etc/redis.conf \
#	&& sed 's/^logfile/d' -i /etc/redis.conf

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 6379/tcp

VOLUME [ "${REDIS_DATA_DIR}" ]

ENTRYPOINT [ "/sbin/entrypoint.sh" ]
