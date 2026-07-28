{ pkgs, ... }: {
  home.packages = with pkgs; [
    trash-cli
  ];

  my.navi-cheats = [
    ''
      % trash-cli

      # move file or directory to trash
      trash-put <file>

      $ file: find . -maxdepth 1
    ''
    ''
      % trash-cli

      # list files in trash
      trash-list
    ''
    ''
      % trash-cli

      # restore a specific file from trash
      trash-restore "<file>"

      $ file: trash-list 2>/dev/null --- --column 3
    ''
    ''
      % trash-cli

      # empty all files from trash
      trash-empty
    ''
  ];
}
