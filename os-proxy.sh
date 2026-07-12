mkdir -p /run/systemd/system/nix-daemon.service.d/
tee /run/systemd/system/nix-daemon.service.d/override.conf << EOF
[Service]
Environment="https_proxy=http://localhost:52207/"
EOF
systemctl daemon-reload
systemctl restart nix-daemon
nixos-rebuild switch --flake ".#$(hostname)"
