return {
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

    { "arkav/lualine-lsp-progress" },

    {
        "nvim-lualine/lualine.nvim",
        -- event = "VeryLazy",
        deppendencies = {
            "kyazdani42/nvim-web-devicons",
            "f-person/git-blame.nvim",
            "ray-x/lsp_signature.nvim",
            "arkav/lualine-lsp-progress"
        },
        -- lazy = false,
        config = function()
            local git_blame = require('gitblame')

            local signatureTextWidth = 100
            local current_signature = function()
                if not pcall(require, 'lsp_signature') then return end
                local sig = require("lsp_signature").status_line(signatureTextWidth)
                return sig.label
            end

            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    section_separators = { left = "", right = "" },
                    component_separators = { left = "•", right = "•" },
                },
                sections = {

                    lualine_c = {
                        {
                            'filename',
                            separator = "|",
                        },
                        {
                            current_signature,
                            separator = "|",
                        },
                        {
                            git_blame.get_current_blame_text,
                            separator = "|",
                            cond = git_blame.is_blame_text_available,
                        },
                    },
                    lualine_x = {
                        {
                            'lsp_progress',
                            display_components = { 'lsp_client_name', 'spinner', { 'title', 'percentage', 'message' } },
                            timer = { progress_enddelay = 500, spinner = 1000, lsp_client_name_enddelay = 1000 },
                            spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
                        }
                    }

                },
                -- tabline = {
                -- 	lualine_a = {'buffers'},
                -- }
            })
        end,
    },
}
