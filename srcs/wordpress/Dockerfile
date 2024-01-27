# Base image of PHP-FPM and other dependencies
FROM alpine:3.18.5

# Install PHP-FPM and additional dependencies
RUN apk update && \
    apk upgrade && \
    apk fix && \
	apk add --no-cache php-fpm && \
	apk add --no-cache php81-mysqli && \
	apk add mysql-client --no-cache

# Create directories & Install WordPress
RUN mkdir -p /usr/share/webapps/ && \
	cd /usr/share/webapps/ && \
	wget https://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz && \
	rm latest.tar.gz

# Create a symbolic link for WordPress
RUN mkdir -p /var/www/localhost/htdocs/wordpress && \
	ln -s /usr/share/webapps/wordpress/ /var/www/localhost/htdocs/wordpress && \
	mkdir /usr/share/webapps/wordpress/portfolio

# Export environment variables
ENV WORDPRESS_DB_HOST=mariadb:3306 \
    WORDPRESS_DB_USER=jokiton \
    WORDPRESS_DB_PASSWORD=pass123 \
    WORDPRESS_DB_NAME=my_database

# Create and copy wp-config.php
COPY wp-config.php /usr/share/webapps/wordpress/
COPY portfolio /var/www/html/
COPY www.conf /etc/php81/php-fpm.d/


# CMD intruction to start PHP-FPM
CMD ["php-fpm81", "--nodaemonize", "-R"]
