{ pkgs, ... }: {
  home.packages = with pkgs; [
    nb
  ];
  my.navi-cheats.nb = ''
      $ note: nb list --- --column 1

      # edit a note in the currect nb notebook
      nb edit <note>
  '';
}
