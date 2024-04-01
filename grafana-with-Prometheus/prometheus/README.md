# Prometheus with Grafana

Grafana is the dashboard but prometheus gets the information for the dashboard by scraping for HTTP requests at a set interval.
You install prometheus on the servers you want to manage and grafana is on it's own server. 
You add prometheus as a data source when on the Grafana dashboard.

Follow the Grafana `README.md` for the recommended specifications and how to install Grafana

## How to Install Prometheus

Using the script `install-prometheus.sh` in this repo is how you start up the service as well as creating it as it's own systemctl so you can start and stop it when needed.

1. On the server/servers you want to monitor copy the `install-prometheus.sh` script and run it. You can also create a new file with `nano install-prometheus.sh` and modifying the permissions to executable to make it easier to run in the future.

2. As part of the script you will need to specify the location of the package you downloaded

2. You should get the following line near the end of the output

` caller=main.go:1114 level=info msg="Server is ready to receive web requests."`

Prometheus is up and you should be able to navigate to it.

3. In a web browser go to the URL,

`<server-ip>:9090`

Make sure to replace `<server-ip>` with the public ip of your server.

## Attach Prometheus Data Sources

To add data sources you have to consider if you are going to have prometheus agent on each of the clients or have a gateway that the clients will push to.
The gateway can be on the same server as prometheus but will not be good if you have a heavy workload in prometheus.

This instruction set is for a push architecture.

1. Download the `pushgateway` file for linux or whatever OS you are using and install it on the client with `install-prometheus-gateway.sh`

2. You will be prompted what the path of where the pushgateway file is at, use the following command in a new terminal tab or window if you are not sure

``

3. Edit the file to add in the following to scrape_configs with the IPs being the servers you want to monitor.
It should look simular to below

```yml

scrape_configs:
  - job_name: 'pushgateway'
    honor_labels: true
    static_configs:
      - targets:
        - 'localhost:9091'  # Push Gateway running on the same server
        - '192.168.1.10:9100'  # Example exporter running on another server
        - '192.168.1.11:9100'  # Another exporter running on yet another server

```

4. 

## Integrate Prometheus with Grafana

## Problems

- Having issues with systemctl but prometheus is still able to run after script and be accessed with `sudo ./prometheus --config.file=prometheus.yml`