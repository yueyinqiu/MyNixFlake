{ pkgs, ... }: {
  home.packages = with pkgs; [
    trash-cli
  ];

  my.navi-cheats.trash-cli = ''
    $ file: find . -maxdepth 1 --- --map my-bash-escape-std
    $ trash: trash-list --- --column 3 --map my-bash-escape-std

    # move file or directory to trash
    trash-put <file>

    # list files in trash
    trash-list

    # restore a specific file from trash
    trash-restore <trash>

    # empty all files from trash
    trash-empty
  '';
}
