#!/bin/bash

#download Nexus
sudo yum update -y
sudo yum install java-1.8.0-openjdk-demo.x86_64 -y
sudo yum install wget  -y
sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz

# Extract Nexus
sudo tar -zxvf *.gz
sudo rm -rf *.gz
sudo mv nexus* nexus

# Create Nexus user
sudo adduser nexus

# Set permissions for Nexus user
sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work

# Modify Nexus run configuration
#sudo sed -i 's/run_as_user=""/run_as_user="nexus"/' /opt/nexus/bin/nexus.rc
 sudo echo 'run_as_user="nexus"' >> /opt/nexus/bin/nexus.rc
# Modify memory settings
#sudo sed -i '/^-Xms/c\# Memory settings\n-Xms1200M\n-Xmx1200M' /opt/nexus/bin/nexus.vmoptions

# Configure Nexus as a service
sudo tee /etc/systemd/system/nexus.service > /dev/null <<EOT
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOT

# Start Nexus service
sudo systemctl enable nexus
sudo systemctl start nexus

# Check Nexus status
sudo systemctl status nexus
