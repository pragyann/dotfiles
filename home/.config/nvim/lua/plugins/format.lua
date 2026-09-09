-- Prettier owns formatting for the web filetypes, so that saving in Neovim and
-- running `npm run format` produce byte-identical results. tsserver formats too,
-- but with its own defaults (4-space indent, `{ }` for empty braces), which
-- rewrites whole files on save; lsp.lua excludes these filetypes from LSP
-- formatting for that reason.
return {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    cmd = 'ConformInfo',
    opts = {
        formatters_by_ft = {
            javascript = { 'prettier' },
            javascriptreact = { 'prettier' },
            typescript = { 'prettier' },
            typescriptreact = { 'prettier' },
            json = { 'prettier' },
            jsonc = { 'prettier' },
            css = { 'prettier' },
            html = { 'prettier' },
            yaml = { 'prettier' },
        },
        -- Only the project's own prettier, never a global one, so the version and
        -- the config come from the repo being edited. No prettier, no formatting.
        formatters = {
            prettier = { require_cwd = true },
        },
        format_on_save = {
            timeout_ms = 2000,
            lsp_format = 'never',
        },
    },
}
