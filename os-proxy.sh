mkdir -p /run/systemd/system/nix-daemon.service.d/
tee /run/systemd/system/nix-daemon.service.d/override.conf << EOF
[Service]
Environment="https_proxy=http://localhost:23569"
Environment="http_proxy=http://localhost:23569"
Environment="all_proxy=http://localhost:23569"
EOF
echo reload
systemctl daemon-reload
echo restart
systemctl restart nix-daemon
echo build!
https_proxy=http://localhost:23569 http_proxy=http://localhost:23569 all_proxy=http://localhost:23569 nixos-rebuild switch --flake ".#$(hostname)" --verbose
