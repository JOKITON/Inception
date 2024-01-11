#! NGINX Dockerfile
FROM alpine:3.19

#! Set the environment variable to non-interactive mode for apt
# (Used to skip questions that may appear when installing packages)
ENV DEBIAN_FRONTEND=noninteractive

#! Install NGINX and required packages on Alpine
# Cache is cleaned to make container smaller
RUN apk update && \
    apk upgrade && \
    apk fix && \
    apk add nginx

RUN mkdir -p /etc/nginx/conf.d \
    /usr/share/nginx/html \
    /etc/nginx/snippets

#! Copy your SSL/TLS certificate and key into the container
COPY nginx.crt /etc/nginx/nginx.crt
COPY nginx.key /etc/nginx/nginx.key
COPY my_own_config.conf /etc/nginx/nginx.conf
COPY snippets/fastcgi-php.conf /etc/nginx/snippets/

#! Update NGINX configuration to enable SSL/TLS
# include my own configuration inside the default configuration file
#RUN sed -i '    /http {/r /etc/nginx/conf.d/my_own_config.conf' /etc/nginx/nginx.conf

#! Expose ports for HTTP (80) and HTTPS (443)
# HTPP
# EXPOSE 80
# HTTPS
EXPOSE 443
# WORDPRESS
# The same as doing: [ sudo ufw allow 9000/tcp ]

# EXAMPLE PORTS:
# FTP : 20-21
# SMTP : 25
# DNS : 53
# ...

#! Run daemon in the background
# nginx : start the Nginx web server
# -g :  pass a global configuration directive -> (daemon off)
# daemon off : not to run in the background as a daemon process ( prevents nginx from closing inside the container )
CMD ["nginx", "-g", "daemon off;"]
