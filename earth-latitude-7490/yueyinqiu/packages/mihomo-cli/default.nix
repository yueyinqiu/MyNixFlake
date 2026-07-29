{ pkgs, ... }:
{
  home.packages = [
    (pkgs.rustPlatform.buildRustPackage {
      pname = "mihomo-tui";
      version = "0.4.5";

      src = pkgs.fetchFromGitHub {
        owner = "potoo0";
        repo = "mihomo-tui";
        rev = "v0.4.5";
        hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
      };

      cargoHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    })
  ];
}
