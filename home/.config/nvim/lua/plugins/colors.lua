-- Groups that keep a filled background even with tokyonight's transparency
-- options on, so the terminal background shows through everywhere.
-- Using :highlight (rather than nvim_set_hl) clears only the background and
-- leaves each group's foreground colors untouched.
local transparent_groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "FloatTitle",
    "SignColumn",
    "LineNr",
    "CursorLineNr",
    "EndOfBuffer",
    "WinSeparator",
    "MsgArea",
    "Folded",
    "NeoTreeNormal",
    "NeoTreeNormalNC",
    "NeoTreeEndOfBuffer",
    "NeoTreeWinSeparator",
    "NeoTreeFloatNormal",
    "NeoTreeFloatBorder",
    "TelescopeNormal",
    "TelescopeBorder",
    "TelescopePromptNormal",
    "TelescopePromptBorder",
    "TelescopeResultsNormal",
    "TelescopeResultsBorder",
    "TelescopePreviewNormal",
    "TelescopePreviewBorder",
    "Pmenu",
    "PmenuSbar",
    "StatusLine",
    "StatusLineNC",
    "DiagnosticVirtualTextError",
    "DiagnosticVirtualTextWarn",
    "DiagnosticVirtualTextInfo",
    "DiagnosticVirtualTextHint",
}

local function clear_backgrounds()
    for _, group in ipairs(transparent_groups) do
        vim.cmd("highlight " .. group .. " guibg=NONE ctermbg=NONE")
    end

    -- Tokyonight's separator colour is a near-black navy that vanishes once the
    -- background is transparent. Use the muted comment grey so split borders
    -- stay visible without competing with the code.
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#565f89", bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { link = "WinSeparator" })

    -- Same story for the gutter: tokyonight's line-number colour is a very dark
    -- navy meant to sit on the filled sidebar background, so it reads as almost
    -- invisible against the terminal. Lift it to a legible grey-blue.
    -- With 'relativenumber', the lines above and below the cursor are drawn
    -- with LineNrAbove/LineNrBelow, not LineNr. Tokyonight defines all three
    -- explicitly, so each one has to be overridden by hand. A cool lavender
    -- keeps them legible while staying distinct from the warm CursorLineNr.
    local line_nr = { fg = "#9aa5ce", bg = "none" }
    vim.api.nvim_set_hl(0, "LineNr", line_nr)
    vim.api.nvim_set_hl(0, "LineNrAbove", line_nr)
    vim.api.nvim_set_hl(0, "LineNrBelow", line_nr)
end

return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {
            transparent = true,
            styles = {
                sidebars = "transparent",
                floats = "transparent",
            },
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)

            -- Re-clear on every colorscheme load, including this first one, so
            -- plugins that define their own groups later stay transparent too.
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = clear_backgrounds,
            })

            vim.cmd.colorscheme "tokyonight"
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = function()
            -- Keep the coloured mode/branch blocks, drop the filler background
            -- between them.
            local theme = require("lualine.themes.tokyonight")
            for _, mode in pairs(theme) do
                if mode.c then
                    mode.c.bg = "none"
                end
            end

            return {
                options = {
                    theme = theme,
                    -- One statusline for the whole screen instead of one per
                    -- window, which frees that row so Neovim can draw the
                    -- horizontal separator between stacked splits.
                    globalstatus = true,
                },
            }
        end,
    },
}
