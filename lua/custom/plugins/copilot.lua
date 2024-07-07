return {
  'github/copilot.vim',
  config = function()
    vim.keymap.set('n', '<leader>ghe', '<cmd>Copilot enable<cr>', { desc = '[E]nable Copilot' })
    vim.keymap.set('n', '<leader>ghd', '<cmd>Copilot disable<cr>', { desc = '[D]isable Copilot' })
    vim.g.copilot_filetypes = { VimspectorPrompt = false, markdown = false }
  end,
}
