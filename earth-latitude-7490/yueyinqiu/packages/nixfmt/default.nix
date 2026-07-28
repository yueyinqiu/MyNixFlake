{ pkgs, ... }: {
  home.packages = with pkgs; [
    nixfmt
  ];

  my.navi-cheats.nixfmt = ''
    # run nixfmt, the official formatter for Nix language code.
    nixfmt <args>
  '';
}
