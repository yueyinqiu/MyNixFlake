{ pkgs, ... }: {
  programs.bash.enable = true;

  home.packages = [
    (pkgs.writeShellApplication {
      name = "my-bash-escape-std";
      text = ''
        input=$(cat)
        printf "%s" "''${input@Q}"
      '';
    })
  ];

  my.navi-cheats.bash = ''
    # run bash, an sh-compatible shell that incorporates useful features from the Korn shell (ksh) and the C shell (csh).
    bash <args>
  '';
}
