{ pkgs, ... }: {
  home.packages = with pkgs; [
    wpsoffice-cn
  ];

  # https://github.com/Beriholic/nix-wpsoffice-cn/issues/1#issuecomment-3706931491
  # https://bbs.wps.cn/topic/61831
  my.r.wps = ''
    HOME="$HOME/.wps" wps
  '';
}
