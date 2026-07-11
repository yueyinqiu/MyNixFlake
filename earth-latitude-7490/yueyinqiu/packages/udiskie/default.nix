{ pkgs, ... }: {
    services.udiskie.enable = true;
    home.file."udiskie".source = "/run/media/yueyinqiu";
}
