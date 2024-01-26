# Base image of PHP-FPM and other dependencies
FROM alpine:3.19

# Install PHP-FPM and additional dependencies
RUN apk update && apk upgrade --no-cache && \
  rm -rf /var/cache/apk/* && \
  apk add openrc mariadb mariadb-client --no-cache && \
  openrc && \
  mkdir -p /run/openrc && touch /run/openrc/softlevel

# Copy configuration files
COPY config/my.cnf etc/
COPY config/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Copy initialization script
COPY config/init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

# Expose the default MariaDB port
EXPOSE 3306

# CMD instruction to start MariaDB
CMD [ "mysqld", "--user=mysql"]
