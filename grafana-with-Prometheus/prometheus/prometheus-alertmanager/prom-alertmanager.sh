#!/bin/bash

# WORKING

# Ensure necessary tools are installed
sudo yum install -y wget tar

# Prompt users to upload Alertmanager package
echo "Please upload the Alertmanager package (tar.gz file) to the server and provide the full path:"
read -p "AlertmanagerPackage Path: " ALERTMANAGER_PACKAGE_PATH

# Extract Prometheus Alertmanager
sudo tar -xvf "$ALERTMANAGER_PACKAGE_PATH" -C /usr/local/bin/

# Set permissions for Alertmanager binary
sudo chmod +x alertmanager

# Create necessary directories
sudo mkdir -p /etc/alertmanager/data

# Create Alertmanager service file
sudo tee /etc/systemd/system/alertmanager.service <<EOF
[Unit]
Description=Prometheus Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/local/bin/alertmanager
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Enable and start Prometheus service
sudo systemctl daemon-reload
sudo systemctl enable alertmanager
sudo systemctl start alertmanager

# Signal if Prometheus is running or not
if systemctl is-active --quiet alertmanager; then
    echo "Alertmanager is now running as a systemd service."
    echo "To edit the alertmanager to send communications based metrics triggering do sudo "
else
    echo "Alertmanager setup encountered an issue. Check alertmanager service status using: sudo systemctl status alertmanager"
    echo "If it shows as failed, run  sudo systemctl restart alertmanager"

fi