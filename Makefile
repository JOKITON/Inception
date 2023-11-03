COMPOSE = docker-compose

COMPOSE_FILE = docker-compose.yml

all: up

# Build and start containers
up :
	sudo $(COMPOSE) -f $(COMPOSE_FILE) up -d

#Stop and remove containers (does not remove images)
down:
	sudo $(COMPOSE) -f $(COMPOSE_FILE) down

# View container logs
logs:
	sudo $(COMPOSE) -f $(COMPOSE_FILE) logs -f

# Build Docker images for services (for ex. NGINX)
build-nginx:
	sudo $(COMPOSE) -f $(COMPOSE_FILE) build nginx

# to-do:
# 1. Add Wordpress & MariaDB build rules
