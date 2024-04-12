sudo apt-get update -y && sudo apt full-upgrade -y && apt autoremove

sudo apt-get install openssh-server -y

# In case we want to access the Virtual Machine through terminal
sudo systemctl start ssh

# Get access & enter the project
sudo apt-get install git -y
git clone https://github.com/JOKITON/Inception
cd Inception

# Install docker compose
sudo apt install -y apt-transport-https ca-certificates curl gnupg
sudo apt install -y docker docker-doc docker-registry

# Get latest docker compose, v2
sudo curl  -L "https://github.com/docker/compose/releases/download/v2.26.1/docker-compose-linux-x86_64" -o /usr/local/bin/docker\ compose

# Make docker compose executable, give it right permissions
sudo chmod +x /usr/local/bin/docker\ compose

# Check docker compose version
docker\ compose --version

sudo apt install -y docker.io

