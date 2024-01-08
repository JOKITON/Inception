# Base image of PHP-FPM and other dependencies
FROM alpine:3.18.5

# Install PHP-FPM and additional dependencies
RUN apk update && \
    apk upgrade && \
    apk fix && \
    apk add --no-cache php-fpm && \
    rm -rf /var/cache/apk/*

# Create directories & Install WordPress
RUN mkdir -p /usr/share/webapps/ && \
	cd /usr/share/webapps/ && \
	wget https://wordpress.org/latest.tar.gz && \
	tar -xzvf latest.tar.gz && \
	rm latest.tar.gz

# Create a symbolic link for WordPress
RUN mkdir -p /var/www/localhost/htdocs/wordpress && \
	ln -s /usr/share/webapps/wordpress/ /var/www/localhost/htdocs/wordpress

# Create and copy wp-config.php
COPY wp-config.php /usr/share/webapps/wordpress/

# CMD intruction to start PHP-FPM
CMD ["php-fpm81"]

