#!/usr/bin/env bash

# https://github.com/ghostty-org/ghostty/pull/11762
niri msg action spawn -- ghostty --command="r expect-bash-run r sing-box-nix-daemon-proxy"
niri msg action spawn -- ghostty --command="r expect-bash-run nix-daemon-proxy socks5h://127.0.0.1:23569"

niri msg action spawn -- FlClash
niri msg action spawn -- qq
niri msg action spawn -- r wechat
