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
}
