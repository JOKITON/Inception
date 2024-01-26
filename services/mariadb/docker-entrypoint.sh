#!/bin/sh
#! Does not work! rc-service is not intended to be used in containers as a tool!
set -e

# Perform initialization steps here
#rc-service mariadb setup

rc-service mariadb start

mysql_install_db

rc-service mariadb stop

# Run the main CMD
exec "$@"