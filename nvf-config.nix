{
  pkgs,
  lib,
  config,
  ...
}: {
  vim = {
    treesitter.indent.enable = false;
    options.autoindent = true;
    mini.indentscope.enable = true;
    filetree.nvimTree = {
      enable = true;
      mappings.toggle = "<C-n>";
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

    lsp = {
      enable = true;
      formatOnSave = true;
      nvim-docs-view.enable = true;
      lspSignature.enable = false; # conflicts with blink in maximal
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

    keymaps = [
      {
        key = "<C-s>";
        mode = "n";
        silent = true;
        action = "<cmd>w<CR>";
      }
    ];
  };
}
