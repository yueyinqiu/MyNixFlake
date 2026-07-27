{ pkgs, ... }: {
  home.packages = with pkgs; [
    dotnetCorePackages.sdk_10_0
  ];

  my.navi-cheats = [
    ''
      % dotnet

      # run a dotnet file-based app.
      dotnet run "<file>"
      $file: find . -maxdepth 1 -type f -name "*.cs"
    ''
  ];
}
