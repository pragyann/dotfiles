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
