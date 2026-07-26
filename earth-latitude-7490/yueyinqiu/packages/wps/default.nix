{ pkgs, ... }: {
  home.packages = with pkgs; [
    wpsoffice-cn
  ];

  # https://github.com/Beriholic/nix-wpsoffice-cn/issues/1#issuecomment-3706931491
  my.r.wps = ''
    mkdir -p $HOME/.wps/Documents
    GTK_IM_MODULE="fcitx" QT_IM_MODULE="fcitx" SDL_IM_MODULE="fcitx" proot -b "$HOME/.wps/Documents:$HOME/Documents" wps "$@"
  '';
}
