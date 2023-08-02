#!/bin/bash

# Update the package list and install required packages
sudo apt update
sudo apt install -y openjdk-11-jdk unzip

# Download and extract SonarQube
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.9.2.46101.zip
unzip sonarqube-8.9.2.46101.zip -d /opt/
sudo mv /opt/sonarqube-8.9.2.46101 /opt/sonarqube

# Create a dedicated user and set permissions
sudo useradd -r sonarqube -s /bin/bash
sudo chown -R sonarqube:sonarqube /opt/sonarqube

# Configure SonarQube to run as a service
sudo tee /etc/systemd/system/sonarqube.service <<EOF
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=simple
User=sonarqube
Group=sonarqube
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
Restart=always
LimitNOFILE=65536
LimitNPROC=8192

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and start SonarQube
sudo systemctl daemon-reload
sudo systemctl start sonarqube
sudo systemctl enable sonarqube

# Allow incoming traffic on port 9000 (SonarQube's default port)
sudo ufw allow 9000/tcp

# Display SonarQube status
sudo systemctl status sonarqube

echo "SonarQube installation and setup completed!"
