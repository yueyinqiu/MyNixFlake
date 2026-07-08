{
    description = "yueyinqiu's flake";

    inputs = {
        nixos-proxy.url = "git+https://gh-proxy.org/https://github.com/NixOS/nixpkgs.git?ref=nixos-unstable&shallow=1";
        
        nixpkgs-proxy.url = "git+https://gh-proxy.org/https://github.com/NixOS/nixpkgs.git?ref=nixpkgs-unstable&shallow=1";
        
        home-manager-proxy.url = "git+https://gh-proxy.org/https://github.com/nix-community/home-manager.git?ref=master&shallow=1";
        home-manager-proxy.inputs.nixpkgs.follows = "nixpkgs-proxy";
    };
    
    outputs = { self, nixos-proxy, nixpkgs-proxy, home-manager-proxy, ... }@inputs: {
        nixosConfigurations.earth-latitude-7490 = nixos-proxy.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./earth-latitude-7490/nixos
                home-manager-proxy.nixosModules.home-manager {
                    home-manager.users.yueyinqiu = import ./earth-latitude-7490/yueyinqiu;
                    home-manager.nixpkgs.pkgs = nixpkgs-proxy.legacyPackages.x86_64-linux;
                }
            ];
        };
    };
}