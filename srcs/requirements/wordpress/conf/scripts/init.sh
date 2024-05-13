#!/bin/sh

# Waits for MariaDB container to be ready
while true
do
 nc -z mariadb 3306
 if [ $? -eq 0 ]
 then
  echo "MariaDB is ready!"
  break
 fi
  sleep 1
done

# Create necessary directories for PHP-FPM log
mkdir -p /var/log/php81

# Set ownership
wp core download --path=/var/www/html --allow-root
#RUN chmod 655 /var/www/html/wp-config.php

# Useless file since I create a copy of wp-config.php
# wp core config --path=/var/www/html --dbhost="$WORDPRESS_DB_HOST" --dbname="$WORDPRESS_DB_NAME" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root

wp core install --path=/var/www/html --url="$WP_SITEURL" --title="$WP_HOME" --admin_name="$WP_ADMIN_USR" --admin_password="$WP_ADMIN_PWD" --admin_email=$WP_ADMIN_EMAIL
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
wp core update --path=/var/www/html --allow-root

# Change permissions to directories
chown -R jokiton:www-data /var/log/php81
chown -R jokiton:www-data /var/www/html
chmod -R 755 /var/www/html

wp plugin install --path=/var/www/html redis-cache --activate --allow-root
wp plugin activate redis-cache --path=/var/www/html --allow-root
chown -R jokiton:www-data /var/www/html

wp theme install --path=/var/www/html astra --activate --allow-root
wp theme activate astra --path=/var/www/html --allow-root
wp theme status --path=/var/www/html --allow-root

wp rewrite structure '/%postname%/' --path=/var/www/html --allow-root
wp rewrite flush --path=/var/www/html --allow-root

chown -R jokiton:www-data /var/www/html

# wp redis enable --allow-root
# Does not work for some reason..
su jokiton

php-fpm81 -F

