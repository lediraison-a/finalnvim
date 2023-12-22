return {
    ------------------------ LSP
    {
        "folke/neodev.nvim",
        opts = {},
        lazy = false,
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        lazy = true,
        config = function()
            -- This is where you modify the settings for lsp-zero
            -- Note: autocompletion settings will not take effect
            require('lsp-zero.settings').preset({})
        end
    },

    ------------------------ LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'williamboman/mason.nvim' },
            'folke/neodev.nvim'
        },
        keys = {
            { "<leader>cgD", "<cmd>lua vim.lsp.buf.declaration()<cr>",          "code goto declarations" },
            { "<leader>cgd", "<cmd>lua vim.lsp.buf.definition()<cr>",           "code goto definition" },
            { "<leader>cgi", "<cmd>lua vim.lsp.buf.implementation()<cr>",       "code goto implementation" },
            { "<leader>cgr", "<cmd>lua vim.lsp.buf.references()<cr>",           "code goto references" },
            { "<leader>cr",  "<cmd>lua vim.lsp.buf.rename()<cr>",               "code rename" },
            { "<leader>ca",  "<cmd>lua vim.lsp.buf.code_action()<cr>",          "code code action" },
            { "<leader>cf",  "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "code format" },
            { "<leader>cs",  "<cmd>lua vim.lsp.buf.signature_help()<cr>",       "code signature help" },
        },
        config = function()
            -- This is where all the LSP shenanigans will live
            local lsp = require('lsp-zero')
            lsp.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                -- lsp.default_keymaps({buffer = bufnr})
                lsp.buffer_autoformat()
            end)
            lsp.setup()
            require('lspconfig').lua_ls.setup {
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                    },
                },
            }
        end
    },


    ---------------------- Mason


    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
        -- build = ":MasonUpdate",
        -- cmd = "Mason",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = function()
            local lsp_zero = require("lsp-zero")
            local lsp_config = require("lspconfig")
            return {
                ensure_installed = {
                },
                handlers = {
                    lsp_zero.default_setup,
                }
            }
        end
    },

    --------------------- Copilot

    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        config = function()
            require("copilot").setup({
                filetypes = {
                    markdown = true,
                    help = true,
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    debounce = 75,
                    -- keymap = {
                    --     accept = "<S-Space>",
                    --     accept_word = false,
                    --     accept_line = false,
                    --     next = "<M-]>",
                    --     prev = "<M-[>",
                    --     dismiss = "<C-]>",
                    -- },
                },
            })
        end
    },
    -- To enable copilot completion, uncomment the following lines
    -- {
    --     "zbirenbaum/copilot-cmp",
    --     config = function()
    --         require("copilot_cmp").setup()
    --     end
    -- },

    ------------------------ Snippets & completion

    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()
            end,
        },
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            { dir = "/home/alban/workspace/cmp_registers", as = "cmp_registers" },
            -- To enable copilot completion, uncomment the following lines
            -- "zbirenbaum/copilot-cmp",
        },
        opts = function()
            local cmp = require("cmp")
            local luasnip = require('luasnip')
            local cmp_action = require('lsp-zero').cmp_action()
            local copilot_suggetion = require('copilot.suggestion')
            local cmp_format = require('lsp-zero').cmp_format()
            require('lsp-zero.cmp').extend()

            local getSuperTabCopilot = function(select_opts)
                return cmp.mapping(function(fallback)
                    local col = vim.fn.col('.') - 1
                    if copilot_suggetion.is_visible() and not cmp.visible() then
                        copilot_suggetion.accept()
                    elseif cmp.visible() then
                        cmp.select_next_item(select_opts)
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { 'i', 's' })
            end

            local options = {
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                sources = cmp.config.sources({
                    -- { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "registers" }
                }),
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<Escape>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false }),
                    ["<Tab>"] = getSuperTabCopilot(),
                    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                }),
                formatting = cmp_format,
                completion = {
                    autocomplete = false,
                    --     completeopt = 'menu,menuone,noinsert'
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                }
                -- preselect = 'item',
            }
            return options
        end,
    },
}
