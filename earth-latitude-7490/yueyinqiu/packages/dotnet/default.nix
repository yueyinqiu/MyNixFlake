{ pkgs, ... }: {
  home.packages = with pkgs; [
    dotnetCorePackages.sdk_10_0
  ];

  my.r.dotnet = ''
    dotnet
  '';
}
