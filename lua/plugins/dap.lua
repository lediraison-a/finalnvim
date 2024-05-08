return {

    {
        "mfussenegger/nvim-dap",
        keys = function()
            local ui = function()
                local widgets = require("dap.ui.widgets")
                local sidebar = widgets.sidebar(widgets.scopes)
                sidebar.open()
            end
            _G.ui = ui
            local keys = {
                -- leader d b to set a breakpoint
                { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "toggle breakpoint" },
                -- leader d c to continue
                { "<leader>dc", "<cmd>lua require('dap').continue()<cr>",          desc = "continue" },
                -- leader d s to stop
                { "<leader>ds", "<cmd>lua require('dap').close()<cr>",             desc = "stop" },
                -- leader d n to next step
                { "<leader>dn", "<cmd>lua require('dap').step_over()<cr>",         desc = "step over" },
                -- leader d i to step into
                { "<leader>di", "<cmd>lua require('dap').step_into()<cr>",         desc = "step into" },
                -- leader d o to step out
                { "<leader>do", "<cmd>lua require('dap').step_out()<cr>",          desc = "step out" },
                -- leader d r to restart
                { "<leader>dr", "<cmd>lua require('dap').restart()<cr>",           desc = "restart" },
                -- leader d u to ui
                -- { "<leader>du", "<cmd>lua ui()<cr>",                               desc = "ui" },
            }
            return keys
        end,
        config = function()
            local dap = require("dap")
            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = '/home/alban/lib/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
            }
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        keys = {
            -- leader d t to toggle ui
            { "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "toggle" },
        },
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("dapui").setup()
        end
    },
    {
        "leoluz/nvim-dap-go",
        ft = "go",
        keys = {
            -- leader dt to debug test
            { "<leader>dt", "<cmd>lua require('dap-go').debug_test()<cr>", desc = "debug test" },
        },
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            require("dap-go").setup()
        end
    },
}
