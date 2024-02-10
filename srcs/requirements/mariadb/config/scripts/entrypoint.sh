#!/bin/bash

sh /docker-entrypoint-initdb.d/init.sh
chmod +x /docker-entrypoint-initdb.d/init.sql

mkdir -p /var/log/mariadb
mysql_install_db --user=mysql --ldata=/var/lib/mysql >> /var/log/mariadb/mariadb_install.log

mysqld --user=mysql --datadir=/var/lib/mysql --init-file=/docker-entrypoint-initdb.d/init.sql