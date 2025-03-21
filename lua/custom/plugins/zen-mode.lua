return { 
  'folke/zen-mode.nvim',
  config = function ()
    vim.keymap.set('n', '<leader>zm', require("zen-mode").toggle, { desc = "[z]en [m]ode" })
  end,
  opts = {
    plugins = {
      options = {
        laststatus = 3
      },
      gitsigns = true,
    }
  }
}
