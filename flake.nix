{
    description = "yueyinqiu's flake";

    inputs = {
        nixpkgs-proxy.url = "git+https://gh-proxy.com/https://github.com/NixOS/nixpkgs.git?ref=nixos-unstable&shallow=1";
        
        home-manager-proxy.url = "git+https://gh-proxy.com/https://github.com/nix-community/home-manager.git?ref=master&shallow=1";
        home-manager-proxy.inputs.nixpkgs.follows = "nixpkgs-proxy";

        flatpaks-proxy.url = "git+https://gh-proxy.com/https://github.com/in-a-dil-emma/declarative-flatpak.git?ref=latest&shallow=1";

        flake-compat-proxy.url = "git+https://gh-proxy.com/https://github.com/edolstra/flake-compat.git?ref=master&shallow=1";
        nix-filter-proxy.url = "git+https://gh-proxy.com/https://github.com/numtide/nix-filter.git?ref=main&shallow=1";
        flake-utils-proxy.url = "git+https://gh-proxy.com/https://github.com/numtide/flake-utils.git?ref=main&shallow=1";

        winapps-proxy.url = "git+https://gh-proxy.com/https://github.com/winapps-org/winapps.git?ref=main&shallow=1";
        winapps-proxy.inputs.nixpkgs.follows = "nixpkgs-proxy";
        winapps-proxy.inputs.nix-filter.follows = "nix-filter-proxy";
        winapps-proxy.inputs.flake-utils.follows = "flake-utils-proxy";
        winapps-proxy.inputs.flake-compat.follows = "flake-compat-proxy";
    };
    
    outputs = { self, nixpkgs-proxy, home-manager-proxy, flatpaks-proxy, winapps-proxy, ... }@inputs: {
        nixosConfigurations.earth-latitude-7490 = nixpkgs-proxy.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { winapps = winapps-proxy; };
            modules = [
                ./earth-latitude-7490/nixos
                home-manager-proxy.nixosModules.home-manager {
                    home-manager.users.yueyinqiu = import ./earth-latitude-7490/yueyinqiu;
                    home-manager.extraSpecialArgs = { flatpaks = flatpaks-proxy; };
                }
            ];
        };
    };
}
