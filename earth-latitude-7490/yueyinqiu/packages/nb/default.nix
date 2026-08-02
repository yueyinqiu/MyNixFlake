{ pkgs, ... }: {
  home.packages = with pkgs; [
    nb
  ];
  my.navi-cheats.nb = ''
      $ note: nb list --filenames --no-id --- my-bash-escape-std

      # edit a note in the currect nb notebook
      nb edit <note>
      
      # disable nb auto sync
      nb set auto_sync 0
      
      # disable nb auto sync
      nb set auto_sync 0
      
      # set nb sync url
      nb remote set <url>

      # sync the currect nb notebook
      nb sync
  '';
}
