#!/bin/sh

# Wait for MariaDB to be ready
sleep 0.1

sudo -u jokiton -i -- wp core install --path=/usr/share/webapps --url=https://localhost --title="jaizpuru.42intra.fr" --admin_name="$WORDPRESS_DB_USER" --admin_password="$WORDPRESS_DB_PASSWORD" --admin_email=example@gmail.com

sudo -u jokiton -i -- wp plugin install --path=/usr/share/webapps redis-cache --activate --allow-root 
sudo -u jokiton -i -- wp theme install --path=/usr/share/webapps astra --activate --allow-root 

sudo -u jokiton -i -- wp theme status --path=/usr/share/webapps --allow-root 
sudo -u jokiton -i -- wp theme activate astra --path=/usr/share/webapps --allow-root 
sudo -u jokiton -i -- wp plugin activate redis-cache --path=/usr/share/webapps --allow-root 

sudo -u jokiton -i -- wp rewrite --path=/usr/share/webapps structure '/%postname%/' --allow-root 
sudo -u jokiton -i -- wp rewrite --path=/usr/share/webapps list --allow-root 
sudo -u jokiton -i -- wp rewrite --path=/usr/share/webapps flush --allow-root

chown -R jokiton:www-data /usr/share/webapps

#service php-fpm82 start
php8.2
sleep infinity
#exec "$@"  # This will execute the CMD from the Dockerfile