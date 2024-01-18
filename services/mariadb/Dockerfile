# Base image of PHP-FPM and other dependencies
FROM alpine:3.19

# Install PHP-FPM and additional dependencies
RUN apk update && \
    apk upgrade && \
    apk fix && \
    apk add --no-cache mariadb mariadb-client  && \
    mysql_install_db --user=mysql --ldata=/var/lib/mysql --rpm

# Expose the default MariaDB port
EXPOSE 3306

# CMD intruction to start MariaDB
CMD ["sleep", "infinity"]
#CMD ["mysqld", "--user=mysql", "--console"]