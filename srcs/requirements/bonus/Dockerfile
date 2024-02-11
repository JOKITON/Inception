# Base image of Alpine
FROM alpine:3.18.6

# Install FTP server side and additional dependencies
RUN apk update && apk upgrade --no-cache && \
  rm -rf /var/cache/apk/* && \
  apk add vsftpd openrc --no-cache

RUN rc-update

# Added to give openrc a volume to work with
VOLUME [ “/sys/fs/cgroup” ]

# CMD instruction to start FTP
#CMD ["sh", "entrypoint.sh"]
CMD ["sleep", "infinity"]