#!/bin/bash
set -e

# Set DEBIAN_FRONTEND environment variable
export DEBIAN_FRONTEND=noninteractive

# Update and upgrade the system
sudo -E apt-get update -qq
sudo -E apt-get upgrade -yqq

# Install required packages in one step
sudo -E apt-get install -yqq git-core software-properties-common python python-setuptools

# Add Ansible PPA and install Ansible
sudo -E apt-add-repository -y ppa:ansible/ansible
sudo -E apt-get update -qq
sudo -E apt-get install -yqq ansible

# Clean up unnecessary files to reduce the AMI size
sudo -E apt-get clean
sudo -E rm -rf /var/lib/apt/lists/*
