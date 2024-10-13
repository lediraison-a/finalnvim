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
    'iguanacucumber/magazine.nvim',
    name = 'nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
    },
    config = function()
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()
      local luasnip = require('luasnip')

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )

      -- custom formating, nvim-highlight-colors & lspkind compatible
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

      -- Supertab mappings
      local tab_mapping = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.locally_jumpable(1) then
          luasnip.jump(1)
        else
          fallback()
        end
      end, { 'i', 's' })
      local stab_mapping = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { 'i', 's' })
      local cr_mapping = cmp.mapping(function(fallback)
        if cmp.visible() then
          if luasnip.expandable() then
            luasnip.expand()
          else
            cmp.confirm({
              select = true,
            })
          end
        else
          fallback()
        end
      end)

      -- cmp setup
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
        mapping = cmp.mapping.preset.insert({
          -- Navigate between completion items
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),
          -- Navigate between snippet placeholder
          ['<C-f>'] = cmp_action.vim_snippet_jump_forward(),
          ['<C-b>'] = cmp_action.vim_snippet_jump_backward(),
          -- Scroll up and down in the completion documentation
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
          -- Supertab
          ['<CR>'] = cr_mapping,
          ['<Tab>'] = tab_mapping,
          ['<S-Tab>'] = stab_mapping,
          --
          ['<Esc>'] = cmp.mapping.abort()
        }),
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
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
  },
  -- lsp saga
  {
    'nvimdev/lspsaga.nvim',
    lazy = true,
    event = { 'LspAttach' },
    config = function()
      require('lspsaga').setup({
        symbol_in_winbar = {
          enable = true,
          color_mode = false,
        },
        border = 'none'
      })
    end,
  }

}
