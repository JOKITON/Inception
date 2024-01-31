# Base image of PHP-FPM and other dependencies
FROM alpine:3.18.5

# Install PHP-FPM and additional dependencies
RUN apk update && \
    apk upgrade && \
    apk add --no-cache php-fpm php81 php81-cgi php81-mysqli mysql-client fcgi php81-phar wget php81-mbstring php81-iconv && \
    rm -rf /var/cache/apk/*

# Add a new user
RUN adduser -D -u 1000 -g 'www-data' jokiton

# Create directories & Install WordPress in a directory where the user has write access
RUN mkdir -p /var/www/html/wordpress && \
    chown -R jokiton:nobody /var/www/html/wordpress

# Install wp-cli
RUN wget -O /tmp/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /tmp/wp-cli.phar && \
    mv /tmp/wp-cli.phar /usr/local/bin/wp

# Copy wp-config.php and other files
COPY wp-config.php /var/www/html/wordpress/wp-config.php
COPY portfolio /var/www/html/wordpress/portfolio
COPY www.conf /etc/php81/php-fpm.d/www.conf

# Set ownership
RUN chown -R jokiton:nobody /var/www/html/wordpress
    
#RUN wp core download
RUN wp core download --path=/var/www/html/wordpress --allow-root

# Useless file since I create a copy of wp-config.php
#RUN wp core config --path=/var/www/html/wordpress --dbhost="$WORDPRESS_DB_HOST" --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --allow-root

RUN chmod 655 /var/www/html/wordpress/wp-config.php

#RUN wp core install --path=/var/www/html/wordpress --url=https://localhost --title="WordpressInstallation" --admin_name="$WORDPRESS_DB_USER" --admin_password="$WORDPRESS_DB_PASSWORD" --admin_email=example@gmail.com

# Create necessary directories for PHP-FPM log
RUN mkdir -p /var/log/php81 && \
    chown -R jokiton:nobody /var/log/php81

# Switch to the nobody user for PHP-FPM
USER jokiton

# CMD instruction to start PHP-FPM
#CMD ["php-fpm81", "--nodaemonize"]
#CMD ["sleep", "infinity"]
#CMD ["dockerize", "-wait", "tcp://mariadb:3306", "-timeout", "60s", "wp", "core", "install", "--path=/var/www/html/wordpress", "--url=https://localhost", "--title=localhost", "--admin_name=$WORDPRESS_DB_USER", "--admin_password=$WORDPRESS_DB_PASSWORD", "--admin_email=example@gmail.com", "--allow-root"]

# CMD instruction to start PHP-FPM
CMD ["php-fpm81", "--nodaemonize"]

#CMD [ "wp", "core", "install", "--path=/var/www/html/wordpress", "--url=https://localhost", "--title="WordpressInstallation"", "--admin_name="$WORDPRESS_DB_USER"", "--admin_password="$WORDPRESS_DB_PASSWORD"", "--admin_email=example@gmail.com" ]
#wp core install --path=/var/www/html/wordpress --url=https://localhost --title="WordpressInstallation" --admin_name="$WORDPRESS_DB_USER" --admin_password="$WORDPRESS_DB_PASSWORD" --admin_email=example@gmail.com