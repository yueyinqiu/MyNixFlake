{ pkgs, ... }: {
    services.udiskie.enable = true;
    home.file."udiskie".source = lib.file.mkOutOfStoreSymlink "/run/media/yueyinqiu";
}
