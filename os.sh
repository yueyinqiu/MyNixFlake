# journalctl -u nix-daemon-proxy -f
sudo all_proxy=socks5h://127.0.0.1:52138 http_proxy=socks5h://127.0.0.1:52138 https_proxy=socks5h://127.0.0.1:52138 nixos-rebuild switch --flake ".#$(hostname)"
