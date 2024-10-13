return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    lazy = true,
    config = false,
  },

  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    'onsails/lspkind.nvim',
    lazy = true
  },
  {
    'brenoprata10/nvim-highlight-colors',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      render = 'background', -- 'background', 'foreground' or 'first_column'
      enable_named_colors = true,
    },
  },
  {
    'L3MON4D3/LuaSnip',
    lazy = true,
    version = 'v2.*',
    build = 'make install_jsregexp'
  },
  {
    'rafamadriz/friendly-snippets',
    lazy = true,
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'saadparwaiz1/cmp_luasnip' }
    },
    config = function()
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()

      local cmp_formating = cmp.get_config().formatting
      cmp_formating.format = function(entry, item)
        local color_item = require('nvim-highlight-colors').format(entry, { kind = item.kind })
        item = require('lspkind').cmp_format({})(entry, item)
        if color_item.abbr_hl_group then
          item.kind_hl_group = color_item.abbr_hl_group
          item.kind = color_item.abbr
        end
        return item
      end

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
        mapping = cmp.mapping.preset.insert({
          -- Navigate between completion items
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),

          -- `Enter` key to confirm completion
          ['<CR>'] = cmp.mapping.confirm({ select = false }),

          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- Navigate between snippet placeholder
          ['<C-f>'] = cmp_action.vim_snippet_jump_forward(),
          ['<C-b>'] = cmp_action.vim_snippet_jump_backward(),

          -- Scroll up and down in the completion documentation
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        }),
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        formatting = cmp_formating
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
    },
    keys = {
      { '<leader>cr',  '<cmd>lua vim.lsp.buf.rename()<cr>',               'code rename' },
      { '<leader>ca',  '<cmd>lua vim.lsp.buf.code_action()<cr>',          'code code action' },
      { '<leader>cf',  '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'code format' },
      { '<leader>cs',  '<cmd>lua vim.lsp.buf.signature_help()<cr>',       'code signature help' },
      { '<leader>cgD', '<cmd>lua vim.lsp.buf.declaration()<cr>',          'code goto declarations' },
      { '<leader>cgd', '<cmd>lua vim.lsp.buf.definition()<cr>',           'code goto definition' },
      { '<leader>cgi', '<cmd>lua vim.lsp.buf.implementation()<cr>',       'code goto implementation' },
      { '<leader>cgr', '<cmd>lua vim.lsp.buf.references()<cr>',           'code goto references' },
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      -- lsp_attach is where you enable features that only work
      -- if there is a language server active in the file
      local lsp_attach = function(client, bufnr)
        local opts = { buffer = bufnr }
        lsp_zero.buffer_autoformat()
      end

      lsp_zero.extend_lspconfig({
        sign_text = {
          error = '✘',
          warn = '▲',
          hint = '⚑',
          info = '»',
        },
        lsp_attach = lsp_attach,
        capabilities = require('cmp_nvim_lsp').default_capabilities()
      })

      require('mason-lspconfig').setup({
        ensure_installed = {},
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup({})
          end,
        }
      })
    end
  }
}
