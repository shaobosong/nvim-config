return {
    "nvim-tree/nvim-tree.lua",
    -- idependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = true,
    cmd = { "NvimTreeToggle" },
    opts = {
        renderer = {
            icons = {
                show = {
                    file = false,
                    folder = false,
                    folder_arrow = false,
                    git = false,
                    modified = false,
                    hidden = false,
                    diagnostics = true,
                    bookmarks = false,
                },
            },
        },
        actions = {
            open_file = {
                quit_on_open = true,
                window_picker = {
                    enable = false,
                },
            },
        },
        update_focused_file = {
            enable = true,
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,  -- 使用当前缓冲区的目录
    },
    -- config = function()
    --     require("nvim-tree").setup({})
    -- end,
}
