{ pkgs, ... }:
pkgs.mkShell {
    nativeBuildInputs = [
        pkgs.dotnetCorePackages.sdk_10_0
        pkgs.nixd
    ];
}
