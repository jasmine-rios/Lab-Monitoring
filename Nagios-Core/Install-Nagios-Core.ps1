# Install Nagios Core

## This Script installs Nagios Core for Network Monitoring

# Disable SELinux to be able to install Nagios
# Re-enable before placing in production using `sudo setenforce 1`

sudo sed -i 's/SELINUX=.*/SELINUX=disabled/g' /etc/selinux/config
sudo setenforce 0

#Install Required Dependencies for Nagios Core and Update

sudo yum install -y gcc glibc glibc-common make gettext automake autoconf wget unzip openssl-devel net-snmp net-snmp-utils httpd httpd-tools php gd gd-devel perl postfix perl

sudo yum update -y

# Download Nagios Core

cd ~

wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/releases/download/nagios-4.5.0/nagios-4.5.0.tar.gz

tar -xvzf nagios-4.5.0.tar.gz

#nagios 4.5.0 is the latest version as of now

# Extract and Compile Nagios Core
cd nagios-4.5.0

sudo ./configure --with-httpd-conf=/etc/httpd/conf.d

sudo make all

# Create Nagios User and Group and add Apache user to nagios group

sudo make install-groups-users

sudo usermod -a -G nagios apache

# Install Binaries and HTML Files

sudo make install

# This installs the service or daemon files and also configures them to start on boot. 
# The Apache httpd service is also configured at this point.

sudo make install-daemoninit

sudo systemctl enable httpd.service

# Install Command Mode and Web Configuration

sudo make install-commandmode

# Install Configuration Files

sudo make install-webconf 

## **NOTE** you can get an error of:
## "Error of /usr/bin/install: failed to access '/etc/httpd/conf.d/nagios.conf': Too many levels of symbolic links
## make: *** [Makefile:340: install-webconf] Error 1"

## To fix this you will ahve to check the symbolic links for nagios with `ls -l /etc/httpd/conf.d/`
## Then remove the existing symbolic link with `sudo rm /etc/httpd/conf.d/nagios.conf`
## Rerun the install command and verify it exists with `ls -l /etc/httpd/conf.d/nagios.conf`

# Create the etc folder for nagios 

sudo mkdir -p /usr/local/nagios/etc/

# Create objects directory in Nagios etc Directory

sudo mkdir -p /usr/local/nagios/etc/objects

# Copy Sample Configuration to Main Configuration File

sudo cp -r /tmp/nagioscore-nagios-4.5.0/sample-config/* /usr/local/nagios/etc/

# Allow moved configs to be Readable by Nagios

sudo chmod 644 /usr/local/nagios/etc/*

# Configure Local Firewall to Allow Port 80 to reach Nagios Core web interface

sudo firewall-cmd --zone=public --add-port=80/tcp

sudo firewall-cmd --zone=public --add-port=80/tcp --permanent

# Create nagiosadmin User Account

sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

## Follow the prompts to set password

# Start Apache and Nagios

sudo systemctl start httpd

sudo systemctl start nagios

# Access Nagios Core by navigating to http://your_server_ip/nagios in a web browser 
# Log in using the nagiosadmin username and the password you set earlier

# Should get error:
# "(No output on stdout) stderr: execvp(/usr/local/nagios/libexec/check_load, ...) failed. errno is 2: No such file or directory"
# Need to install Nagios Plugins in next step

# Install Nagios Plugins

cd /tmp

wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

sudo rpm -ihv epel-release-latest-8.noarch.rpm

subscription-manager repos --enable=rhel-8-server-optional-rpms

yum install -y gcc glibc glibc-common make gettext automake autoconf wget openssl-devel net-snmp net-snmp-utils

yum install -y perl-Net-SNMP