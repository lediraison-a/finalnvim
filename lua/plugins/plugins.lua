return {
  -- theme
  {
    'projekt0n/github-nvim-theme',
    name = 'github-theme',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('github-theme').setup({
        options = {
          darken = {
            sidebars = {
              enable = false,
            }
          }
        }
      })
      vim.cmd('colorscheme github_dark_default')
    end,
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true
  },
  -- nvim tree
  {
    'nvim-tree/nvim-tree.lua',
    lazy = false,
    keys = {
      { '<leader>tt', '<cmd>NvimTreeToggle<cr>', desc = 'NvimTree toggle' },
    },
    opts = {
      view = {
        width = 25,
        cursorline = true,
      },
      renderer = {
        group_empty = true,
        indent_markers = {
          enable = true,
          icons = { corner = '└ ', edge = '│ ', none = '  ' }
        },
      },
    },
  },
  -- lualine
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    opts = {
      options = {
        icons_enabled = true,
        section_separators = { left = '', right = '' },
        component_separators = { left = '•', right = '•' },
      },
    }
  },
  -- bufferline
  {
    'akinsho/bufferline.nvim',
    version = '*',
    lazy = false,
    keys = {
      { '<leader>bse', '<cmd>BufferLineSortByExtension<cr>',         desc = 'BufferLine Sort By Extenion' },
      { '<leader>bsd', '<cmd>BufferLineSortByRelativeDirectory<cr>', desc = 'BufferLine Sort By RelativeDirectory' },
      { '<leader>bco', '<cmd>BufferLineCloseOthers<cr>',             desc = 'BufferLine Close Others' },
      { '<leader>bcr', '<cmd>BufferLineCloseRight<cr>',              desc = 'BufferLine Close Right' },
      { '<leader>bcl', '<cmd>BufferLineCloseLeft<cr>',               desc = 'BufferLine Close Left' },
      { '<leader>bP',  '<cmd>BufferLineTogglePin<cr>',               desc = 'BufferLine Toggle Pin' },
      { '<leader>bp',  '<cmd>BufferLinePick<cr>',                    desc = 'BufferLine Pick' },
      { '<C-l>',       '<cmd>BufferLineCycleNext<cr>',               desc = 'BufferLine Next' },
      { '<C-h>',       '<cmd>BufferLineCyclePrev<cr>',               desc = 'BufferLine Prev' },
      { '<C-j>',       '<cmd>BufferLineMoveNext<cr>',                desc = 'BufferLine Move Next' },
      { '<C-k>',       '<cmd>BufferLineMovePrev<cr>',                desc = 'BufferLine Move Prev' },
    },
    opts = {
      options = {
        mode = 'buffers',
        enforce_regular_tabs = true,
        show_close_icon = false,
        show_buffer_close_icons = false,
        show_buffer_icons = true,
        always_show_bufferline = false,
        offsets = { {
          filetype = 'NvimTree',
          separator = true,
          text = '🌊 NEOVIM',
          text_align = 'left' --[[| 'center' | 'right',]]
        } },
      }
    },
  },
  -- telescope
  {
    'nvim-lua/plenary.nvim',
    lazy = true,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    keys = {
      { '<leader>ctr', '<cmd>Telescope lsp_references<cr>',           desc = 'LSP References' },
      { '<leader>cti', '<cmd>Telescope lsp_implementations<cr>',      desc = 'LSP Implementations' },
      { '<leader>ctd', '<cmd>Telescope lsp_definitions<cr>',          desc = 'LSP Definitions' },
      { '<leader>ctD', '<cmd>Telescope lsp_type_definitions<cr>',     desc = 'LSP Type Definitions' },
      -- Telescope diagnostics
      { '<leader>cd',  '<cmd>Telescope diagnostics bufnr=0<cr>',      desc = 'Document diagnostics' },
      { '<leader>cD',  '<cmd>Telescope diagnostics<cr>',              desc = 'Workspace diagnostics' },
      -- Telescope files
      { '<leader>fo',  '<cmd>Telescope oldfiles<cr>',                 desc = 'Recent' },
      { '<leader>ff',  '<cmd>Telescope find_files<cr>',               desc = 'Find Files (root dir)' },
      -- Lsp symbols
      { '<leader>fs',  '<cmd>Telescope lsp_document_symbols<cr>',     desc = 'Document Symbols' },
      { '<leader>fS',  '<cmd>Telescope lsp_workspace_symbols<cr>',    desc = 'Workspace Symbols' },
      -- Tabs & buffers
      { '<leader>fb',  '<cmd>Telescope buffers<cr>',                  desc = 'Buffers' },
      { '<leader>ft',  '<cmd>Telescope telescope-tabs list_tabs<cr>', desc = 'Tabs' },
      --
      { '<leader>fc',  '<cmd>Telescope command_history<cr>',          desc = 'Command History' },
      { '<leader>fg',  '<cmd>Telescope live_grep<cr>',                desc = 'Live Grep' },
      { '<leader>fk',  '<cmd>Telescope keymaps<cr>',                  desc = 'Key Maps' },
    }
  },
  -- git
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {}
  },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  ----
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    dependencies = {
      { 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim' },
    },
    event = { 'BufReadPre', 'BufNewFile' },
    main = 'ibl',
    opts = function()
      local highlight = {
        'RainbowRed',
        'RainbowYellow',
        'RainbowBlue',
        'RainbowOrange',
        'RainbowGreen',
        'RainbowViolet',
        'RainbowCyan',
      }

      local hooks = require 'ibl.hooks'
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
        vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
        vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
        vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
        vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
        vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
        vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }

      return {
        indent = {
          highlight = highlight,
        },
        scope = {
          enabled = false,
        }
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {},
  },
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'numToStr/Comment.nvim',
    opts = {}
  },
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
    },
    opts = {},
  },
  {
    'j-hui/fidget.nvim',
    opts = {},
  }
}
