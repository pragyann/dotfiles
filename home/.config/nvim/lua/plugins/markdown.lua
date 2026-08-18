return {
    { -- Render markdown in the buffer itself: headings, tables, lists, code
        -- blocks and links are drawn as virtual text over the real source. The
        -- file on disk is never touched, so editing stays exactly as it was.
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },
        ft = { "markdown" },
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {
            -- Rendering is on in normal mode and off in insert, so the raw
            -- syntax comes back the moment you start typing.
            render_modes = { "n", "c" },
            -- Keep the cursor line rendered like every other line in normal
            -- mode. Raw syntax only comes back on entering insert mode, which
            -- render_modes above already handles.
            anti_conceal = { enabled = false },
            code = {
                -- Draw the code block as a filled box but keep the language
                -- label, instead of hiding the ``` fences entirely.
                style = "full",
                width = "block",
                min_width = 40,
                border = "thin",
                left_pad = 2,
                right_pad = 2,
            },
            overrides = {
                -- Strips the padding and background from code blocks in LSP
                -- hover and signature-help floats.
                buftype = {
                    nofile = {
                        code = {
                            disable_background = true,
                            border = "none",
                            language_border = " ",
                            min_width = 0,
                            left_pad = 0,
                            right_pad = 0,
                        },
                    },
                },
            },
            heading = {
                -- No background bar behind headings: the icon and the coloured
                -- heading text carry the level on their own.
                backgrounds = {},
            },
        },
        keys = {
            {
                "<leader>m",
                "<cmd>RenderMarkdown buf_toggle<cr>",
                ft = "markdown",
                desc = "Toggle markdown rendering",
            },
        },
    },
}
