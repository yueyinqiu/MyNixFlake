{ pkgs, ... }: {
  home.packages = with pkgs; [
    dotnetCorePackages.sdk_10_0
  ];

  my.navi-cheats.dotnet = ''
    $ script: find . -maxdepth 1 -type f -name "*.cs" --- --map my-bash-escape-std

    # run a dotnet file-based app.
    dotnet run <script>
  '';
}
