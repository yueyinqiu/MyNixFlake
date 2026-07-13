# journalctl -u nix-daemon-proxy -f
sudo all_proxy=socks5h://127.0.0.1:62751 nixos-rebuild switch --flake ".#$(hostname)"
