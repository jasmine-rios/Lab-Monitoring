#!/bin/bash

# This is the script that downloads Prometheus for RHEL and other linux like distrubutions

# Enable the primary port that Prometheus uses

sudo firewall-cmd --zone=public --add-port=9090/tcp --permanent

# Step 1: Download Prometheus
PROMETHEUS_VERSION="2.51.0-rc.0"
sudo wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

# Step 2: Extract Prometheus
sudo tar -xvf prometheus-${PROMETHEUS_VERSION}.linux-amd64.tar.gz

# Step 3: Navigate to Prometheus directory
cd prometheus-${PROMETHEUS_VERSION}.linux-amd64/

# Step 4: Set permissions for Prometheus binary
sudo chmod +x prometheus

# Step 5: Create necessary directories
mkdir -p data

# Step 6: Start Prometheus
./prometheus --config.file=prometheus.yml

# Signal if Prometheus is running or not
if systemctl is-active --quiet prometheus-server; then
    echo "Prometheus is now running."
    echo "To access the Prometheus UI, use the following URL in a supported browser:"
    echo "http://<PublicIp>:9090"
else
    echo "Prometheus setup encountered an issue. Check prometheus service status using: sudo systemctl status prometheus-server"
