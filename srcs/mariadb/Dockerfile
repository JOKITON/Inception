# Base image of PHP-FPM and other dependencies
FROM debian:bookworm

# Install MariaDB and additional dependencies

RUN apt update && apt upgrade  && \
  rm -rf /var/cache/apt/*

RUN apt install -y mariadb-server

RUN apt update && apt upgrade

RUN apt full-upgrade && \
  rm -rf /var/cache/apt/* && \
  apt autoremove && apt autoclean

# Copy configuration files
COPY config/my.cnf etc/mysql/my.cnf
COPY config/mariadb.cnf /etc/mysql/mariadb.cnf

# Copy initialization script
COPY config/scripts/init.sql /docker-entrypoint-initdb.d/
RUN chmod +x /docker-entrypoint-initdb.d/init.sql
RUN mkdir /run/mysqld

# Expose the default MariaDB port
EXPOSE 3306

# In case something happens, we create a log file
RUN mkdir -p /var/log/mysql
#RUN service mariadb start
RUN mysql_install_db --user=root --ldata=/var/lib/mysql >> /var/log/mysql/mysql_installation.log
COPY config/my.cnf etc/mysql/my.cnf

# CMD instruction to start MariaDB
CMD [ "mysqld", "--user=root", "--datadir=/var/lib/mysql", "--init-file=/docker-entrypoint-initdb.d/init.sql"]
#CMD ["sleep", "infinity"]