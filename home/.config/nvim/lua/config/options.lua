local set = vim.opt

-- line nums
set.number = true
set.relativenumber = true

-- indentation and tabs
set.tabstop = 4
set.shiftwidth = 4
set.autoindent = true
set.expandtab = true

-- search settings
set.ignorecase = true
set.smartcase = true

-- appearance
set.background = "dark"
set.signcolumn = "yes"
set.termguicolors = true
set.wrap = false

-- cursor line
set.cursorline = true

-- split windows
set.splitbelow = true
set.splitright = true

-- scrolling
-- Keep 8 lines of context above and below the cursor, so the view starts
-- scrolling before the cursor reaches the edge of the window.
set.scrolloff = 8
set.sidescrolloff = 8
-- Scroll sideways one column at a time. The default of 0 lurches the view half
-- a screen the moment the cursor crosses the edge, which loses your place the
-- same way a half-page <C-d> did.
set.sidescroll = 1

-- faster cursor hold
set.updatetime = 50
