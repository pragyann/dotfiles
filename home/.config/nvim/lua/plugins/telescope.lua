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
                    '--ignore-case',
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

        -- live grep with case-sensitive and whole-word toggles, bound to <M-c>
        -- and <M-w> inside the picker. each toggle reopens the picker with the
        -- matching rg flag, keeping whatever is already typed. state persists
        -- for the rest of the session.
        local grep_flags = { case_sensitive = false, whole_word = false }

        local live_grep
        live_grep = function(default_text)
            local args = {}
            local title = 'Live Grep'
            if grep_flags.case_sensitive then
                args[#args + 1] = '--case-sensitive'
                title = title .. ' [Aa]'
            end
            if grep_flags.whole_word then
                args[#args + 1] = '--word-regexp'
                title = title .. ' [W]'
            end

            builtin.live_grep({
                default_text = default_text,
                additional_args = args,
                prompt_title = title,
                attach_mappings = function(bufnr, map)
                    local actions = require('telescope.actions')
                    local state = require('telescope.actions.state')

                    local function toggle(flag)
                        return function()
                            local text = state.get_current_line()
                            actions.close(bufnr)
                            grep_flags[flag] = not grep_flags[flag]
                            vim.schedule(function() live_grep(text) end)
                        end
                    end

                    map({ 'i', 'n' }, '<M-c>', toggle('case_sensitive'))
                    map({ 'i', 'n' }, '<M-w>', toggle('whole_word'))
                    return true
                end,
            })
        end

        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', function() live_grep() end, { desc = 'Telescope live grep' })
        vim.keymap.set({ 'n', 'v' }, '<leader>fs', builtin.grep_string, { desc = 'Telescope grep word under cursor' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
}
