#!/bin/bash

# Define the output SQL file
SQL_FILE="/docker-entrypoint-initdb.d/init.sql"

# Retrieve environment variables
MYSQL_ROOT_PASSWORD="${MYSQL_ROOT_PASSWORD:-}"
MYSQL_PASSWORD="${MYSQL_PASSWORD:-}"

# Check if required environment variables are set
if [ -z "$MYSQL_ROOT_PASSWORD" ] || [ -z "$MYSQL_PASSWORD" ]; then
    echo "Error: MYSQL_ROOT_PASSWORD and MYSQL_PASSWORD environment variables must be set."
    exit 1
fi

# Create the SQL initialization script
cat > "$SQL_FILE" <<EOF
-- SQL Initialization Script

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS my_database;

-- Alter root user password
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

-- Create user 'jokiton' with password
CREATE USER 'jokiton'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

-- Grant privileges to user 'jokiton'
GRANT ALL PRIVILEGES ON my_database.* TO 'jokiton'@'%';

-- Drop empty user (if exists)
DROP USER ''@'localhost';

-- Flush privileges
FLUSH PRIVILEGES;
EOF

echo "Initialization SQL script created: $SQL_FILE"