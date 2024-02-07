#!/bin/sh

# Wait for MariaDB to be ready
# sleep 0.1

wp core install --path=/usr/share/webapps --url=https://jaizpuru.42.fr --title="jaizpuru.42intra.fr" --admin_name="$WORDPRESS_DB_USER" --admin_password="$WORDPRESS_DB_PASSWORD" --admin_email=jokinaizpuru28@gmail.com --allow-root

wp plugin install --path=/usr/share/webapps redis-cache --activate --allow-root 
wp theme install --path=/usr/share/webapps astra --activate --allow-root 

wp theme status --path=/usr/share/webapps --allow-root 
wp theme activate astra --path=/usr/share/webapps --allow-root 
wp plugin activate redis-cache --path=/usr/share/webapps --allow-root 

wp rewrite --path=/usr/share/webapps structure '/%postname%/' --allow-root 
wp rewrite --path=/usr/share/webapps list --allow-root 
wp rewrite --path=/usr/share/webapps flush --allow-root

wp core update --path=/usr/share/webapps --allow-root
wp core language update --path=/usr/share/webapps --allow-root
wp plugin update --path=/usr/share/webapps --all --allow-root
wp theme update --path=/usr/share/webapps --all --allow-root
wp core update-db --path=/usr/share/webapps --allow-root
wp db repair --path=/usr/share/webapps --allow-root
wp db optimize --path=/usr/share/webapps --allow-root

chown -R jokiton:www-data /usr/share/webapps

php-fpm8.2 -F
#exec "$@"  # This will execute the CMD from the Dockerfile