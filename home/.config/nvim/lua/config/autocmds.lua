local group = vim.api.nvim_create_augroup("terminal-behaviour", { clear = true })

-- Terminal buffers should be ready to type in, both when first opened and when
-- moved back into from another window.
local function start_insert()
    -- Once the shell exits the buffer is left read-only, and startinsert there
    -- would strand the cursor in a mode that accepts no input.
    if vim.bo.buftype == "terminal" and vim.b.terminal_job_id ~= nil then
        vim.cmd.startinsert()
    end
end

vim.api.nvim_create_autocmd("TermOpen", {
    group = group,
    callback = start_insert,
})

vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
    group = group,
    pattern = "term://*",
    callback = start_insert,
})

-- Prose is written as one long line per paragraph and soft-wrapped by the
-- editor, so markdown is the one filetype where the global 'nowrap' would push
-- most of the text off the right edge.
vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("markdown-behaviour", { clear = true }),
    pattern = "markdown",
    callback = function()
        vim.opt_local.wrap = true
        -- Break at whitespace rather than mid-word, and indent the wrapped
        -- rows so a continued list item stays visually under its own bullet.
        vim.opt_local.linebreak = true
        vim.opt_local.breakindent = true
    end,
})
