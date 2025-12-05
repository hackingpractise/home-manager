{
  pkgs,
  lib,
  config,
  ...
}: {
  vim = {
    treesitter.indent.enable = false;

    options = {
      autoindent = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      softtabstop = 2;
    };

    mini.indentscope.enable = true;

    filetree.neo-tree = {
      enable = true;
      setupOpts.enable_cursor_hijack = true;
    };

    lsp = {
      # This must be enabled for the language modules to hook into
      # the LSP API.
      enable = true;

      formatOnSave = true;
      lspkind.enable = false;
      lightbulb.enable = true;
      lspsaga.enable = false;
      trouble.enable = true;
      lspSignature.enable = false; # conflicts with blink in maximal
      otter-nvim.enable = true;
      nvim-docs-view.enable = true;
    };

    statusline = {
      lualine = {
        enable = true;
        theme = "catppuccin";
      };
    };

    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = false;
    };

    autocomplete = {
      nvim-cmp.enable = false;
      blink-cmp.enable = true;
    };

    tabline.nvimBufferline = {
      enable = true;
      mappings.cyclePrevious = "<S-tab>";
      mappings.cycleNext = "<tab>";
      mappings.closeCurrent = "<leader x>";
    };

    telescope.enable = true;

    languages = {
      enableFormat = true;
      enableTreesitter = true;

      nix.enable = true;
      zig.enable = true;

      rust = {
        enable = true;
        crates.enable = true;
        treesitter.enable = true;
      };
      sql.enable = true;
    };

    mini.ai.enable = true;
    mini.git.enable = true;

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
    };

    keymaps = [
      {
        key = "<C-s>";
        mode = "n";
        silent = true;
        action = "<cmd>w<CR>";
      }
      {
        key = "<C-h>";
        mode = "n";
        action = "<cmd>Neotree focus<CR>";
      }
      {
        key = "<C-n>";
        mode = "n";
        action = "<cmd>Neotree toggle<CR>";
      }
    ];
  };
}
