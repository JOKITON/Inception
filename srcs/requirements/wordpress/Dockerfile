# Base image of PHP-FPM and other dependencies
FROM alpine:3.19

# Install PHP-FPM and additional dependencies
RUN apk update && \
    apk upgrade && \
    apk fix && \
	apk add --no-cache php-fpm php82 php82-cgi php82-mysqli mysql-client fcgi php82-phar wget php82-mbstring php82-iconv

RUN adduser --disabled-password jokiton
RUN adduser jokiton www-data

# Create directories & Install WordPress in a directory where the user has write access
RUN mkdir -p /var/www/
RUN mkdir -p /usr/share/webapps/wordpress
RUN ln -s /usr/share/webapps/wordpress/ /var/www/jaizpuru.42.fr

# Install wp-cli
RUN wget -O /tmp/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /tmp/wp-cli.phar && \
    mv /tmp/wp-cli.phar /usr/local/bin/wp

# Copy wp-config.php and other files
COPY conf/wp-config.php /usr/share/webapps/wordpress/wp-config.php
COPY portfolio /usr/share/webapps/wordpress/portfolio
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf

COPY conf/scripts/init.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD [ "/entrypoint.sh" ]
#CMD ["sleep", "infinity"]