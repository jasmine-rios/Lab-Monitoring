# Install Nagios Core

## This Script installs Nagios Core for Network Monitoring

# Disable SELinux to be able to install Nagios
# Re-enable before placing in production using `sudo setenforce 1`

sudo setenforce 0

# Update the System
sudo yum update

#Install Required Dependencies for Nagios Core and 

sudo yum install -y gcc glibc glibc-common make gettext automake autoconf wget unzip openssl-devel net-snmp net-snmp-utils httpd httpd-tools php gd gd-devel perl postfix Net SNMP

# Download Nagios Core

cd ~

wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.5.0.tar.gz

tar xzf nagioscore.tar.gz

#nagios 4.4.14 is the latest version as of now

# Extract and Compile Nagios Core
cd nagioscore-nagios-4.5.0

./configure --with-httpd-conf=/etc/apache2/sites-enabled

make all

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

sudo make install-config

# Install Apache Configuration Files

sudo make install-webconf

# Allow port 80 inbound on local firewall

firewall-cmd --zone=public --add-port=80/tcp

firewall-cmd --zone=public --add-port=80/tcp --permanent

# Create nagiosadmin User Account

sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

## Follow the prompts to set password

# Start Apache and Nagios

sudo systemctl start httpd.service

sudo systemctl enable nagios.service

sudo systemctl start nagios.service

# Access Nagios Core by navigating to http://your_server_ip/nagios in a web browser 
# Log in using the nagiosadmin username and the password you set earlier

# Should get error:
# "(No output on stdout) stderr: execvp(/usr/local/nagios/libexec/check_load, ...) failed. errno is 2: No such file or directory"
# Need to install Nagios Plugins in next step

# Install Epel (Extra Packages for Enterprise Linux)

cd ~

sudo dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

sudo rpm -ihv epel-release-latest-9.noarch.rpm

sudo subscription-manager repos --enable codeready-builder-for-rhel-9-$(arch)-rpms

# Install Nagios Plugin

cd ~

wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.4.8.tar.gz

tar xzf nagios-plugins.tar.gz

cd nagios-plugins-release-2.4.8

## Compile and Install Nagios Plugin

./tools/setup

./configure
 
sudo make

sudo make install

## Test Plugin with by going to http://<Your-server-ip>/nagios

##Go to a host or service object and "Re-schedule the next check" under the Commands menu. The error you previously saw should now disappear and the correct output will be shown on the screen.
