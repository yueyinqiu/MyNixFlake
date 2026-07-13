mkdir -p /run/systemd/system/nix-daemon.service.d/
tee /run/systemd/system/nix-daemon.service.d/override.conf <<EOF
[Service]
Environment="all_proxy=$(cat)"
EOF
systemctl daemon-reload
systemctl restart nix-daemon
