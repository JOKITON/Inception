#! NGINX Dockerfile
FROM debian:bookworm

#! Install NGINX and required packages on Debian
# Cache is cleaned to make container smaller
RUN apt update && \
    apt upgrade && \
    apt full-upgrade && \
    apt autoremove && \ 
    apt install -y curl nginx openssl procps

# In case I want to restart any service
# RUN apt install openrc --no-cache

RUN mkdir -p /etc/nginx/conf.d \
    /usr/share/nginx/html

#! Copy your SSL/TLS certificate and key into the container
COPY conf/openssl.conf /etc/
RUN openssl req -newkey rsa:4096 \
        -x509 \
        -sha256 \
        -days 3650 \
        -nodes \
        -out /etc/nginx/nginx.crt \
        -keyout /etc/nginx/nginx.key \
         -config /etc/openssl.conf

COPY conf/my_own_config.conf /etc/nginx/nginx.conf

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
#CMD ["sleep", "infinity"]