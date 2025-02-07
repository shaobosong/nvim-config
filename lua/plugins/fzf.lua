return {
    "ibhagwan/fzf-lua",
    dependencies = {
        -- "nvim-tree/nvim-web-devicons",
        -- or
        -- "echasnovski/mini.icons",
        {
            'junegunn/fzf',
            build = './install --bin',
        },
    },
    lazy = true,
    cmd = { "FzfLua" },
    keys = {
        -- search
        { "<leader>/", "<cmd>FzfLua grep_project<cr>", mode = "" },
        { "<leader>?", "<cmd>FzfLua grep_last<cr>",    mode = "" },
        { "<leader>*", "<cmd>FzfLua grep_cword<cr>",   mode = "n" },
        { "<leader>*", "<cmd>FzfLua grep_visual<cr>",  mode = "x" },
        -- lsp
        -- { "<leader>ld", "<cmd>FzfLua lsp_definitions<cr>",     mode = "" },
        { "<leader>ld", ":lua require('fzf-lua').lsp_definitions({jump_to_single_result=true})<cr>", mode = "", silent = true },
        { "<leader>lD", "<cmd>FzfLua lsp_declarations<cr>",    mode = "" },
        { "<leader>lt", "<cmd>FzfLua lsp_typedefs<cr>",        mode = "" },
        { "<leader>li", "<cmd>FzfLua lsp_implementations<cr>", mode = "" },
        { "<leader>lr", "<cmd>FzfLua lsp_references<cr>",      mode = "" },
        { "<leader>la", "<cmd>FzfLua lsp_code_actions<cr>",    mode = "" },
        -- misc
        { "<leader>:", "<cmd>FzfLua<cr>",         mode = "" },
        { "<leader>b", "<cmd>FzfLua buffers<cr>", mode = "" },
        { "<leader>f", "<cmd>FzfLua files<cr>",   mode = "" },
        { "<leader>t", "<cmd>FzfLua tags<cr>",    mode = "" },
    },
    --- @see fzf-lua-customization
    config = function()
        local fzf_lua = require("fzf-lua")
        local actions = fzf_lua.actions
        fzf_lua.setup({
            fzf_bin = vim.fn.stdpath("data") .. "/lazy/fzf/bin/fzf",
            keymap = {
                builtin = {
                    -- inherit from default values
                    true,
                    ["<c-u>"] = "preview-page-up",
                    ["<c-d>"] = "preview-page-down",
                },
                fzf = {
                    ["alt-j"] = "down",
                    ["alt-k"] = "up",
                    ["alt-l"] = "abort",
                    ["ctrl-alt-h"] = "backward-kill-word",
                },
            },
            actions = {
                files = {
                    ["enter"]  = actions.file_edit_or_qf,
                    ["ctrl-s"] = actions.file_split,
                    ["ctrl-v"] = actions.file_vsplit,
                    ["ctrl-t"] = actions.file_tabedit,
                    ["alt-q"]  = actions.file_sel_to_qf,
                    ["alt-Q"]  = actions.file_sel_to_ll,
                    ["alt-i"]  = actions.toggle_ignore,
                    ["alt-h"]  = actions.toggle_hidden,
                    ["alt-F"]  = actions.toggle_follow,
                },
            },
            lsp = {
                jump_to_single_result = false,
                includeDeclaration = false,
                ignore_current_line = true,
                jump_to_single_result_action = actions.file_edit,
                -- jump_to_single_result_action = actions.file_vsplit,
                -- default for others
            },
        })
    end,
}
