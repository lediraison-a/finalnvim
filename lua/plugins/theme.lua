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
                darken = {
                    floats = false,
                    sidebars = {
                        enabled = false,
                        list = { 'NvimTree' } -- default is {}
                    }
                }
            }


            local spec = require('github-theme.spec').load('github_dark_tritanopia')
            -- override syntax colors
            spec['syntax'] = {
                builtin0 = '#00FF7F',
                builtin1 = 'pink',
                builtin2 = 'yellow',
                number = 'yellow',
                conditional = '#00FF7F',
                field = '#FF7F50',
                variable = 'pink',
                type = '#FF7F50',
                statement = 'yellow',
                const = 'pink',
                ident = 'blue',
                -- bracket = 'cyan',
                -- func = 'magenta',
                -- string = 'cyan',
            }
            spec['groups'] = {
                BufferLineBackground = { bg = '#ffffff' },
            }
            require('github-theme').setup({
                options = options,
                specs = {
                    github_dark = spec
                },
            })
            vim.cmd('colorscheme github_dark')
        end,

    },
}
