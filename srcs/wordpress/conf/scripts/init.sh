#!/bin/sh

# Wait for MariaDB to be ready
sleep 0.1

wp core install --path=/usr/share/webapps --url=https://localhost --title="jaizpuru.42intra.fr" --admin_name="$WORDPRESS_DB_USER" --admin_password="$WORDPRESS_DB_PASSWORD" --admin_email=example@gmail.com

wp plugin install --path=/usr/share/webapps redis-cache --activate --allow-root
wp theme install --path=/usr/share/webapps astra --activate --allow-root

wp theme status --path=/usr/share/webapps --allow-root
wp theme activate astra --path=/usr/share/webapps --allow-root
wp plugin activate redis-cache --path=/usr/share/webapps --allow-root

wp rewrite --path=/usr/share/webapps structure '/%postname%/'
wp rewrite --path=/usr/share/webapps list
wp rewrite --path=/usr/share/webapps flush

chown -R jokiton:www-data /usr/share/webapps

su jokiton

php-fpm81 -F