# Cloud Testing of Grafana/Prometheus Solution 

## Testing in Azure
See directory `Azure-ARM` for deployment of Grafana on Azure either with VM and/or infrastructure (infra): 

- Deploying the whole infrastructure is in directory `ARM-VM-and-infra` and you use `template.json` with `parameters.template.json` if you wish to change any parameters

- Deploying only the RHEL VM (Must allow 80,443, and 8080 inbound in Network Security Group) is in directory `ARM-VM-Only` and you use `template.json` for the deployment and `template.parameters.json` for the names of each resource.

##  Methods to Test Deployment in Azure

### Simulate a What-if ARM Deployment in Azure
To test what will change, add, or be deleted when you deploy the ARM, `template.json`, use the what-if command in terminal or Azure CloudShell without deploying any resources:

`az deployment group what-if --template-file <path/to/template.json> --resourcegroup <resource-group-for-deployment>`

You will be able to see in different colors what resources will change, be added, be deleted, or ignored to the selected resource group.

### Deploy ARM using Command-line Interface

To deploy the resources to Azure using Azure CLI in terminal or in Azure Portal's CloudShell use the following command:

`az deployment group create --name <Name-of-new-deployment> --template-file <path/to/template.json> --resourcegroup <resource-group-for-deployment>`

Enter in the value for the `adminPassword` and press enter

It will deploy all of the resources as specified in `template.json` 

### Deploy ARM in Azure Portal using Custom Template

Follow these steps to deploy the respective `template.json` and `parameters.template.json` in the Azure portal:

1. In the Azure portal, click the search bar up top and search for "Deploy a custom template".

2. Click "Deploy a custom Template" to launch a custom template.

3. Select "Build your own template in the editor".

3. Copy the template.json from the directory that has your use case.

4. Paste the contents in the box and click "Save".

5. Click "Edit parameters" and then copy and paste the respective template.parameters.json. Click "Save".

6. Choose your resource group from the `resource group` drop down.

7. In the box to the right of `adminPassword` type in the password you want to log on to the VMs using Azure Bastion.

8. Click "Review + create".

9. After validation is complete, click "Create".

10. The resources should deploy in the resource group using the deployment after 10-15 minutes.

### Accessing VMs using Bastion in Azure

## Testing in AWS

See directory `AWS-Cloudformation` for deployment of Grafana on AWS.

- Deploying the whole test infrastructure is in directory `cf-EC2-and-infra` and `infra.yml` is what is used for CloudFormation template.

- Deploying only the RHEL EC2 instance (Must allow ports 80,443, and 8080 inbound in Network Security Group) is in directory `cf-EC2-only` and `EC2-only.yml` is what is used for CloudFormation template

## Methods to Test Deployment in AWS

### Deploy CloudFormation in AWS Portal

Follow these steps to deploy the respective `grafana.yml` in AWS portal:

1. While logged into AWS portal, in the top search box search for "cloudformation".

2. In CloudFormation, click 

3. 

### Deploy CloudFomation using Command-line Interface
Follow these steps to deploy the respective `grafana.yml` in AWS CLI:

1. 

2. 

### Accessing VMs using Bastion in AWS
In a web browser, navigate to the URL making sure to replace with the public-IP you used to SSH with.

`http://<Server-Public-IP>:3000`