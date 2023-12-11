return {
    {
        'projekt0n/github-nvim-theme',
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            local options = {
                styles = {
                    comments = 'italic',
                    functions = 'italic,bold',
                },
                darken = { -- Darken floating windows and sidebar-like windows
                    floats = true,
                },
            }


            local spec = require('github-theme.spec').load('github_dark_tritanopia')
            spec['syntax']['builtin0'] = '#00FF7F'
            spec['syntax']['builtin1'] = 'pink'
            spec['syntax']['builtin2'] = 'yellow'
            spec['syntax']['number'] = 'yellow'
            spec['syntax']['conditional'] = '#00FF7F'
            spec['syntax']['field'] = '#FF7F50'
            spec['syntax']['variable'] = 'pink'
            spec['syntax']['type'] = '#FF7F50'
            spec['syntax']['statement'] = 'yellow'
            spec['syntax']['const'] = 'pink'
            spec['syntax']['ident'] = 'blue'
            -- spec['syntax']['bracket'] = 'cyan'
            -- spec['syntax']['func'] = 'magenta'
            -- spec['syntax']['string'] = 'cyan'
            local specs =
                require('github-theme').setup({
                    options = options,
                    specs = {
                        github_dark = spec
                    },
                })
            vim.cmd('colorscheme github_dark')
        end,

    },

    {
        'akinsho/bufferline.nvim',
        dependencies = 'nvim-tree/nvim-web-devicons',
        lazy = false,
        keys = {
            { "<leader>bse", "<cmd>BufferLineSortByExtension<cr>",         desc = "BufferLine Sort By Extenion" },
            { "<leader>bsd", "<cmd>BufferLineSortByRelativeDirectory<cr>", desc = "BufferLine Sort By RelativeDirectory" },
            { "<leader>bco", "<cmd>BufferLineCloseOthers<cr>",             desc = "BufferLine Close Others" },
            { "<leader>bcr", "<cmd>BufferLineCloseRight<cr>",              desc = "BufferLine Close Right" },
            { "<leader>bcl", "<cmd>BufferLineCloseLeft<cr>",               desc = "BufferLine Close Left" },
            { "<leader>bP",  "<cmd>BufferLineTogglePin<cr>",               desc = "BufferLine Toggle Pin" },
            { "<leader>bp",  "<cmd>BufferLinePick<cr>",                    desc = "BufferLine Pick" },
            { "<C-l>",       "<cmd>BufferLineCycleNext<cr>",               desc = "BufferLine Next" },
            { "<C-h>",       "<cmd>BufferLineCyclePrev<cr>",               desc = "BufferLine Prev" },
            { "<C-j>",       "<cmd>BufferLineMoveNext<cr>",                desc = "BufferLine Move Next" },
            { "<C-k>",       "<cmd>BufferLineMovePrev<cr>",                desc = "BufferLine Move Prev" },
        },
        opts = {
            options = {
                mode = "buffers",
                enforce_regular_tabs = true,
                show_close_icon = false,
                show_buffer_close_icons = false,
                show_buffer_icons = true,
                always_show_bufferline = false,
                offsets = { {
                    filetype = "NvimTree",
                    separator = true,
                    text = "🌊 NEOVIM",
                    text_align = "left" --[[| "center" | "right",]]
                } },
            },
        },
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        lazy = false,
        opts = function()
            local git_blame = require('gitblame')
            return {
                options = {
                    icons_enabled = true,
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "•", right = "•" },
                },
                sections = {
                    lualine_c = {
                        { 'filename' },
                        { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available }
                    }
                },
                -- tabline = {
                -- 	lualine_a = {'buffers'},
                -- }
            }
        end,
    },

    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2', -- or branch = '0.1.x',
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
            "xiyaowong/telescope-emoji.nvim",
            "LukasPietzschmann/telescope-tabs"
        },
        keys = {
            -- Telescope lsp goto references, implementation, declaration
            { "<leader>ctr", "<cmd>Telescope lsp_references<cr>",           desc = "LSP References" },
            { "<leader>cti", "<cmd>Telescope lsp_implementations<cr>",      desc = "LSP Implementations" },
            { "<leader>ctd", "<cmd>Telescope lsp_definitions<cr>",          desc = "LSP Definitions" },
            { "<leader>ctD", "<cmd>Telescope lsp_type_definitions<cr>",     desc = "LSP Type Definitions" },
            -- Telescope diagnostics
            { "<leader>fd",  "<cmd>Telescope diagnostics bufnr=0<cr>",      desc = "Document diagnostics" },
            { "<leader>fD",  "<cmd>Telescope diagnostics<cr>",              desc = "Workspace diagnostics" },
            -- Telescope files
            { "<leader>fo",  "<cmd>Telescope oldfiles<cr>",                 desc = "Recent" },
            { "<leader>ff",  "<cmd>Telescope find_files<cr>",               desc = "Find Files (root dir)" },
            -- Lsp symbols
            { "<leader>fs",  "<cmd>Telescope lsp_document_symbols<cr>",     desc = "Document Symbols" },
            { "<leader>fS",  "<cmd>Telescope lsp_workspace_symbols<cr>",    desc = "Workspace Symbols" },
            -- Tabs & buffers
            { '<leader>fb',  "<cmd>Telescope buffers<cr>",                  desc = "Buffers" },
            { "<leader>ft",  "<cmd>Telescope telescope-tabs list_tabs<cr>", desc = "Tabs" },
            --
            { "<leader>fc",  "<cmd>Telescope command_history<cr>",          desc = "Command History" },
            { "<leader>fg",  "<cmd>Telescope live_grep<cr>",                desc = "Live Grep" },
            { "<leader>fe",  "<cmd>Telescope emoji<cr>",                    desc = "Emoji" },
            { "<leader>fu",  "<cmd>Telescope undo<cr>",                     desc = "Undo" },
            { "<leader>fk",  "<cmd>Telescope keymaps<cr>",                  desc = "Key Maps" },
            { '<leader>fr',  "<cmd>Telescope registers<cr>",                desc = "Registers" },
            -- {
            --     '<C-R>',
            --     "<cmd>Telescope registers<cr>",
            --     mode = "i",
            --     desc =
            --     "Registers"
            -- },
        },
        config = function()
            local telescope = require("telescope")
            telescope.load_extension("undo")
            telescope.load_extension("emoji")

            local pushToRegister = function(prompt_bufnr)
                local entry = require("telescope.actions.state").get_selected_entry()
                require("telescope.actions").select_default(prompt_bufnr)
                vim.fn.setreg('+', vim.fn.getreg(entry.value))
                vim.fn.setreg('*', vim.fn.getreg(entry.value))
            end

            local previewers = require('telescope.previewers')

            -- add previewer to registers picker
            telescope.setup({
                pickers = {
                    registers = {
                        preview = true,
                        mappings = {
                            i = {
                                ["<CR>"] = pushToRegister,
                            },
                            n = {
                                ["<CR>"] = pushToRegister,
                            }
                        }
                    }
                }
            })

            require("telescope-tabs").setup({})
        end
    },

    {
        dir = "/home/alban/workspace/registers.nvim",
        -- "tversteeg/registers.nvim",
        lazy = false,
        keys = {
            { "\"",    mode = { "n", "v" } },
            { "<C-R>", mode = "i" }
        },
        config = function()
            local registers = require("registers")
            registers.setup({
                window = {
                    transparency = 0,
                },
                bind_keys = {
                    ["<Tab>"] = registers.move_cursor_down(),
                    ["<S-Tab>"] = registers.move_cursor_up(),
                    ["<Space>"] = registers.apply_register(),
                },
                -- trim_whitespace = true,
                -- hide_only_whitespace = true,
            })
        end,
    },

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
            return { indent = { highlight = highlight } }
        end
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
        "brenoprata10/nvim-highlight-colors",
        opts = {
            render = 'background', -- 'background', 'foreground' or 'first_column'
            enable_named_colors = true,
            enable_tailwind = false,
        }
    },
    {
        "nvim-tree/nvim-tree.lua",
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
            },
        }
    },


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

    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {
            hint_enable = true, -- virtual hint enable
            hint_prefix = ">",
            handler_opts = {
                border = "none" -- double, rounded, single, shadow, none, or a table of borders
            },
            padding = ' '
        },
        config = function(_, opts) require 'lsp_signature'.setup(opts) end
    }

}
