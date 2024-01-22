# Base image of PHP-FPM and other dependencies
FROM alpine:3.19

# Install PHP-FPM and additional dependencies
RUN apk update && apk upgrade --no-cache && \
  rm -rf /var/cache/apk/* && \
  apk add openrc mariadb mariadb-client --no-cache && \
  openrc && \
  mkdir -p /run/openrc && touch /run/openrc/softlevel && \
  /etc/init.d/mariadb setup && \
  rc-service mariadb start



# Expose the default MariaDB port
EXPOSE 3306

COPY config/init.sql /docker-entrypoint-initdb.d/
COPY config/my.cnf etc/
COPY config/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# CMD intruction to start MariaDB
CMD ["/usr/bin/mysqld", "--user=mysql"]