# Grafana

## What is Grafana?

Grafana is a powerful open-source suite that has many features.

One of the main features is Grafana Alerting.
Grafana Alerting monitors your network and alerts to an action group when certain conditions are met.

Grafana integrates with communication platforms such as Slack, email using alerts. 

### Data Sources

Data sources are the things that you want to monitor with Grafana.
Examples of these data sources are cloud hosted services, on-premises services, and databases.

Data sources are installed with an agent that communicates with the Grafana instance.
Through the communications you can see network performance on a customizable dashboard.
In that dashboard you have panels which is the choice of what metric you want to monitor.
Some monitored metrics include I/O profromance, bandwidth usage, latency, packet loss, and interface statistics.

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

Minimum Hardware recommendations:
- 512 MB memory
- 1 CPU 

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

### 

## Testing Before Deployment

Before deploying to PROD, test that it actually executes.
This repo has the testing for Azure and AWS.

For Azure:
See directory 'Azure-ARM` for deployment of Grafana on Azure.
- Deploying a whole infrastructure as in directory `ARM-VM-and-infra` 
- Deploying only the RHEL VM (Must allow port 80 inbound in Network Security Group) 

For AWS:
See directory `` for deployment of Grafana on AWS.
- Deploying a whole infrastructure as in directory `ARM-VM-and-infra` 
- Deploying only the RHEL EC2 instance (Must allow port 80 inbound in Network Security Group) 

## Apply Best Security Practices to Grafana
