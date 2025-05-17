#!/usr/bin/env bash
# this script appends 2 new values to kubelet configuration after the certificates have been approved manually
set -euo pipefail

CONFIG_FILE="/var/lib/kubelet/config.yaml"

# Append the TLS settings to kubelet config
cat <<EOF >> "$CONFIG_FILE"
tlsPrivateKeyFile: /var/lib/kubelet/pki/kubelet-server-current.pem
tlsCertFile: /var/lib/kubelet/pki/kubelet-server-current.pem
EOF

# Reload systemd and restart kubelet
systemctl daemon-reload
systemctl restart kubelet

echo "Appended TLS configuration and restarted kubelet successfully."