{
    description = "yueyinqiu's flake";

    inputs = {
        nixpkgs-proxy.url = "git+https://mirrors-us01.git-zh.com/NixOS/nixpkgs.git?ref=nixos-unstable&shallow=1";
        
        home-manager-proxy.url = "git+https://mirrors-us01.git-zh.com/nix-community/home-manager.git?ref=master&shallow=1";
        home-manager-proxy.inputs.nixpkgs.follows = "nixpkgs-proxy";
    };
    
    outputs = { self, nixpkgs-proxy, home-manager-proxy, ... }@inputs: {
        nixosConfigurations.earth-latitude-7490 = nixpkgs-proxy.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./earth-latitude-7490/nixos
                home-manager-proxy.nixosModules.home-manager {
                    home-manager.users.yueyinqiu = import ./earth-latitude-7490/yueyinqiu;
                }
            ];
        };
    };
}
