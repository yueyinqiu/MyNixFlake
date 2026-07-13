#!/usr/bin/env bash

# https://github.com/ghostty-org/ghostty/pull/11762
niri msg action spawn -- ghostty --command="r sing-box-nix-daemon-proxy; exec $SHELL"
niri msg action spawn -- ghostty --command="nix-daemon-proxy socks5h://127.0.0.1:23569; exec $SHELL"

niri msg action spawn -- r flclash
niri msg action spawn -- r qq
niri msg action spawn -- r wechat
