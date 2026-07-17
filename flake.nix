{
  description = "yueyinqiu's flake";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    nixpkgs-master = {
      url = "github:NixOS/nixpkgs/master";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flatpaks = {
      url = "github:in-a-dil-emma/declarative-flatpak/latest";
    };

    NixVirt = {
      url = "github:AshleyYakeley/NixVirt/v0.6.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-master,
      home-manager,
      flatpaks,
      NixVirt,
      nur,
      vscode-server,
      ...
    }:
    {
      nixosConfigurations.earth-latitude-7490 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          nixvirt = NixVirt;
        };
        modules = [
          ./earth-latitude-7490/nixos
          home-manager.nixosModules.home-manager
          {
            home-manager.users.yueyinqiu = import ./earth-latitude-7490/yueyinqiu;
            home-manager.extraSpecialArgs = {
              flatpaks = flatpaks;
              nixvirt = NixVirt;
              nixpkgs-master = nixpkgs-master.legacyPackages."x86_64-linux";
              nur = nur.legacyPackages."x86_64-linux";
            };
          }
        ];
      };

      homeConfigurations.yueyinqiu-on-xamorix = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./yueyinqiu-on-xamorix
          vscode-server.homeModules.default
        ];
      };
    };
}
