#!/usr/bin/env bash

set -e

cd /etc/netplan || {
	echo "Failed to cd to /etc/netplan"
	exit 1
}

if [ -f 01-network-manager-all.yaml ]; then
    sudo mv 01-network-manager-all.yaml 01-network-manager-all.txt
    sudo mv 02-network-manager.txt 02-network-manager.yaml
elif [ -f 01-network-manager-all.txt ]; then
    sudo mv 01-network-manager-all.txt 01-network-manager-all.yaml
    sudo mv 02-network-manager.yaml 02-network-manager.txt
else
    echo "No known config state."
    exit 1
fi

sudo netplan generate
sudo netplan apply

sudo systemctl restart systemd-resolved
sudo systemctl restart systemd-networkd
