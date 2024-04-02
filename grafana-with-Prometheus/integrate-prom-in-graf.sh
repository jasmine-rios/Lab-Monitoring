#!/bin/bash

# WORKING

# Set Grafana API URL and credentials
GRAFANA_URL="http://localhost:3000/api/datasources"
GRAFANA_USER="admin"
GRAFANA_PASSWORD="admin"

# Define Prometheus data source configuration
DATA_SOURCE='{
  "name": "Prometheus",
  "type": "prometheus",
  "url": "http://localhost:9090",
  "access": "proxy",
  "basicAuth": false
}'

# Add Prometheus data source using Grafana API
curl -X POST -u "$GRAFANA_USER:$GRAFANA_PASSWORD" -H "Content-Type: application/json" -d "$DATA_SOURCE" "$GRAFANA_URL"
