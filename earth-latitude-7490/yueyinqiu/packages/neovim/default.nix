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
      vim.binds = {
        whichKey = {
          enable = true;
        };
      };
      vim.filetree = {
        neo-tree = {
          enable = true;
        };
      };
    };
  };

  my.navi-cheats = [
    ''
      % neovim

      # run neovim, a modern, fast and feature-rich editor that is fully compatible with Vim.
      nvim <args>
    ''
  ];
}
