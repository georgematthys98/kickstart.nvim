return {
  'stevearc/oil.nvim', -- file navigation
  config = function()
    local oil = require 'oil'
    oil.setup {
      keymaps = {
        ['<C-h>'] = false,
        ['<C-l>'] = false,
      },
      skip_confirm_for_simple_edits = true,
    }
    vim.keymap.set('n', '-', require('oil').open, { desc = 'Open parent directory' })
    vim.keymap.set('n', '<leader>.', require('oil').toggle_hidden, { desc = 'Toggle hidden files' })
  end,
}
