COMPOSE = sudo docker-compose -f

COMPOSE_FILE = docker-compose.yml

VOL_DOCKER = sudo docker volume
IMG_DOCKER = sudo docker image
IMGS = nginx wordpress mariadb
VOL_MARIADB = inception_db_data
VOL_WORDPRESS = inception_wordpress_data

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

ps : $(COMPOSE_FILE)
	$(COMPOSE) $(COMPOSE_FILE) ps

# View container logs
logs : $(COMPOSE_FILE)
	$(COMPOSE) $(COMPOSE_FILE) logs -f

# Build Docker images for services (for ex. NGINX)
build-nginx : $(COMPOSE_FILE)
	$(COMPOSE) $(COMPOSE_FILE) build nginx

