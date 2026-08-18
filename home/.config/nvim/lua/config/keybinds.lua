vim.g.mapleader = " "

-- File navigation
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
-- Leave a terminal split in one keystroke instead of stopping in normal mode
-- first. These shadow the shell's own C-l (clear) and C-k (kill line).
vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], { desc = "Go to left window" })
vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], { desc = "Go to lower window" })
vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], { desc = "Go to upper window" })
vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], { desc = "Go to right window" })


-- Window resizing. Alt-hjkl slide the border in the direction pressed, so the
-- same key moves it the same way from either side of a split. Vim's :resize is
-- relative instead: it always grows the current window, taking the space from
-- the window after it, or from the one before it when there is none. Being that
-- last window is what flips which border moves, and so flips the sign here.
local function resize(dir, step)
    local vertical = dir == "h" or dir == "l"
    local forward = dir == "l" or dir == "j" -- rightwards / downwards
    local last = vim.fn.winnr(vertical and "l" or "j") == vim.fn.winnr()
    local delta = (forward ~= last) and step or -step
    vim.cmd((vertical and "vertical resize " or "resize ") .. ("%+d"):format(delta))
end

-- A Lua callback keeps the current mode, like <cmd> does, so these work
-- mid-typing in insert and terminal mode too. In a terminal they shadow the
-- shell's own M-h (run-help) and M-l (down-case-word).
for dir, towards in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
    vim.keymap.set({ "n", "i", "t" }, "<M-" .. dir .. ">", function()
        resize(dir, 2)
    end, { desc = "Move window border " .. towards })
end

-- Scrolling one line at a time, so holding the key glides at the keyboard's
-- repeat rate like j/k instead of teleporting half a screen.
-- The leading count is what does the work: [count]<C-d> sets the 'scroll'
-- option to that count before scrolling. Repeating it on every press matters
-- because Neovim resets 'scroll' to half the window height whenever the window
-- is resized, which would silently undo a one-off `set scroll=1`.
vim.keymap.set({ "n", "v", "x" }, "<C-d>", "1<C-d>", { desc = "Scroll down one line" })
vim.keymap.set({ "n", "v", "x" }, "<C-u>", "1<C-u>", { desc = "Scroll up one line" })

-- Search
-- Clears the search highlight. Neovim's default for this is <C-l>, which is
-- taken by window navigation above.
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Quickfix
vim.keymap.set("n", "<leader>co", vim.cmd.copen, { desc = "Open quickfix list" })
vim.keymap.set("n", "<leader>cc", vim.cmd.cclose, { desc = "Close quickfix list" })

-- Terminal
vim.keymap.set("n", "<leader>tj", function()
    vim.cmd("belowright split | terminal")
    vim.cmd.startinsert()
end, { desc = "Open terminal split below" })
vim.keymap.set("n", "<leader>tl", function()
    vim.cmd("botright vsplit | terminal")
    vim.cmd.startinsert()
end, { desc = "Open terminal split right" })
vim.keymap.set("n", "<leader>tL", function()
    vim.cmd("vsplit | terminal")
    vim.cmd.startinsert()
end, { desc = "Open terminal split right in current window" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

