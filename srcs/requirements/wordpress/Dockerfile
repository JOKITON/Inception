# Base image of PHP-FPM and other dependencies
FROM debian:bookworm

# Install PHP-FPM and additional dependencies
RUN apt update && \
    apt upgrade && \
    apt install -y wget sudo php-common php-imap php-redis php-snmp php-xml php-mysqli php-zip php-mbstring php-curl libapache2-mod-php php-fpm mariadb-client && \
    rm -rf /var/cache/apt/* && \
    apt full-upgrade && \
    apt autoremove

RUN adduser --disabled-password --gecos "" jokiton
RUN usermod -aG sudo jokiton
RUN adduser jokiton www-data

# Create directories & Install WordPress in a directory where the user has write access
RUN mkdir -p /var/www/jaizpuru.42.fr/htdocs/wordpress
RUN mkdir -p /usr/share/webapps/

# Install wp-cli
RUN wget -O /tmp/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /tmp/wp-cli.phar && \
    mv /tmp/wp-cli.phar /usr/local/bin/wp

# Copy wp-config.php and other files
COPY conf/wp-config.php /usr/share/webapps/wp-config.php
RUN chmod 600 /usr/share/webapps/wp-config.php
COPY portfolio /usr/share/webapps/portfolio
COPY conf/php-fpm.conf /etc/php/8.2/fpm/php-fpm.conf
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

COPY conf/scripts/wp-cli.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

RUN chown -R jokiton:www-data /etc/php/8.2/fpm/

# Set ownership
RUN wp core download --path=/usr/share/webapps/ --allow-root
COPY conf/wp-config.php /usr/share/webapps/wp-config.php
RUN chmod 600 /usr/share/webapps/wp-config.php

# Useless file since I create a copy of wp-config.php
#RUN wp core config --path=/var/www/html/wordpress --dbhost="$WORDPRESS_DB_HOST" --dbname="$WORDPRESS_DB_NAME" --dbuser="$WORDPRESS_DB_USER" --dbpass="$WORDPRESS_DB_PASSWORD" --allow-root

# Create necessary directories for PHP-FPM log
RUN mkdir -p /var/log/php/8.2/fpm
RUN mkdir -p /var/log/wp

# Change permissions to directories
RUN chown -R jokiton:www-data /var/log/php
RUN chown -R jokiton:www-data /usr/share/webapps

RUN touch /var/log/wp/installation_error.log
RUN chmod 777 /var/log/wp/installation_error.log

CMD ["/entrypoint.sh"]

# Switch to the nobody user for PHP-FPM
#USER www-data