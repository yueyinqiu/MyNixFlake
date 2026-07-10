{ ... }: {
    xdg.configFile."winapps/winapps.conf".source = ./winapps.conf;
    xdg.configFile."winapps/compose.yaml".source = ./compose.yaml;
    my.r.win = "winapps windows";
}
