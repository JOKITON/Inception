COMPOSE = docker-compose

COMPOSE_FILE = docker-compose.yml

RM = rm

all: up

# Build and start containers
up : $(COMPOSE_FILE)
	sudo $(COMPOSE) -f $(COMPOSE_FILE) up -d
	echo "Available rules inside Makefile:\n\t1 : up\n\t2 : down\n\t3 : ps"

#Stop and remove containers (does not remove images)
down : $(COMPOSE_FILE)
	sudo $(COMPOSE) -f $(COMPOSE_FILE) down
	sudo docker image $(RM) nginx wordpress mariadb

ps : $(COMPOSE_FILE)
	sudo $(COMPOSE) -f $(COMPOSE_FILE) ps

# View container logs
logs : $(COMPOSE_FILE)
	sudo $(COMPOSE) -f $(COMPOSE_FILE) logs -f

# Build Docker images for services (for ex. NGINX)
build-nginx : $(COMPOSE_FILE)
	sudo $(COMPOSE) -f $(COMPOSE_FILE) build nginx

