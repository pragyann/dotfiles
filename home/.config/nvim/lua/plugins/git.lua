return {
    {
        'NeogitOrg/neogit',
        dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' },
        keys = { { '<leader>g', function() require('neogit').open() end, desc = 'Neogit' } },
    },
    {
        -- installed as a neogit dependency; configured here for the keymaps
        'sindrets/diffview.nvim',
        opts = {
            keymaps = {
                -- buffer-local, so q still records macros everywhere else
                view = { { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } } },
                file_panel = { { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } } },
                file_history_panel = { { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } } },
            },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufWinEnter',
        opts = { current_line_blame = true }, -- who last touched this line
    },
}
