return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = { "lua_ls", "clangd" },
                automatic_installation = false,
                handlers = nil,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lspconfig = require("lspconfig")
            local on_attach = function(client, bufnr)
                -- keymaps
                local opts = { noremap = true, silent = true, buffer = bufnr }
                -- vim.keymap.set('', '<leader>ld', vim.lsp.buf.definition, opts)
                -- vim.keymap.set('', '<leader>lD', vim.lsp.buf.declaration, opts)
                -- vim.keymap.set('', '<leader>lt', vim.lsp.buf.type_definition, opts)
                -- vim.keymap.set('', '<leader>li', vim.lsp.buf.implementation, opts)
                -- vim.keymap.set('', '<leader>lr', vim.lsp.buf.references, opts)
                -- vim.keymap.set('', '<leader>la', vim.lsp.buf.code_action, opts)
                vim.keymap.set('', '<leader>k', vim.lsp.buf.hover, opts)
                vim.keymap.set('', '<leader>lR', vim.lsp.buf.rename, opts)
                vim.keymap.set('', '<leader>lf', function()
                    vim.lsp.buf.format { async = true }
                end, opts)
                -- disable tagfunc from lsp server
                vim.opt.tagfunc = ''
                -- disable syntax highlight from lsp server
                -- client.server_capabilities.semanticTokensProvider = nil
                -- type: vim.diagnostic.Opts
                local diagnostic = {
                    underline = true,
                    -- virtual_text = {
                    --     prefix = '▶',
                    --     virt_text_pos = 'right_align',
                    -- },
                    update_in_insert = false,
                    signs = false,
                }
                vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                    vim.lsp.diagnostic.on_publish_diagnostics, diagnostic
                )
                vim.lsp.handlers["textDocument/diagnostic"] = vim.lsp.with(
                    vim.lsp.diagnostic.on_diagnostic, diagnostic
                )
                vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                    vim.lsp.handlers.hover, {
                        border = "single",
                        -- title = " hover "
                    }
                )
            end

            -- C-family
            lspconfig.clangd.setup({
                on_attach = on_attach,
                root_dir = function(fname)
                    return require("lspconfig.util").root_pattern(
                        ".git",
                        "Makefile",
                        "configure.ac",
                        "configure.in",
                        "config.h.in",
                        "meson.build",
                        "meson_options.txt",
                        "build.ninja",
                        "compile_commands.json",
                        "compile_flags.txt"
                    )(fname) or vim.fs.dirname(
                        vim.fs.find('.git', { path = fname, upward = true })[1]
                    )
                end,
                cmd = {
                    'clangd',
                    '--compile-commands-dir=build',
                    '--background-index',
                    '--completion-style=detailed',
                    '--header-insertion=iwyu',
                    -- '--clang-tidy',
                    -- '--inlay-hints',
                    -- "--function-arg-placeholders",
                    -- "--fallback-style=llvm",
                },
                init_options = {
                    usePlaceholders = true,
                    completeUnimported = true,
                    clangdFileStatus = true,
                },
                single_file_support = true,
            })
            -- Lua
            lspconfig.lua_ls.setup({
                on_attach = on_attach,
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = { 'vim' },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })
        end,
    },
}
