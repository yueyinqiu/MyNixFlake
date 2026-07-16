{ ... }: {
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export GTK_IM_MODULE=fcitx
      export QT_IM_MODULE=fcitx
      export XMODIFIERS=@im=fcitx
    '';
  };
  my.r."bash" = ''
    bash "$@"
  '';
}
