{ config, ... }: {
    xdg.configFile."sing-box/config.json".source = ./config.json;
    xdg.configFile."sing-box/outbounds.json.example".source = ./outbounds.json.example;

    my.r.nixos-rebuild-proxy = "sing-box run -C ${config.xdg.configHome}/sing-box -D ${config.xdg.configHome}/sing-box";
}
