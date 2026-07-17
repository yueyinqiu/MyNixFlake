{ pkgs, ... }: {
  home.packages = with pkgs; [
    opencode
  ];

  my.r.opencode = ''
    opencode "$@"
  '';
}
