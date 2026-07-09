{ pkgs, lib, config, ... }: {
    options.my.r = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {};
    };

    config = {
        xdg.configFile = lib.mapAttrs' (name: cmd: {
            name = "r/${name}.sh";
            value = { text = cmd; };
        }) config.my.r;

        home.packages = [
            (pkgs.writeShellScriptBin "r" ''
                exec sh "''${XDG_CONFIG_HOME:-$HOME/.config}/run/''${1}.sh" "$@"
            '')
        ];
    };
}
