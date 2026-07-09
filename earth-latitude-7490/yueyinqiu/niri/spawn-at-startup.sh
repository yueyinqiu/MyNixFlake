#!/usr/bin/env bash
niri msg action focus-workspace 1

niri msg spawn "FlClash"

niri msg action focus-workspace 2
niri msg spawn "qq"
niri msg spawn "sh" "-c" "run wechat"

niri msg action focus-workspace 3
