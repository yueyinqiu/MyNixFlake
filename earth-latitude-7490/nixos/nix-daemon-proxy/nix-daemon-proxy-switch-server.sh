read -r proxy
echo $proxy

mkdir -p /run/systemd/system/nix-daemon.service.d/
tee /run/systemd/system/nix-daemon.service.d/override.conf <<EOF
[Service]
Environment="all_proxy=$proxy"
EOF
systemctl daemon-reload
systemctl restart nix-daemon --no-block
