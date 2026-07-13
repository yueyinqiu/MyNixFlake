{ pkgs, ... }: {
    programs.vscode.enable = true;
    programs.vscode.package = pkgs.vscode.fhs;


    my.r.code = ''
        code "$@"
    '';

    my.r.os = "code ~/MyProjects/Nix/MyNixFlake";
    my.r.note = "code ~/MyMiscellaneousFiles/Notes";
}