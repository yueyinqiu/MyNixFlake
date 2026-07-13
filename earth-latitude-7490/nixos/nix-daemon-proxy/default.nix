{ pkgs, lib, ... }:
let
    script = pkgs.writeShellScriptBin "nix-daemon-proxy" (builtins.readFile ./nix-daemon-proxy.sh);
in {
    environment.systemPackages = [ script ];

    users.groups.nix-daemon-proxy = {};

    security.sudo.extraRules = [{
        groups = [ "nix-daemon-proxy" ];
        commands = [{
            command = "${script}/bin/nix-daemon-proxy";
            options = [ "NOPASSWD" ];
        }];
    }];
}
