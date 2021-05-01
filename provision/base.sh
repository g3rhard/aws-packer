#!/bin/bash

# Base
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq install git-core software-properties-common python python-setuptools -y
sudo DEBIAN_FRONTEND=noninteractive apt-add-repository -y ppa:ansible/ansible
sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -qq install -y ansible
