#!/bin/bash

# Prompt users to provide the path to Prometheus Push Gateway package
echo "Please upload the Prometheus Push Gateway package (tar.gz file) to the server and provide the full path:"
read -p "Prometheus Push Gateway Package Path: " PUSHGATEWAY_PACKAGE_PATH

# Extract Prometheus Push Gateway
sudo tar -xvf "$PUSHGATEWAY_PACKAGE_PATH" -C /usr/local/bin/

# Copy Prometheus Push Gateway binary to appropriate location
sudo cp /usr/local/bin/pushgateway-*linux-amd64/pushgateway /usr/local/bin/

# Create Prometheus Push Gateway service file
sudo tee /etc/systemd/system/prometheus-pushgateway.service <<EOF
[Unit]
Description=Prometheus Push Gateway
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=/usr/local/bin/pushgateway
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Enable and start Prometheus Push Gateway service
sudo systemctl daemon-reload
sudo systemctl enable prometheus-pushgateway
sudo systemctl start prometheus-pushgateway

# Configure Prometheus to scrape metrics from Push Gateway
PROMETHEUS_CONFIG_FILE="/etc/prometheus/prometheus.yml"
cat >> "$PROMETHEUS_CONFIG_FILE" <<EOF

scrape_configs:
  - job_name: 'pushgateway'
    honor_labels: true
    static_configs:
      - targets:
        - 'localhost:9091'  # Push Gateway running on the same server
EOF

# Prompt users to modify prometheus.yml
echo "Add the IPs of the servers you want to monitor in the yaml file after localhost:9091 with comment for a description of what this server is and save it."
echo "After complete, start Prometheus with 'sudo systemctl restart prometheus'."

# Wait for user to modify prometheus.yml
read -p "Press Enter to continue after modifying prometheus.yml"

# Restart Prometheus to apply the new configuration
sudo systemctl restart prometheus

echo "Prometheus Push Gateway has been installed and configured successfully."
