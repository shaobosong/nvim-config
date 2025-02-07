local opts = { noremap = true, silent = true }

vim.keymap.set('', '<ESC>L', '<C-W>l', opts)
vim.keymap.set('', '<ESC>H', '<C-W>h', opts)
vim.keymap.set('', '<ESC>J', '<C-W>j', opts)
vim.keymap.set('', '<ESC>K', '<C-W>k', opts)
-- menu
-- vim.keymap.set('', '<leader>m', '', opts)

vim.keymap.set('!', '<ESC>L', '<ESC><C-W>l', opts)
vim.keymap.set('!', '<ESC>H', '<ESC><C-W>h', opts)
vim.keymap.set('!', '<ESC>J', '<ESC><C-W>j', opts)
vim.keymap.set('!', '<ESC>K', '<ESC><C-W>k', opts)

vim.keymap.set('n', 'gs', ':s@<c-r><c-w>@<c-r><c-w>@g<C-F>hhi' ,opts)
vim.keymap.set('x', 'gs', ':s@@@g<C-F>hhi' ,opts)

vim.keymap.set('', 'gt', ':<C-U>TagbarToggle<CR>' ,opts)
vim.keymap.set('', '[[', ':<C-U>TagbarJumpPrev<CR>' ,opts)
vim.keymap.set('', ']]', ':<C-U>TagbarJumpNext<CR>' ,opts)
