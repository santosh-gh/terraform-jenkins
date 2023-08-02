#!/bin/bash

# Update the package list
sudo apt update && sudo apt upgrade -y

# Install Java (required for Jenkins)
sudo apt install -y default-jdk

# Add the Jenkins repository key and source list
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'

# Update the package list again
sudo apt update

# Install Jenkins
sudo apt install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins to start on boot
sudo systemctl enable jenkins

# Display initial admin password
echo "Wait a moment for Jenkins to start..."
sleep 30
sudo cat /var/lib/jenkins/secrets/initialAdminPassword