{ winapps, ... }: {
    xdg.configFile."winapps/winapps.conf".source = ./winapps.conf;
    xdg.configFile."winapps/compose.yaml".source = ./compose.yaml;
    home.packages = [ winapps.winapps ];
    my.r.win = "winapps windows";
}