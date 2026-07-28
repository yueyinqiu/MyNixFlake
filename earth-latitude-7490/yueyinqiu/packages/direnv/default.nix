{ ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  my.navi-cheats.direnv = ''
    # initialize .envrc with "use flake" for Nix environment
    r direnv-use-flake

    # grant permission to run the current .envrc in this directory
    direnv allow

    # check direnv status and currently loaded environment variables
    direnv status
  '';
}
