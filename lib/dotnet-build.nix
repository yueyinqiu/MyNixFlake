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
            export DOTNET_CLI_HOME="$TMPDIR"
            export XDG_DATA_HOME="$TMPDIR"
            "${sdk}/bin/dotnet" project convert "${src}" --output "$out" --interactive False
            mv "$out/${lib.removeSuffix ".cs" (builtins.baseNameOf src)}.csproj" "$out/${name}.csproj"
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
