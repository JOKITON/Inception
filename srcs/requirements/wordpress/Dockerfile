# Base image of Alpine
FROM alpine:3.18.6

# Install PHP-FPM and additional dependencies
RUN apk update && \
    apk upgrade && \
    apk add --no-cache php81-fpm php81 php81-mysqli php81-phar wget php81-mbstring php81-iconv && \
    rm -rf /var/cache/apk/*

# Adds a user & joins 'www-data' group
RUN adduser --disabled-password jokiton
RUN adduser jokiton www-data

# Create directories & Install WordPress in a directory where the user has write access
RUN mkdir -p /var/www/
RUN mkdir -p /usr/share/webapps/wordpress
RUN ln -s /usr/share/webapps/wordpress/ /var/www/html

# Install wp-cli
RUN wget -O /tmp/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /tmp/wp-cli.phar && \
    mv /tmp/wp-cli.phar /usr/local/bin/wp

# Copy wp-config.php and other files
COPY conf/wp-config.php /var/www/html/wp-config.php
COPY portfolio /var/www/html/portfolio
COPY conf/www.conf /etc/php81/php-fpm.d/www.conf

# Copies the script into the container & gives user permissions to execute it
COPY conf/scripts/init.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

#We go the html directory
WORKDIR /var/www/html/
EXPOSE 9000

CMD [ "/entrypoint.sh" ]