{ pkgs, ... }: {
  home.packages = with pkgs; [
    nixd
  ];

  my.navi-cheats = [
    ''
      % nixd

      # run nixd, a feature-rich nix language server interoperating with C++ nix.
      nixd <args>
    ''
  ];
}
