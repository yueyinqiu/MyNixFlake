{ pkgs, ... }: {
  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscode.fhs;

  my.r.v = ''
    code "$@"
  '';
}
