COMPOSE = docker-compose
VOL_DOCKER = docker volume
IMG_DOCKER = docker image
NET_DOCKER = docker network

FILE = srcs/docker-compose.yml
COMPOSE_FILE = -f srcs/docker-compose.yml

IMGS = inception-nginx inception-wordpress inception-mariadb
VOL_MARIADB = wordpress_database
VOL_WORDPRESS = wordpress_webpage
VOL_WORDPRESS_DATABASE = /home/jaizpuru/data/wordpress_database
VOL_WORDPRESS_WEBPAGE = /home/jaizpuru/data/wordpress_webpage
ENV = srcs/.env

RM = rm
RMI = rmi
PRUNE = prune

all: up

# Build and start containers
up : $(VOL_WORDPRESS_DATABASE) $(VOL_WORDPRESS_WEBPAGE) $(FILE) $(ENV)
	echo "Add this line to /etc/hosts : "localhost	jaizpuru.42.fr" \n"
	$(COMPOSE) --env-file $(ENV) $(COMPOSE_FILE) build
	$(COMPOSE) --env-file $(ENV) $(COMPOSE_FILE) up
	echo "Available rules inside Makefile:\n\t1 : up\n\t2 : down\n\t3 : ps"

$(VOL_WORDPRESS_DATABASE) : $(FILE)
	sudo mkdir -p /home/jaizpuru/data/wordpress_database

$(VOL_WORDPRESS_WEBPAGE) : $(FILE)
	sudo mkdir -p /home/jaizpuru/data/wordpress_webpage

#Stop and remove containers, associated images, volumes & network
down : $(FILE)
	$(COMPOSE) $(COMPOSE_FILE) down
	sudo $(RM) -rf /home/jaizpuru/data
	$(IMG_DOCKER) $(RMI) $(IMGS) -f
	$(VOL_DOCKER) $(RM) $(VOL_WORDPRESS)
	$(VOL_DOCKER) $(RM) $(VOL_MARIADB)
	$(NET_DOCKER) $(PRUNE) -f

restart: $(FILE)
	$(COMPOSE) $(COMPOSE_FILE) restart

# Lists the containers created with docker compose, docker & volumes
ps : $(FILE)
	$(COMPOSE) $(COMPOSE_FILE) ps
	$(IMG_DOCKER) ls
	$(VOL_DOCKER) ls

# View container logs
logs : $(FILE)
	$(COMPOSE) $(COMPOSE_FILE) logs -f

# Build Docker images for services (for ex. NGINX)
build-nginx : $(FILE)
	$(COMPOSE) $(COMPOSE_FILE) build nginx
	$(COMPOSE) $(COMPOSE_FILE) up nginx

build-mariadb : $(FILE)
	$(COMPOSE) $(COMPOSE_FILE) build mariadb
	$(COMPOSE) $(COMPOSE_FILE) up mariadb

build-wordpress : $(FILE)
	$(COMPOSE) $(COMPOSE_FILE) build wordpress
	$(COMPOSE) $(COMPOSE_FILE) up wordpress
