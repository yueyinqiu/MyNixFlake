{ flatpaks, ... }: {
  imports = [
    flatpaks.homeModules.default
  ];

  services.flatpak = {
    enable = true;
    remotes = {
      "flathub" = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    };
  };

  my.navi-cheats = [
    ''
      % flatpak

      # run flatpak, a framework for distributing desktop applications across various Linux distributions.
      flatpak <args>
    ''
  ];
}
