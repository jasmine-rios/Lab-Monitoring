#!/bin/bash

# Ensure necessary tools are installed
sudo yum install -y wget tar

# Prompt users to upload Prometheus package
echo "Please upload the Prometheus package (tar.gz file) to the server and provide the full path:"
read -p "Prometheus Package Path: " PROMETHEUS_PACKAGE_PATH

# Extract Prometheus
sudo tar -xvf "$PROMETHEUS_PACKAGE_PATH" -C /usr/local/bin/

# Navigate to Prometheus directory
PROMETHEUS_VERSION=$(basename "$PROMETHEUS_PACKAGE_PATH" .tar.gz)
cd "/usr/local/bin/prometheus-${PROMETHEUS_VERSION}.linux-amd64/"

# Set permissions for Prometheus binary
sudo chmod +x prometheus

# Create necessary directories
sudo mkdir -p /etc/prometheus/data

# Move configuration file to /etc/prometheus/ directory
sudo mv prometheus.yml /etc/prometheus/

# Create Prometheus service file
sudo tee /etc/systemd/system/prometheus.service <<EOF
[Unit]
Description=Prometheus Monitoring
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/etc/prometheus/data
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Enable and start Prometheus service
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus

# Allow Prometheus port through firewall
sudo firewall-cmd --zone=public --add-port=9090/tcp --permanent
sudo firewall-cmd --reload

# Signal if Prometheus is running or not
if systemctl is-active --quiet prometheus; then
    echo "Prometheus is now running as a systemd service."
    echo "To access the Prometheus UI, use the following URL in a supported browser:"
    echo "http://<PublicIp>:9090"
else
    echo "Prometheus setup encountered an issue. Check Prometheus service status using: sudo systemctl status prometheus"
    echo "If it shows as failed, run: sudo ./prometheus --config.file=prometheus.yml"

fi
