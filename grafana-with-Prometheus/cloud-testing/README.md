
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

