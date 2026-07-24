{ pkgs, ... }: {
  home.packages = with pkgs; [
    wpsoffice-cn
  ];

  # https://github.com/Beriholic/nix-wpsoffice-cn/issues/1#issuecomment-3706931491
  my.r.wps = ''
    HOME=/home/yueyinqiu/.wps GTK_IM_MODULE="fcitx" QT_IM_MODULE="fcitx" SDL_IM_MODULE="fcitx" wps "$@"
  '';
}
