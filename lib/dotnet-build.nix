{ pkgs, lib, ... }:
let
    singleFile = {
        name,
        version,
        src,
        sdk ? pkgs.dotnetCorePackages.sdk_10_0,
    }:
    let
        project = pkgs.runCommand "${name}-project" {} ''
            "${sdk}/bin/dotnet" project convert "${src}" --output "$out" --interactive False
            mv "$out/${builtins.baseNameOf src}.csproj" "$out/${name}.csproj"
        '';
    in
    pkgs.buildDotnetModule {
        pname = name;
        version = version;
        src = project;
        dotnet-sdk = sdk;
        projectFile = "${name}.csproj" ;
    };
in
{
    _module.args.dotnetBuild = { singleFile = singleFile; };
}
