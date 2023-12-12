#!/bin/bash
THRESHOLD=70
USAGE=$(df -h /containerdata | awk 'NR==2 {print substr($5, 1, length($5)-1)}')


if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Disk usage in /containerdata is greater than $THRESHOLD%."
    echo "Running crictl prune command..."
    sudo /var/lib/rancher/rke2/bin/crictl --runtime-endpoint unix:///run/k3s/containerd/containerd.sock rmi --prune
    echo "crictl prune command executed successfully."
else
    echo "Disk usage in /containerdata is below $THRESHOLD%. Skipping docker prune."
fi
