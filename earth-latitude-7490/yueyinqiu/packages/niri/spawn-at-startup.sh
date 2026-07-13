#!/usr/bin/env bash

niri msg action spawn -- r nix-daemon-proxy
niri msg action spawn -- nix-daemon-proxy socks5h://127.0.0.1:23569

niri msg action spawn -- FlClash
niri msg action spawn -- qq
niri msg action spawn -- r wechat
