#!/bin/bash

# This installs Grafana from the RPM but allows you to control the version of Grafana.
# Manually updating Grafana is required by the script.

# Install Grafana using Yum

sudo yum install -y https://dl.grafana.com/enterprise/release/grafana-enterprise-10.3.3-1.x86_64.rpm # Latest package

# Enable Grafana to be able to start

sudo systemctl enable grafana-server

# Reload the daemon

sudo systemctl daemon-reload

# Start Grafana

sudo systemctl start grafana-server

# See if Grafana is running

sudo systemctl status grafana-server

      # Check if Grafana is running
      if sudo systemctl is-active --quiet grafana-server; then
          echo "Grafana is set up and ready to use."
          echo "To access the Grafana UI, use the following URL in a supported browser:"
          echo "http://${MyEC2Instance.PublicIp}:3000"
      else
          echo "Grafana setup encountered an issue. Check Grafana service status using: sudo systemctl status grafana-server"
      fi