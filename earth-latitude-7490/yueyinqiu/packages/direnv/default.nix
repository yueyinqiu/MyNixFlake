{ ... }: {
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  my.r."direnv-use-flake" = ''
    if [ -f .envrc ]; then
        echo ".envrc already exists, skipped"
    else
        echo "use flake" > .envrc
        echo ".envrc created"
    fi
  '';

  my.r."direnv-allow" = "direnv allow";
}
