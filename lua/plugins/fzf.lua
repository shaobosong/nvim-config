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
        {
            "MisanthropicBit/fzf-lua-ast-grep.nvim",
        },
    },
    lazy = true,
    cmd = { "FzfLua" },
    keys = {
        -- search
        { "<leader>/",     "<cmd>FzfLua grep_project<cr>",     mode = "" },
        { "<leader>?",     "<cmd>FzfLua grep_last<cr>",        mode = "" },
        { "<leader>*",     "<cmd>FzfLua grep_cword<cr>",       mode = "n" },
        { "<leader>*",     "<cmd>FzfLua grep_visual<cr>",      mode = "x" },
        { "<leader><C-]>", "<cmd>FzfLua my_ast_live_grep<cr>", mode = "" },
        -- lsp
        { "<leader>ld", "<cmd>FzfLua my_lsp_definitions<cr>",  mode = "" },
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
            winopts  = {
                treesitter = false,
            },
            keymap = {
                builtin = {
                    -- inherit from default values
                    true,
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

        -- my lsp-definitions
        fzf_lua.my_lsp_definitions = (function(default_lsp_definitions)
            return function(opts)
                local my_opts = {
                    jump_to_single_result = true,
                }
                opts = vim.tbl_deep_extend("force", my_opts, opts or {});
                default_lsp_definitions(opts)
            end
        end)(fzf_lua.lsp_definitions)

        -- extension: my ast-grep
        local fzf_lua_ast_live_grep = require('fzf-lua-ast-grep')
        local default_ast_live_grep = fzf_lua_ast_live_grep.ast_live_grep
        fzf_lua.my_ast_live_grep = function(opts)
            local my_opts = {
                fzf_lua_options = {
                    prompt = "> ",
                    winopts = {
                        title = " Grep AST ",
                    },
                },
                -- invalid for now
                ast_grep_options = {
                    command = "ast-grep",
                    args = {
                        "run",
                        "--color=always",
                        "--heading=never",
                    },
                },
            }
            opts = vim.tbl_deep_extend("force", my_opts, opts or {});
            return default_ast_live_grep(opts)
        end
    end,
}
