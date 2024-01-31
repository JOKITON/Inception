sleep 1
wp core install --path=/var/www/html/wordpress --url=https://localhost --title="jaizpuru.42intra.fr" --admin_name="$WORDPRESS_DB_USER" --admin_password="$WORDPRESS_DB_PASSWORD" --admin_email=example@gmail.com
mkdir -p /var/log/php81
chown -R jokiton:nobody /var/log/php81

php-fpm81 --nodaemonize