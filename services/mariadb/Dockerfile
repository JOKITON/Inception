# Base image of PHP-FPM and other dependencies
FROM alpine:3.19

# Install PHP-FPM and additional dependencies
RUN apk update && apk upgrade --no-cache && \
  rm -rf /var/cache/apk/* && \
  apk add openrc mariadb mariadb-client --no-cache

# Copy configuration files
COPY config/my.cnf etc/
COPY config/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

# Copy initialization script
COPY config/scripts/init.sql /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sql

# Expose the default MariaDB port
EXPOSE 3306

RUN mysql_install_db --user=mysql --ldata=/var/lib/mysql

# CMD instruction to start MariaDB
CMD [ "mysqld", "--user=mysql", "--datadir=/var/lib/mysql", "--init-file=/docker-entrypoint-initdb.d/init.sql"]
#CMD ["sleep", "infinity"]