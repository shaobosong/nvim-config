return {
    "nvim-treesitter/nvim-treesitter",
    tag = "v0.9.3",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "lua", "c", "cpp" },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = { "c", "cpp" },
            },
            indent = {
                enable = true,
            },
        })
    end,
}
