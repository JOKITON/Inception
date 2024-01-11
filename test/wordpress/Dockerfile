# Base image of PHP-FPM and other dependencies
FROM alpine:3.19

# Install PHP-FPM and additional dependencies
RUN apk update && \
    apk upgrade && \
    apk fix && \
    apk add --no-cache php-fpm

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

# Expose port to communicate with Nginx
EXPOSE 9000
# Expose port to communicate with MariaDB
#EXPOSE 3306

# Create and copy wp-config.php
COPY wp-config.php /usr/share/webapps/wordpress/
COPY portfolio /usr/share/webapps/wordpress/portfolio

# CMD intruction to start PHP-FPM
CMD ["php-fpm82", "--nodaemonize"]
