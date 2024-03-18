# Prometheus with Grafana

Grafana is the dashboard but prometheus gets the information for the dashboard

You install prometheus on the servers you want to manage and grafana is on it's own server. 

You add prometheus as a data source when on the Grafana dashboard.

## How to Install Prometheus

Using the script `install-prometheus.sh` in this repo is how you start up the service as well as creating it as it's own systemctl so you can start and stop it when needed.

1. On the server/servers you want to monitor copy the install-prometheus.sh script and run it. You can also create a new file with `nano install-prometheus.sh` and modifying the permissions to executable to make it easier to run in the future.

2. You should get the following line near the end of the output

` caller=main.go:1114 level=info msg="Server is ready to receive web requests."`

Prometheus is up and you should be able to navigate to it.

3. In a web browser go to the URL,

`<server-ip>:9090`

Make sure to replace `<server-ip>` with the public ip of your server.

## Attach Prometheus as a Data Source on Grafana

1. In order to have the data from what you want to monitor, you must add it in the Grafana UI

`<server-ip>:8080

