return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.2', -- or branch = '0.1.x',
        -- lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
            "xiyaowong/telescope-emoji.nvim",
            "LukasPietzschmann/telescope-tabs",
            "desdic/telescope-rooter.nvim",
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
            -- register list in insert mode using telescope
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
                -- extenssions = {
                --     rooter = {
                --         config = {
                --         }
                --     }
                -- },
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
    }
}
