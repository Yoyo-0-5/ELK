#!/bin/bash
set -e

# Update package list
sudo dnf update

# Ensure Python venv module is installed
sudo dnf install -y python3.12-devel

# Create Python virtual environment if not exists
if [ ! -d ".venv" ]; then
  python3 -m venv .venv
fi


# 以下自行輸入
# # Activate the virtual environment
# source .venv/bin/activate

# # Upgrade pip and install Ansible
# pip install --upgrade pip
# pip install ansible requests joblib tqdm

# echo "Virtual environment and Ansible are ready."