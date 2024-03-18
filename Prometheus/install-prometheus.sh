# This is the script that downloads Prometheus for RHEL and other linux like distrubutions

# Enable the primary port that Prometheus uses

sudo firewall-cmd --zone=public --add-port=9090/tcp --permanent

# Reload the firewall 

sudo firewall-cmd --reload

# Download prometheus

sudo wget https://github.com/prometheus/prometheus/releases/download/v2.51.0-rc.0/prometheus-2.51.0-rc.0.linux-amd64.tar.gz

# Extract the tarball

sudo tar -xvf prometheus-2.51.0-rc.0.linux-amd64.tar.gz

# Change directories to the newly created directory

cd prometheus-2.51.0.linux-amd64/

# Once downloaded there will be a file called `prometheus.yml`
# Configure the yaml file as needed for the intervals

# Run the prometheus binary

./prometheuss
