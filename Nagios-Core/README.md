# Install Network Monitoring

## Description

This repo is for installing and validating lab monitoring solutions.

## Nagios Core Installation Script- install-nagios-core.ps1

This script automates the installation of Nagios Core on a Red Hat Enterprise Linux (RHEL) system. 
Nagios Core is a powerful open-source monitoring system that enables organizations to identify and resolve IT infrastructure issues before they affect critical business processes.

### What is Nagios?

[Nagios](https://www.nagios.org/) is an industry-standard open-source monitoring solution that provides a comprehensive platform for monitoring the availability, performance, and security of IT infrastructure. It is widely used for network monitoring, server monitoring, application monitoring, and more.

### What is Nagios Core?

[Nagios Core](https://www.nagios.org/projects/nagios-core/) is the open-source core engine of the Nagios monitoring system. It serves as the foundation for building a customized monitoring solution by providing essential monitoring and alerting functionality. Nagios Core can be extended with various plugins to monitor different types of services, hosts, and devices.

### Prerequisites

- A Red Hat Enterprise Linux (RHEL) system.
- Administrative privileges on the system.
- Internet connectivity for downloading packages.

### Usage

There are three ways to accomplish this with options listed below:

- Option 1: Install Nagios When Creating RHEL VM on Azure
- Option 2: Install Nagios when Connected to RHEL VM with Terminal
- Option 3: Install RHEL VM with Nagios Using Template

#### Option 1: Install Nagios When Creating RHEL VM on Azure
1. In Azure Portal, navigate to Virtual Machines.

2. Click "Create" to add a virtual machine.

3. Choose the subscription and Resource Group you want the RHEL VM in.

4. Name the virtual machine.

5. Under Image, Click See All Images.

6. Now in Marketplace, search for "Red Hat".

7. Scroll down until you see "Red Hat Enterprise Linux Raw" and click select.

8. Choose "Red Hat Enterprise Linux 9.2 RAW with cloud-init - Gen2" from the drop-down.

9. Under Size, click "See all sizes" and choose "Standard_B2s".

10. Click Next at the bottom until you reach the "Security" tab.

11. Make sure SSH is enabled with port 22 and HTTP is enabled with port 80.

12. Click Next at the bottom until you reach the "Advanced" tab.

13. In "custom data" paste in !!.

14. Click "Review + create" and download the SSH key.
** THIS KEY IS PRIVATE, DO NOT SHARE!!**

15. Click "Go to Resource" once the VM is created.

16. On the RHEL VM overview page, click "Connect" and connect using SSH client. 

17. Go into terminal and go into the directory that you saved the SSH key.

`cd <name-of-folder-you-saved-SSH-key-in>`

18. Move the SSH key into the ssh folder.

`mv <key-name>.pem ~/.ssh`

19. Go into SSH folder that is a hidden directory in home. 

`cd ~/.ssh`

20. Change the permissions of the SSH key so it can be used.

`chmod 400 <key-name>.pem`

21. SSH into instance using public IP as shown when you clicked "Connect" on the instance.

`ssh -i <key-name>.pem azureuser@<VM-Public-IP>`

22. Click Y to remember fingerprint if prompted.

23. Now in the instance, make sure nagios and httpd are running.

```bash
ps aux | grep nagios
systemctl status httpd
```

if not start the processes

```bash
sudo systemctl start httpd.service
sudo systemctl start nagios.service
```

24. Navigate in browser to the RHEL public IP.

> http://your-server-ip/nagios

25. Log in using the username `nagiosadmin` and the password you set during the installation.

#### Option 2: Install Nagios when Connected to RHEL VM with Terminal

1. Follow option 1 steps 1-11 to install RHEL VM if not done with needed ports open and click "Review + Create" to create VM.

If RHEL VM is already created, follow option 1 steps 16-24 to connect into instance.

2. Connected to the RHEL VM, download the script if you have SSH keys configured from GitLab.

!!`git clone https://github.com/your-username/nagios-core-installation.git`

OR

If not able to, you can create the copy the script contents, make a new directory, make a new file and paste the contents into the file.
Save and exit with "ctrl+x".

```bash
mkdir <name-of-directory>
cd <name-of-direcory>
nano install-nagios-core.ps1
```

3. Make the script is executable .

`sudo chmod +x /path/to/install-nagios-core.ps1`

4. Run the script where directory is hosted or list path of directory followed by script name.

`sudo pwsh /path/to/install-nagios-core.ps1`

#### Option 3: Install RHEL VM with Nagios Using ARM Template in Azure Portal

(Deploy resources from custom template)[https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deploy-portal#deploy-resources-from-custom-template]

1. Open Azure Portal and click "Create a resource".

2. Search for "template".

3. Click "Template deployment (deploy using custom templates)".

4. Click Create next to the plan box.

5. Click "Build your own template in the editor".

6. Go to the Gitlab and copy and paste the template.json.

7. Notice the number of resources to be created is 5 and click Save.

8. In the "Custom deployment", click "Edit parameters".

9. Go to the Gitlab and copy and paste the parameters.json, click Save.

10. See all of the parameters populate and choose the Resource Group for these resources to be created in. 

11. In SSH public key source, choose to either "Generate new key pair", "Use existing key stored in Azure", or "Use existing public key" then provide the public key or create a new pair. 

12. Click "Review + create" and click "Create" when validation is complete.

13. A window will popup named "Generate new key pairs" if you choose "Generate new key pair" as the "SSH public key resource". Click Download + create and save in a secure place like `~/.ssh` and then run this to change the permisions of the key to be able to be used:

`chmod 400 <path-of-private-key>/<name-of-private-key>`

14. The template will now deploy, wait for it to say "Your deployment is complete" and click "Go to resource group".

15. You see all those 5 resource deployed to the resource group. Click on the Deployments blade and click Outputs to get the information to SSH into the RHEL instance.

16. While in the instance, run the following script to complete setup !!!

### Troubleshooting Help

Troubleshooting help for Nagios Core is found in its documentation
[Nagios Core Troublshooting Documentation](https://support.nagios.com/kb/category.php?id=80)

Common issue that happens is when trying to start Nagios using
`sudo systemctl start nagios.service`, it fails with error.

Looking into the error with `sudo systemctl status nagios.service` shows it failed due to configuration files.

e.g.
```bash
[azureuser@JMR-RHEL etc]$ sudo systemctl status nagios.service
× nagios.service - Nagios Core 4.4.14
     Loaded: loaded (/usr/lib/systemd/system/nagios.service; enabled; preset: disabled)
     Active: failed (Result: exit-code) since Tue 2024-02-06 18:38:55 UTC; 13s ago
       Docs: https://www.nagios.org/documentation
    Process: 10770 ExecStartPre=/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg (code=exited, status=1/FAILURE)
    Process: 10771 ExecStopPost=/usr/bin/rm -f /usr/local/nagios/var/rw/nagios.cmd (code=exited, status=0/SUCCESS)
        CPU: 8ms

Feb 06 18:38:55 JMR-RHEL nagios[10770]: ***> One or more problems was encountered while processing the config files...
Feb 06 18:38:55 JMR-RHEL nagios[10770]:      Check your configuration file(s) to ensure that they contain valid
Feb 06 18:38:55 JMR-RHEL nagios[10770]:      directives and data definitions.  If you are upgrading from a previous
Feb 06 18:38:55 JMR-RHEL nagios[10770]:      version of Nagios, you should be aware that some variables/definitions
Feb 06 18:38:55 JMR-RHEL nagios[10770]:      may have been removed or modified in this version.  Make sure to read
Feb 06 18:38:55 JMR-RHEL nagios[10770]:      the HTML documentation regarding the config files, as well as the
Feb 06 18:38:55 JMR-RHEL nagios[10770]:      'Whats New' section to find out what has changed.
Feb 06 18:38:55 JMR-RHEL systemd[1]: nagios.service: Control process exited, code=exited, status=1/FAILURE
Feb 06 18:38:55 JMR-RHEL systemd[1]: nagios.service: Failed with result 'exit-code'.
Feb 06 18:38:55 JMR-RHEL systemd[1]: Failed to start Nagios Core 4.4.14.
```

To find what might be wrong, use `sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg` or `sudo /usr/local/nagios/bin/nagios -vv /usr/local/nagios/etc/nagios.cfg` for a more detailed explanation.

e.g.
```bash
$ sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

Nagios Core 4.4.14
Copyright (c) 2009-present Nagios Core Development Team and Community Contributors
Copyright (c) 1999-2009 Ethan Galstad
Last Modified: 2023-08-01
License: GPL

Website: https://www.nagios.org
Reading configuration data...
   Read main config file okay...
Error: Cannot open config file '/usr/local/nagios/etc/objects/commands.cfg' for reading: Permission denied
   Error processing object config files!


***> One or more problems was encountered while processing the config files...

     Check your configuration file(s) to ensure that they contain valid
     directives and data definitions.  If you are upgrading from a previous
     version of Nagios, you should be aware that some variables/definitions
     may have been removed or modified in this version.  Make sure to read
     the HTML documentation regarding the config files, as well as the
     'Whats New' section to find out what has changed.
```

You can look into where certain files that are needed
`sudo find / -name commands.cfg`

## Project status

Working install-nagios-core.ps1 and README.md.
!! Means that it is being worked on.
