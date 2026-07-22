{ pkgs, ... }:

let
  sub2sing-box = pkgs.buildGoModule rec {
    pname = "sub2sing-box";
    version = "0.0.11";

    src = pkgs.fetchFromGitHub {
      owner = "bestnite";
      repo = "sub2sing-box";
      rev = "v${version}";
      hash = "sha256-A5FRrWjIs2YHP+JVXdM4f1nWh3x4zxt7pGI4XZunw+w=";
    };

    vendorHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    proxyVendor = false;
    meta = with pkgs.lib; {
      description = "将节点和订阅转换为 sing-box 配置的工具";
      homepage = "https://github.com/bestnite/sub2sing-box";
      license = licenses.mit;
      mainProgram = "sub2sing-box";
    };
  };

in {
  home.packages = [
    sub2sing-box
  ];
}