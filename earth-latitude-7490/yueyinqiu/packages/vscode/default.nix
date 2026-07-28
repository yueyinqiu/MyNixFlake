{ pkgs, ... }: {
  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscode.fhs;

  home.shellAlias.v = ''code "$@"'';

  my.navi-cheats.vscode = ''
    $ target: find . -maxdepth 1 --- --map my-bash-escape-std
    
    # run vscode, a free, open-source code editor for Windows, macOS, and Linux.
    code
    
    # open a file or folder with vscode 
    code <target>
  '';
}
