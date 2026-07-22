{ ... }: {
  imports = [
    ./packages
  ];

  home.username = "yueyinqiu";
  home.homeDirectory = "/home/yueyinqiu";

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "26.05";
}
