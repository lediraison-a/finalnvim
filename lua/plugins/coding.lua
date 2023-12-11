return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        opts = {
            context_commentstring = {
                enable = true,
            },
        }
    },
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        opts = {},
    },
    -- {
    -- 	"NMAC427/guess-indent.nvim",
    -- 	opts = {
    -- 		auto_cmd = true,      -- Set to false to disable automatic execution
    -- 		override_editorconfig = false, -- Set to true to override settings set by .editorconfig
    -- 		filetype_exclude = {  -- A list of filetypes for which the auto command gets disabled
    -- 			"netrw",
    -- 			"tutor",
    -- 		},
    -- 		buftype_exclude = { -- A list of buffer types for which the auto command gets disabled
    -- 			"help",
    -- 			"nofile",
    -- 			"terminal",
    -- 			"prompt",
    -- 		},
    -- 	}
    -- },

    ------------------------ comment
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
    },

    --------------------- Surround

    {
        "kylechui/nvim-surround",
        opts = {

        }
    },


    --------------------- Registers

    -- {
    --     "tenxsoydev/karen-yank.nvim",
    --     config = true,
    --     -- lazy = false,
    --     opts = {
    --         mappings = {
    --             disable = { "s", "S", "d", "D", "c", "C" }
    --         }
    --     }
    --
    -- },


}
