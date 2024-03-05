#!/bin/bash

# Check if Grafana is already installed and running
if systemctl is-active --quiet grafana-server; then
    echo "Grafana is already installed and running."
    echo "To access the Grafana UI, use the following URL in a supported browser:"
    echo "http://<PublicIp>:3000"
    echo "Use 'admin' as the username and password then reset the password"
else
    # Install Grafana using Yum
    sudo yum install -y https://dl.grafana.com/enterprise/release/grafana-enterprise-10.3.3-1.x86_64.rpm # Latest package, change if not latest

    # Enable Grafana to be able to start
    sudo systemctl enable grafana-server

    # Reload the daemon
    sudo systemctl daemon-reload

    # Enable VM firewall to allow port 3000
    sudo firewall-cmd --zone=public --add-port=3000/tcp --permanent

    # Uncomment the 'protocol' and 'http_port' lines in grafana.ini
    sed -i 's/;protocol = http/protocol = http/' /etc/grafana/grafana.ini
    sed -i 's/;http_port = 3000/http_port = 3000/' /etc/grafana/grafana.ini

    # Start Grafana
    sudo systemctl start grafana-server

    # See if Grafana is running
    sudo systemctl status grafana-server

    # Check if Grafana is running
    if systemctl is-active --quiet grafana-server; then
        echo "Grafana is set up and ready to use."
        echo "To access the Grafana UI, use the following URL in a supported browser:"
        echo "http://<PublicIp>:3000"
        echo "Use 'admin' as the username and password then reset the password"
    else
        echo "Grafana setup encountered an issue. Check Grafana service status using: sudo systemctl status grafana-server"
    fi
fi
