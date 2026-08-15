return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    cmd = "Neotree",
    keys = {
        {
            "<leader>e",
            "<cmd>Neotree toggle<cr>",
            desc = "Toggle file explorer",
        },
    },
    opts = {
        window = {
            width = 30,
        },
        filesystem = {
            follow_current_file = {
                enabled = true,
            },
            -- OS-level watchers, so files created outside nvim (agents, git
            -- checkouts, other terminals) show up without toggling the tree.
            -- without this, refreshes only ride on BufWritePost.
            use_libuv_file_watcher = true,
            filtered_items = {
                visible = true,
                show_hidden_count = true,
                hide_dotfiles = false,
                hide_gitignored = false,
            },
        },
    },
}
