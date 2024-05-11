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
wp core download --path=/var/www/wordpress --allow-root
#RUN chmod 655 /var/www/wordpress/wp-config.php

# Useless file since I create a copy of wp-config.php
#wp core config --path=/var/www/wordpress --dbhost="$WORDPRESS_DB_HOST" --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --allow-root

wp core install --path=/var/www/wordpress --url=https://jaizpuru.42.fr --title="jaizpuru.42.fr" --admin_name="$WORDPRESS_DB_USER" --admin_password="$WORDPRESS_DB_PASSWORD" --admin_email=example@gmail.com
wp core update --path=/var/www/wordpress --allow-root

# Change permissions to directories
chown -R jokiton:www-data /var/log/php81
chown -R jokiton:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

wp plugin install --path=/var/www/wordpress redis-cache --activate --allow-root
wp theme install --path=/var/www/wordpress astra --activate --allow-root

wp theme status --path=/var/www/wordpress --allow-root
wp theme activate astra --path=/var/www/wordpress --allow-root
wp plugin activate redis-cache --path=/var/www/wordpress --allow-root

wp rewrite structure '/%postname%/' --path=/var/www/wordpress --allow-root
wp rewrite flush --path=/var/www/wordpress --allow-root

chown -R jokiton:www-data /var/www/wordpress

su jokiton

php-fpm81 -F

