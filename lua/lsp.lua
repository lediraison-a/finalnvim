return {
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
    -- lazy = true,
    version = 'v2.*',
    build = 'make install_jsregexp'
  },
  {
    'rafamadriz/friendly-snippets',
    -- lazy = true,
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
  -- completion
  {
    -- 'hrsh7th/nvim-cmp',
    'iguanacucumber/magazine.nvim',
    name = 'nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      -- { 'hrsh7th/nvim_lsp_signature_help' },
      -- { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
    },
    config = function()
      local cmp = require('cmp')
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
      local cspace_mapping = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.abort()
        else
          cmp.complete()
        end
      end)

      -- cmp setup
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip' },
          {
            name = "lazydev",
            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
          },
        }, {
          { name = 'buffer' },
          { name = 'path' },
        }),
        mapping = cmp.mapping.preset.insert({
          -- Navigate between completion items
          ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
          ['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cspace_mapping,
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

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
        }, {
          { name = 'buffer' },
          {
            name = 'cmdline',
            option = {
              ignore_cmds = { 'Man', '!' }
            }
          }
        })
      })
    end
  },
  -- LSP
  {
    "mason-org/mason-lspconfig.nvim",
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
    opts = {
      ensure_installed = {},
    },
    lazy = false,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {}
      },
      {
        "neovim/nvim-lspconfig",
      },
    },
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
