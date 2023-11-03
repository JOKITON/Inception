# NGINX Dockerfile
FROM alpine:3.18.3

# Set the environment variable to non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install NGINX and required packages on Alpine
RUN apk update && \
    apk upgrade && \
    apk fix && \
    apk add nginx
    

# Install NGINX and required packages on Debian
# RUN apt-get update && \
#    apt-get install -y --no-install-recommends nginx && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/* && \
#    rm -f /etc/nginx/sites-available/default && \
#    rm -f /etc/nginx/sites-enabled/default

# Copy your SSL/TLS certificate and key into the container
COPY nginx.crt /etc/nginx/nginx.crt
COPY nginx.key /etc/nginx/nginx.key

# Update NGINX configuration to enable SSL/TLS
RUN sed -i '/server {/a \    listen 443 ssl;' /etc/nginx/nginx.conf
RUN sed -i '/server {/a \    ssl_certificate \/etc\/nginx\/nginx.crt;' /etc/nginx/nginx.conf
RUN sed -i '/server {/a \    ssl_certificate_key \/etc\/nginx\/nginx.key;' /etc/nginx/nginx.conf

# Expose ports for HTTP (80) and HTTPS (443)
EXPOSE 80
EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

