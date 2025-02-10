return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        { "hrsh7th/cmp-nvim-lua", lazy = true },
        { 'hrsh7th/cmp-nvim-lsp', lazy = true },
        { 'hrsh7th/cmp-buffer', lazy = true },
        { 'hrsh7th/cmp-path', lazy = true },
        { 'hrsh7th/cmp-cmdline', lazy = true },
        { 'dmitmel/cmp-cmdline-history', lazy = true },
    },
    opts = function(_, opts)
        if not opts.sources then opts.sources = {} end
        table.insert(opts.sources, { name = "nvim_lua" })
    end,
    config = function()
        local cmp = require'cmp'
        cmp.setup{
            window = {
                completion = {
                    border = 'single',
                    winhighlight = 'Normal:Pmenu,CursorLine:PmenuSel',
                    winblend = 10,
                },
                documentation = {
                    border = 'rounded',
                    winhighlight = 'Normal:Pmenu',
                    winblend = 10,
                },
            },
            preselect = cmp.PreselectMode.Item,
            mapping = cmp.mapping.preset.insert({
                ['<ESC>j'] = {
                    i = function()
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            cmp.complete()
                        end
                    end,
                },
                ['<ESC>k'] = {
                    i = function()
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            cmp.complete()
                        end
                    end,
                },
                ['<ESC>l'] = {
                    i = function()
                        if cmp.visible() then
                            cmp.close()
                        end
                        vim.api.nvim_input('<Esc><Esc>')
                    end
                },
                -- [''] = cmp.mapping.complete(),
                -- [''] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior, count = 1 }),
                -- [''] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior, count = 1 }),
                -- [''] = cmp.mapping.confirm({ select = false, behavior = cmp.ConfirmBehavior.Insert }),

            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                -- { name = 'buffer' },
                -- { name = 'path' },
                -- { name = 'cmdline' },
            })
        }
        local my_mapping_preset_cmdline = {
            ['<Tab>'] = {
                c = function()
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        cmp.complete()
                    end
                end,
            },
            ['<S-Tab>'] = {
                c = function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    else
                        cmp.complete()
                    end
                end,
            },
        }
        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ '/', '?' }, {
            -- mapping = cmp.mapping.preset.cmdline(),
            mapping = my_mapping_preset_cmdline,
            sources = {
                { name = 'buffer' },
            }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
            -- mapping = cmp.mapping.preset.cmdline(),
            mapping = my_mapping_preset_cmdline,
            sources = cmp.config.sources({
                { name = 'path' },
            }, {
                { name = 'cmdline' },
                -- { name = 'cmdline_history' },
            }),
            matching = { disallow_symbol_nonprefix_matching = false }
        })
    end
}
