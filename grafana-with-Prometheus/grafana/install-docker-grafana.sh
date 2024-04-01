#!/bin/bash

# This installs both Docker and Grafana at the same time.
# If you already have Docker, start at section `Install Grafana`.

# Install Docker
install_docker() {
    sudo yum update -y
    sudo yum install -y \
        yum-utils \
        device-mapper-persistent-data \
        lvm2

    Add Docker repository
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

    # Install Docker
    sudo yum install -y docker-ce docker-ce-cli containerd.io

    # Start and enable Docker service
    sudo systemctl start docker
    sudo systemctl enable docker

    # Add the current user to the docker group to run Docker without sudo
    sudo usermod -aG docker $USER

    echo "Docker installed. Please log out and log back in to apply group changes for Docker."
    }

# Install Grafana
install_grafana() {
    # Create a directory to persist Grafana data
    mkdir -p ~/grafana_data

    # Run Grafana Docker container
    docker run -d -p 3000:3000 \
        --name=grafana \
        -v ~/grafana_data:/var/lib/grafana \
        grafana/grafana
}

# Execute functions
install_docker
install_grafana