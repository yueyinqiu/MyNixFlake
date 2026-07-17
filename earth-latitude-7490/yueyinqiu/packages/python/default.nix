{ pkgs, ... }: {
  home.packages = with pkgs; [
    python314
  ];

  my.r.python = ''
    python
  '';
}
