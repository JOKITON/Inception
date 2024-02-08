# Base image of PHP-FPM and other dependencies
FROM alpine:3.18.6

# Install PHP-FPM and additional dependencies
RUN apk update && apk upgrade --no-cache && \
  rm -rf /var/cache/apk/* && \
  apk add openrc mariadb mariadb-client --no-cache

# Testing...
#COPY config/my.cnf default_my.cnf

# Copy configuration files
COPY config/my.cnf etc/my.cnf
COPY config/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf

ENV MYSQL_PASSWORD=pass123
ENV MYSQL_ROOT_PASSWORD=pass123

# Copy initialization script
COPY config/scripts/init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh
RUN sh /docker-entrypoint-initdb.d/init.sh
RUN chmod +x /docker-entrypoint-initdb.d/init.sql

# Expose the default MariaDB port
EXPOSE 3306

RUN mkdir -p /var/log/mariadb
RUN mysql_install_db --user=mysql --ldata=/var/lib/mysql >> /var/log/mariadb/mariadb_install.log

# CMD instruction to start MariaDB
CMD [ "mysqld", "--user=mysql", "--datadir=/var/lib/mysql", "--init-file=/docker-entrypoint-initdb.d/init.sql"]
#CMD ["sleep", "infinity"]