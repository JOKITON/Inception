# Base image of PHP-FPM and other dependencies
FROM alpine:3.18.5

# Install PHP-FPM and additional dependencies
RUN apk update && \
    apk upgrade && \
    apk fix && \
    apk add --no-cache mariadb && \
    rm -rf /var/cache/apk/*


# CMD intruction to start PHP-FPM
#CMD ["php-fpm81"]

