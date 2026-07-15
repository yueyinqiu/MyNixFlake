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
            cp "${src}" "$TMPDIR/${name}.cs"
            "${sdk}/bin/dotnet" project convert "$TMPDIR/${name}.cs" --output "$out" --interactive False
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
