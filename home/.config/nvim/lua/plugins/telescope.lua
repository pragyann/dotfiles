return {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    config = function()
        local telescope = require('telescope')

        telescope.setup({
            defaults = {
                -- telescope's default rg args plus --hidden, so dotfiles and
                -- dotfolders are searched. the first six flags produce the
                -- file:line:col: output telescope parses, so they must stay.
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case',
                    '--hidden',
                    '--glob=!**/.git/*',
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    -- lua patterns, not globs
                    file_ignore_patterns = { '^%.git/', '/%.git/' },
                },
            },
        })

        -- native C sorter; falls back to the lua sorter if the build is missing
        pcall(telescope.load_extension, 'fzf')

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
}
