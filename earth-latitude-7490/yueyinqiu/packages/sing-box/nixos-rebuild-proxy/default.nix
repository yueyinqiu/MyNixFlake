{ config, ... }: {
    xdg.configFile."sing-box/nixos-rebuild-proxy/config.json".source = ./config.json;
    xdg.configFile."sing-box/nixos-rebuild-proxy/outbounds.json.example".source = ./outbounds.json.example;
    xdg.configFile."sing-box/nixos-rebuild-proxy/rules.json.example".source = ./rules.json.example;

    my.r.nixos-rebuild-proxy = "sing-box run -C ${config.xdg.configHome}/sing-box -D ${config.xdg.configHome}/sing-box";
}
