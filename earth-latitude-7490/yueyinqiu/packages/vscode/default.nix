{ pkgs, ... }: {
    programs.vscode.enable = true;
    my.r.code = "code";
    my.r.os = "code ~/MyProjects/Nix/MyNixFlake";
    my.r.note = "code ~/MyMiscellaneousFiles/Notes";
}