# init.sh
echo "Initializing database..."
mysql -e "CREATE DATABASE IF NOT EXISTS my_database;"
mysql -e "CREATE USER 'jokiton'@'%' IDENTIFIED BY 'pass123';"
mysql -e "GRANT ALL PRIVILEGES ON my_database.* TO 'jokiton'@'%';"
mysql -e "FLUSH PRIVILEGES;"
echo "Initialization complete."

