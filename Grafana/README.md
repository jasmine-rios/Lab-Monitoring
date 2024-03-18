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

## Testing Before Deployment

Before deploying to PROD, test that it actually executes.
This repo has the testing for Azure and AWS.

### Testing Deployment in Azure
See directory `Azure-ARM` for deployment of Grafana on Azure either with VM and/or infrastructure (infra) 

- Deploying the whole infrastructure is in directory `ARM-VM-and-infra` and you use `template.json` for the deployment and `template.parameters.json` for the names of each resource.

- Deploying only the RHEL VM (Must allow 80,443, and 8080 inbound in Network Security Group) is in directory `ARM-VM-Only` and you use `template.json` for the deployment and `template.parameters.json` for the names of each resource.

Follow these steps to deploy the respective `template.json` and `template.parameters.json` in the Azure portal:

1. In the azure portal, click the search bar up top and search for "Deploy a custom template".

2. Select "Build your own template in the editor"

3. Copy the template.json from the directory that has your use case.

4. Paste the contents in the box and click "Save".

5. Click "Edit parameters" and then copy and paste the respective template.parameters.json. Click "Save".

6. Choose your resource group and SSH key from the drop box.

7. Click "Review + create".

8. After validation is complete, click "Create".

9. The resources should deploy in the resource group using the deployment.

10. When finished click Output for SSH information and `chmod` command to change private key permissions.

11. When SSH into the Grafana VM, edit the grafana.ini ???

`sudo nano /etc/grafana/grafana.ini`

12. Uncomment by removing `;` from the following lines under Server
```
;protocol = http
;http_port = 3000
```

13. Restart Grafana

`sudo systemctl restart grafana-server`

14. In a web browser, navigate to the URL making sure to replace with the public-IP you used to SSH with.

`http://<Server-Public-IP>:3000`

Follow these steps to deploy the respective `template.json` and `template.parameters.json` in the Azure portal:

**NOTE**
You must already have your ssh key uploaded in Azure CloudShell or CLI in order to create the deployment programatically.
If you need to create the ssh key, use the portal to deploy the json files
**NOTE**

1. In the CloudShell (found on the Azure Portal on the left side with an icon of a box and a carrot, `>`, in the box) or Azure CLI use this command

`az deployment create template.json --parameter template.paramaeters.json`

### Testing Deployment in AWS

See directory `AWS-Cloudformation` for deployment of Grafana on AWS.

- Deploying a whole infrastructure is in directory `Cf-EC2-and-infra` and `grafana.yml` is what is used for CloudFormation

- Deploying only the RHEL EC2 instance (Must allow ports 80,443, and 8080 inbound in Network Security Group) is in directory `Cf-EC2-only` and `grafana.yml` is what is used for CloudFormation

Follow these steps to deploy the respective `grafana.yml` in AWS portal:

1. While logged into AWS portal, in the top search box search for "cloudformation".

2. In CloudFormation, click 

3. 

Follow these steps to deploy the respective `grafana.yml` in AWS CLI:

1. 

2. 

### Deploy Cloudformation template to AWS


## Grafana UI

The Grafana UI will allow you to connect to sources using the grafana agent and create dashboards of what needs to be monitored.

### Connect to Sources

1. 

### Create a Grafana

1. 

## Apply Best Security Practices to Grafana
