
return {
  "aaronik/treewalker.nvim",
  config = function()
    vim.keymap.set({ 'n', 'v' }, '<C-S-k>', '<cmd>Treewalker Up<cr>', { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<C-S-j>', '<cmd>Treewalker Down<cr>', { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<C-S-h>', '<cmd>Treewalker Left<cr>', { silent = true })
    vim.keymap.set({ 'n', 'v' }, '<C-S-l>', '<cmd>Treewalker Right<cr>', { silent = true })
    end
}
