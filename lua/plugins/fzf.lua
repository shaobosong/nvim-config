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
        -- grep/rg search
        { "<leader>g/", "<cmd>FzfLua grep_project<cr>", mode = "" },
        { "<leader>g?", "<cmd>FzfLua grep_last<cr>",    mode = "" },
        { "<leader>g*", "<cmd>FzfLua grep_cword<cr>",   mode = "n" },
        { "<leader>g*", "<cmd>FzfLua grep_visual<cr>",  mode = "x" },
        -- ast-grep search
        { "<leader>gi", "<cmd>FzfLua ast_grep_identifier<cr>", mode = "" },
        -- lsp
        { "<leader>ld", "<cmd>FzfLua my_lsp_definitions<cr>",  mode = "" },
        { "<leader>lD", "<cmd>FzfLua lsp_declarations<cr>",    mode = "" },
        { "<leader>lt", "<cmd>FzfLua my_lsp_typedefs<cr>",     mode = "" },
        { "<leader>li", "<cmd>FzfLua lsp_implementations<cr>", mode = "" },
        { "<leader>lr", "<cmd>FzfLua lsp_references<cr>",      mode = "" },
        { "<leader>la", "<cmd>FzfLua lsp_code_actions<cr>",    mode = "" },
        -- misc
        { "<leader>:", "<cmd>FzfLua<cr>",         mode = "" },
        { "<leader>b", "<cmd>FzfLua buffers<cr>", mode = "" },
        { "<leader>f", "<cmd>FzfLua files<cr>",   mode = "" },
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
            fzf_opts = {
                -- ignorecase
                ["-i"] = true,
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

        -- my lsp-typedefs
        fzf_lua.my_lsp_typedefs = (function(default_lsp_typedefs)
            return function(opts)
                local my_opts = {
                    jump_to_single_result = true,
                }
                opts = vim.tbl_deep_extend("force", my_opts, opts or {});
                default_lsp_typedefs(opts)
            end
        end)(fzf_lua.lsp_typedefs)

        -- Extension: ast-grep identifier
        fzf_lua.ast_grep_identifier = function(opts)
            local my_opts = {
                prompt = "> ",
                winopts = {
                    title = " Grep AST Identifier ",
                },
                keymap = {
                    fzf = {
                        ["alt-j"] = "down",
                        ["alt-k"] = "up",
                        ["alt-l"] = "abort",
                        ["ctrl-alt-h"] = "backward-kill-word",
                    },
                },
                fzf_opts = {
                    ["-i"] = true,
                    ["--delimiter"] = ":",
                    ["--nth"]  = '3..',
                },
                git_icons = false,
                file_icons = false,
                color_icons = false,
                actions = {
                    ["enter"]  = actions.file_edit_or_qf,
                    ["ctrl-s"] = actions.file_split,
                    ["ctrl-v"] = actions.file_vsplit,
                    ["ctrl-t"] = actions.file_tabedit,
                    ["alt-q"]  = actions.file_sel_to_qf,
                    ["alt-Q"]  = actions.file_sel_to_ll,
                },
                previewer = "builtin",
            }
            opts = vim.tbl_deep_extend("force", my_opts, opts or {});
            local my_cmd = "ast-grep --pattern '$PATTERN' --heading=never --color=always --selector identifier"
            fzf_lua.fzf_exec(my_cmd, opts)
        end
    end,
}
