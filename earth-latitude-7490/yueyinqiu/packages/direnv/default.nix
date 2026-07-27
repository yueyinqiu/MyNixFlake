{ ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  my.r.direnv-use-flake = ''
    if [ -f .envrc ]; then
        echo ".envrc already exists, skipped"
    else
        echo "use flake" > .envrc
        echo ".envrc created"
    fi
  '';

  my.navi-cheats = [
    ''
      % direnv, nix

      # initialize .envrc with "use flake" for Nix environment
      r direnv-use-flake
    ''
    ''
      % direnv

      # grant permission to run the current .envrc in this directory
      direnv allow
    ''
    ''
      % direnv

      # check direnv status and currently loaded environment variables
      direnv status
    ''
  ];
}
