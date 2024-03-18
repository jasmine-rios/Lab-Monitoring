"extensions": [
        {
        "name": "customScript",
        "properties": {
          "script": "[base64('#!/bin/bash if systemctl is-active --quiet grafana-server; then echo \nGrafana is already installed and running.\necho \nTo access the Grafana UI, use the following URL in a supported browser:\necho \nhttp://<Server-Public-IP>:3000\necho use admin as the username and password then reset the password\n; else sudo yum install -y https://dl.grafana.com/enterprise/release/grafana-enterprise-10.3.3-1.x86_64.rpm  sudo systemctl enable grafana-server  sudo systemctl daemon-reload  sudo firewall-cmd --zone=public --add-port=3000/tcp --permanent  sudo systemctl start grafana-server  sudo systemctl status grafana-server  if systemctl is-active --quiet grafana-server; thenecho \nGrafana is set up and ready to use.\necho \nTo access the Grafana UI, use the following URL in a supported browser:\necho \nhttp://<Server-Public-IP>:3000\necho \nUse admin as the username and password then reset the password\n; else echo \nGrafana setup encountered an issue. Check Grafana service status using: sudo systemctl status grafana-server\n; fi; fi')]"
        }
        }
        ],