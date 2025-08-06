#!/bin/bash
export PATH=/usr/local/bin:$PATH
# filepath: scripts/install_k3s_auto.sh

set -e

# ====== [階段 1] 系統與 Python 環境準備 ======
echo "[1/5] 系統與 Python 環境準備..."
sudo dnf update -y
sleep 1
sudo dnf install python3.12-pip -y
sleep 1
python3.12 -m ensurepip --upgrade
sleep 1
python3.12 -m pip install --upgrade pip
sleep 1
python3.12 -m pip install ansible --no-input
sleep 1

# ====== [階段 2] 進入專案根目錄 ======
echo "[2/5] 進入專案根目錄..."
cd "$(dirname "$0")/.." || { echo "找不到專案根目錄"; exit 1; }
sleep 1

# ====== [階段 3] 執行 Ansible Playbook 安裝 k3s ======
echo "[3/5] 執行 Ansible Playbook 安裝 k3s..."
ansible-playbook -i ansible/inventories/hosts.ini ansible/playbooks/install_k3s.yaml
sleep 1


echo "k3s 自動化安裝完成！"
sleep 1

# ====== [階段 4] 進入 elk 目錄 ======
echo "[4/5] 進入 elk 目錄..."
cd elk || { echo "找不到 elk 目錄"; exit 1; }
sleep 1

echo "設定 KUBECONFIG 供 Helm 使用..."
export KUBECONFIG="$HOME/.k3s/k3s.yaml"
sleep 1

# ====== [階段 5] 安裝 ELK 服務 ======
echo "[5/5] 安裝 ELK 服務..."
helm repo update
sleep 1
echo "安裝 elasticsearch..."
helm upgrade --install elasticsearch elastic/elasticsearch -f elasticsearch/values.yml
sleep 1
echo "安裝 filebeat..."
helm upgrade --install filebeat elastic/filebeat -f filebeat/values.yml
sleep 1
echo "安裝 logstash..."
helm upgrade --install logstash elastic/logstash -f logstash/values.yml
echo "等待 elasticsearch 安裝完成..."
sleep 300
echo "安裝 kibana..."
helm upgrade --install kibana elastic/kibana -f kibana/values.yml
sleep 1

echo "ELK 服務安裝完成！"
sleep 1
