{
    description = "yueyinqiu's flake";

    inputs = {
        nixpkgs-proxy.url = "git+https://gh-proxy.com/https://github.com/NixOS/nixpkgs.git?ref=nixos-unstable&shallow=1";
        
        home-manager-proxy.url = "git+https://gh-proxy.com/https://github.com/nix-community/home-manager.git?ref=master&shallow=1";
        home-manager-proxy.inputs.nixpkgs.follows = "nixpkgs-proxy";

        nix-flatpak-proxy.url = "git+https://gh-proxy.com/https://github.com/gmodena/nix-flatpak.git?ref=main&shallow=1";
    };
    
    outputs = { self, nixpkgs-proxy, home-manager-proxy, nix-flatpak-proxy, ... }@inputs: {
        nixosConfigurations.earth-latitude-7490 = nixpkgs-proxy.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./earth-latitude-7490/nixos
                home-manager-proxy.nixosModules.home-manager {
                    home-manager.users.yueyinqiu = import ./earth-latitude-7490/yueyinqiu;
                    home-manager.extraSpecialArgs = { nix-flatpak = nix-flatpak-proxy; };
                }
            ];
        };
    };
}
