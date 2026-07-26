{ pkgs, ... }: {
  home.packages = with pkgs; [
    trash-cli
  ];

  my.r.trash-empty = ''
    trash-empty "$@"
  '';
  my.r.trash-list = ''
    trash-list "$@"
  '';
  my.r.trash-put = ''
    trash-put "$@"
  '';
  my.r.trash-restore = ''
    trash-restore "$@"
  '';
  my.r.trash-rm = ''
    trash-rm "$@"
  '';
}
