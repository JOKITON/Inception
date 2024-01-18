#! NGINX Dockerfile
FROM alpine:3.19

#! Install NGINX and required packages on Alpine
# Cache is cleaned to make container smaller
RUN apk update && \
    apk upgrade && \
    apk fix && \
    apk add nginx

# In case I want to restart any service
# RUN apk add openrc --no-cache

RUN mkdir -p /etc/nginx/conf.d \
    /usr/share/nginx/html

#! Copy your SSL/TLS certificate and key into the container
COPY nginx.crt /etc/nginx/nginx.crt
COPY nginx.key /etc/nginx/nginx.key
COPY my_own_config.conf /etc/nginx/nginx.conf

#! Update NGINX configuration to enable SSL/TLS
# include my own configuration inside the default configuration file
RUN sed -i '    /http {/r /etc/nginx/conf.d/my_own_config.conf' /etc/nginx/nginx.conf

#! They are just informative, they do NOT publish any ports
# HTPP
# EXPOSE 80
# HTTPS
EXPOSE 443

#! Run daemon in the background
# nginx : start the Nginx web server
# -g :  pass a global configuration directive -> (daemon off)
# daemon off : not to run in the background as a daemon process ( prevents nginx from closing inside the container )
CMD ["nginx", "-g", "daemon off;"]
