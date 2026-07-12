mkdir -p /run/systemd/system/nix-daemon.service.d/
tee /run/systemd/system/nix-daemon.service.d/override.conf << EOF
[Service]
Environment="https_proxy=http://localhost:52207"
Environment="http_proxy=http://localhost:52207"
Environment="all_proxy=http://localhost:52207"
EOF
systemctl daemon-reload
systemctl restart nix-daemon
https_proxy=http://localhost:52207 http_proxy=http://localhost:52207 all_proxy=http://localhost:52207 nixos-rebuild switch --flake ".#$(hostname)"
