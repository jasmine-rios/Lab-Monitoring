# Grafana

## What is Grafana?

Grafana is a powerful open-source suite that has many features.

One of the main features is Grafana Alerting.
Grafana Alerting monitors your network and alerts to an action group when certain conditions are met.

Grafana integrates with communication platforms such as Slack, email using alerts. 

### Data Sources with Prometheus

Data sources are the things that you want to monitor with Grafana.
Examples of these data sources are cloud hosted services, on-premises services, and databases.

Data sources are installed with an agent that communicates with the Grafana instance.

You can use Prometheus as the agent that connects to these servers.

Follow the Prometheus `README.md` to install it either alone or with a gateway.

Through the communications you can see network performance on a customizable dashboard.

In that dashboard you have panels which is the choice of what metric you want to monitor.

### Log Analysis

Grafana allows you take the collected logs and preform log analysis.
Using log anaysis provides insights into system events, errors, and debug information that can help in troubleshooting.
You can zoom into timeframes and or events using it's interactive features.

## How to Install Grafana

(Install Grafana)[https://grafana.com/docs/grafana/latest/setup-grafana/installation/]

Grafana can be installed on many operating systems:
- Debian or Ubuntu
- Red Hat, RHEL, or Fedora
- SUSE or openSUSE
- Windows

You can install it on other operating systems but it is not recommended or supported.

Have the following hardware to start off with but grow it as needed.

Minimum Hardware recommendations for Grafana alone:
- 512 MB Storage (just for configurations)
- 2 CPU cores
- 2-4 GB RAM

Minumum Hardware recommendations for Grafana, Prometheus, and Prometheus Gatway on one server based on 50 hosts and log retention of 14 days:
- 550 GB Storage
- 4 CPU Cores
- 8 GB RAM 

Supported databases must be used to store configuration data like users, data sources, and dashboards.
The requirements depend on the size of the Grafana installation and features you use.

Supported databases: 
- SQLite 3
- MySQL 5.7+
- PostgreSQL 12+

By default, Grafana uses an embedded SQLite database which is stored in the Grafana installion location.
This might do if you have a small environment but is not scalable.

### Grafana UI

Grafana's UI is accessible with the following browsers that are in the latest version:

- Chrome/Chromium
- Firefox
- Safari
- Microsoft Edge

**NOTE**
Javascript will have to be enabled in the browser

### Install Grafana on RHEL

The scripts in this repo will apply to installing Grafana on RHEL (Red Hat Enterprise Linux). 

For installation on other OS installations, refer to (Installation of Grafana on Other OS)[https://grafana.com/docs/grafana/latest/setup-grafana/installation/#supported-operating-systems]

There is many options to install Grafana on RHEL:

- (Install Grafana from the RPM repository)[https://grafana.com/docs/grafana/latest/setup-grafana/installation/redhat-rhel-fedora/#install-grafana-from-the-rpm-repository] 
- (Install the Grafana RPM package manually)[https://grafana.com/docs/grafana/latest/setup-grafana/installation/redhat-rhel-fedora/#install-the-grafana-rpm-package-manually]
- (Install Grafana as a standalone binary)[https://grafana.com/docs/grafana/latest/setup-grafana/installation/redhat-rhel-fedora/#install-grafana-as-a-standalone-binary]

Installing Grafana from the RPM repository is recommended if you want the newest updates for Grafana installed automatically.
If not, choose Install the Grafana RPM package manually using  `install-grafana.sh`.

The latest versions of Grafana for each OS as well as the commands to update are found at (Grafana Downloads)[https://grafana.com/grafana/download]

You can also install it on an Docker instance so it's isolated from the host resources.
See `install-docker-grafana.sh` for installation.

### Start Grafana on RHEL

These commands are included in `install-grafana.sh` and allow Grafana to be started:

```sh
sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server
```
More ways to start Grafana (i.e. Docker) are found at (Start the Grafana server)[https://grafana.com/docs/grafana/latest/setup-grafana/start-restart-grafana/]

### Sign into Grafana

1. In supported web browser, navigate to `http://localhost:3000`. !!!

**NOTE** 
The URL given above is default. If not working look into the grafana.ini to find the applicable URL !!!

`cat /etc/grafana/grafana.ini`

2. Enter admin as username and password and sign in.

3. When prompted to change the password, change the password.

## How to Configure Grafana

(Configure Grafana)[https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#configure-grafana]

The Grafana backend has a number of configuration options defined in its config file (usually located at /etc/grafana/grafana.ini on linux systems).

In this config file you can change things like the default admin password, http port, grafana database (sqlite3, mysql, postgres), authentication options (google, github, ldap, auth proxy) along with many other options.

## Testing Before Deployment

Before deploying to PROD, test that it actually executes.
This repo has the testing in ARM for Azure and in CloudFormation for AWS located in directory `cloud-testing`
Follow the `README.md` in that directory

## Grafana UI

The Grafana UI will allow you to connect to sources using the grafana agent and create dashboards of what needs to be monitored.

### Connect to Sources: Prometheus

You can add prometheus as a data source in the UI by signing into Grafana with `admin` and the password you set.

Or you can progmatically add it using `integrate-prom-in-graf.sh` and set the variables to what is applicable to you.

#### Connect to Prometheus in Grafana UI

1. While in the Grafana UI homepage, You should see a tile that says "Add your first data source", click it.

If that tile is not there, click the menu button on the upper left and click Connections>Add new connection and search for "prometheus" then click "Add new data source"

2. Now on the newly created data source for prometheus, click in the box under Connection, next to "Prometheus server URL".

3. Type in the URL you used to connect to prometheus, which is the server IP hosting prometheus and it's default port

`http://<Enter-server-ip>:9090

4. You can change other defaults such as Authentication methods, TLS, HTTP headers, and advanced settings.

In the tab next to settings near the top of the page, you can click Dashboards and import dashboards or build your own.

5. Click "Save & Test" and you should get a message at the bottom that reads "Successfully queried the Prometheus API. Next, you can start to visualize data by building a dashboard, or by querying data in the Explore view"

### Create a Grafana dashboard

There are numerous ways to create a dashboard in the Grafana UI:

- Choose a baseline dashboard when connecting prometheus as a data source in the "Dashboards" tab and import then click it
- Click the success message hyperlink that says "building a dashboard"
- Click the "Build a dashboard" in the prometheus dashboard

You can also create a dashboard programmatically using JSON model

(Dashboard JSON Model)[https://grafana.com/docs/grafana/latest/dashboards/build-dashboards/view-dashboard-json-model/]

1. 

## Apply Best Security Practices to Grafana
