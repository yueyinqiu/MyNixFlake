{ pkgs, ... }: {
  home.packages = with pkgs; [
    nb
  ];
  my.navi-cheats.nb = ''
      $ note: nb list --- --column 2 --map my-bash-escape-std

      # edit a note in the currect nb notebook
      nb edit <note>
  '';
}
