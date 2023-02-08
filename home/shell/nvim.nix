{ config, pkgs, ... }:

{
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      plugins = with pkgs.vimPlugins; [
        sensible
        deoplete-nvim
      ];
      extraLuaConfig = ''
        require("catppuccin").setup({
          integrations = {
              aerial = false,
              barbar = false,
              beacon = false,
              cmp = true,
              coc_nvim = false,
              dashboard = true,
              fern = false,
              fidget = false,
              gitgutter = false,
              gitsigns = true,
              harpoon = false,
              hop = false,
              illuminate = false,
              leap = false,
              lightspeed = false,
              lsp_saga = false,
              lsp_trouble = false,
              markdown = true,
              mason = true,
              mini = false,
              neogit = false,
              neotest = false,
              neotree = false,
              noice = false,
              notify = false,
              nvimtree = true,
              overseer = false,
              pounce = false,
              semantic_tokens = false,
              symbols_outline = false,
              telekasten = false,
              telescope = true,
              treesitter = true,
              treesitter_context = false,
              ts_rainbow = false,
              vim_sneak = false,
              vimwiki = false,
              which_key = false,

              -- Special integrations, see https://github.com/catppuccin/nvim#special-integrations
              dap = {
                  enabled = false,
                  enable_ui = false,
              },
              indent_blankline = {
                  enabled = true,
                  colored_indent_levels = false,
              },
              native_lsp = {
                  enabled = true,
                  virtual_text = {
                      errors = { "italic" },
                      hints = { "italic" },
                      warnings = { "italic" },
                      information = { "italic" },
                  },
                  underlines = {
                      errors = { "underline" },
                      hints = { "underline" },
                      warnings = { "underline" },
                      information = { "underline" },
                  },
              },
              navic = {
                  enabled = false,
                  custom_bg = "NONE",
              },
            },
          })
          local latte = require("catppuccin.palettes").get_palette "latte"
          local frappe = require("catppuccin.palettes").get_palette "frappe"
          local macchiato = require("catppuccin.palettes").get_palette "macchiato"
          local mocha = require("catppuccin.palettes").get_palette "mocha"
          require("nvim-dap-virtual-text").setup()
          require('go').setup()
          require'navigator'.setup()
          require('feline').setup()
          local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
          vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*.go",
            callback = function()
            require('go.format').goimport()
            end,
            group = format_sync_grp,
          })
          require'nvim-web-devicons'.setup {
          -- your personnal icons can go here (to override)
          -- you can specify color or cterm_color instead of specifying both of them
          -- DevIcon will be appended to `name`
          override = {
            zsh = {
              icon = "",
              color = "#428850",
              cterm_color = "65",
              name = "Zsh"
            }
          };
          -- globally enable different highlight colors per icon (default to true)
          -- if set to false all icons will have the default icon's color
          color_icons = true;
          -- globally enable default icons (default to false)
          -- will get overriden by `get_icons` option
          default = true;
          }
      '';
      extraConfig = ''
        syntax on
        set nu ru et
        set ts=2 sts=2 sw=2
        set cursorline
        set hlsearch
        set nocompatible   " be improved, required
        filetype off       " required
        set termguicolors
        call plug#begin()

        " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
        Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
        Plug 'junegunn/vim-easy-align'
        Plug 'cuducos/yaml.nvim'
        Plug 'rcarriga/nvim-dap-ui'
        Plug 'morhetz/gruvbox'
        Plug 'tpope/vim-fugitive'
        Plug 'preservim/nerdtree', 
        Plug 'kien/ctrlp.vim'
        Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
        Plug 'mfussenegger/nvim-dap'
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'nvim-lua/plenary.nvim'
        Plug 'nvim-telescope/telescope.nvim'
        Plug 'theHamsta/nvim-dap-virtual-text'
        Plug 'neovim/nvim-lspconfig'
        Plug 'ray-x/navigator.lua'
        Plug 'ray-x/go.nvim'
        Plug 'ray-x/guihua.lua'
        Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
        Plug 'feline-nvim/feline.nvim'
        Plug 'nvim-tree/nvim-web-devicons'
        Plug 'ful1e5/onedark.nvim'
        Plug 'leoluz/nvim-dap-go'

        " Initialize plugin system
        " - Automatically executes `filetype plugin indent on` and `syntax enable`.
        call plug#end()

        function! StartUp()
            if 0 == argc()
                NERDTree
            end
        endfunction

        autocmd VimEnter * call StartUp()

        autocmd vimenter * ++nested colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
        map <silent> <C-n> :NERDTreeFocus<CR>

      '';
    };
}