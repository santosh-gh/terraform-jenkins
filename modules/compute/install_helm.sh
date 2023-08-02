#!/bin/bash

echo "Install Helm Chart Using Script"

# Download the latest Helm release
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3

# Make the script executable
chmod +x get_helm.sh

# Run the script to install Helm
./get_helm.sh

# Verify Helm installation
helm version

# Clean up the installation script
rm get_helm.sh

echo "Helm installation completed!"
