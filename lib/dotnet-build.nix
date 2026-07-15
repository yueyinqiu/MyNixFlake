{ pkgs, lib, ... }:
let
    singleFile = {
        name,
        files,
        dllName,
        sdk ? pkgs.dotnetCorePackages.sdk_10_0,
    }:
    let
        src = pkgs.runCommand "${name}-src" {} ''
            ${lib.concatMapStringsSep "\n" (f: ''
                mkdir -p "$out/${builtins.dirOf f.path}"
                cp "${f.src}" "$out/${f.path}"
            '') files}
        '';
        main = (builtins.head files).path;
    in
    pkgs.stdenv.mkDerivation {
        name = name;

        buildPhase = ''
            runHook preBuild

            "${sdk}/bin/dotnet" project convert "${src}/${main}" --output ./project --interactive False
            "${sdk}/bin/dotnet" publish ./project -c Release -p:PublishAot=false -o ./output

            runHook postBuild
        '';

        installPhase = ''
            runHook preInstall

            mkdir -p "$out/bin"
            cp -r ./output/* "$out/"

            cat > "$out/bin/${name}" << 'EOF'
            exec "${sdk}/bin/dotnet" "$out/${dllName}" "$@"
            EOF
            chmod +x "$out/bin/${name}"

            runHook postInstall
        '';

        configurePhase = "true";
        fixupPhase = "true";
    };
in
{
    _module.args.dotnetBuild = { singleFile = singleFile; };
}
