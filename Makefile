COMPOSE = sudo docker-compose -f

COMPOSE_FILE = docker-compose.yml

VOL_DOCKER = docker volume
IMG_DOCKER = docker image
IMGS = nginx wordpress mariadb
VOL_MARIADB = wordpress_database
VOL_WORDPRESS = wordpress_webpage

RM = rm
RMI = rmi

all: up

# Build and start containers
up : $(COMPOSE_FILE)
	$(COMPOSE) $(COMPOSE_FILE) up -d
	echo "Available rules inside Makefile:\n\t1 : up\n\t2 : down\n\t3 : ps"

#Stop and remove containers (does not remove images)
down : $(COMPOSE_FILE)
	$(COMPOSE) $(COMPOSE_FILE) down
	$(IMG_DOCKER) $(RMI) $(IMGS)
	$(VOL_DOCKER) $(RM) $(VOL_WORDPRESS)
	$(VOL_DOCKER) $(RM) $(VOL_MARIADB)

restart:
	$(COMPOSE) $(COMPOSE_FILE) restart

ps : $(COMPOSE_FILE)
	$(COMPOSE) $(COMPOSE_FILE) ps

# View container logs
logs : $(COMPOSE_FILE)
	$(COMPOSE) $(COMPOSE_FILE) logs -f

# Build Docker images for services (for ex. NGINX)
build-nginx : $(COMPOSE_FILE)
	$(COMPOSE) $(COMPOSE_FILE) build nginx

