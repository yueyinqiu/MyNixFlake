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
            (pkgs.writeShellScriptBin "r" (builtins.readFile ./r.sh))
        ];
    };

    config.my.r.help = ''
        cat "''${XDG_CONFIG_HOME:-''$HOME/.config}/r/''${1}.sh"
    '';
}
