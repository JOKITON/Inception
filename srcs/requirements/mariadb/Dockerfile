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

COPY config/scripts/entrypoint.sh entrypoint.sh
RUN chmod +x entrypoint.sh

# Copy MariaDB initialization script
COPY config/scripts/init.sh /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sh

# Expose the default MariaDB port
EXPOSE 3306

# In case my.cnf is needed to check
#COPY config/my.cnf etc/my.cnf

# CMD instruction to start MariaDB
CMD ["sh", "entrypoint.sh"]
#CMD [ "mysqld", "--user=mysql", "--datadir=/var/lib/mysql", "--init-file=/docker-entrypoint-initdb.d/init.sql"]
#CMD ["sleep", "infinity"]