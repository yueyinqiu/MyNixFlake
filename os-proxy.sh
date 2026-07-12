sudo mkdir -p /run/systemd/system/nix-daemon.service.d/
sudo tee /run/systemd/system/nix-daemon.service.d/override.conf << EOF
[Service]
Environment="https_proxy=http://localhost:52207/"
EOF
sudo systemctl daemon-reload
sudo systemctl restart nix-daemon
sudo nixos-rebuild switch --flake ".#$(hostname)"
