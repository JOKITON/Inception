#!/bin/sh

# Set ownership
wp core download --path=/usr/share/webapps/wordpress --allow-root
#RUN chmod 655 /usr/share/webapps/wordpress/wp-config.php

# Useless file since I create a copy of wp-config.php
#wp core config --path=/usr/share/webapps/wordpress --dbhost="$WORDPRESS_DB_HOST" --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --allow-root

# Create necessary directories for PHP-FPM log
mkdir -p /var/log/php82

# Change permissions to directories
chown -R jokiton:www-data /var/log/php82
chown -R jokiton:www-data /usr/share/webapps/wordpress
chmod -R 755 /usr/share/webapps/wordpress

wp core install --path=/usr/share/webapps/wordpress --url=https://jaizpuru.42.fr --title="jaizpuru.42intra.fr" --admin_name="$WORDPRESS_DB_USER" --admin_password="$WORDPRESS_DB_PASSWORD" --admin_email=example@gmail.com
wp core update --path=/usr/share/webapps/wordpress --allow-root

wp plugin install --path=/usr/share/webapps/wordpress redis-cache --activate --allow-root
wp theme install --path=/usr/share/webapps/wordpress astra --activate --allow-root

wp theme status --path=/usr/share/webapps/wordpress --allow-root
wp theme activate astra --path=/usr/share/webapps/wordpress --allow-root
wp plugin activate redis-cache --path=/usr/share/webapps/wordpress --allow-root

wp rewrite structure '/%postname%/' --path=/usr/share/webapps/wordpress --allow-root
wp rewrite flush --path=/usr/share/webapps/wordpress --allow-root

chown -R jokiton:www-data /usr/share/webapps/wordpress

su jokiton

php-fpm82 -R -F