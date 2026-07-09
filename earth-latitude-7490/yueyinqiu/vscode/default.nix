{ pkgs, ... }: {
    programs.vscode.enable = true;
    my.run.entries.vscode = "code";
}