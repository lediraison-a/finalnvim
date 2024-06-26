return {
    -- {
    --     dir = "/home/alban/workspace/myregisters",
    --     opts = {
    --         border = 'none',
    --         registers = { "*" }
    --     }
    --     -- config = function()
    --     --     require("myregisters").setup({
    --     --         border = 'none'
    --     --     })
    --     -- end
    -- },

    -- {
    --     dir = "/home/alban/workspace/registers.nvim",
    --     -- "tversteeg/registers.nvim",
    --     lazy = false,
    --     keys = {
    --         { "\"",    mode = { "n", "v" } },
    --         { "<C-R>", mode = "i" }
    --     },
    --     config = function()
    --         local registers = require("registers")
    --         registers.setup({
    --             window = {
    --                 transparency = 0,
    --             },
    --             bind_keys = {
    --                 ["<Tab>"] = registers.move_cursor_down(),
    --                 ["<S-Tab>"] = registers.move_cursor_up(),
    --                 ["<Space>"] = registers.apply_register(),
    --             },
    --             -- trim_whitespace = true,
    --             -- hide_only_whitespace = true,
    --         })
    --     end,
    -- },

    -- indent-blankline
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = function()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }

            local hooks = require "ibl.hooks"
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            hooks.register(
                hooks.type.WHITESPACE,
                hooks.builtin.hide_first_tab_indent_level
            )

            return {
                indent = {
                    highlight = highlight,
                    tab_char = "▎",
                },
                scope = {
                    enabled = false,
                }
            }
        end
    },

    -- Git
    {
        "f-person/git-blame.nvim",
        opts = {
            display_virtual_text = false,
            enabled = true
        }
    },
    {
        "kdheepak/lazygit.nvim",
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
        }
    },


    -- Color hl
    {
        "brenoprata10/nvim-highlight-colors",
        opts = {
            render = 'background', -- 'background', 'foreground' or 'first_column'
            enable_named_colors = true,
            enable_tailwind = false,
        }
    },

    -- NvimTree
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons"
        },
        keys = {
            { "<leader>tt", "<cmd>NvimTreeToggle<cr>", desc = "NvimTree" },
        },
        opts = {
            sort_by = "case_sensitive",
            view = {
                width = 30,
                cursorline = true,
            },
            renderer = {
                group_empty = true,
                indent_markers = {
                    enable = true,
                    icons = { corner = "└ ", edge = "│ ", none = "  " }
                },
            },
            filters = {
                dotfiles = true,
                git_ignored = true,
            },
            sync_root_with_cwd = true,
            respect_buf_cwd = false,
            update_focused_file = {
                enable = true,
                update_root = true
            },
        }
    },


    -- which key & surround support
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            plugins = {
                registers = false,
            }
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        "roobert/surround-ui.nvim",
        dependencies = {
            "kylechui/nvim-surround",
            "folke/which-key.nvim",
        },
        config = function()
            require("surround-ui").setup({
                root_key = "S"
            })
        end,
    },

    -- rainbow brackets
    {
        'hiphish/rainbow-delimiters.nvim',
        lazy = false,
        config = function()
            local rainbow_delimiters = require('rainbow-delimiters')
            require('rainbow-delimiters.setup').setup {
                strategy = {
                    -- cpp = {
                    --     '{', '}', '(', ')', '[', ']'
                    -- },
                    -- h = {
                    --     '{', '}', '(', ')', '[', ']'
                    -- },
                    -- [''] = rainbow_delimiters.strategy['global'],
                    -- vim = rainbow_delimiters.strategy['global'],
                },
                query = {
                    -- Use parentheses by default
                    -- [''] = 'rainbow-delimiters',
                    -- Use blocks for Lua
                    -- lua = 'rainbow-blocks',
                    -- cpp = 'rainbow-blocks',
                    -- h = 'rainbow-blocks',
                    -- Determine the query dynamically
                    -- query = function()
                    --     -- Use blocks for read-only buffers like in `:InspectTree`
                    --     local is_nofile = vim.bo.buftype == 'nofile'
                    --     return is_nofile and 'rainbow-blocks' or 'rainbow-delimiters'
                    -- end
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end,
    },

    -- LSP signature
    {
        "ray-x/lsp_signature.nvim",
        keys = {
            { "<C-S>", "<cmd>lua require'lsp_signature'.toggle_float_win()<cr>", mode = "i", desc = "Toggle signature" },
            { "<C-S>", "<cmd>lua require'lsp_signature'.toggle_float_win()<cr>", mode = "n", desc = "Toggle signature" },
        },
        lazy = false,
        config = function()
            local lsp_signature = require('lsp_signature')

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorMoved", "CursorMovedI" }, {
                pattern = "*",
                callback = function(ev)
                    -- if lsp client not ready, don't do anything
                    if next(require('lspconfig').util.available_servers()) == nil then
                        return
                    end
                    lsp_signature.signature()
                    lsp_signature.on_UpdateSignature()
                    lsp_signature.check_signature_should_close()
                end
            })



            lsp_signature.setup({
                hint_enable = false, -- virtual hint enable
                hint_prefix = ">",
                handler_opts = {
                    border = "none" -- double, rounded, single, shadow, none, or a table of borders
                },
                padding = ' ',
                -- always_trigger = true,              -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
                -- auto_close_after = nil,             -- autoclose signature float win after x sec, disabled if nil.
                -- extra_trigger_chars = { "(", "," }, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
            })
        end
    },

}
