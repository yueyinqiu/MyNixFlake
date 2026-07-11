{ pkgs, ... }: {
    services.udiskie.enable = true;
    home.file."udiskie".symlink = "/run/media/yueyinqiu";
}
