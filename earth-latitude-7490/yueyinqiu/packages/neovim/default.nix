{ nvf, ... }: {
  imports = [
    nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.lsp = {
        enable = true;
      };
      vim.filetree = {
        neo-tree = {
          enable = true;
        };
      };
    };
  };
}
