{ pkgs, username, ... }:
{
  home-manager.users.${username} = {
    programs.neovim = {
      enable = true;
    };
    programs.nixvim = {
      plugins = {
        chadtree = {
          enable = true;

        };
        gitsigns = {
          enable = true;
        };
        cmp = {
          enable = true;
        };

        treesitter.enable = true;
        todo-comments.enable = true;
        nvim-autopairs.enable = true;
        indent-blankline.enable = true;

        cmp-tabnine.enable = true;
        cmp-path.enable = true;
        cmp-cmdline.enable = true;
        cmp-buffer.enable = true;


        cmp-nvim-lsp.enable = true;
      };
    };
  };
}