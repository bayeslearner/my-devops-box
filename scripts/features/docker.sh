#!/bin/bash -eu

VERSION=${DOCKER_COMPOSE_VERSION:-"1.24.0"}

# install docker
if ! [ -x "$(command -v docker)" ] ; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
    apt-get update
    apt-get install -y docker-ce
    usermod -aG docker ${USER}
else
    echo "Docker was already installed, skipping..."
    exit 0
fi 

# install docker-compose
if ! [ -x "$(command -v docker-compose)" ]; then
    curl -fsSL https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
else
    echo "docker-compose was already installed, skipping..."
    exit 0
fi
