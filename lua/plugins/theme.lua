return {
    {
        'projekt0n/github-nvim-theme',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
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
}
