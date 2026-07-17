{ vscode-server, ... }: {
  imports = [
    vscode-server.homeModules.default
  ];
          
  services.vscode-server.enable = true;
}
