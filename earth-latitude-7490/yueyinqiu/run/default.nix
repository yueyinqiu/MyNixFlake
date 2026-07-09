{ pkgs, lib, config, ... }: {
    options.my.run.entries = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {};
    };

    xdg.configFile = lib.mapAttrs' (name: cmd: {
        name = "run/${name}.sh";
        value = { text = cmd; };
    }) config.my.run.entries;

    home.packages = [
        (pkgs.writeShellScriptBin "run" ''
            exec sh "''${XDG_CONFIG_HOME:-$HOME/.config}/run/''${1}.sh" "$@"
        '')
    ];
}
