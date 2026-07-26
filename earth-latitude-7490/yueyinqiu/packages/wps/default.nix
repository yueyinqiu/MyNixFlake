{ pkgs, ... }: {
  # https://github.com/Beriholic/nix-wpsoffice-cn/issues/1#issuecomment-3706931491
  # https://bbs.wps.cn/topic/61831
  my.r.wps = ''
    GTK_IM_MODULE="fcitx" QT_IM_MODULE="fcitx" SDL_IM_MODULE="fcitx" HOME="$HOME/.wps" ${pkgs.wpsoffice-cn}/bin/wps
  '';
}
