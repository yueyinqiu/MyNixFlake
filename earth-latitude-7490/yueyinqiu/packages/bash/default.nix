{ ... }: {
  programs.bash.enable = true;
  my.navi-cheats = [
    ''
      % bash

      # run bash, an sh-compatible shell that incorporates useful features from the Korn shell (ksh) and the C shell (csh).
      bash <args>
    ''
  ];
}
