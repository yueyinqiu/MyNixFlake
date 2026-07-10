{ pkgs, ... }: {
    programs.vscode.enable = true;
    my.r.vscode = "code";
    my.r.os = "code ~/MyProjects/Nix/MyNixFlake";
    my.r.note = "code ~/MyMiscellaneousFiles/Notes";
}