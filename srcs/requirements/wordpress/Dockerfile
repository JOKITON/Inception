# Base image of Alpine
FROM alpine:3.18.6

# Install PHP-FPM and additional dependencies
RUN apk update && \
    apk upgrade && \
    apk add --no-cache php-fpm php81 php81-cgi php81-mysqli mysql-client fcgi php81-phar wget php81-mbstring php81-iconv && \
    rm -rf /var/cache/apk/*

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
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

COPY conf/scripts/init.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD [ "/entrypoint.sh" ]