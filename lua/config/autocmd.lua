local opts = { noremap = true, silent = true }

vim.api.nvim_create_autocmd("InsertEnter", {
    pattern = "*",
    command = "set colorcolumn=81"
})

vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "set colorcolumn=0"
})

vim.api.nvim_create_autocmd("FocusLost", {
    pattern = "*",
    command = "set colorcolumn=0"
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "fzf",
    callback = function()
        -- vim.api.nvim_buf_set_keymap(0, "t", "<ESC>j", "<Down>", opts)
        -- vim.api.nvim_buf_set_keymap(0, "t", "<ESC>k", "<Up>", opts)
        -- vim.api.nvim_buf_set_keymap(0, "t", "<ESC>l", "<C-Q>", opts)
        -- vim.api.nvim_buf_set_keymap(0, "t", "<C-R>", "<C-W>", opts)
    end
})

-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "qf,query",
--     callback = function()
--         vim.api.nvim_buf_set_keymap(0, "n", "<ESC>l", "<C-W>c", opts)
--         vim.api.nvim_buf_set_keymap(0, "n", "<ESC>H", "<C-W>c", opts)
--         vim.api.nvim_buf_set_keymap(0, "n", "<ESC>J", "<C-W>c", opts)
--         vim.api.nvim_buf_set_keymap(0, "n", "<ESC>K", "<C-W>c", opts)
--         vim.api.nvim_buf_set_keymap(0, "n", "<ESC>L", "<C-W>c", opts)
--         vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<CR>:cclose<CR>", opts)
--     end
-- })

vim.api.nvim_create_autocmd({"WinLeave"}, {
    pattern = "*",
    callback = function()
        local ft_tbl = { "tagbar", "query", "qf", "netrw", "man" }
        if vim.tbl_contains(ft_tbl, vim.bo.filetype) and vim.fn.winnr("$") > 1 then
            vim.cmd("q")
        end
    end
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
    pattern = "*",
    callback = function()
        -- vim.api.nvim_buf_set_keymap(0, "n", "<ESC>l", "<C-W>c", opts)
        vim.api.nvim_buf_set_keymap(0, "n", "<ESC>K", "<C-W>c", opts)
        vim.api.nvim_buf_set_keymap(0, "i", "<ESC>K", "<ESC><C-W>c", opts)
    end
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead", "BufEnter"}, {
    pattern = "*.c.inc",
    command = "setlocal filetype=c"
})


--- @see lsp-defaults-disable
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        vim.bo[ev.buf].formatexpr = nil
        vim.bo[ev.buf].omnifunc = nil
        vim.keymap.del('n', 'K', { buffer = ev.buf })
    end,
})
